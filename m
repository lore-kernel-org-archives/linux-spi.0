From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: bcm-qspi: fix suspend/resume #ifdef" to the spi tree
Date: Fri, 16 Sep 2016 18:40:40 +0100
Message-ID: <E1bkx7w-0004CB-R7@debutante>
References: <20160915154712.3007781-1-arnd@arndb.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Yendapally Reddy Dhananjaya Reddy
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160915154712.3007781-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: bcm-qspi: fix suspend/resume #ifdef

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

>From a0319f8b12c0fb9800da61f4cba9bd6fd80e37a4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Thu, 15 Sep 2016 17:46:53 +0200
Subject: [PATCH] spi: bcm-qspi: fix suspend/resume #ifdef

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
