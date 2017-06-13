From: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 1/4] spi: rockchip: fix error handling when probe
Date: Tue, 13 Jun 2017 13:25:40 +0800
Message-ID: <1497331543-8565-1-git-send-email-jeffy.chen@rock-chips.com>
Cc: briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org,
        Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

After failed to request dma tx chain, we need to disable pm_runtime.
Also cleanup error labels for better readability.

Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

Changes in v2: None

 drivers/spi/spi-rockchip.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index acf31f3..bab9b13 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -684,33 +684,33 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(rs->regs)) {
 		ret =  PTR_ERR(rs->regs);
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	rs->apb_pclk = devm_clk_get(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
 		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
 		ret = PTR_ERR(rs->apb_pclk);
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	rs->spiclk = devm_clk_get(&pdev->dev, "spiclk");
 	if (IS_ERR(rs->spiclk)) {
 		dev_err(&pdev->dev, "Failed to get spi_pclk\n");
 		ret = PTR_ERR(rs->spiclk);
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	ret = clk_prepare_enable(rs->apb_pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable apb_pclk\n");
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	ret = clk_prepare_enable(rs->spiclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable spi_clk\n");
-		goto err_spiclk_enable;
+		goto err_disable_apbclk;
 	}
 
 	spi_enable_chip(rs, 0);
@@ -728,7 +728,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (!rs->fifo_len) {
 		dev_err(&pdev->dev, "Failed to get fifo length\n");
 		ret = -EINVAL;
-		goto err_get_fifo_len;
+		goto err_disable_spiclk;
 	}
 
 	spin_lock_init(&rs->lock);
@@ -755,7 +755,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		/* Check tx to see if we need defer probing driver */
 		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_get_fifo_len;
+			goto err_disable_pm_runtime;
 		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
 		rs->dma_tx.ch = NULL;
@@ -786,23 +786,24 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register master\n");
-		goto err_register_master;
+		goto err_free_dma_rx;
 	}
 
 	return 0;
 
-err_register_master:
-	pm_runtime_disable(&pdev->dev);
+err_free_dma_rx:
 	if (rs->dma_rx.ch)
 		dma_release_channel(rs->dma_rx.ch);
 err_free_dma_tx:
 	if (rs->dma_tx.ch)
 		dma_release_channel(rs->dma_tx.ch);
-err_get_fifo_len:
+err_disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+err_disable_spiclk:
 	clk_disable_unprepare(rs->spiclk);
-err_spiclk_enable:
+err_disable_apbclk:
 	clk_disable_unprepare(rs->apb_pclk);
-err_ioremap_resource:
+err_put_master:
 	spi_master_put(master);
 
 	return ret;
-- 
2.1.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
