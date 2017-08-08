From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: allow block mode to generate multiple transactions" to the spi tree
Date: Tue, 08 Aug 2017 12:18:09 +0100
Message-ID: <E1df2WX-0006Ha-72@finisterre>
References: <1500882445-29008-11-git-send-email-varada@codeaurora.org>
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        Matthew McClintock <mmcclint@codeaurora.org>,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500882445-29008-11-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: allow block mode to generate multiple transactions

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

>From 5dc47fefe1d470da47dd400796bbf93ffe82fd33 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:57 +0530
Subject: [PATCH] spi: qup: allow block mode to generate multiple transactions

This let's you write more to the SPI bus than 64K-1 which is important
if the block size of a SPI device is >= 64K or some other device wants
to do something larger.

This has the benefit of completely removing spi_message from the spi-qup
transactions

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 128 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 1aa60785bf98..707b1ec427fa 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -120,7 +120,7 @@
 
 #define SPI_NUM_CHIPSELECTS		4
 
-#define SPI_MAX_DMA_XFER		(SZ_64K - 64)
+#define SPI_MAX_XFER			(SZ_64K - 64)
 
 /* high speed mode is when bus rate is greater then 26MHz */
 #define SPI_HS_MIN_RATE			26000000
@@ -149,6 +149,8 @@ struct spi_qup {
 	int			n_words;
 	int			tx_bytes;
 	int			rx_bytes;
+	const u8		*tx_buf;
+	u8			*rx_buf;
 	int			qup_v1;
 
 	int			mode;
@@ -173,6 +175,12 @@ static inline bool spi_qup_is_dma_xfer(int mode)
 	return false;
 }
 
+/* get's the transaction size length */
+static inline unsigned int spi_qup_len(struct spi_qup *controller)
+{
+	return controller->n_words * controller->w_size;
+}
+
 static inline bool spi_qup_is_valid_state(struct spi_qup *controller)
 {
 	u32 opstate = readl_relaxed(controller->base + QUP_STATE);
@@ -225,10 +233,9 @@ static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 	return 0;
 }
 
-static void spi_qup_read_from_fifo(struct spi_qup *controller,
-	struct spi_transfer *xfer, u32 num_words)
+static void spi_qup_read_from_fifo(struct spi_qup *controller, u32 num_words)
 {
-	u8 *rx_buf = xfer->rx_buf;
+	u8 *rx_buf = controller->rx_buf;
 	int i, shift, num_bytes;
 	u32 word;
 
@@ -236,8 +243,9 @@ static void spi_qup_read_from_fifo(struct spi_qup *controller,
 
 		word = readl_relaxed(controller->base + QUP_INPUT_FIFO);
 
-		num_bytes = min_t(int, xfer->len - controller->rx_bytes,
-					controller->w_size);
+		num_bytes = min_t(int, spi_qup_len(controller) -
+				       controller->rx_bytes,
+				       controller->w_size);
 
 		if (!rx_buf) {
 			controller->rx_bytes += num_bytes;
@@ -258,13 +266,12 @@ static void spi_qup_read_from_fifo(struct spi_qup *controller,
 	}
 }
 
-static void spi_qup_read(struct spi_qup *controller,
-			    struct spi_transfer *xfer)
+static void spi_qup_read(struct spi_qup *controller)
 {
 	u32 remainder, words_per_block, num_words;
 	bool is_block_mode = controller->mode == QUP_IO_M_MODE_BLOCK;
 
-	remainder = DIV_ROUND_UP(xfer->len - controller->rx_bytes,
+	remainder = DIV_ROUND_UP(spi_qup_len(controller) - controller->rx_bytes,
 				 controller->w_size);
 	words_per_block = controller->in_blk_sz >> 2;
 
@@ -285,7 +292,7 @@ static void spi_qup_read(struct spi_qup *controller,
 		}
 
 		/* read up to the maximum transfer size available */
-		spi_qup_read_from_fifo(controller, xfer, num_words);
+		spi_qup_read_from_fifo(controller, num_words);
 
 		remainder -= num_words;
 
@@ -307,18 +314,18 @@ static void spi_qup_read(struct spi_qup *controller,
 
 }
 
-static void spi_qup_write_to_fifo(struct spi_qup *controller,
-	struct spi_transfer *xfer, u32 num_words)
+static void spi_qup_write_to_fifo(struct spi_qup *controller, u32 num_words)
 {
-	const u8 *tx_buf = xfer->tx_buf;
+	const u8 *tx_buf = controller->tx_buf;
 	int i, num_bytes;
 	u32 word, data;
 
 	for (; num_words; num_words--) {
 		word = 0;
 
-		num_bytes = min_t(int, xfer->len - controller->tx_bytes,
-				    controller->w_size);
+		num_bytes = min_t(int, spi_qup_len(controller) -
+				       controller->tx_bytes,
+				       controller->w_size);
 		if (tx_buf)
 			for (i = 0; i < num_bytes; i++) {
 				data = tx_buf[controller->tx_bytes + i];
@@ -338,13 +345,12 @@ static void spi_qup_dma_done(void *data)
 	complete(&qup->done);
 }
 
-static void spi_qup_write(struct spi_qup *controller,
-			    struct spi_transfer *xfer)
+static void spi_qup_write(struct spi_qup *controller)
 {
 	bool is_block_mode = controller->mode == QUP_IO_M_MODE_BLOCK;
 	u32 remainder, words_per_block, num_words;
 
-	remainder = DIV_ROUND_UP(xfer->len - controller->tx_bytes,
+	remainder = DIV_ROUND_UP(spi_qup_len(controller) - controller->tx_bytes,
 				 controller->w_size);
 	words_per_block = controller->out_blk_sz >> 2;
 
@@ -364,7 +370,7 @@ static void spi_qup_write(struct spi_qup *controller,
 			num_words = 1;
 		}
 
-		spi_qup_write_to_fifo(controller, xfer, num_words);
+		spi_qup_write_to_fifo(controller, num_words);
 
 		remainder -= num_words;
 
@@ -471,36 +477,62 @@ static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 {
 	struct spi_master *master = spi->master;
 	struct spi_qup *qup = spi_master_get_devdata(master);
-	int ret;
+	int ret, n_words, iterations, offset = 0;
 
-	ret = spi_qup_io_config(spi, xfer);
-	if (ret)
-		return ret;
+	n_words = qup->n_words;
+	iterations = n_words / SPI_MAX_XFER; /* round down */
+	qup->rx_buf = xfer->rx_buf;
+	qup->tx_buf = xfer->tx_buf;
 
-	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
-	if (ret) {
-		dev_warn(qup->dev, "cannot set RUN state\n");
-		return ret;
-	}
+	do {
+		if (iterations)
+			qup->n_words = SPI_MAX_XFER;
+		else
+			qup->n_words = n_words % SPI_MAX_XFER;
 
-	ret = spi_qup_set_state(qup, QUP_STATE_PAUSE);
-	if (ret) {
-		dev_warn(qup->dev, "cannot set PAUSE state\n");
-		return ret;
-	}
+		if (qup->tx_buf && offset)
+			qup->tx_buf = xfer->tx_buf + offset * SPI_MAX_XFER;
 
-	if (qup->mode == QUP_IO_M_MODE_FIFO)
-		spi_qup_write(qup, xfer);
+		if (qup->rx_buf && offset)
+			qup->rx_buf = xfer->rx_buf + offset * SPI_MAX_XFER;
 
-	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
-	if (ret) {
-		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
-				__func__, __LINE__);
-		return ret;
-	}
+		/*
+		 * if the transaction is small enough, we need
+		 * to fallback to FIFO mode
+		 */
+		if (qup->n_words <= (qup->in_fifo_sz / sizeof(u32)))
+			qup->mode = QUP_IO_M_MODE_FIFO;
 
-	if (!wait_for_completion_timeout(&qup->done, timeout))
-		return -ETIMEDOUT;
+		ret = spi_qup_io_config(spi, xfer);
+		if (ret)
+			return ret;
+
+		ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+		if (ret) {
+			dev_warn(qup->dev, "cannot set RUN state\n");
+			return ret;
+		}
+
+		ret = spi_qup_set_state(qup, QUP_STATE_PAUSE);
+		if (ret) {
+			dev_warn(qup->dev, "cannot set PAUSE state\n");
+			return ret;
+		}
+
+		if (qup->mode == QUP_IO_M_MODE_FIFO)
+			spi_qup_write(qup);
+
+		ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+		if (ret) {
+			dev_warn(qup->dev, "cannot set RUN state\n");
+			return ret;
+		}
+
+		if (!wait_for_completion_timeout(&qup->done, timeout))
+			return -ETIMEDOUT;
+
+		offset++;
+	} while (iterations--);
 
 	return 0;
 }
@@ -508,7 +540,6 @@ static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
-	struct spi_transfer *xfer = controller->xfer;
 	u32 opflags, qup_err, spi_err;
 	int error = 0;
 
@@ -545,10 +576,10 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
-			spi_qup_read(controller, xfer);
+			spi_qup_read(controller);
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
-			spi_qup_write(controller, xfer);
+			spi_qup_write(controller);
 	}
 
 	if ((opflags & QUP_OP_MAX_INPUT_DONE_FLAG) || error)
@@ -755,7 +786,8 @@ static int spi_qup_transfer_one(struct spi_master *master,
 		return ret;
 
 	timeout = DIV_ROUND_UP(xfer->speed_hz, MSEC_PER_SEC);
-	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
+	timeout = DIV_ROUND_UP(min_t(unsigned long, SPI_MAX_XFER,
+				     xfer->len) * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
 
 	reinit_completion(&controller->done);
@@ -969,7 +1001,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
 	master->dma_alignment = dma_get_cache_alignment();
-	master->max_dma_len = SPI_MAX_DMA_XFER;
+	master->max_dma_len = SPI_MAX_XFER;
 
 	platform_set_drvdata(pdev, master);
 
-- 
2.13.2
