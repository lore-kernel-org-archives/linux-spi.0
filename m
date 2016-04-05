From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: cadence: Remove the clock enable and disable from suspend and resume" to the spi tree
Date: Tue, 05 Apr 2016 11:51:52 -0700
Message-ID: <E1anW4u-0000OQ-2E@finisterre>
References: <1459879674-13012-6-git-send-email-shubhraj@xilinx.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459879674-13012-6-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: cadence: Remove the clock enable and disable from suspend and resume

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

>From 2198b7483d4a89cf2cc710045c76a76dba573ea5 Mon Sep 17 00:00:00 2001
From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Date: Tue, 5 Apr 2016 23:37:53 +0530
Subject: [PATCH] spi: cadence: Remove the clock enable and disable from
 suspend and resume

Now that the clocks are enabled and disabled per transaction
, remove the clock enable and disable from resume and suspend
hooks.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 3b94063b2823..d0cdd1801e9e 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -621,14 +621,9 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
 	spi_master_suspend(master);
 
-	clk_disable_unprepare(xspi->ref_clk);
-
-	clk_disable_unprepare(xspi->pclk);
-
 	return 0;
 }
 
@@ -644,21 +639,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
-	struct cdns_spi *xspi = spi_master_get_devdata(master);
-	int ret = 0;
-
-	ret = clk_prepare_enable(xspi->pclk);
-	if (ret) {
-		dev_err(dev, "Cannot enable APB clock.\n");
-		return ret;
-	}
 
-	ret = clk_prepare_enable(xspi->ref_clk);
-	if (ret) {
-		dev_err(dev, "Cannot enable device clock.\n");
-		clk_disable(xspi->pclk);
-		return ret;
-	}
 	spi_master_resume(master);
 
 	return 0;
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
