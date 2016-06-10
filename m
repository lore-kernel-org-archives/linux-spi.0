From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: spidev: Allow matching DT compatible strings from ACPI
Date: Fri, 10 Jun 2016 13:55:47 +0300
Message-ID: <1465556147-86198-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Allow the same devices to be used in ACPI based systems if they provide
proper DT compatible string.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spidev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f30f591..86a4c28b9e58 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -691,14 +691,12 @@ static const struct file_operations spidev_fops = {
 
 static struct class *spidev_class;
 
-#ifdef CONFIG_OF
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "rohm,dh2228fv" },
 	{ .compatible = "lineartechnology,ltc2488" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-#endif
 
 /*-------------------------------------------------------------------------*/
 
@@ -788,7 +786,7 @@ static int spidev_remove(struct spi_device *spi)
 static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
-		.of_match_table = of_match_ptr(spidev_dt_ids),
+		.of_match_table = spidev_dt_ids,
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
