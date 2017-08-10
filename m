From: Anton Volkov <avolkov@ispras.ru>
Subject: [PATCH] tegra114: fix to a race condition due to early registration of interrupt handler
Date: Thu, 10 Aug 2017 15:42:08 +0300
Message-ID: <1502368928-17280-1-git-send-email-avolkov@ispras.ru>
References: <20170731104105.GF26667@ulmo>
Cc: ldewangan@nvidia.com, jonathanh@nvidia.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        khoroshilov@ispras.ru, Anton Volkov <avolkov@ispras.ru>
To: thierry.reding@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170731104105.GF26667@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The early registration of interrupt handler made possible a race
condition leading to the usage of an incorrect physical address
obtained by reading uninitialized tspi->tx_dma_phys.

This patch moves the registration of an interrupt handler further
down the code of tegra_spi_probe to make the race infeasible.

Found by by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Volkov <avolkov@ispras.ru>
---
 drivers/spi/spi-tegra114.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 08012ae..9a88dca 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1065,29 +1065,18 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	}
 	tspi->phys = r->start;
 
-	spi_irq = platform_get_irq(pdev, 0);
-	tspi->irq = spi_irq;
-	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
-			tegra_spi_isr_thread, IRQF_ONESHOT,
-			dev_name(&pdev->dev), tspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
-					tspi->irq);
-		goto exit_free_master;
-	}
-
 	tspi->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
 		ret = PTR_ERR(tspi->clk);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->rst = devm_reset_control_get(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
 		dev_err(&pdev->dev, "can not get reset\n");
 		ret = PTR_ERR(tspi->rst);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
@@ -1095,7 +1084,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	ret = tegra_spi_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_irq;
+		goto exit_free_master;
 	ret = tegra_spi_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1105,6 +1094,17 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	init_completion(&tspi->xfer_completion);
 
+	spi_irq = platform_get_irq(pdev, 0);
+	tspi->irq = spi_irq;
+	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
+			tegra_spi_isr_thread, IRQF_ONESHOT,
+			dev_name(&pdev->dev), tspi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
+					tspi->irq);
+		goto exit_rx_dma_free;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
 		ret = tegra_spi_runtime_resume(&pdev->dev);
@@ -1133,11 +1133,10 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
+	free_irq(spi_irq, tspi);
 	tegra_spi_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_spi_deinit_dma_param(tspi, true);
-exit_free_irq:
-	free_irq(spi_irq, tspi);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
-- 
2.7.4
