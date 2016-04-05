From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] spi: cadence: Remove the clock enable and disable from suspend and resume
Date: Tue, 5 Apr 2016 23:37:53 +0530
Message-ID: <1459879674-13012-6-git-send-email-shubhraj@xilinx.com>
References: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459879674-13012-1-git-send-email-shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Now that the clocks are enabled and disabled per transaction
, remove the clock enable and disable from resume and suspend
hooks.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-cadence.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 3b94063..d0cdd18 100644
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
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
