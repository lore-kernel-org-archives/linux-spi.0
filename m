From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 3/8] spi: core: add spi_split_transfers_maxsize
Date: Mon, 14 Dec 2015 15:20:20 +0000
Message-ID: <1450106426-2277-4-git-send-email-kernel@martin.sperl.org>
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

Add spi_split_transfers_maxsize method that splits
spi_transfers transparently into multiple transfers
that are below the given max-size.

This makes use of the spi_res framework via
spi_replace_transfers to allocate/free the extra
transfers as well as reverting back the changes applied
while processing the spi_message.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  111 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   15 +++++++
 2 files changed, 126 insertions(+)

Changelog:
  V2 -> V3: split into distinct patches and rewrite

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ede3e57..37e6507 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -145,6 +145,8 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(14, "16384-32767");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");

+SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
+
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
@@ -182,6 +184,7 @@ static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_transfer_bytes_histo14.attr,
 	&dev_attr_spi_device_transfer_bytes_histo15.attr,
 	&dev_attr_spi_device_transfer_bytes_histo16.attr,
+	&dev_attr_spi_device_transfers_split_maxsize.attr,
 	NULL,
 };

@@ -224,6 +227,7 @@ static struct attribute *spi_master_statistics_attrs[] = {
 	&dev_attr_spi_master_transfer_bytes_histo14.attr,
 	&dev_attr_spi_master_transfer_bytes_histo15.attr,
 	&dev_attr_spi_master_transfer_bytes_histo16.attr,
+	&dev_attr_spi_master_transfers_split_maxsize.attr,
 	NULL,
 };

@@ -2235,6 +2239,113 @@ struct spi_replaced_transfers *spi_replace_transfers(
 }
 EXPORT_SYMBOL_GPL(spi_replace_transfers);

+int __spi_split_transfer_maxsize(struct spi_master *master,
+				 struct spi_message *msg,
+				 struct spi_transfer **xferp,
+				 size_t maxsize,
+				 gfp_t gfp)
+{
+	struct spi_transfer *xfer = *xferp, *xfers;
+	struct spi_replaced_transfers *srt;
+	size_t offset;
+	size_t count, i;
+
+	/* warn once about this fact that we are splitting a transfer */
+	dev_warn_once(&msg->spi->dev,
+		      "spi_transfer of length %i exceed max length of %i - needed to split transfers\n",
+		      xfer->len, maxsize);
+
+	/* calculate how many we have to replace */
+	count = DIV_ROUND_UP(xfer->len, maxsize);
+
+	/* create replacement */
+	srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, gfp);
+	if (!srt)
+		return -ENOMEM;
+	xfers = srt->inserted_transfers;
+
+	/* now handle each of those newly inserted spi_transfers
+	 * note that the replacements spi_transfers all are preset
+	 * to the same values as *xferp, so tx_buf, rx_buf and len
+	 * are all identical (as well as most others)
+	 * so we just have to fix up len and the pointers.
+	 *
+	 * this also includes support for the depreciated
+	 * spi_message.is_dma_mapped interface
+	 */
+
+	/* the first transfer just needs the length modified, so we
+	 * run it outside the loop
+	 */
+	xfers[0].len = min(maxsize, xfer[0].len);
+
+	/* all the others need rx_buf/tx_buf also set */
+	for (i = 1, offset = maxsize; i < count; offset += maxsize, i++) {
+		/* update rx_buf, tx_buf and dma */
+		if (xfers[i].rx_buf)
+			xfers[i].rx_buf += offset;
+		if (xfers[i].rx_dma)
+			xfers[i].rx_dma += offset;
+		if (xfers[i].tx_buf)
+			xfers[i].tx_buf += offset;
+		if (xfers[i].tx_dma)
+			xfers[i].tx_dma += offset;
+
+		/* update length */
+		xfers[i].len = min(maxsize, xfers[i].len - offset);
+	}
+
+	/* we set up xferp to the last entry we have inserted,
+	 * so that we skip those already split transfers
+	 */
+	*xferp = &xfers[count - 1];
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
+int spi_split_transfers_maxsize(struct spi_master *master,
+				struct spi_message *msg,
+				size_t maxsize,
+				gfp_t gfp)
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
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->len > maxsize) {
+			ret = __spi_split_transfer_maxsize(
+				master, msg, &xfer, maxsize, gfp);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
+
 /*-------------------------------------------------------------------------*/

 /* Core methods for SPI master protocol drivers.  Some of the
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 13831ed..8ced84a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -53,6 +53,10 @@ extern struct bus_type spi_bus_type;
  *
  * @transfer_bytes_histo:
  *                 transfer bytes histogramm
+ *
+ * @transfers_split_maxsize:
+ *                 number of transfers that have been split because of
+ *                 maxsize limit
  */
 struct spi_statistics {
 	spinlock_t		lock; /* lock for the whole structure */
@@ -72,6 +76,8 @@ struct spi_statistics {

 #define SPI_STATISTICS_HISTO_SIZE 17
 	unsigned long transfer_bytes_histo[SPI_STATISTICS_HISTO_SIZE];
+
+	unsigned long transfers_split_maxsize;
 };

 void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
@@ -920,6 +926,15 @@ extern struct spi_replaced_transfers *spi_replace_transfers(

 /*---------------------------------------------------------------------------*/

+/* SPI transfer transformation methods */
+
+extern int spi_split_transfers_maxsize(struct spi_master *master,
+				       struct spi_message *msg,
+				       size_t maxsize,
+				       gfp_t gfp);
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
