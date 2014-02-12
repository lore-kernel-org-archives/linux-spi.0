From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] spi: sirf: use SET_SYSTEM_SLEEP_PM_OPS to initialize PM entries
Date: Thu, 13 Feb 2014 00:30:20 +0800
Message-ID: <1392222620-17273-3-git-send-email-21cnbao@gmail.com>
References: <1392222620-17273-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392222620-17273-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

use SET_SYSTEM_SLEEP_PM_OPS to initialize PM entries, this makes the codes
clean and also enable the ability of hibernation support for sirf SPI.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a213e87..5bffa5f 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -739,7 +739,7 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int spi_sirfsoc_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -762,12 +762,11 @@ static int spi_sirfsoc_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops spi_sirfsoc_pm_ops = {
-	.suspend = spi_sirfsoc_suspend,
-	.resume = spi_sirfsoc_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(spi_sirfsoc_suspend, spi_sirfsoc_resume)
 };
-#endif
 
 static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,prima2-spi", },
@@ -780,9 +779,7 @@ static struct platform_driver spi_sirfsoc_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
-#ifdef CONFIG_PM
 		.pm     = &spi_sirfsoc_pm_ops,
-#endif
 		.of_match_table = spi_sirfsoc_of_match,
 	},
 	.probe = spi_sirfsoc_probe,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
