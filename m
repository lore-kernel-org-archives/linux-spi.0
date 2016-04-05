From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/7] spi: cadence: Fix probe error handling
Date: Tue, 5 Apr 2016 23:37:50 +0530
Message-ID: <1459879674-13012-3-git-send-email-shubhraj@xilinx.com>
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

The clock disabling is missed out in some
error cases at probe. Fix the same.

Signed-off-by: Shubhrajyoti Datta <shubhraj-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-cadence.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 97a3bf6..2915b25 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -527,7 +527,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (irq <= 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "irq number is invalid\n");
-		goto remove_master;
+		goto clk_dis_all;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, cdns_spi_irq,
@@ -535,7 +535,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto remove_master;
+		goto clk_dis_all;
 	}
 
 	master->prepare_transfer_hardware = cdns_prepare_transfer_hardware;
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
