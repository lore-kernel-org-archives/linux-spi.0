From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap2-mcspi: fix dma transfer for vmalloced buffer" to the spi tree
Date: Wed, 23 Mar 2016 13:43:11 +0000
Message-ID: <E1aij43-0004HA-9G@debutante>
References: <1458576021-4373-1-git-send-email-akinobu.mita@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458576021-4373-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap2-mcspi: fix dma transfer for vmalloced buffer

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

>From 3525e0aac91c4de5d20b1f22a6c6e2b39db3cc96 Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 22 Mar 2016 01:00:21 +0900
Subject: [PATCH] spi: omap2-mcspi: fix dma transfer for vmalloced buffer

Currently omap2-mcspi cannot handle dma transfer for vmalloced buffer.
I hit this problem when using mtdblock on spi-nor.

This lets the SPI core handle the page mapping for dma transfer buffer.

Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 62 ++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0caa3c8bef46..43a02e377b3b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -423,16 +423,12 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 
 	if (mcspi_dma->dma_tx) {
 		struct dma_async_tx_descriptor *tx;
-		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
 
-		sg_init_table(&sg, 1);
-		sg_dma_address(&sg) = xfer->tx_dma;
-		sg_dma_len(&sg) = xfer->len;
-
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, &sg, 1,
-		DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, xfer->tx_sg.sgl,
+					     xfer->tx_sg.nents, DMA_MEM_TO_DEV,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_tx_callback;
 			tx->callback_param = spi;
@@ -478,20 +474,15 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 	if (mcspi_dma->dma_rx) {
 		struct dma_async_tx_descriptor *tx;
-		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
 		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
 			dma_count -= es;
 
-		sg_init_table(&sg, 1);
-		sg_dma_address(&sg) = xfer->rx_dma;
-		sg_dma_len(&sg) = dma_count;
-
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, &sg, 1,
-				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT |
-				DMA_CTRL_ACK);
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, xfer->rx_sg.sgl,
+					     xfer->rx_sg.nents, DMA_DEV_TO_MEM,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_rx_callback;
 			tx->callback_param = spi;
@@ -505,8 +496,6 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
 	wait_for_completion(&mcspi_dma->dma_rx_completion);
-	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
-			 DMA_FROM_DEVICE);
 
 	if (mcspi->fifo_depth > 0)
 		return count;
@@ -619,8 +608,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
-		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
-				 DMA_TO_DEVICE);
 
 		if (mcspi->fifo_depth > 0) {
 			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
@@ -1087,6 +1074,16 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		gpio_free(spi->cs_gpio);
 }
 
+static bool omap2_mcspi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
+{
+	if (xfer->len < DMA_MIN_BYTES)
+		return false;
+
+	return true;
+}
+
 static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 		struct spi_device *spi, struct spi_transfer *t)
 {
@@ -1268,32 +1265,6 @@ static int omap2_mcspi_transfer_one(struct spi_master *master,
 		return -EINVAL;
 	}
 
-	if (len < DMA_MIN_BYTES)
-		goto skip_dma_map;
-
-	if (mcspi_dma->dma_tx && tx_buf != NULL) {
-		t->tx_dma = dma_map_single(mcspi->dev, (void *) tx_buf,
-				len, DMA_TO_DEVICE);
-		if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
-			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
-					'T', len);
-			return -EINVAL;
-		}
-	}
-	if (mcspi_dma->dma_rx && rx_buf != NULL) {
-		t->rx_dma = dma_map_single(mcspi->dev, rx_buf, t->len,
-				DMA_FROM_DEVICE);
-		if (dma_mapping_error(mcspi->dev, t->rx_dma)) {
-			dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
-					'R', len);
-			if (tx_buf != NULL)
-				dma_unmap_single(mcspi->dev, t->tx_dma,
-						len, DMA_TO_DEVICE);
-			return -EINVAL;
-		}
-	}
-
-skip_dma_map:
 	return omap2_mcspi_work_one(mcspi, spi, t);
 }
 
@@ -1377,6 +1348,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
+	master->can_dma = omap2_mcspi_can_dma;
 	master->dev.of_node = node;
 	master->max_speed_hz = OMAP2_MCSPI_MAX_FREQ;
 	master->min_speed_hz = OMAP2_MCSPI_MAX_FREQ >> 15;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
