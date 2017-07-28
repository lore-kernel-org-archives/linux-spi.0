From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v6 02/14] spi: qup: Setup DMA mode correctly
Date: Fri, 28 Jul 2017 12:22:49 +0530
Message-ID: <1501224781-19519-3-git-send-email-varada@codeaurora.org>
References: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

To operate in DMA mode, the buffer should be aligned and
the size of the transfer should be a multiple of block size
(for v1). And the no. of words being transferred should
be programmed in the count registers appropriately.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 118 +++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index c0d4def..abe799b 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -149,11 +149,18 @@ struct spi_qup {
 	int			rx_bytes;
 	int			qup_v1;
 
-	int			use_dma;
+	int			mode;
 	struct dma_slave_config	rx_conf;
 	struct dma_slave_config	tx_conf;
 };
 
+static inline bool spi_qup_is_dma_xfer(int mode)
+{
+	if (mode == QUP_IO_M_MODE_DMOV || mode == QUP_IO_M_MODE_BAM)
+		return true;
+
+	return false;
+}
 
 static inline bool spi_qup_is_valid_state(struct spi_qup *controller)
 {
@@ -424,7 +431,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	if (!controller->use_dma) {
+	if (!spi_qup_is_dma_xfer(controller->mode)) {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
 			spi_qup_fifo_read(controller, xfer);
 
@@ -443,34 +450,11 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static u32
-spi_qup_get_mode(struct spi_master *master, struct spi_transfer *xfer)
-{
-	struct spi_qup *qup = spi_master_get_devdata(master);
-	u32 mode;
-
-	qup->w_size = 4;
-
-	if (xfer->bits_per_word <= 8)
-		qup->w_size = 1;
-	else if (xfer->bits_per_word <= 16)
-		qup->w_size = 2;
-
-	qup->n_words = xfer->len / qup->w_size;
-
-	if (qup->n_words <= (qup->in_fifo_sz / sizeof(u32)))
-		mode = QUP_IO_M_MODE_FIFO;
-	else
-		mode = QUP_IO_M_MODE_BLOCK;
-
-	return mode;
-}
-
 /* set clock freq ... bits per word */
 static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct spi_qup *controller = spi_master_get_devdata(spi->master);
-	u32 config, iomode, mode, control;
+	u32 config, iomode, control;
 	int ret, n_words;
 
 	if (spi->mode & SPI_LOOP && xfer->len > controller->in_fifo_sz) {
@@ -491,25 +475,30 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		return -EIO;
 	}
 
-	mode = spi_qup_get_mode(spi->master, xfer);
+	controller->w_size = DIV_ROUND_UP(xfer->bits_per_word, 8);
+	controller->n_words = xfer->len / controller->w_size;
 	n_words = controller->n_words;
 
-	if (mode == QUP_IO_M_MODE_FIFO) {
+	if (n_words <= (controller->in_fifo_sz / sizeof(u32))) {
+
+		controller->mode = QUP_IO_M_MODE_FIFO;
+
 		writel_relaxed(n_words, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(n_words, controller->base + QUP_MX_WRITE_CNT);
 		/* must be zero for FIFO */
 		writel_relaxed(0, controller->base + QUP_MX_INPUT_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
-	} else if (!controller->use_dma) {
+	} else if (spi->master->can_dma &&
+		   spi->master->can_dma(spi->master, spi, xfer) &&
+		   spi->master->cur_msg_mapped) {
+
+		controller->mode = QUP_IO_M_MODE_BAM;
+
 		writel_relaxed(n_words, controller->base + QUP_MX_INPUT_CNT);
 		writel_relaxed(n_words, controller->base + QUP_MX_OUTPUT_CNT);
 		/* must be zero for BLOCK and BAM */
 		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
-	} else {
-		mode = QUP_IO_M_MODE_BAM;
-		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
-		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
 
 		if (!controller->qup_v1) {
 			void __iomem *input_cnt;
@@ -528,19 +517,28 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 
 			writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
 		}
+	} else {
+
+		controller->mode = QUP_IO_M_MODE_BLOCK;
+
+		writel_relaxed(n_words, controller->base + QUP_MX_INPUT_CNT);
+		writel_relaxed(n_words, controller->base + QUP_MX_OUTPUT_CNT);
+		/* must be zero for BLOCK and BAM */
+		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
+		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
 	}
 
 	iomode = readl_relaxed(controller->base + QUP_IO_M_MODES);
 	/* Set input and output transfer mode */
 	iomode &= ~(QUP_IO_M_INPUT_MODE_MASK | QUP_IO_M_OUTPUT_MODE_MASK);
 
-	if (!controller->use_dma)
+	if (!spi_qup_is_dma_xfer(controller->mode))
 		iomode &= ~(QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN);
 	else
 		iomode |= QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN;
 
-	iomode |= (mode << QUP_IO_M_OUTPUT_MODE_MASK_SHIFT);
-	iomode |= (mode << QUP_IO_M_INPUT_MODE_MASK_SHIFT);
+	iomode |= (controller->mode << QUP_IO_M_OUTPUT_MODE_MASK_SHIFT);
+	iomode |= (controller->mode << QUP_IO_M_INPUT_MODE_MASK_SHIFT);
 
 	writel_relaxed(iomode, controller->base + QUP_IO_M_MODES);
 
@@ -581,7 +579,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	config |= xfer->bits_per_word - 1;
 	config |= QUP_CONFIG_SPI_MODE;
 
-	if (controller->use_dma) {
+	if (spi_qup_is_dma_xfer(controller->mode)) {
 		if (!xfer->tx_buf)
 			config |= QUP_CONFIG_NO_OUTPUT;
 		if (!xfer->rx_buf)
@@ -599,7 +597,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		 * status change in BAM mode
 		 */
 
-		if (mode == QUP_IO_M_MODE_BAM)
+		if (spi_qup_is_dma_xfer(controller->mode))
 			mask = QUP_OP_IN_SERVICE_FLAG | QUP_OP_OUT_SERVICE_FLAG;
 
 		writel_relaxed(mask, controller->base + QUP_OPERATIONAL_MASK);
@@ -633,7 +631,7 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	controller->tx_bytes = 0;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
-	if (controller->use_dma)
+	if (spi_qup_is_dma_xfer(controller->mode))
 		ret = spi_qup_do_dma(master, xfer);
 	else
 		ret = spi_qup_do_pio(master, xfer);
@@ -641,14 +639,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	if (ret)
 		goto exit;
 
-	if (spi_qup_set_state(controller, QUP_STATE_RUN)) {
-		dev_warn(controller->dev, "cannot set EXECUTE state\n");
-		goto exit;
-	}
-
-	if (!wait_for_completion_timeout(&controller->done, timeout))
-		ret = -ETIMEDOUT;
-
 exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
@@ -657,7 +647,7 @@ static int spi_qup_transfer_one(struct spi_master *master,
 		ret = controller->error;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
-	if (ret && controller->use_dma)
+	if (ret && spi_qup_is_dma_xfer(controller->mode))
 		spi_qup_dma_terminate(master, xfer);
 
 	return ret;
@@ -668,26 +658,28 @@ static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	size_t dma_align = dma_get_cache_alignment();
-	u32 mode;
-
-	qup->use_dma = 0;
+	int n_words;
 
-	if (xfer->rx_buf && (xfer->len % qup->in_blk_sz ||
-	    IS_ERR_OR_NULL(master->dma_rx) ||
-	    !IS_ALIGNED((size_t)xfer->rx_buf, dma_align)))
-		return false;
+	if (xfer->rx_buf) {
+		if (!IS_ALIGNED((size_t)xfer->rx_buf, dma_align) ||
+		    IS_ERR_OR_NULL(master->dma_rx))
+			return false;
+		if (qup->qup_v1 && (xfer->len % qup->in_blk_sz))
+			return false;
+	}
 
-	if (xfer->tx_buf && (xfer->len % qup->out_blk_sz ||
-	    IS_ERR_OR_NULL(master->dma_tx) ||
-	    !IS_ALIGNED((size_t)xfer->tx_buf, dma_align)))
-		return false;
+	if (xfer->tx_buf) {
+		if (!IS_ALIGNED((size_t)xfer->tx_buf, dma_align) ||
+		    IS_ERR_OR_NULL(master->dma_tx))
+			return false;
+		if (qup->qup_v1 && (xfer->len % qup->out_blk_sz))
+			return false;
+	}
 
-	mode = spi_qup_get_mode(master, xfer);
-	if (mode == QUP_IO_M_MODE_FIFO)
+	n_words = xfer->len / DIV_ROUND_UP(xfer->bits_per_word, 8);
+	if (n_words <= (qup->in_fifo_sz / sizeof(u32)))
 		return false;
 
-	qup->use_dma = 1;
-
 	return true;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
