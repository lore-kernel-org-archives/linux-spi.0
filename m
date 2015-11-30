From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/3] spi: add initial set of spi_transfer transformation methods
Date: Mon, 30 Nov 2015 13:04:53 +0000
Message-ID: <1448888695-2260-3-git-send-email-kernel@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448888695-2260-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

added the following spi_transformation methods:
* spi_split_transfers_first_page_len_not_aligned -
  this splits spi_transfers that are not aligned on rx_buf/tx_buf
  this will create 2 or 3 transfers, where the first 1/2 transfers are
  just there to allow the last transfer to be fully aligned. These first
  transfers will have a length less than alignment.
* spi_split_transfers_maxsize
  this splits the spi_transfer into multiple independent spi_transfers
  all of which will be of size max_size or smaller.

To start these shall get used by the individual drivers in prepare_message,
but some may get moved into spi-core with the correct parametrization in
spi_master.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  392 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   27 ++++
 2 files changed, 419 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eecbbe1..7576131 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -145,6 +145,9 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(14, "16384-32767");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");
 
+SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
+SPI_STATISTICS_SHOW(transfers_split_unaligned, "%lu");
+
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
@@ -182,6 +185,8 @@ static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_transfer_bytes_histo14.attr,
 	&dev_attr_spi_device_transfer_bytes_histo15.attr,
 	&dev_attr_spi_device_transfer_bytes_histo16.attr,
+	&dev_attr_spi_device_transfers_split_maxsize.attr,
+	&dev_attr_spi_device_transfers_split_unaligned.attr,
 	NULL,
 };
 
@@ -224,6 +229,8 @@ static struct attribute *spi_master_statistics_attrs[] = {
 	&dev_attr_spi_master_transfer_bytes_histo14.attr,
 	&dev_attr_spi_master_transfer_bytes_histo15.attr,
 	&dev_attr_spi_master_transfer_bytes_histo16.attr,
+	&dev_attr_spi_master_transfers_split_maxsize.attr,
+	&dev_attr_spi_master_transfers_split_unaligned.attr,
 	NULL,
 };
 
@@ -2103,6 +2110,391 @@ void spi_res_release(struct spi_master *master,
 	}
 }
 EXPORT_SYMBOL_GPL(spi_res_release);
+/*-------------------------------------------------------------------------*/
+
+/* Core methods for spi_message alterations */
+
+/* the spi_resource structure used */
+struct spi_res_replaced_transfers {
+	spi_res_release_t release;
+	struct list_head replaced_transfers;
+	int inserted;
+	struct spi_transfer xfers[];
+};
+
+static void __spi_replace_transfers_release(struct spi_master *master,
+					    struct spi_message *msg,
+					    void *res)
+{
+	struct spi_res_replaced_transfers *srt = res;
+	int i;
+
+	/* call extra callback */
+	if (srt->release)
+		srt->release(master, msg, res);
+
+	/* insert transfers back into the message ahead of xfers[0] */
+	list_splice(&srt->replaced_transfers, &srt->xfers[0].transfer_list);
+
+	/* remove the formerly inserted entries */
+	for (i = 0; i < srt->inserted; i++)
+		list_del(&srt->xfers[i].transfer_list);
+}
+
+/**
+ * spi_replace_transfers - replace transfers with several transfers
+ *                         and register change with spi_message.resources
+ * @msg: the spi_message we work upon
+ * @xfer: the spi_transfer we want to replace
+ * @remove: number of transfers to remove
+ * @insert: the number of transfers we want to insert
+ * @release: extra release code necessary in some circumstances
+ *
+ * Returns: pointer to array of newly inserted transfers,
+ *          NULL in case of errors
+ */
+struct spi_transfer *spi_replace_transfers(struct spi_message *msg,
+					   struct spi_transfer *xfer,
+					   int remove, int insert,
+					   spi_res_release_t release)
+{
+	int i;
+	size_t size = insert * sizeof(struct spi_transfer)
+		      + sizeof(struct spi_res_replaced_transfers);
+	struct spi_res_replaced_transfers *srt;
+	struct spi_transfer *next;
+
+	if (unlikely(insert < 1))
+		return NULL;
+
+	/* allocate the structure */
+	srt = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
+			    size, 0);
+	if (unlikely(!srt))
+		return NULL;
+
+	/* the release code to use before running the generic release */
+	srt->release = release;
+
+	/* create copy of the given xfer with identical settings */
+	srt->inserted = insert;
+	for (i = 0; i < insert ; i++) {
+		/* copy all settings */
+		memcpy(&srt->xfers[i], xfer, sizeof(*xfer));
+
+		/* for anything but the last transfer, clear some settings */
+		if (i < insert - 1) {
+			srt->xfers[i].cs_change = 0;
+			srt->xfers[i].delay_usecs = 0;
+		}
+
+		/* add before the xfer to remove itself */
+		list_add_tail(&srt->xfers[i].transfer_list,
+			      &xfer->transfer_list);
+	}
+
+	/* remove the requested number of transfers */
+	for (i = 0; i < remove; i++, xfer = next) {
+		/* check for error case - we want to remove list_head...*/
+		if (&xfer->transfer_list == &msg->transfers) {
+			dev_err(&msg->spi->dev,
+				"requested to remove more spi_transfers than are available\n");
+			spi_res_free(srt);
+			return NULL;
+		}
+		/* get the next xfer for later */
+		next = list_next_entry(xfer, transfer_list);
+
+		/* and remove the current transfer from the list of transfers */
+		list_del_init(&xfer->transfer_list);
+
+		/* and add it to the list in spi_res_replaced_transfers */
+		INIT_LIST_HEAD(&srt->replaced_transfers);
+		list_add(&xfer->transfer_list, &srt->replaced_transfers);
+	}
+
+	/* and register it */
+	spi_res_add(msg, srt);
+
+	/* return the head of the list */
+	return &srt->xfers[0];
+}
+EXPORT_SYMBOL_GPL(spi_replace_transfers);
+
+/* core spi_transfer transformation */
+
+static void __spi_split_transfers_fixup_transfer_addr_and_len(
+	struct spi_transfer *xfer, int count, int shift)
+{
+	int i;
+
+	/* fix up transfer length */
+	xfer[0].len = shift;
+
+	/* shift all the addresses arround */
+	for (i = 1; i < count; i++) {
+		xfer[i].len -= shift;
+		xfer[i].tx_buf += xfer[i].tx_buf ? shift : 0;
+		xfer[i].rx_buf += xfer[i].rx_buf ? shift : 0;
+		xfer[i].tx_dma += xfer[i].tx_dma ? shift : 0;
+		xfer[i].rx_dma += xfer[i].rx_dma ? shift : 0;
+	}
+}
+
+static int __spi_split_transfers_first_page_len_not_aligned(
+	struct spi_master *master,
+	struct spi_message *message,
+	struct spi_transfer *xfer,
+	size_t alignment_mask)
+{
+	int count;
+	struct spi_transfer *xfers;
+	const char *tx_start, *rx_start; /* the rx/tx_buf address */
+	const char *tx_end, *rx_end; /* the last byte of the transfer */
+	size_t tx_start_page, rx_start_page; /* the "page address" for start */
+	size_t tx_end_page, rx_end_page; /* the "page address" for end */
+	size_t tx_start_align, rx_start_align; /* alignment of buf address */
+
+	/* calculate the necessary values */
+	tx_start = xfer->tx_buf;
+	tx_start_page = (size_t)tx_start & (PAGE_SIZE - 1);
+	tx_start_align = ((size_t)tx_start & alignment_mask);
+	tx_end = tx_start ? &tx_start[xfer->len - 1] : NULL;
+	tx_end_page = (size_t)tx_end & (PAGE_SIZE - 1);
+
+	rx_start = xfer->rx_buf;
+	rx_start_page = (size_t)rx_start & (PAGE_SIZE - 1);
+	rx_start_align = ((size_t)rx_start & alignment_mask);
+	rx_end = rx_start ? &tx_start[xfer->len - 1] : NULL;
+	rx_end_page = (size_t)rx_end & (PAGE_SIZE - 1);
+
+	/* if we do not cross a page for either rx or tx,
+	 * then there is nothing to do...
+	 */
+	if ((tx_start_page == tx_end_page) &&
+	    (rx_start_page == rx_end_page))
+		return 0;
+
+	/* calculate how many transfers we need to replace the current */
+	count = 1;
+	if (rx_start_align)
+		count++;
+	if ((tx_start_align) &&
+	    (tx_start_align != rx_start_align) &&
+	    (tx_start != rx_start))
+		count++;
+
+	/* send a one-time warning */
+	dev_warn_once(&message->spi->dev,
+		      "unaligned spi_transfers produced by spi_device driver - please fix driver\n");
+
+	/* create replacement */
+	xfers = spi_replace_transfers(message, xfer, 1, count, NULL);
+	if (!xfers)
+		return -ENOMEM;
+
+	/* now we fix up the transfer pointer and transfer len */
+	if (count == 2) {
+		__spi_split_transfers_fixup_transfer_addr_and_len(
+			xfers, 2, max(tx_start_align, rx_start_align));
+	} else {
+		if (tx_start_align < rx_start_align) {
+			__spi_split_transfers_fixup_transfer_addr_and_len(
+				&xfers[0], 3,
+				tx_start_align);
+			__spi_split_transfers_fixup_transfer_addr_and_len(
+				&xfers[1], 2,
+				rx_start_align - tx_start_align);
+		} else {
+			__spi_split_transfers_fixup_transfer_addr_and_len(
+				&xfers[0], 3,
+				rx_start_align);
+			__spi_split_transfers_fixup_transfer_addr_and_len(
+				&xfers[1], 2,
+				tx_start_align - rx_start_align);
+		}
+	}
+
+	/* increment statistics counters */
+	SPI_STATISTICS_INCREMENT_FIELD(&master->statistics,
+				       transfers_split_unaligned);
+	SPI_STATISTICS_INCREMENT_FIELD(&message->spi->statistics,
+				       transfers_split_unaligned);
+
+	return 0;
+}
+
+/**
+ * spi_split_tranfers_first_page_len_not_aligned - split spi transfers into
+ *                                                 two transfers on the
+ *                                                 first page boundary, when
+ *                                                 the start address is not
+ *                                                 aligned
+ * @master:       the @spi_master for this transfer
+ * @message:      the @spi_message to transform
+ * @when_can_dma: true if we only should execute when we can use dma
+ * @alignment:    the requested alignment
+ * @min_size:     the minimum transfer when to apply this
+ *
+ * Return: status of transformation
+ *
+ * This implements one of the ways that (dma-enabled) HW may be constrained
+ * in this case the HW is able to do unaligned transfers, but a DMA-transfer
+ * is always of size align from a register perspective (even if it only
+ * writes < align bytes back to ram).
+ * As there is no guarantee that the next logical page is actually adjectant
+ * for the dma perspective, we need to split the first page of a transfer
+ * into separate transfers (1 or 2 depending on alignment of rx_buf and
+ * tx_buf respectively).
+ * this does not make sure that the individual transfers that are
+ * added are address, aligned, but it makes sure that each of those
+ * new transfers.len is < alignment.
+ *
+ */
+int spi_split_transfers_first_page_len_not_aligned(
+	struct spi_master *master,
+	struct spi_message *message,
+	bool when_can_dma,
+	size_t alignment)
+{
+	struct spi_device *spi = message->spi;
+	struct spi_transfer *_xfer, *xfer = NULL;
+	size_t alignment_mask = alignment - 1;
+	int ret;
+
+	/* if when_can_dma is set, but can_dma is unset,
+	 * something major is wrong...
+	 */
+	if (when_can_dma && (!master->can_dma)) {
+		dev_err(&master->dev,
+			"configured without can_dma, but requests can_dma to be set calling first_page_len_not_aligned\n");
+		return -EINVAL;
+	}
+
+	/* iterate over the transfer_list in a safe manner
+	 * there is a posibility of replacement and we need to make sure
+	 * we run over all the entries
+	 */
+	xfer = list_prepare_entry(xfer, &message->transfers, transfer_list);
+	list_for_each_entry_safe_continue(xfer, _xfer,
+					  &message->transfers,
+					  transfer_list) {
+		if (when_can_dma && (!master->can_dma(master, spi, xfer)))
+			continue;
+		if (((size_t)xfer->rx_buf & alignment_mask) ||
+		    ((size_t)xfer->tx_buf & alignment_mask)) {
+			ret = __spi_split_transfers_first_page_len_not_aligned(
+				master, message, xfer, alignment_mask);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_split_transfers_first_page_len_not_aligned);
+
+int __spi_split_transfer_maxsize(struct spi_master *master,
+				 struct spi_message *msg,
+				 struct spi_transfer *xfer,
+				 size_t maxsize)
+{
+	int count = DIV_ROUND_UP(xfer->len, maxsize);
+	size_t offset = 0;
+	int i;
+	struct spi_transfer *xfers;
+
+	/* create replacement */
+	xfers = spi_replace_transfers(msg, xfer, 1, count, NULL);
+	if (!xfers)
+		return -ENOMEM;
+
+	/* now handle each of those newly inserted xfers */
+	for (i = 0; i < count; i++) {
+		/* the first transfer just needs the length modified,
+		 * so do not change the pointers
+		 */
+		if (i) {
+			/* update rx_buf if it is not tx_buf */
+			if (xfers[i].rx_buf &&
+			    (xfers[i].tx_buf != xfers[i].rx_buf)) {
+				/* modify the rx_buf */
+				xfers[i].rx_buf += offset;
+				/* this is actually not used with any
+				 * scatter_lists, but it is still there,
+				 * so we have to support it
+				 */
+				if (xfers[i].rx_dma)
+					xfers[i].rx_dma += offset;
+			}
+			/* update tx_buf */
+			if (xfers[i].tx_buf) {
+				/* modify the rx_buf */
+				xfers[i].tx_buf += offset;
+				/* this is actually not used with any
+				 * scatter_lists, but it is still there,
+				 * so we have to support it...
+				 */
+				if (xfers[i].tx_dma)
+					xfers[i].tx_dma += offset;
+			}
+		}
+		/* modify length */
+		if (i < count - 1) /* for all but the last transfer */
+			xfers[i].len = maxsize;
+		else /* the last one is most likley not max_size */
+			xfers[i].len -= offset;
+
+		/* increment offset */
+		offset += maxsize;
+	}
+
+	/* increment statistics counters */
+	SPI_STATISTICS_INCREMENT_FIELD(&master->statistics,
+				       transfers_split_maxsize);
+	SPI_STATISTICS_INCREMENT_FIELD(&msg->spi->statistics,
+				       transfers_split_maxsize);
+
+	return 0;
+}
+
+/**
+ * spi_split_tranfers_maxsize - split spi transfers into multiple transfers
+ *                              when an individual transfer exceeds a
+ *                              certain size
+ * @master:    the @spi_master for this transfer
+ * @message:   the @spi_message to transform
+ * @max_size:  the maximum when to apply this
+ *
+ * Return: status of transformation
+ */
+
+int spi_split_transfers_maxsize(struct spi_master *master,
+				struct spi_message *msg,
+				size_t maxsize)
+{
+	struct spi_transfer *_xfer, *xfer = NULL;
+	int ret;
+
+	/* iterate over the transfer_list in a safe manner
+	 * there is a posibility of replacement and we need to make sure
+	 * we run over all the entries
+	 */
+	xfer = list_prepare_entry(xfer, &msg->transfers, transfer_list);
+	list_for_each_entry_safe_continue(xfer, _xfer,
+					  &msg->transfers,
+					  transfer_list) {
+		if (xfer->len > maxsize) {
+			ret = __spi_split_transfer_maxsize(
+				master, msg, xfer, maxsize);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7e74e0e..8075c93 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -53,6 +53,11 @@ extern struct bus_type spi_bus_type;
  *
  * @transfer_bytes_histo:
  *                 transfer bytes histogramm
+ *
+ * @transfers_split_maxsize:
+ *                 number of transfers split because of len exceeds maxsize
+ * @transfers_split_unaligned:
+ *                 number of transfers split because of unaligned transfers
  */
 struct spi_statistics {
 	spinlock_t		lock; /* lock for the whole structure */
@@ -72,6 +77,10 @@ struct spi_statistics {
 
 #define SPI_STATISTICS_HISTO_SIZE 17
 	unsigned long transfer_bytes_histo[SPI_STATISTICS_HISTO_SIZE];
+
+	unsigned long           transfers_split_maxsize;
+	unsigned long           transfers_split_unaligned;
+
 };
 
 void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
@@ -607,6 +616,24 @@ extern void spi_res_free(void *res);
 extern void spi_res_release(struct spi_master *master,
 			    struct spi_message *message);
 
+/* SPI transfer modifications using spi_res */
+
+extern struct spi_transfer *spi_replace_transfers(
+	struct spi_message *msg,
+	struct spi_transfer *xfer,
+	int remove, int insert,
+	spi_res_release_t release);
+
+extern int spi_split_transfers_first_page_len_not_aligned(
+	struct spi_master *master,
+	struct spi_message *message,
+	bool when_can_dma,
+	size_t alignment);
+
+extern int spi_split_transfers_maxsize(struct spi_master *master,
+				       struct spi_message *msg,
+				       size_t maxsize);
+
 /*---------------------------------------------------------------------------*/
 
 /*
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
