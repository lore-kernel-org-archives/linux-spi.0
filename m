From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] spi: spidev: Warn loudly if instantiated from DT as "spidev"
Date: Fri, 27 Mar 2015 16:42:22 -0700
Message-ID: <1427499742-26916-1-git-send-email-broonie@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since spidev is a detail of how Linux controls a device rather than a
description of the hardware in the system we should never have a node
described as "spidev" in DT, any SPI device could be a spidev so this
is just not a useful description.

In order to help prevent users from writing such device trees generate a
warning if spidev is instantiated as a DT node without an ID in the match
table.

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 23ad97807797..92c909eed6b5 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -703,6 +703,14 @@ static const struct file_operations spidev_fops = {
 
 static struct class *spidev_class;
 
+#ifdef CONFIG_OF
+static const struct of_device_id spidev_dt_ids[] = {
+	{ .compatible = "rohm,dh2228fv" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spidev_dt_ids);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 static int spidev_probe(struct spi_device *spi)
@@ -711,6 +719,17 @@ static int spidev_probe(struct spi_device *spi)
 	int			status;
 	unsigned long		minor;
 
+	/*
+	 * spidev should never be referenced in DT without a specific
+	 * compatbile string, it is a Linux implementation thing
+	 * rather than a description of the hardware.
+	 */
+	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
+		dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
+		WARN_ON(spi->dev.of_node &&
+			!of_match_device(spidev_dt_ids, &spi->dev));
+	}
+
 	/* Allocate driver data */
 	spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
 	if (!spidev)
@@ -777,13 +796,6 @@ static int spidev_remove(struct spi_device *spi)
 	return 0;
 }
 
-static const struct of_device_id spidev_dt_ids[] = {
-	{ .compatible = "rohm,dh2228fv" },
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-
 static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
