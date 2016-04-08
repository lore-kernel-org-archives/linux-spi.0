From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Revert "spi: omap2-mcspi: fix dma transfer for vmalloced buffer"
Date: Sat,  9 Apr 2016 03:43:15 +0900
Message-ID: <1460140995-4062-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This reverts commit 3525e0aac91c4de5d20b1f22a6c6e2b39db3cc96.

The DMA transfer for RX buffer was not handled correctly in this change.

The actual transfer length for DMA RX can be less than xfer->len in the
specific condition and the last words will be filled after the DMA
completion, but the commit doesn't consider it and the dmaengine is
started with rx_sg mapped by spi core.

The solution for this at least requires more lines than this commit
has inserted.  So revert it for now.

Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 62 +++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 43a02e3..0caa3c8 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -423,12 +423,16 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 
 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
+		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
 
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
-					     xfer->tx_sg.nents, DMA_MEM_TO_DEV,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		sg_init_table(&sg, 1);
+		sg_dma_address(&sg) = xfer->tx_dma;
+		sg_dma_len(&sg) = xfer->len;
+
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, &sg, 1,
+		DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_tx_callback;
 			tx->callback_param = spi;
@@ -474,15 +478,20 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 	if (mcspi_dma->dma_rx) {
 		struct dma_async_tx_descriptor *tx;
+		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
 		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
 			dma_count -= es;
 
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, xfer->rx_sg.sgl,
-					     xfer->rx_sg.nents, DMA_DEV_TO_MEM,
-					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		sg_init_table(&sg, 1);
+		sg_dma_address(&sg) = xfer->rx_dma;
+		sg_dma_len(&sg) = dma_count;
+
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, &sg, 1,
+				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT |
+				DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_rx_callback;
 			tx->callback_param = spi;
@@ -496,6 +505,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
 	wait_for_completion(&mcspi_dma->dma_rx_completion);
+	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
+			 DMA_FROM_DEVICE);
 
 	if (mcspi->fifo_depth > 0)
 		return count;
@@ -608,6 +619,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
+		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
+				 DMA_TO_DEVICE);
 
 		if (mcspi->fifo_depth > 0) {
 			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
@@ -1074,16 +1087,6 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		gpio_free(spi->cs_gpio);
 }
 
-static bool omap2_mcspi_can_dma(struct spi_master *master,
-				struct spi_device *spi,
-				struct spi_transfer *xfer)
-{
-	if (xfer->len < DMA_MIN_BYTES)
-		return false;
-
-	return true;
-}
-
 static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 		struct spi_device *spi, struct spi_transfer *t)
 {
@@ -1265,6 +1268,32 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
 		return -EINVAL;
 	}
 
+	if (len < DMA_MIN_BYTES)
+		goto skip_dma_map;
+
+	if (mcspi_dma->dma_tx && tx_buf != NULL) {
+		t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
+				len, DMA_TO_DEVICE);
+		if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
+			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
+					'T', len);
+			return -EINVAL;
+		}
+	}
+	if (mcspi_dma->dma_rx && rx_buf != NULL) {
+		t->rx_dma = dma_map_single(mcspi->dev, rx_buf, t->len,
+				DMA_FROM_DEVICE);
+		if (dma_mapping_error(mcspi->dev, t->rx_dma)) {
+			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
+					'R', len);
+			if (tx_buf != NULL)
+				dma_unmap_single(mcspi->dev, t->tx_dma,
+						len, DMA_TO_DEVICE);
+			return -EINVAL;
+		}
+	}
+
+skip_dma_map:
 	return omap2_mcspi_work_one(mcspi, spi, t);
 }
 
@@ -1348,7 +1377,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
-	master->can_dma = omap2_mcspi_can_dma;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
 	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
