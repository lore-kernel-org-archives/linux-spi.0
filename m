From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: add transfer histogram statistics via sysfs" to the spi tree
Date: Sat, 19 Sep 2015 17:13:16 -0700
Message-ID: <E1ZdSFo-0004DK-I8@finisterre>
References: <1434978124-2396-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434978124-2396-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: add transfer histogram statistics via sysfs

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

>From 6b7bc0618ff1a333d2265131b124e966335d5dee Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Mon, 22 Jun 2015 13:02:04 +0000
Subject: [PATCH] spi: add transfer histogram statistics via sysfs

report transfer sizes as a histogram via the following files:
  /sys/class/spi_master/spi*/statistics/transfer_bytes_histo_*
  /sys/class/spi_master/spi*/spi*.*/statistics/transfer_bytes_histo_*

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 61 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3abb390..73face0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -123,6 +123,28 @@ SPI_STATISTICS_SHOW(bytes, "%llu");
 SPI_STATISTICS_SHOW(bytes_rx, "%llu");
 SPI_STATISTICS_SHOW(bytes_tx, "%llu");
 
+#define SPI_STATISTICS_TRANSFER_BYTES_HISTO(index, number)		\
+	SPI_STATISTICS_SHOW_NAME(transfer_bytes_histo##index,		\
+				 "transfer_bytes_histo_" number,	\
+				 transfer_bytes_histo[index],  "%lu")
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(0,  "0-1");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(1,  "2-3");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(2,  "4-7");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(3,  "8-15");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(4,  "16-31");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(5,  "32-63");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(6,  "64-127");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(7,  "128-255");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(8,  "256-511");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(9,  "512-1023");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(10, "1024-2047");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(11, "2048-4095");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(12, "4096-8191");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(13, "8192-16383");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(14, "16384-32767");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(15, "32768-65535");
+SPI_STATISTICS_TRANSFER_BYTES_HISTO(16, "65536+");
+
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
@@ -143,6 +165,23 @@ static struct attribute *spi_device_statistics_attrs[] = {
 	&dev_attr_spi_device_bytes.attr,
 	&dev_attr_spi_device_bytes_rx.attr,
 	&dev_attr_spi_device_bytes_tx.attr,
+	&dev_attr_spi_device_transfer_bytes_histo0.attr,
+	&dev_attr_spi_device_transfer_bytes_histo1.attr,
+	&dev_attr_spi_device_transfer_bytes_histo2.attr,
+	&dev_attr_spi_device_transfer_bytes_histo3.attr,
+	&dev_attr_spi_device_transfer_bytes_histo4.attr,
+	&dev_attr_spi_device_transfer_bytes_histo5.attr,
+	&dev_attr_spi_device_transfer_bytes_histo6.attr,
+	&dev_attr_spi_device_transfer_bytes_histo7.attr,
+	&dev_attr_spi_device_transfer_bytes_histo8.attr,
+	&dev_attr_spi_device_transfer_bytes_histo9.attr,
+	&dev_attr_spi_device_transfer_bytes_histo10.attr,
+	&dev_attr_spi_device_transfer_bytes_histo11.attr,
+	&dev_attr_spi_device_transfer_bytes_histo12.attr,
+	&dev_attr_spi_device_transfer_bytes_histo13.attr,
+	&dev_attr_spi_device_transfer_bytes_histo14.attr,
+	&dev_attr_spi_device_transfer_bytes_histo15.attr,
+	&dev_attr_spi_device_transfer_bytes_histo16.attr,
 	NULL,
 };
 
@@ -168,6 +207,23 @@ static struct attribute *spi_master_statistics_attrs[] = {
 	&dev_attr_spi_master_bytes.attr,
 	&dev_attr_spi_master_bytes_rx.attr,
 	&dev_attr_spi_master_bytes_tx.attr,
+	&dev_attr_spi_master_transfer_bytes_histo0.attr,
+	&dev_attr_spi_master_transfer_bytes_histo1.attr,
+	&dev_attr_spi_master_transfer_bytes_histo2.attr,
+	&dev_attr_spi_master_transfer_bytes_histo3.attr,
+	&dev_attr_spi_master_transfer_bytes_histo4.attr,
+	&dev_attr_spi_master_transfer_bytes_histo5.attr,
+	&dev_attr_spi_master_transfer_bytes_histo6.attr,
+	&dev_attr_spi_master_transfer_bytes_histo7.attr,
+	&dev_attr_spi_master_transfer_bytes_histo8.attr,
+	&dev_attr_spi_master_transfer_bytes_histo9.attr,
+	&dev_attr_spi_master_transfer_bytes_histo10.attr,
+	&dev_attr_spi_master_transfer_bytes_histo11.attr,
+	&dev_attr_spi_master_transfer_bytes_histo12.attr,
+	&dev_attr_spi_master_transfer_bytes_histo13.attr,
+	&dev_attr_spi_master_transfer_bytes_histo14.attr,
+	&dev_attr_spi_master_transfer_bytes_histo15.attr,
+	&dev_attr_spi_master_transfer_bytes_histo16.attr,
 	NULL,
 };
 
@@ -186,10 +242,15 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 				       struct spi_master *master)
 {
 	unsigned long flags;
+	int l2len = min(fls(xfer->len), SPI_STATISTICS_HISTO_SIZE) - 1;
+
+	if (l2len < 0)
+		l2len = 0;
 
 	spin_lock_irqsave(&stats->lock, flags);
 
 	stats->transfers++;
+	stats->transfer_bytes_histo[l2len]++;
 
 	stats->bytes += xfer->len;
 	if ((xfer->tx_buf) &&
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 269e8af..5b6fdc4 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -51,6 +51,8 @@ extern struct bus_type spi_bus_type;
  * @bytes_tx:      number of bytes sent to device
  * @bytes_rx:      number of bytes received from device
  *
+ * @transfer_bytes_histo:
+ *                 transfer bytes histogramm
  */
 struct spi_statistics {
 	spinlock_t		lock; /* lock for the whole structure */
@@ -68,6 +70,8 @@ struct spi_statistics {
 	unsigned long long	bytes_rx;
 	unsigned long long	bytes_tx;
 
+#define SPI_STATISTICS_HISTO_SIZE 17
+	unsigned long transfer_bytes_histo[SPI_STATISTICS_HISTO_SIZE];
 };
 
 void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
