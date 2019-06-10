From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: [PATCH] spi: qup: fix PIO/DMA transfers.
Date: Mon, 10 Jun 2019 09:22:43 +0200
Message-ID: <20190610072243.19710-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        khasim.mohammed@linaro.org
To: jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

- DMA/PIO:
  If an error IRQ occurred during PIO or DMA mode make sure to log it so
on completion the transfer can be marked as an error.

- PIO:
  Do not complete a transaction until all data has been transferred or
an error IRQ was flagged.

1) If there was no error IRQ, ignore the done flag IRQ
(QUP_OP_MAX_INPUT_DONE_FLAG) until all data for the transfer has been
processed: not doing so risks completing the transfer returning
uninitialized data in the buffers.

2) Under stress testing we have identified the need to
protect read/write operations against spurious IN/OUT service events.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/spi/spi-qup.c | 51 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..0a2ffd2f968a 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -281,6 +281,9 @@ static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
+		if (!remainder)
+			goto exit;
+
 		if (is_block_mode) {
 			num_words = (remainder > words_per_block) ?
 					words_per_block : remainder;
@@ -310,11 +313,13 @@ static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 	 * to refresh opflags value because MAX_INPUT_DONE_FLAG may now be
 	 * present and this is used to determine if transaction is complete
 	 */
-	*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
-	if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
-		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
-			       controller->base + QUP_OPERATIONAL);
-
+exit:
+	if (!remainder) {
+		*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
+		if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
+			writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
+				       controller->base + QUP_OPERATIONAL);
+	}
 }
 
 static void spi_qup_write_to_fifo(struct spi_qup *controller, u32 num_words)
@@ -362,6 +367,10 @@ static void spi_qup_write(struct spi_qup *controller)
 		writel_relaxed(QUP_OP_OUT_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
+		/* make sure the interrupt is valid */
+		if (!remainder)
+			return;
+
 		if (is_block_mode) {
 			num_words = (remainder > words_per_block) ?
 				words_per_block : remainder;
@@ -575,10 +584,24 @@ static int spi_qup_do_pio(struct spi_device *spi, struct spi_transfer *xfer,
 	return 0;
 }
 
+static bool spi_qup_data_pending(struct spi_qup *controller)
+{
+	unsigned int remainder_tx, remainder_rx;
+
+	remainder_tx = DIV_ROUND_UP(spi_qup_len(controller) -
+				    controller->tx_bytes, controller->w_size);
+
+	remainder_rx = DIV_ROUND_UP(spi_qup_len(controller) -
+				    controller->rx_bytes, controller->w_size);
+
+	return remainder_tx || remainder_rx;
+}
+
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
 	u32 opflags, qup_err, spi_err;
+	unsigned long flags;
 	int error = 0;
 
 	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
@@ -610,6 +633,11 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
+	spin_lock_irqsave(&controller->lock, flags);
+	if (!controller->error)
+		controller->error = error;
+	spin_unlock_irqrestore(&controller->lock, flags);
+
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
@@ -618,11 +646,22 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
 			spi_qup_write(controller);
+
+		if (!spi_qup_data_pending(controller))
+			complete(&controller->done);
 	}
 
-	if ((opflags & QUP_OP_MAX_INPUT_DONE_FLAG) || error)
+	if (error)
 		complete(&controller->done);
 
+	if (opflags & QUP_OP_MAX_INPUT_DONE_FLAG) {
+		if (!spi_qup_is_dma_xfer(controller->mode)) {
+			if (spi_qup_data_pending(controller))
+				return IRQ_HANDLED;
+		}
+		complete(&controller->done);
+	}
+
 	return IRQ_HANDLED;
 }
 
-- 
2.21.0
