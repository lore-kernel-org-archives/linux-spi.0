From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v4 08/14] spi: qup: Do block sized read/write in block mode
Date: Tue, 27 Jun 2017 15:15:25 +0530
Message-ID: <1498556731-13087-9-git-send-email-varada@codeaurora.org>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch corrects the behavior of the BLOCK
transactions.  During block transactions, the controller
must be read/written to in block size transactions.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 151 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 119 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2bd5115..1a83248 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -82,6 +82,8 @@
 #define QUP_IO_M_MODE_BAM		3
 
 /* QUP_OPERATIONAL fields */
+#define QUP_OP_IN_BLOCK_READ_REQ	BIT(13)
+#define QUP_OP_OUT_BLOCK_WRITE_REQ	BIT(12)
 #define QUP_OP_MAX_INPUT_DONE_FLAG	BIT(11)
 #define QUP_OP_MAX_OUTPUT_DONE_FLAG	BIT(10)
 #define QUP_OP_IN_SERVICE_FLAG		BIT(9)
@@ -156,6 +158,13 @@ struct spi_qup {
 	struct dma_slave_config	tx_conf;
 };
 
+static inline bool spi_qup_is_flag_set(struct spi_qup *controller, u32 flag)
+{
+	u32 opflag = readl_relaxed(controller->base + QUP_OPERATIONAL);
+
+	return (opflag & flag) != 0;
+}
+
 static inline bool spi_qup_is_dma_xfer(int mode)
 {
 	if (mode == QUP_IO_M_MODE_DMOV || mode == QUP_IO_M_MODE_BAM)
@@ -216,29 +225,26 @@ static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 	return 0;
 }
 
-static void spi_qup_fifo_read(struct spi_qup *controller,
-			    struct spi_transfer *xfer)
+static void spi_qup_read_from_fifo(struct spi_qup *controller,
+	struct spi_transfer *xfer, u32 num_words)
 {
 	u8 *rx_buf = xfer->rx_buf;
-	u32 word, state;
-	int idx, shift, w_size;
+	int i, shift, num_bytes;
+	u32 word;
 
-	w_size = controller->w_size;
-
-	while (controller->rx_bytes < xfer->len) {
-
-		state = readl_relaxed(controller->base + QUP_OPERATIONAL);
-		if (0 == (state & QUP_OP_IN_FIFO_NOT_EMPTY))
-			break;
+	for (; num_words; num_words--) {
 
 		word = readl_relaxed(controller->base + QUP_INPUT_FIFO);
 
+		num_bytes = min_t(int, xfer->len - controller->rx_bytes,
+					controller->w_size);
+
 		if (!rx_buf) {
-			controller->rx_bytes += w_size;
+			controller->rx_bytes += num_bytes;
 			continue;
 		}
 
-		for (idx = 0; idx < w_size; idx++, controller->rx_bytes++) {
+		for (i = 0; i < num_bytes; i++, controller->rx_bytes++) {
 			/*
 			 * The data format depends on bytes per SPI word:
 			 *  4 bytes: 0x12345678
@@ -246,38 +252,80 @@ static void spi_qup_fifo_read(struct spi_qup *controller,
 			 *  1 byte : 0x00000012
 			 */
 			shift = BITS_PER_BYTE;
-			shift *= (w_size - idx - 1);
+			shift *= (controller->w_size - i - 1);
 			rx_buf[controller->rx_bytes] = word >> shift;
 		}
 	}
 }
 
-static void spi_qup_fifo_write(struct spi_qup *controller,
+static void spi_qup_read(struct spi_qup *controller,
 			    struct spi_transfer *xfer)
 {
-	const u8 *tx_buf = xfer->tx_buf;
-	u32 word, state, data;
-	int idx, w_size;
+	u32 remainder, words_per_block, num_words;
+	bool is_block_mode = controller->mode == QUP_IO_M_MODE_BLOCK;
+
+	remainder = DIV_ROUND_UP(xfer->len - controller->rx_bytes,
+				 controller->w_size);
+	words_per_block = controller->in_blk_sz >> 2;
+
+	do {
+		/* ACK by clearing service flag */
+		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
+			       controller->base + QUP_OPERATIONAL);
+
+		if (is_block_mode) {
+			num_words = (remainder > words_per_block) ?
+					words_per_block : remainder;
+		} else {
+			if (!spi_qup_is_flag_set(controller,
+						 QUP_OP_IN_FIFO_NOT_EMPTY))
+				break;
 
-	w_size = controller->w_size;
+			num_words = 1;
+		}
 
-	while (controller->tx_bytes < xfer->len) {
+		/* read up to the maximum transfer size available */
+		spi_qup_read_from_fifo(controller, xfer, num_words);
 
-		state = readl_relaxed(controller->base + QUP_OPERATIONAL);
-		if (state & QUP_OP_OUT_FIFO_FULL)
+		remainder -= num_words;
+
+		/* if block mode, check to see if next block is available */
+		if (is_block_mode && !spi_qup_is_flag_set(controller,
+					QUP_OP_IN_BLOCK_READ_REQ))
 			break;
 
+	} while (remainder);
+
+	/*
+	 * Due to extra stickiness of the QUP_OP_IN_SERVICE_FLAG during block
+	 * mode reads, it has to be cleared again at the very end
+	 */
+	if (is_block_mode && spi_qup_is_flag_set(controller,
+				QUP_OP_MAX_INPUT_DONE_FLAG))
+		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
+			       controller->base + QUP_OPERATIONAL);
+
+}
+
+static void spi_qup_write_to_fifo(struct spi_qup *controller,
+	struct spi_transfer *xfer, u32 num_words)
+{
+	const u8 *tx_buf = xfer->tx_buf;
+	int i, num_bytes;
+	u32 word, data;
+
+	for (; num_words; num_words--) {
 		word = 0;
-		for (idx = 0; idx < w_size; idx++, controller->tx_bytes++) {
 
-			if (!tx_buf) {
-				controller->tx_bytes += w_size;
-				break;
+		num_bytes = min_t(int, xfer->len - controller->tx_bytes,
+				    controller->w_size);
+		if (tx_buf)
+			for (i = 0; i < num_bytes; i++) {
+				data = tx_buf[controller->tx_bytes + i];
+				word |= data << (BITS_PER_BYTE * (3 - i));
 			}
 
-			data = tx_buf[controller->tx_bytes];
-			word |= data << (BITS_PER_BYTE * (3 - idx));
-		}
+		controller->tx_bytes += num_bytes;
 
 		writel_relaxed(word, controller->base + QUP_OUTPUT_FIFO);
 	}
@@ -288,6 +336,44 @@ static void spi_qup_dma_done(void *data)
 	complete(data);
 }
 
+static void spi_qup_write(struct spi_qup *controller,
+			    struct spi_transfer *xfer)
+{
+	bool is_block_mode = controller->mode == QUP_IO_M_MODE_BLOCK;
+	u32 remainder, words_per_block, num_words;
+
+	remainder = DIV_ROUND_UP(xfer->len - controller->tx_bytes,
+				 controller->w_size);
+	words_per_block = controller->out_blk_sz >> 2;
+
+	do {
+		/* ACK by clearing service flag */
+		writel_relaxed(QUP_OP_OUT_SERVICE_FLAG,
+			       controller->base + QUP_OPERATIONAL);
+
+		if (is_block_mode) {
+			num_words = (remainder > words_per_block) ?
+				words_per_block : remainder;
+		} else {
+			if (spi_qup_is_flag_set(controller,
+						QUP_OP_OUT_FIFO_FULL))
+				break;
+
+			num_words = 1;
+		}
+
+		spi_qup_write_to_fifo(controller, xfer, num_words);
+
+		remainder -= num_words;
+
+		/* if block mode, check to see if next block is available */
+		if (is_block_mode && !spi_qup_is_flag_set(controller,
+					QUP_OP_OUT_BLOCK_WRITE_REQ))
+			break;
+
+	} while (remainder);
+}
+
 static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
 			   enum dma_transfer_direction dir,
 			   dma_async_tx_callback callback, void *data)
@@ -389,7 +475,8 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
 		return ret;
 	}
 
-	spi_qup_fifo_write(qup, xfer);
+	if (qup->mode == QUP_IO_M_MODE_FIFO)
+		spi_qup_write(qup, xfer);
 
 	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
 	if (ret) {
@@ -444,10 +531,10 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
-			spi_qup_fifo_read(controller, xfer);
+			spi_qup_read(controller, xfer);
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
-			spi_qup_fifo_write(controller, xfer);
+			spi_qup_write(controller, xfer);
 	}
 
 	if ((opflags & QUP_OP_MAX_INPUT_DONE_FLAG) || error)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
