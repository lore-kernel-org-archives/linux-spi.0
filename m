From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 4/4] spi/bcm63xx: fix pm sleep support
Date: Tue, 17 Dec 2013 21:42:10 +0100
Message-ID: <1387312930-22436-5-git-send-email-jogo@openwrt.org>
References: <1387312930-22436-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387312930-22436-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the correct symbol to guard the callbacks and use appropriate defines
for setting up the ops struct.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 0c8c68a..77286ae 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -436,7 +436,7 @@ static int bcm63xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int bcm63xx_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
@@ -463,22 +463,17 @@ static int bcm63xx_spi_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops bcm63xx_spi_pm_ops = {
-	.suspend	= bcm63xx_spi_suspend,
-	.resume		= bcm63xx_spi_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(bcm63xx_spi_suspend, bcm63xx_spi_resume)
 };
 
-#define BCM63XX_SPI_PM_OPS	(&bcm63xx_spi_pm_ops)
-#else
-#define BCM63XX_SPI_PM_OPS	NULL
-#endif
-
 static struct platform_driver bcm63xx_spi_driver = {
 	.driver = {
 		.name	= "bcm63xx-spi",
 		.owner	= THIS_MODULE,
-		.pm	= BCM63XX_SPI_PM_OPS,
+		.pm	= &bcm63xx_spi_pm_ops,
 	},
 	.probe		= bcm63xx_spi_probe,
 	.remove		= bcm63xx_spi_remove,
-- 
1.8.5.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
