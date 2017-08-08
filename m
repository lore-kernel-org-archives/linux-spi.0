From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Setup DMA mode correctly" to the spi tree
Date: Tue, 08 Aug 2017 12:18:39 +0100
Message-ID: <E1df2X1-0006Q0-AO@finisterre>
References: <1497419551-21834-3-git-send-email-varada@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-3-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Setup DMA mode correctly

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

>From 32ecab999f80370e5853cb907aa053ec4d64f86f Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:49 +0530
Subject: [PATCH] spi: qup: Setup DMA mode correctly

To operate in DMA mode, the buffer should be aligned and
the size of the transfer should be a multiple of block size
(for v1). And the no. of words being transferred should
be programmed in the count registers appropriately.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 118 +++++++++++++++++++++++---------------------------
 1 file changed, 55 insertions(+), 63 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index c0d4defc1c13..abe799bbc67f 100644
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
2.13.2
