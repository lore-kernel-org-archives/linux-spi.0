From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 3/3] spi/bcm63xx-hsspi: fix pm sleep support
Date: Tue, 17 Dec 2013 21:44:48 +0100
Message-ID: <1387313088-22493-4-git-send-email-jogo@openwrt.org>
References: <1387313088-22493-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387313088-22493-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the right CONFIG symbol to guard, properly (un)preprare clocks on
suspend/resume, and check the result of it.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 1721ea9..b528f9f 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -425,14 +425,14 @@ static int bcm63xx_hsspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int bcm63xx_hsspi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
 
 	spi_master_suspend(master);
-	clk_disable(bs->clk);
+	clk_disable_unprepare(bs->clk);
 
 	return 0;
 }
@@ -441,30 +441,27 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(bs->clk);
+	if (ret)
+		return ret;
 
-	clk_enable(bs->clk);
 	spi_master_resume(master);
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops bcm63xx_hsspi_pm_ops = {
-	.suspend	= bcm63xx_hsspi_suspend,
-	.resume		= bcm63xx_hsspi_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(bcm63xx_hsspi_suspend, bcm63xx_hsspi_resume)
 };
 
-#define BCM63XX_HSSPI_PM_OPS	(&bcm63xx_hsspi_pm_ops)
-#else
-#define BCM63XX_HSSPI_PM_OPS	NULL
-#endif
-
-
-
 static struct platform_driver bcm63xx_hsspi_driver = {
 	.driver = {
 		.name	= "bcm63xx-hsspi",
 		.owner	= THIS_MODULE,
-		.pm	= BCM63XX_HSSPI_PM_OPS,
+		.pm	= &bcm63xx_hsspi_pm_ops,
 	},
 	.probe		= bcm63xx_hsspi_probe,
 	.remove		= bcm63xx_hsspi_remove,
-- 
1.8.5.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
