From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: add spi_split_transfers_maxsize" to the spi tree
Date: Tue, 09 Feb 2016 19:43:13 +0000
Message-ID: <E1aTEBt-0003JV-L6@debutante>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: add spi_split_transfers_maxsize

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d9f1212272818420fcde611a940c1ad611a8b785 Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Mon, 14 Dec 2015 15:20:20 +0000
Subject: [PATCH] spi: core: add spi_split_transfers_maxsize

Add spi_split_transfers_maxsize method that splits
spi_transfers transparently into multiple transfers
that are below the given max-size.

This makes use of the spi_res framework via
spi_replace_transfers to allocate/free the extra
transfers as well as reverting back the changes applied
while processing the spi_message.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  15 +++++++
 2 files changed, 126 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2ec8e66a8098..34e3741504f9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -144,6 +144,8 @@ SPI_STATISTICS_TRANSFER_BYTES_HISTO(14, "16384-32767");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
 SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");
 
+SPI_STATISTICS_SHOW(transfers_split_maxsize, "%lu");
+
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
@@ -181,6 +183,7 @@ static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_transfer_bytes_histo14.attr,
 	&dev_attr_spi_device_transfer_bytes_histo15.attr,
 	&dev_attr_spi_device_transfer_bytes_histo16.attr,
+	&dev_attr_spi_device_transfers_split_maxsize.attr,
 	NULL,
 };
 
@@ -223,6 +226,7 @@ static struct attribute *spi_master_statistics_attrs[] = {
 	&dev_attr_spi_master_transfer_bytes_histo14.attr,
 	&dev_attr_spi_master_transfer_bytes_histo15.attr,
 	&dev_attr_spi_master_transfer_bytes_histo16.attr,
+	&dev_attr_spi_master_transfers_split_maxsize.attr,
 	NULL,
 };
 
@@ -2237,6 +2241,113 @@ struct spi_replaced_transfers *spi_replace_transfers(
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
index d71385756fee..3c02b4d06268 100644
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
@@ -935,6 +941,15 @@ extern struct spi_replaced_transfers *spi_replace_transfers(
 
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
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
