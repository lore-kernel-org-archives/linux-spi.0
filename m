From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] spi: s3c64xx: Don't request/release DMA channels for each SPI
 transfer
Date: Thu, 29 Dec 2016 13:19:31 +0100
Message-ID: <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161229121937eucas1p11cd0bb98b21699b0f773ecaeb7c29d26@eucas1p1.samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Requesting a DMA channel might be a time consuming operation, so there is
no need to acquire and release DMA channel for each SPI transfer.
DMA channels can be requested during driver probe and kept all the time,
also because there are no shared nor dynamically allocated channels on
Samsung S3C/S5P/Exynos platforms.

While moving dma_requrest_slave_channel calls, lets switch to
dma_request_slave_channel_reason(), which returns error codes on failure,
which can be properly propagated to the caller (this for example defers
SPI probe when DMA controller is not yet available).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/spi/spi-s3c64xx.c | 57 ++++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 28dfdce4beae..849ee82483e4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -341,43 +341,16 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
-	struct device *dev = &sdd->pdev->dev;
 
 	if (is_polling(sdd))
 		return 0;
 
-	/* Acquire DMA channels */
-	sdd->rx_dma.ch = dma_request_slave_channel(dev, "rx");
-	if (!sdd->rx_dma.ch) {
-		dev_err(dev, "Failed to get RX DMA channel\n");
-		return -EBUSY;
-	}
 	spi->dma_rx = sdd->rx_dma.ch;
-
-	sdd->tx_dma.ch = dma_request_slave_channel(dev, "tx");
-	if (!sdd->tx_dma.ch) {
-		dev_err(dev, "Failed to get TX DMA channel\n");
-		dma_release_channel(sdd->rx_dma.ch);
-		return -EBUSY;
-	}
 	spi->dma_tx = sdd->tx_dma.ch;
 
 	return 0;
 }
 
-static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
-{
-	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(spi);
-
-	/* Free DMA channels */
-	if (!is_polling(sdd)) {
-		dma_release_channel(sdd->rx_dma.ch);
-		dma_release_channel(sdd->tx_dma.ch);
-	}
-
-	return 0;
-}
-
 static bool s3c64xx_spi_can_dma(struct spi_master *master,
 				struct spi_device *spi,
 				struct spi_transfer *xfer)
@@ -1094,7 +1067,6 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	master->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
 	master->prepare_message = s3c64xx_spi_prepare_message;
 	master->transfer_one = s3c64xx_spi_transfer_one;
-	master->unprepare_transfer_hardware = s3c64xx_spi_unprepare_transfer;
 	master->num_chipselect = sci->num_cs;
 	master->dma_alignment = 8;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
@@ -1161,6 +1133,24 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (!is_polling(sdd)) {
+		/* Acquire DMA channels */
+		sdd->rx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
+								  "rx");
+		if (IS_ERR(sdd->rx_dma.ch)) {
+			dev_err(&pdev->dev, "Failed to get RX DMA channel\n");
+			ret = PTR_ERR(sdd->rx_dma.ch);
+			goto err_disable_io_clk;
+		}
+		sdd->tx_dma.ch = dma_request_slave_channel_reason(&pdev->dev,
+								  "tx");
+		if (IS_ERR(sdd->tx_dma.ch)) {
+			dev_err(&pdev->dev, "Failed to get TX DMA channel\n");
+			ret = PTR_ERR(sdd->tx_dma.ch);
+			goto err_release_tx_dma;
+		}
+	}
+
 	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -1206,6 +1196,12 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
+	if (!is_polling(sdd))
+		dma_release_channel(sdd->rx_dma.ch);
+err_release_tx_dma:
+	if (!is_polling(sdd))
+		dma_release_channel(sdd->tx_dma.ch);
+err_disable_io_clk:
 	clk_disable_unprepare(sdd->ioclk);
 err_disable_src_clk:
 	clk_disable_unprepare(sdd->src_clk);
@@ -1226,6 +1222,11 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
+	if (!is_polling(sdd)) {
+		dma_release_channel(sdd->rx_dma.ch);
+		dma_release_channel(sdd->tx_dma.ch);
+	}
+
 	clk_disable_unprepare(sdd->ioclk);
 
 	clk_disable_unprepare(sdd->src_clk);
-- 
1.9.1
