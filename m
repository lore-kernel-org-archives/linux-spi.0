From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 3/3] spi: rspi: Add runtime PM support, using spi core auto_runtime_pm
Date: Tue, 11 Mar 2014 10:59:12 +0100
Message-ID: <1394531952-3905-3-git-send-email-geert@linux-m68k.org>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394531952-3905-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-rspi.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 92bec7e91046..1fb0ad213324 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -33,6 +33,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/rspi.h>
@@ -1111,7 +1112,7 @@ static int rspi_remove(struct platform_device *pdev)
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
 	rspi_release_dma(rspi);
-	clk_disable_unprepare(rspi->clk);
+	pm_runtime_disable(&pdev->dev);
 
 	return 0;
 }
@@ -1242,16 +1243,13 @@ static int rspi_probe(struct platform_device *pdev)
 		goto error1;
 	}
 
-	ret = clk_prepare_enable(rspi->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to prepare/enable clock\n");
-		goto error1;
-	}
+	pm_runtime_enable(&pdev->dev);
 
 	init_waitqueue_head(&rspi->wait);
 
 	master->bus_num = pdev->id;
 	master->setup = rspi_setup;
+	master->auto_runtime_pm = true;
 	master->transfer_one = ops->transfer_one;
 	master->prepare_message = rspi_prepare_message;
 	master->unprepare_message = rspi_unprepare_message;
@@ -1312,7 +1310,7 @@ static int rspi_probe(struct platform_device *pdev)
 error3:
 	rspi_release_dma(rspi);
 error2:
-	clk_disable_unprepare(rspi->clk);
+	pm_runtime_disable(&pdev->dev);
 error1:
 	spi_master_put(master);
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
