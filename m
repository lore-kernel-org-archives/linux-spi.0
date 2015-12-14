From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 5/8] spi: core: add spi_merge_transfers method
Date: Mon, 14 Dec 2015 15:20:22 +0000
Message-ID: <1450106426-2277-6-git-send-email-kernel@martin.sperl.org>
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

Added method spi_merge_transfers which consolidates multiple
spi_transfers into a single spi_transfer making use of
spi_res for management of resources/reverting changes to the
spi_message structure.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  227 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |    9 ++
 2 files changed, 236 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f276c99..fe3b18e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -148,6 +148,7 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");
 SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
 SPI_STATISTICS_SHOW(transfers_split_unaligned, "%lu");
 SPI_STATISTICS_SHOW(transfers_split_unaligned_copy, "%lu");
+SPI_STATISTICS_SHOW(transfers_merged, "%lu");
 
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
@@ -189,6 +190,7 @@ static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_transfers_split_maxsize.attr,
 	&dev_attr_spi_device_transfers_split_unaligned.attr,
 	&dev_attr_spi_device_transfers_split_unaligned_copy.attr,
+	&dev_attr_spi_device_transfers_merged.attr,
 	NULL,
 };
 
@@ -234,6 +236,7 @@ static struct attribute *spi_master_statistics_attrs[] = {
 	&dev_attr_spi_master_transfers_split_maxsize.attr,
 	&dev_attr_spi_master_transfers_split_unaligned.attr,
 	&dev_attr_spi_master_transfers_split_unaligned_copy.attr,
+	&dev_attr_spi_master_transfers_merged.attr,
 	NULL,
 };
 
@@ -2552,6 +2555,230 @@ int spi_split_transfers_unaligned(struct spi_master *master,
 }
 EXPORT_SYMBOL_GPL(spi_split_transfers_unaligned);
 
+static void __spi_merge_transfers_release(struct spi_master *master,
+					  struct spi_message *msg,
+					  struct spi_replaced_transfers *srt)
+{
+	u8 *ptr = srt->inserted_transfers[0].rx_buf;
+	struct spi_transfer *xfer;
+
+	/* copy the data to the final locations */
+	list_for_each_entry(xfer, &srt->replaced_transfers, transfer_list) {
+		/* fill data only if rx_buf is set */
+		if (xfer->rx_buf)
+			memcpy(xfer->rx_buf, ptr, xfer->len);
+		/* update the pointer for next loop */
+		ptr += xfer->len;
+	}
+}
+
+static int __spi_merge_transfers_do(struct spi_master *master,
+				    struct spi_message *msg,
+				    struct spi_transfer **xfer_start,
+				    struct spi_transfer *xfer_end,
+				    int count,
+				    size_t size,
+				    gfp_t gfp)
+{
+	size_t align = master->dma_alignment ? : sizeof(int);
+	size_t align_overhead = BIT(align) - 1;
+	size_t size_to_alloc = size + align_overhead;
+	struct spi_transfer *xfer_new, *xfer;
+	struct spi_replaced_transfers *srt;
+	u8 *data_tx;
+	int i;
+
+	/* for anything but 3-wire mode we need rx/tx_buf to be set */
+	if (!(msg->spi->mode & SPI_3WIRE))
+		size_to_alloc *= 2;
+
+	/* replace count transfers starting with xfer_start
+	 * and replace them with a single transfer (which is returned)
+	 * the extra data requeste starts at:
+	 *   returned pointer + sizeof(struct_transfer)
+	 */
+	srt = spi_replace_transfers(msg, *xfer_start, count, 1,
+				    __spi_merge_transfers_release,
+				    size_to_alloc, gfp);
+	if (!srt)
+		return -ENOMEM;
+
+	/* the inserted transfer */
+	xfer_new = srt->inserted_transfers;
+
+	/* pointer to data_tx data allocated - aligned */
+	data_tx = PTR_ALIGN(srt->extradata, align);
+
+	/* fill the transfer with the settings from the last replaced */
+	xfer_new->cs_change = xfer_end->cs_change;
+	xfer_new->delay_usecs = xfer_end->delay_usecs;
+
+	/* set the size of the transfer */
+	xfer_new->len = size;
+
+	/* now fill in the corresponding aligned pointers */
+	if (msg->spi->mode & SPI_3WIRE) {
+		/* if the first transfer has tx_buf set,
+		 * then we are transmitting
+		 */
+		if ((*xfer_start)->tx_buf) {
+			xfer_new->tx_buf = data_tx;
+			xfer_new->rx_buf = NULL;
+		} else {
+			xfer_new->tx_buf = NULL;
+			xfer_new->rx_buf = data_tx;
+		}
+	} else {
+		xfer_new->tx_buf = data_tx;
+		xfer_new->rx_buf = PTR_ALIGN(data_tx + size, align);
+	}
+
+	/* copy the data we need for tx (if it is set) */
+	if (xfer_new->tx_buf) {
+		for (xfer = *xfer_start, i = 0;
+		    i < count;
+		    i++, xfer = list_next_entry(xfer, transfer_list)) {
+			/* fill data only if tx_buf is set */
+			if (xfer->tx_buf)
+				memcpy(data_tx, xfer->tx_buf, xfer->len);
+			/* update pointer to after memcpy for next loop */
+			data_tx += xfer->len;
+		}
+	}
+
+	/* update the transfer to the one we have just put into the list */
+	*xfer_start = xfer_new;
+
+	/* increment statistics counters */
+	SPI_STATISTICS_ADD_TO_FIELD(&master->statistics,
+				    transfers_merged, count);
+	SPI_STATISTICS_ADD_TO_FIELD(&msg->spi->statistics,
+				    transfers_merged, count);
+
+	return 0;
+}
+
+static int __spi_merge_transfers(struct spi_master *master,
+				 struct spi_message *msg,
+				 struct spi_transfer **xfer_start,
+				 size_t min_size,
+				 size_t max_size,
+				 gfp_t gfp)
+{
+	struct spi_transfer *xfer, *xfer_end;
+	int count;
+	size_t size;
+
+	/* loop transfers until we reach
+	 * * the end of the list
+	 * * a change in some essential parameters in spi_transfer
+	 *   compared to the first transfer we check
+	 *   (speed, bits, direction in 3 wire mode)
+	 * * settings that immediately indicate we need to stop testing
+	 *   the next transfer (cs_change, delay_usecs)
+	 */
+	for (count = 0, size = 0, xfer = *xfer_start, xfer_end = xfer;
+	     !list_is_last(&xfer->transfer_list, &msg->transfers);
+	     xfer = list_next_entry(xfer, transfer_list)) {
+		/* now check on total size */
+		if (size + xfer->len > max_size)
+			break;
+		/* these checks are only necessary on subsequent transfers */
+		if (count) {
+			/* check if we differ from the first transfer */
+			if (xfer->speed_hz != (*xfer_start)->speed_hz)
+				break;
+			if (xfer->tx_nbits != (*xfer_start)->tx_nbits)
+				break;
+			if (xfer->rx_nbits != (*xfer_start)->rx_nbits)
+				break;
+			if (xfer->bits_per_word !=
+			    (*xfer_start)->bits_per_word)
+				break;
+
+			/* 3-wire we need to handle in a special way */
+			if (msg->spi->mode & SPI_3WIRE) {
+				/* did we switch directions in 3 wire mode ? */
+				if (xfer->tx_buf && (*xfer_start)->rx_buf)
+					break;
+				if (xfer->rx_buf && (*xfer_start)->tx_buf)
+					break;
+			}
+		}
+		/* otherwise update counters for the last few tests,
+		 * that only depend on settings of the current transfer
+		 */
+		count++;
+		size += xfer->len;
+		xfer_end = xfer;
+
+		/* check for conditions that would trigger a merge
+		 * based only on the current transfer
+		 * so we need count and size updated already...
+		 */
+		if (xfer->cs_change)
+			break;
+		if (xfer->delay_usecs)
+			break;
+	}
+
+	/* merge only when we have at least 2 transfers to handle */
+	if (count < 2)
+		return 0;
+
+	/* and also only if we really have reached our min_size */
+	if (size < min_size)
+		return 0;
+
+	/* do the transformation for real now */
+	return __spi_merge_transfers_do(master, msg,
+					xfer_start, xfer_end,
+					count, size, gfp);
+}
+
+/**
+ * spi_merge_tranfers - merges multiple spi_transfers into a single one
+ *                      copying the corresponding data
+ * @master:    the @spi_master for this transfer
+ * @message:   the @spi_message to transform
+ * @max_size:  the minimum total length when to apply this transform
+ * @max_size:  the maximum total length when to apply this transform
+ * @gfp:       gfp flags
+ *
+ * Return: status of transformation
+ */
+int spi_merge_transfers(struct spi_master *master,
+			struct spi_message *msg,
+			size_t min_size,
+			size_t max_size,
+			gfp_t gfp)
+{
+	struct spi_transfer *xfer;
+	int ret;
+
+	/* nothing to merge if the list is empty */
+	if (list_is_singular(&msg->transfers))
+		return 0;
+
+	/* if the total transfer size is too small, then skip */
+	if (msg->frame_length < min_size)
+		return 0;
+
+	/* iterate over all transfers and modify xfer if we have
+	 * replaced some transfers
+	 */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* test if it is a merge candidate */
+		ret = __spi_merge_transfers(master, msg, &xfer,
+					    min_size, max_size, gfp);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_merge_transfers);
+
 /*-------------------------------------------------------------------------*/
 
 /* Core methods for SPI master protocol drivers.  Some of the
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index deb94a3..7172e73 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -63,6 +63,9 @@ extern struct bus_type spi_bus_type;
  * @transfers_split_unaligned_copy:
  *                 number of transfers that have been aligned by copying
  *                 at least one buffer (typically tx)
+ * @transfers_merged:
+ *                 number of transfers that have been merged to allow
+ *                 for better efficiency using dma
  */
 struct spi_statistics {
 	spinlock_t		lock; /* lock for the whole structure */
@@ -86,6 +89,7 @@ struct spi_statistics {
 	unsigned long transfers_split_maxsize;
 	unsigned long transfers_split_unaligned;
 	unsigned long transfers_split_unaligned_copy;
+	unsigned long transfers_merged;
 };
 
 void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
@@ -945,6 +949,11 @@ extern int spi_split_transfers_unaligned(struct spi_master *master,
 					 size_t min_size,
 					 size_t alignment,
 					 gfp_t gfp);
+extern int spi_merge_transfers(struct spi_master *master,
+			       struct spi_message *msg,
+			       size_t min_size,
+			       size_t max_size,
+			       gfp_t gfp);
 
 /*---------------------------------------------------------------------------*/
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
