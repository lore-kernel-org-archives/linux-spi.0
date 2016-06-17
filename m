From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RFC] [PATCH 3/3] spi: omap2-mcspi: Use the SPI framework to handle DMA mapping
Date: Fri, 17 Jun 2016 17:45:13 -0500
Message-ID: <1466203513-4771-4-git-send-email-fcooper@ti.com>
References: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Franklin S Cooper Jr <fcooper@ti.com>
To: <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <david.s.gordon@intel.com>,
	<akpm@linux-foundation.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
	<peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466203513-4771-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently, the driver handles mapping buffers to be used by the DMA.
However, there are times that the current mapping implementation will
fail for certain buffers. Fortunately, the SPI framework can detect
and map buffers so its usable by the DMA.

Update the driver to utilize the SPI framework for buffer
mapping instead. Also incorporate hooks that the framework uses to
determine if the DMA can or can not be used.

This will result in the original omap2_mcspi_transfer_one function being
deleted and omap2_mcspi_work_one being renamed to
omap2_mcspi_transfer_one. Previously transfer_one was only responsible
for mapping and work_one handled the transfer. But now only transferring
needs to be handled by the driver.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 109 ++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 73 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index c47f958..84ba671 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -419,16 +419,13 @@ static void omap2_mcspi_tx_dma(struct spi_device *spi,
 
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
+					     xfer->tx_sg.nents,
+					     DMA_MEM_TO_DEV,
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (tx) {
 			tx->callback = omap2_mcspi_tx_callback;
 			tx->callback_param = spi;
@@ -449,7 +446,8 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 {
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma  *mcspi_dma;
-	unsigned int		count, dma_count;
+	struct sg_table		*cloned_table = NULL;
+	unsigned int		count, transfer_reduction = 0;
 	u32			l;
 	int			elements = 0;
 	int			word_len, element_count;
@@ -457,7 +455,6 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	mcspi = spi_master_get_devdata(spi->master);
 	mcspi_dma = &mcspi->dma_channels[spi->chip_select];
 	count = xfer->len;
-	dma_count = xfer->len;
 
 	/*
 	 *  In the "End-of-Transfer Procedure" section for DMA RX in OMAP35x TRM
@@ -465,7 +462,7 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	 *  normal mode.
 	 */
 	if (mcspi->fifo_depth == 0)
-		dma_count -= es;
+		transfer_reduction = es;
 
 	word_len = cs->word_len;
 	l = mcspi_cached_chconf0(spi);
@@ -479,7 +476,6 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 
 	if (mcspi_dma->dma_rx) {
 		struct dma_async_tx_descriptor *tx;
-		struct scatterlist sg;
 
 		dmaengine_slave_config(mcspi_dma->dma_rx, &cfg);
 
@@ -488,13 +484,22 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 		 *  configured in turbo mode.
 		 */
 		if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
-			dma_count -= es;
+			transfer_reduction += es;
+
+		/*
+		 * Get a cloned copy of the rx sg_table whose transfer count
+		 * has been reduced by transfer_reduction.
+		 */
+		cloned_table = sg_table_clone(&xfer->rx_sg,
+					      count - transfer_reduction,
+					      GFP_KERNEL);
 
-		sg_init_table(&sg, 1);
-		sg_dma_address(&sg) = xfer->rx_dma;
-		sg_dma_len(&sg) = dma_count;
+		if (IS_ERR(cloned_table))
+			return 0;
 
-		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx, &sg, 1,
+		tx = dmaengine_prep_slave_sg(mcspi_dma->dma_rx,
+				cloned_table->sgl,
+				cloned_table->nents,
 				DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT |
 				DMA_CTRL_ACK);
 		if (tx) {
@@ -510,8 +515,9 @@ omap2_mcspi_rx_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	omap2_mcspi_set_dma_req(spi, 1, 1);
 
 	wait_for_completion(&mcspi_dma->dma_rx_completion);
-	dma_unmap_single(mcspi->dev, xfer->rx_dma, count,
-			 DMA_FROM_DEVICE);
+
+	kfree(cloned_table->sgl);
+	kfree(cloned_table);
 
 	if (mcspi->fifo_depth > 0)
 		return count;
@@ -628,8 +634,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
 
 	if (tx != NULL) {
 		wait_for_completion(&mcspi_dma->dma_tx_completion);
-		dma_unmap_single(mcspi->dev, xfer->tx_dma, xfer->len,
-				 DMA_TO_DEVICE);
 
 		if (mcspi->fifo_depth > 0) {
 			irqstat_reg = mcspi->base + OMAP2_MCSPI_IRQSTATUS;
@@ -1087,7 +1091,7 @@ static void omap2_mcspi_cleanup(struct spi_device *spi)
 		gpio_free(spi->cs_gpio);
 }
 
-static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
+static int omap2_mcspi_transfer_one(struct spi_master *master,
 		struct spi_device *spi, struct spi_transfer *t)
 {
 
@@ -1098,7 +1102,7 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 	 * chipselect with the FORCE bit ... CS != channel enable.
 	 */
 
-	struct spi_master		*master;
+	struct omap2_mcspi		*mcspi;
 	struct omap2_mcspi_dma		*mcspi_dma;
 	struct omap2_mcspi_cs		*cs;
 	struct omap2_mcspi_device_config *cd;
@@ -1106,7 +1110,7 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 	int				status = 0;
 	u32				chconf;
 
-	master = spi->master;
+	mcspi = spi_master_get_devdata(master);
 	mcspi_dma = mcspi->dma_channels + spi->chip_select;
 	cs = spi->controller_state;
 	cd = spi->controller_data;
@@ -1166,7 +1170,8 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 		unsigned	count;
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    (t->len >= DMA_MIN_BYTES))
+		    master->cur_msg_mapped &&
+		    master->can_dma(master, spi, t))
 			omap2_mcspi_set_fifo(spi, t, 1);
 
 		omap2_mcspi_set_enable(spi, 1);
@@ -1177,7 +1182,8 @@ static int omap2_mcspi_work_one(struct omap2_mcspi *mcspi,
 					+ OMAP2_MCSPI_TX0);
 
 		if ((mcspi_dma->dma_rx && mcspi_dma->dma_tx) &&
-		    (t->len >= DMA_MIN_BYTES))
+		    master->cur_msg_mapped &&
+		    master->can_dma(master, spi, t))
 			count = omap2_mcspi_txrx_dma(spi, t);
 		else
 			count = omap2_mcspi_txrx_pio(spi, t);
@@ -1246,55 +1252,11 @@ static int omap2_mcspi_prepare_message(struct spi_master *master,
 	return 0;
 }
 
-static int omap2_mcspi_transfer_one(struct spi_master *master,
-		struct spi_device *spi, struct spi_transfer *t)
+static bool omap2_mcspi_can_dma(struct spi_master *master,
+				struct spi_device *spi,
+				struct spi_transfer *xfer)
 {
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*mcspi_dma;
-	const void	*tx_buf = t->tx_buf;
-	void		*rx_buf = t->rx_buf;
-	unsigned	len = t->len;
-
-	mcspi = spi_master_get_devdata(master);
-	mcspi_dma = mcspi->dma_channels + spi->chip_select;
-
-	if ((len && !(rx_buf || tx_buf))) {
-		dev_dbg(mcspi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
-				t->speed_hz,
-				len,
-				tx_buf ? "tx" : "",
-				rx_buf ? "rx" : "",
-				t->bits_per_word);
-		return -EINVAL;
-	}
-
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
-	return omap2_mcspi_work_one(mcspi, spi, t);
+	return (xfer->len >= DMA_MIN_BYTES);
 }
 
 static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
@@ -1374,6 +1336,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	master->setup = omap2_mcspi_setup;
 	master->auto_runtime_pm = true;
 	master->prepare_message = omap2_mcspi_prepare_message;
+	master->can_dma = omap2_mcspi_can_dma;
 	master->transfer_one = omap2_mcspi_transfer_one;
 	master->set_cs = omap2_mcspi_set_cs;
 	master->cleanup = omap2_mcspi_cleanup;
-- 
1.9.1
