From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: s3c64xx: Don't request/release DMA channels for each SPI transfer" to the spi tree
Date: Mon, 09 Jan 2017 20:02:01 +0000
Message-ID: <E1cQg8n-00074T-PN@debutante>
References: <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
Cc: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483013971-26446-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: s3c64xx: Don't request/release DMA channels for each SPI transfer

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

>From 3d63a47a380a873408dad10ca62bd8299b2208f1 Mon Sep 17 00:00:00 2001
From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 9 Jan 2017 11:36:10 +0100
Subject: [PATCH] spi: s3c64xx: Don't request/release DMA channels for each SPI
 transfer

Requesting a DMA channel might be a time consuming operation, so there is
no need to acquire and release DMA channel for each SPI transfer.
DMA channels can be requested during driver probe and kept all the time,
also because there are no shared nor dynamically allocated channels on
Samsung S3C/S5P/Exynos platforms.

While moving dma_requrest_slave_channel calls, lets switch to
dma_request_slave_channel_reason(), which returns error codes on failure,
which can be properly propagated to the caller (this for example defers
SPI probe when DMA controller is not yet available).

Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Tested-by: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Reviewed-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
