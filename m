From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 2/8] spi: core: add spi_replace_transfers method
Date: Mon, 14 Dec 2015 15:20:19 +0000
Message-ID: <1450106426-2277-3-git-send-email-kernel@martin.sperl.org>
References: <1450106426-2277-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450106426-2277-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add the spi_replace_transfers method that can get used
to replace some spi_transfers from a spi_message with other
transfers.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  132 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   45 ++++++++++++++++
 2 files changed, 177 insertions(+)

Changelog:
  V2 -> V3: new implementation of spi_replace_transfers

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8149602..ede3e57 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2105,6 +2105,138 @@ EXPORT_SYMBOL_GPL(spi_res_release);

 /*-------------------------------------------------------------------------*/

+/* Core methods for spi_message alterations */
+
+static void __spi_replace_transfers_release(struct spi_master *master,
+					    struct spi_message *msg,
+					    void *res)
+{
+	struct spi_replaced_transfers *rxfer = res;
+	size_t i;
+
+	/* call extra callback if requested */
+	if (rxfer->release)
+		rxfer->release(master, msg, res);
+
+	/* insert replaced transfers back into the message */
+	list_splice(&rxfer->replaced_transfers, rxfer->replaced_after);
+
+	/* remove the formerly inserted entries */
+	for (i = 0; i < rxfer->inserted; i++)
+		list_del(&rxfer->inserted_transfers[i].transfer_list);
+}
+
+/**
+ * spi_replace_transfers - replace transfers with several transfers
+ *                         and register change with spi_message.resources
+ * @msg:           the spi_message we work upon
+ * @xfer_first:    the first spi_transfer we want to replace
+ * @remove:        number of transfers to remove
+ * @insert:        the number of transfers we want to insert instead
+ * @release:       extra release code necessary in some circumstances
+ * @extradatasize: extra data to allocate (with alignment guarantees
+ *                 of struct @spi_transfer)
+ *
+ * Returns: pointer to @spi_replaced_transfers,
+ *          PTR_ERR(...) in case of errors.
+ */
+struct spi_replaced_transfers *spi_replace_transfers(
+	struct spi_message *msg,
+	struct spi_transfer *xfer_first,
+	size_t remove,
+	size_t insert,
+	spi_replaced_release_t release,
+	size_t extradatasize,
+	gfp_t gfp)
+{
+	struct spi_replaced_transfers *rxfer;
+	struct spi_transfer *xfer;
+	size_t i;
+
+	/* allocate the structure using spi_res */
+	rxfer = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
+			      insert * sizeof(struct spi_transfer)
+			      + sizeof(struct spi_replaced_transfers)
+			      + extradatasize,
+			      gfp);
+	if (!rxfer)
+		return ERR_PTR(-ENOMEM);
+
+	/* the release code to invoke before running the generic release */
+	rxfer->release = release;
+
+	/* assign extradata */
+	if (extradatasize)
+		rxfer->extradata =
+			&rxfer->inserted_transfers[insert];
+
+	/* init the replaced_transfers list */
+	INIT_LIST_HEAD(&rxfer->replaced_transfers);
+
+	/* assign the list_entry after which we should reinsert
+	 * the @replaced_transfers - it may be spi_message.messages!
+	 */
+	rxfer->replaced_after = xfer_first->transfer_list.prev;
+
+	/* remove the requested number of transfers */
+	for (i = 0; i < remove; i++) {
+		/* if the entry after replaced_after it is msg->transfers
+		 * then we have been requested to remove more transfers
+		 * than are in the list
+		 */
+		if (rxfer->replaced_after->next == &msg->transfers) {
+			dev_err(&msg->spi->dev,
+				"requested to remove more spi_transfers than are available\n");
+			/* insert replaced transfers back into the message */
+			list_splice(&rxfer->replaced_transfers,
+				    rxfer->replaced_after);
+
+			/* free the spi_replace_transfer structure */
+			spi_res_free(rxfer);
+
+			/* and return with an error */
+			return ERR_PTR(-EINVAL);
+		}
+
+		/* remove the entry after replaced_after from list of
+		 * transfers and add it to list of replaced_transfers
+		 */
+		list_move_tail(rxfer->replaced_after->next,
+			       &rxfer->replaced_transfers);
+	}
+
+	/* create copy of the given xfer with identical settings
+	 * based on the first transfer to get removed
+	 */
+	for (i = 0; i < insert; i++) {
+		/* we need to run in reverse order */
+		xfer = &rxfer->inserted_transfers[insert - 1 - i];
+
+		/* copy all spi_transfer data */
+		memcpy(xfer, xfer_first, sizeof(*xfer));
+
+		/* add to list */
+		list_add(&xfer->transfer_list, rxfer->replaced_after);
+
+		/* clear cs_change and delay_usecs for all but the last */
+		if (i) {
+			xfer->cs_change = false;
+			xfer->delay_usecs = 0;
+		}
+	}
+
+	/* set up inserted */
+	rxfer->inserted = insert;
+
+	/* and register it with spi_res/spi_message */
+	spi_res_add(msg, rxfer);
+
+	return rxfer;
+}
+EXPORT_SYMBOL_GPL(spi_replace_transfers);
+
+/*-------------------------------------------------------------------------*/
+
 /* Core methods for SPI master protocol drivers.  Some of the
  * other core methods are currently defined as inline functions.
  */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 739a476..13831ed 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -875,6 +875,51 @@ extern int spi_async_locked(struct spi_device *spi,

 /*---------------------------------------------------------------------------*/

+/* SPI transfer replacement methods which make use of spi_res */
+
+/**
+ * struct spi_replaced_transfers - structure describing the spi_transfer
+ *                                 replacements that have occurred
+ *                                 so that they can get reverted
+ * @release:            some extra release code to get executed prior to
+ *                      relasing this structure
+ * @extradata:          pointer to some extra data if requested or NULL
+ * @replaced_transfers: transfers that have been replaced and which need
+ *                      to get restored
+ * @replaced_after:     the transfer after which the @replaced_transfers
+ *                      are to get re-inserted
+ * @inserted:           number of transfers inserted
+ * @inserted_transfers: array of spi_transfers of array-size @inserted,
+ *                      that have been replacing replaced_transfers
+ *
+ * note: that @extradata will point to @inserted_transfers[@inserted]
+ * if some extra allocation is requested, so alignment will be the same
+ * as for spi_transfers
+ */
+struct spi_replaced_transfers;
+typedef void (*spi_replaced_release_t)(struct spi_master *master,
+				       struct spi_message *msg,
+				       struct spi_replaced_transfers *res);
+struct spi_replaced_transfers {
+	spi_replaced_release_t release;
+	void *extradata;
+	struct list_head replaced_transfers;
+	struct list_head *replaced_after;
+	size_t inserted;
+	struct spi_transfer inserted_transfers[];
+};
+
+extern struct spi_replaced_transfers *spi_replace_transfers(
+	struct spi_message *msg,
+	struct spi_transfer *xfer_first,
+	size_t remove,
+	size_t insert,
+	spi_replaced_release_t release,
+	size_t extradatasize,
+	gfp_t gfp);
+
+/*---------------------------------------------------------------------------*/
+
 /* All these synchronous SPI transfer routines are utilities layered
  * over the core async transfer primitive.  Here, "synchronous" means
  * they will sleep uninterruptibly until the async transfer completes.
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
