From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] spi: rspi: Pass spi_master pointer to rspi_release_dma()
Date: Fri,  6 Jun 2014 13:38:43 +0200
Message-ID: <1402054723-30682-3-git-send-email-geert+renesas@glider.be>
References: <1402054723-30682-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1402054723-30682-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

rspi_release_dma() doesn't need access to any fields in the driver private
data, except for the pointer to the SPI master object. Hence just pass the
needed pointer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ddee9df1547d..38fd938d6360 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -926,19 +926,19 @@ static int rspi_request_dma(struct device *dev, struct spi_master *master,
 	return 0;
 }
 
-static void rspi_release_dma(struct rspi_data *rspi)
+static void rspi_release_dma(struct spi_master *master)
 {
-	if (rspi->master->dma_tx)
-		dma_release_channel(rspi->master->dma_tx);
-	if (rspi->master->dma_rx)
-		dma_release_channel(rspi->master->dma_rx);
+	if (master->dma_tx)
+		dma_release_channel(master->dma_tx);
+	if (master->dma_rx)
+		dma_release_channel(master->dma_rx);
 }
 
 static int rspi_remove(struct platform_device *pdev)
 {
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
-	rspi_release_dma(rspi);
+	rspi_release_dma(rspi->master);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
@@ -1140,7 +1140,7 @@ static int rspi_probe(struct platform_device *pdev)
 	return 0;
 
 error3:
-	rspi_release_dma(rspi);
+	rspi_release_dma(master);
 error2:
 	pm_runtime_disable(&pdev->dev);
 error1:
-- 
1.9.1

