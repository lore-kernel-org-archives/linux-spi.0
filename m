From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V2 1/3] spi: img-spfi: Implement a handle_err() callback
Date: Wed,  8 Apr 2015 10:03:14 -0700
Message-ID: <1428512596-23766-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>

The driver can be greatly simplified by moving the transfer timeout
handling to a handle_err() callback.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
Changes from v1:
 - Moved timeout handling from unprepare_message() to handle_err()
---
 drivers/spi/spi-img-spfi.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index bef986f..a3cf5be 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -270,7 +270,6 @@ static int img_spfi_start_pio(struct spi_master *master,
 
 	if (rx_bytes > 0 || tx_bytes > 0) {
 		dev_err(spfi->dev, "PIO transfer timed out\n");
-		spfi_reset(spfi);
 		return -ETIMEDOUT;
 	}
 
@@ -396,6 +395,29 @@ stop_dma:
 	return -EIO;
 }
 
+static void img_spfi_handle_err(struct spi_master *master,
+				struct spi_message *msg)
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
+}
+
 static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 {
 	struct img_spfi *spfi = spi_master_get_devdata(master);
@@ -462,8 +484,6 @@ static int img_spfi_transfer_one(struct spi_master *master,
 				 struct spi_transfer *xfer)
 {
 	struct img_spfi *spfi = spi_master_get_devdata(spi->master);
-	bool dma_reset = false;
-	unsigned long flags;
 	int ret;
 
 	if (xfer->len > SPFI_TRANSACTION_TSIZE_MASK) {
@@ -473,23 +493,6 @@ static int img_spfi_transfer_one(struct spi_master *master,
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
@@ -607,6 +610,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->set_cs = img_spfi_set_cs;
 	master->transfer_one = img_spfi_transfer_one;
 	master->prepare_message = img_spfi_prepare;
+	master->handle_err = img_spfi_handle_err;
 
 	spfi->tx_ch = dma_request_slave_channel(spfi->dev, "tx");
 	spfi->rx_ch = dma_request_slave_channel(spfi->dev, "rx");
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
