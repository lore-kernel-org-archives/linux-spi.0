From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: cadence: Return the error code for cdns_spi_suspend and cdns_spi_resume" to the spi tree
Date: Tue, 05 Apr 2016 11:51:51 -0700
Message-ID: <E1anW4t-0000Nk-3f@finisterre>
References: <1459879674-13012-7-git-send-email-shubhraj@xilinx.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459879674-13012-7-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: cadence: Return the error code for cdns_spi_suspend and cdns_spi_resume

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

>From 6fe9b67dbe5e0a0abeeabd428cb596b913995b36 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Date: Tue, 5 Apr 2016 23:37:54 +0530
Subject: [PATCH] spi: cadence: Return the error code for cdns_spi_suspend and
 cdns_spi_resume

Return the error code for cdns_spi_suspend and cdns_spi_resume.
Also fixes a comment where which claims that the error code is
returned.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index d0cdd1801e9e..07481e12d8a3 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -615,16 +615,14 @@ static int cdns_spi_remove(struct platform_device *pdev)
  * This function disables the SPI controller and
  * changes the driver state to "suspend"
  *
- * Return:	Always 0
+ * Return:	0 on success and error value on error
  */
 static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 
-	spi_master_suspend(master);
-
-	return 0;
+	return spi_master_suspend(master);
 }
 
 /**
@@ -640,9 +638,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
 
-	spi_master_resume(master);
-
-	return 0;
+	return spi_master_resume(master);
 }
 
 /**
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
