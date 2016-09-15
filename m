From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: bcm-qspi: fix suspend/resume #ifdef
Date: Thu, 15 Sep 2016 17:46:53 +0200
Message-ID: <20160915154712.3007781-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The two power management functions are define inside of an #ifdef
but referenced unconditionally, which is obviously broken when
CONFIG_PM_SLEEP is not set:

drivers/spi/spi-bcm-qspi.c:1300:13: error: 'bcm_qspi_suspend' undeclared here (not in a function)
drivers/spi/spi-bcm-qspi.c:1301:13: error: 'bcm_qspi_resume' undeclared here (not in a function)

This replaces the #ifdef with a __maybe_unused annotation that lets
the compiler figure out whether to drop the functions itself,
and uses SIMPLE_DEV_PM_OPS() to refer to the functions.

This will also fill the freeze/thaw/poweroff/restore callback
pointers in addition to suspend/resume, but as far as I can tell,
this is what we want.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
---
 drivers/spi/spi-bcm-qspi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 5da182be073e..64e693de1486 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1268,8 +1268,7 @@ int bcm_qspi_remove(struct platform_device *pdev)
 /* function to be called by SoC specific platform driver remove() */
 EXPORT_SYMBOL_GPL(bcm_qspi_remove);
 
-#ifdef CONFIG_PM_SLEEP
-static int bcm_qspi_suspend(struct device *dev)
+static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 {
 	struct bcm_qspi *qspi = dev_get_drvdata(dev);
 
@@ -1280,7 +1279,7 @@ static int bcm_qspi_suspend(struct device *dev)
 	return 0;
 };
 
-static int bcm_qspi_resume(struct device *dev)
+static int __maybe_unused bcm_qspi_resume(struct device *dev)
 {
 	struct bcm_qspi *qspi = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1293,12 +1292,9 @@ static int bcm_qspi_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-const struct dev_pm_ops bcm_qspi_pm_ops = {
-	.suspend = bcm_qspi_suspend,
-	.resume  = bcm_qspi_resume,
-};
+SIMPLE_DEV_PM_OPS(bcm_qspi_pm_ops, bcm_qspi_suspend, bcm_qspi_resume);
+
 /* pm_ops to be called by SoC specific platform driver */
 EXPORT_SYMBOL_GPL(bcm_qspi_pm_ops);
 
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
