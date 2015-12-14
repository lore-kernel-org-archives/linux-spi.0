From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 4/8] spi: core: added spi_split_transfers_unaligned
Date: Mon, 14 Dec 2015 15:20:21 +0000
Message-ID: <1450106426-2277-5-git-send-email-kernel@martin.sperl.org>
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

Added code that splits a single spi_transfer into 2 transfers
in case either transfer-buffer is not aligned.

In the case of rx and tx_buf misaligned to different offsets,
the tx_buf is also copied to an aligned address so that the
whole transfer is aligned on both buffers.

We chose tx_buf to get copied because this may allow us to
use CPU resources (or different cores) in parallel to an
already running transfer in the future and avoids a
syncronous copy after the transfer is finished.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  206 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   13 +++
 2 files changed, 219 insertions(+)

Changelog:
  V1 -> V3: split into distinct patches and rewrite to allow for copy

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 37e6507..f276c99 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -146,6 +146,8 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");

 SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
+SPI_STATISTICS_SHOW(transfers_split_unaligned, "%lu");
+SPI_STATISTICS_SHOW(transfers_split_unaligned_copy, "%lu");

 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
@@ -185,6 +187,8 @@ static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_transfer_bytes_histo15.attr,
 	&dev_attr_spi_device_transfer_bytes_histo16.attr,
 	&dev_attr_spi_device_transfers_split_maxsize.attr,
+	&dev_attr_spi_device_transfers_split_unaligned.attr,
+	&dev_attr_spi_device_transfers_split_unaligned_copy.attr,
 	NULL,
 };

@@ -228,6 +232,8 @@ static struct attribute *spi_master_statistics_attrs[] = {
 	&dev_attr_spi_master_transfer_bytes_histo15.attr,
 	&dev_attr_spi_master_transfer_bytes_histo16.attr,
 	&dev_attr_spi_master_transfers_split_maxsize.attr,
+	&dev_attr_spi_master_transfers_split_unaligned.attr,
+	&dev_attr_spi_master_transfers_split_unaligned_copy.attr,
 	NULL,
 };

@@ -2346,6 +2352,206 @@ int spi_split_transfers_maxsize(struct spi_master *master,
 }
 EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);

+static int __spi_split_transfer_unaligned_do(
+	struct spi_master *master,
+	struct spi_message *msg,
+	struct spi_transfer **xferp,
+	size_t alignment,
+	size_t alignment_to_correct,
+	bool copy_tx,
+	gfp_t gfp)
+{
+	struct spi_transfer *xfers;
+	struct spi_replaced_transfers *srt;
+	size_t alignment_shift;
+	size_t extra = 0;
+	void *data;
+
+	/* warn once about this fact that we are splitting */
+	dev_warn_once(&msg->spi->dev,
+		      "spi_transfer with misaligned buffers - had to split transfers\n");
+
+	/* the number of bytes by which we need to shift to align */
+	alignment_shift = BIT(alignment) - alignment_to_correct;
+
+	/* calculate extra buffer we need to allocate to align tx by copy */
+	if (copy_tx)
+		extra = (*xferp)->len - alignment_shift + BIT(alignment);
+
+	/* replace the transfer */
+	srt = spi_replace_transfers(msg, *xferp, 1, 2, NULL, extra, gfp);
+	if (!srt)
+		return -ENOMEM;
+	xfers = srt->inserted_transfers;
+
+	/* for the first transfer we only set the length */
+	xfers[0].len = alignment_shift;
+
+	/* for the second transfer we need to shift the pointers as well
+	 * as modify length (substracting the len we transfer in the first)
+	 */
+	xfers[1].len -= alignment_shift;
+	if (xfers[1].tx_buf)
+		xfers[1].tx_buf += alignment_shift;
+	if (xfers[1].rx_buf)
+		xfers[1].rx_buf += alignment_shift;
+	if (xfers[1].tx_dma)
+		xfers[1].tx_dma += alignment_shift;
+	if (xfers[1].rx_dma)
+		xfers[1].rx_dma += alignment_shift;
+
+	/* handle copy_tx  */
+	if (copy_tx) {
+		data = PTR_ALIGN(srt->extradata, alignment);
+
+		/* copy data from old to new */
+		memcpy(data, xfers[1].tx_buf, xfers[1].len);
+
+		/* set up the pointer to the new buffer */
+		xfers[1].tx_buf = data;
+
+		/* force the tx_dma/rx_dma buffers to be unset */
+		xfers[1].tx_dma = 0;
+		xfers[1].rx_dma = 0;
+
+		/* warn once about this fact that we are also copying */
+		dev_warn_once(&msg->spi->dev, "spi_transfer rx/tx buffers are misaligned to different offsets - need to copy tx_buf to fix it\n");
+		/* increment statistics counters */
+		SPI_STATISTICS_INCREMENT_FIELD(
+			&master->statistics,
+			transfers_split_unaligned_copy);
+		SPI_STATISTICS_INCREMENT_FIELD(
+			&msg->spi->statistics,
+			transfers_split_unaligned_copy);
+	}
+
+	/* finally we can set up xferp as xfers[1] */
+	*xferp = &xfers[1];
+
+	/* increment statistics counters */
+	SPI_STATISTICS_INCREMENT_FIELD(&master->statistics,
+				       transfers_split_unaligned);
+	SPI_STATISTICS_INCREMENT_FIELD(&msg->spi->statistics,
+				       transfers_split_unaligned);
+
+	return 0;
+}
+
+static int __spi_split_transfer_unaligned_check(
+	struct spi_master *master,
+	struct spi_message *msg,
+	struct spi_transfer **xferp,
+	size_t alignment,
+	gfp_t gfp)
+{
+	struct spi_transfer *xfer = *xferp;
+	size_t alignment_mask;
+
+	const char *tx_start, *rx_start; /* the rx/tx_buf address */
+	const char *tx_end, *rx_end; /* the last byte of the transfer */
+	size_t tx_start_page, rx_start_page; /* the "page address" for start */
+	size_t tx_end_page, rx_end_page; /* the "page address" for end */
+	size_t tx_start_align, rx_start_align; /* alignment of buf address */
+
+	/* calculate the values */
+	alignment_mask = (1 << alignment) - 1;
+
+	tx_start = xfer->tx_buf;
+	tx_start_align = ((size_t)tx_start & alignment_mask);
+
+	rx_start = xfer->rx_buf;
+	rx_start_align = ((size_t)rx_start & alignment_mask);
+
+	/* if the start alignment is 0 for both rx and tx */
+	if ((!rx_start_align) && (!tx_start_align))
+		return 0;
+
+	/* the end pointer */
+	tx_end = tx_start ? &tx_start[xfer->len - 1] : NULL;
+	rx_end = rx_start ? &tx_start[xfer->len - 1] : NULL;
+
+	/* and the page addresses - mostly needed to see if the transfer
+	 * spills over a page boundary
+	 */
+	tx_start_page = (size_t)tx_start & (PAGE_SIZE - 1);
+	tx_end_page = (size_t)tx_end & (PAGE_SIZE - 1);
+	rx_start_page = (size_t)rx_start & (PAGE_SIZE - 1);
+	rx_end_page = (size_t)rx_end & (PAGE_SIZE - 1);
+
+	/* if we are on the same end-page, then there is nothing to do */
+	if ((tx_start_page == tx_end_page) &&
+	    (rx_start_page == rx_end_page))
+		return 0;
+
+	/* if tx_align (not 0 means also not null) and rx_start is null */
+	if (tx_start_align && (!rx_start))
+		return __spi_split_transfer_unaligned_do(
+			master, msg, xferp, alignment, tx_start_align,
+			false, gfp);
+
+	/* if rx_align (not 0 means also not null) and tx_start is null */
+	if (rx_start_align && (!tx_start))
+		return __spi_split_transfer_unaligned_do(
+			master, msg, xferp, alignment, rx_start_align,
+			false, gfp);
+
+	/* if the alignment for both is identical */
+	if (rx_start_align == tx_start_align)
+		return __spi_split_transfer_unaligned_do(
+			master, msg, xferp, alignment, rx_start_align,
+			false, gfp);
+
+	/* for the final case with tx and rx of different alignment
+	 * we just align rx and copy tx to an alligned transfer
+	 */
+	return __spi_split_transfer_unaligned_do(
+		master, msg, xferp, alignment, rx_start_align, true, gfp);
+}
+
+/**
+ * spi_split_tranfers_unaligned - split spi transfers into multiple transfers
+ *                                when rx_buf or tx_buf are unaligned
+ *                                and the transfer size is above minimum
+ * @master:    the @spi_master for this transfer
+ * @message:   the @spi_message to transform
+ * @min_size:  the minimum size when to apply this
+ * @alignment: the alignment  that we require
+ * @gfp:       gfp flags
+ *
+ * Return: status of transformation
+ *
+ * note that the "first" transfer is always unaligned,
+ * but its length is always < (1 << alignment) - this assumes that
+ * the first transfer gets done in PIO mode
+ */
+int spi_split_transfers_unaligned(struct spi_master *master,
+				  struct spi_message *message,
+				  size_t min_size,
+				  size_t alignment,
+				  gfp_t gfp)
+{
+	struct spi_transfer *xfer;
+	int ret;
+
+	/* iterate over the transfer_list,
+	 * but note that xfer is advanced to the last transfer inserted
+	 * to avoid checking sizes again unnecessarily (also xfer does
+	 * potentiall belong to a different list by the time the
+	 * replacement has happened
+	 */
+	list_for_each_entry(xfer, &message->transfers, transfer_list) {
+		if (xfer->len >= min_size) {
+			ret = __spi_split_transfer_unaligned_check(
+				master, message, &xfer, alignment, gfp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_split_transfers_unaligned);
+
 /*-------------------------------------------------------------------------*/

 /* Core methods for SPI master protocol drivers.  Some of the
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8ced84a..deb94a3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -57,6 +57,12 @@ extern struct bus_type spi_bus_type;
  * @transfers_split_maxsize:
  *                 number of transfers that have been split because of
  *                 maxsize limit
+ * @transfers_split_unaligned:
+ *                 number of transfers that have been split because of
+ *                 alignment issues
+ * @transfers_split_unaligned_copy:
+ *                 number of transfers that have been aligned by copying
+ *                 at least one buffer (typically tx)
  */
 struct spi_statistics {
 	spinlock_t		lock; /* lock for the whole structure */
@@ -78,6 +84,8 @@ struct spi_statistics {
 	unsigned long transfer_bytes_histo[SPI_STATISTICS_HISTO_SIZE];

 	unsigned long transfers_split_maxsize;
+	unsigned long transfers_split_unaligned;
+	unsigned long transfers_split_unaligned_copy;
 };

 void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
@@ -932,6 +940,11 @@ extern int spi_split_transfers_maxsize(struct spi_master *master,
 				       struct spi_message *msg,
 				       size_t maxsize,
 				       gfp_t gfp);
+extern int spi_split_transfers_unaligned(struct spi_master *master,
+					 struct spi_message *msg,
+					 size_t min_size,
+					 size_t alignment,
+					 gfp_t gfp);

 /*---------------------------------------------------------------------------*/

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
