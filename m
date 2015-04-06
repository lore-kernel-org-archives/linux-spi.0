From: Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 3/5] spi: img-spfi: Implement an unprepare_message() callback
Date: Mon,  6 Apr 2015 14:29:05 -0700
Message-ID: <1428355747-16822-3-git-send-email-abrestic@chromium.org>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

The driver can be greatly simplified by moving the transfer
finishing and timeout handling to an unprepare_message() callback.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/spi/spi-img-spfi.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index b1c0165..30c89f9 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -271,7 +271,6 @@ static int img_spfi_start_pio(struct spi_master *master,
 
 	if (rx_bytes > 0 || tx_bytes > 0) {
 		dev_err(spfi->dev, "PIO transfer timed out\n");
-		spfi_reset(spfi);
 		return -ETIMEDOUT;
 	}
 
@@ -397,6 +396,30 @@ stop_dma:
 	return -EIO;
 }
 
+static int img_spfi_unprepare(struct spi_master *master, struct spi_message *m)
+{
+	struct img_spfi *spfi = spi_master_get_devdata(master);
+	unsigned long flags;
+
+	/*
+	 * Stop all DMA and reset the controller if the previous transaction
+	 * timed-out and never completed it's DMA.
+	 */
+	spin_lock_irqsave(&spfi->lock, flags);
+	if (spfi->tx_dma_busy || spfi->rx_dma_busy) {
+		spfi->tx_dma_busy = false;
+		spfi->rx_dma_busy = false;
+
+		dmaengine_terminate_all(spfi->tx_ch);
+		dmaengine_terminate_all(spfi->rx_ch);
+	}
+	spin_unlock_irqrestore(&spfi->lock, flags);
+
+	spfi_reset(spfi);
+
+	return 0;
+}
+
 static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 {
 	struct img_spfi *spfi = spi_master_get_devdata(master);
@@ -462,8 +485,6 @@ static int img_spfi_transfer_one(struct spi_master *master,
 				 struct spi_transfer *xfer)
 {
 	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
-	bool dma_reset = false;
-	unsigned long flags;
 	int ret;
 
 	if (xfer->len > SPFI_TRANSACTION_TSIZE_MASK) {
@@ -473,23 +494,6 @@ static int img_spfi_transfer_one(struct spi_master *master,
 		return -EINVAL;
 	}
 
-	/*
-	 * Stop all DMA and reset the controller if the previous transaction
-	 * timed-out and never completed it's DMA.
-	 */
-	spin_lock_irqsave(&spfi->lock, flags);
-	if (spfi->tx_dma_busy || spfi->rx_dma_busy) {
-		dev_err(spfi->dev, "SPI DMA still busy\n");
-		dma_reset = true;
-	}
-	spin_unlock_irqrestore(&spfi->lock, flags);
-
-	if (dma_reset) {
-		dmaengine_terminate_all(spfi->tx_ch);
-		dmaengine_terminate_all(spfi->rx_ch);
-		spfi_reset(spfi);
-	}
-
 	img_spfi_config(master, spi, xfer);
 	if (master->can_dma && master->can_dma(master, spi, xfer))
 		ret = img_spfi_start_dma(master, spi, xfer);
@@ -607,6 +611,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->set_cs = img_spfi_set_cs;
 	master->transfer_one = img_spfi_transfer_one;
 	master->prepare_message = img_spfi_prepare;
+	master->unprepare_message = img_spfi_unprepare;
 
 	spfi->tx_ch = dma_request_slave_channel(spfi->dev, "tx");
 	spfi->rx_ch = dma_request_slave_channel(spfi->dev, "rx");
-- 
2.2.0.rc0.207.ga3a616c
