From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: refactor spi_qup_io_config into two functions" to the spi tree
Date: Tue, 08 Aug 2017 12:18:16 +0100
Message-ID: <E1df2We-0006Jk-Po@finisterre>
References: <1500882445-29008-9-git-send-email-varada@codeaurora.org>
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
In-Reply-To: <1500882445-29008-9-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: refactor spi_qup_io_config into two functions

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

>From 94b9149febddcd367de75d2706a32183e2abbaa7 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:55 +0530
Subject: [PATCH] spi: qup: refactor spi_qup_io_config into two functions

This is in preparation for handling transactions larger than
64K-1 bytes in block mode, which is currently unsupported and
quietly fails.

We need to break these into two functions 1) prep is
called once per spi_message and 2) io_config is called
once per spi-qup bus transaction

This is just refactoring, there should be no functional
change

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 91 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 8cfa112bb142..ff5aa08b5725 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -545,12 +545,11 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* set clock freq ... bits per word */
-static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
+/* set clock freq ... bits per word, determine mode */
+static int spi_qup_io_prep(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct spi_qup *controller = spi_master_get_devdata(spi->master);
-	u32 config, iomode, control;
-	int ret, n_words;
+	int ret;
 
 	if (spi->mode & SPI_LOOP && xfer->len > controller->in_fifo_sz) {
 		dev_err(controller->dev, "too big size for loopback %d > %d\n",
@@ -565,32 +564,56 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		return -EIO;
 	}
 
-	if (spi_qup_set_state(controller, QUP_STATE_RESET)) {
-		dev_err(controller->dev, "cannot set RESET state\n");
-		return -EIO;
-	}
-
 	controller->w_size = DIV_ROUND_UP(xfer->bits_per_word, 8);
 	controller->n_words = xfer->len / controller->w_size;
-	n_words = controller->n_words;
-
-	if (n_words <= (controller->in_fifo_sz / sizeof(u32))) {
 
+	if (controller->n_words <= (controller->in_fifo_sz / sizeof(u32)))
 		controller->mode = QUP_IO_M_MODE_FIFO;
+	else if (spi->master->can_dma &&
+		 spi->master->can_dma(spi->master, spi, xfer) &&
+		 spi->master->cur_msg_mapped)
+		controller->mode = QUP_IO_M_MODE_BAM;
+	else
+		controller->mode = QUP_IO_M_MODE_BLOCK;
+
+	return 0;
+}
+
+/* prep qup for another spi transaction of specific type */
+static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct spi_qup *controller = spi_master_get_devdata(spi->master);
+	u32 config, iomode, control;
+	unsigned long flags;
+
+	spin_lock_irqsave(&controller->lock, flags);
+	controller->xfer     = xfer;
+	controller->error    = 0;
+	controller->rx_bytes = 0;
+	controller->tx_bytes = 0;
+	spin_unlock_irqrestore(&controller->lock, flags);
+
+
+	if (spi_qup_set_state(controller, QUP_STATE_RESET)) {
+		dev_err(controller->dev, "cannot set RESET state\n");
+		return -EIO;
+	}
 
-		writel_relaxed(n_words, controller->base + QUP_MX_READ_CNT);
-		writel_relaxed(n_words, controller->base + QUP_MX_WRITE_CNT);
+	switch (controller->mode) {
+	case QUP_IO_M_MODE_FIFO:
+		writel_relaxed(controller->n_words,
+			       controller->base + QUP_MX_READ_CNT);
+		writel_relaxed(controller->n_words,
+			       controller->base + QUP_MX_WRITE_CNT);
 		/* must be zero for FIFO */
 		writel_relaxed(0, controller->base + QUP_MX_INPUT_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
-	} else if (spi->master->can_dma &&
-		   spi->master->can_dma(spi->master, spi, xfer) &&
-		   spi->master->cur_msg_mapped) {
-
-		controller->mode = QUP_IO_M_MODE_BAM;
-
-		writel_relaxed(n_words, controller->base + QUP_MX_INPUT_CNT);
-		writel_relaxed(n_words, controller->base + QUP_MX_OUTPUT_CNT);
+		break;
+	case QUP_IO_M_MODE_BAM:
+		writel_relaxed(controller->n_words,
+			       controller->base + QUP_MX_INPUT_CNT);
+		writel_relaxed(controller->n_words,
+			       controller->base + QUP_MX_OUTPUT_CNT);
 		/* must be zero for BLOCK and BAM */
 		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
@@ -608,19 +631,25 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 			if (xfer->tx_buf)
 				writel_relaxed(0, input_cnt);
 			else
-				writel_relaxed(n_words, input_cnt);
+				writel_relaxed(controller->n_words, input_cnt);
 
 			writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
 		}
-	} else {
-
-		controller->mode = QUP_IO_M_MODE_BLOCK;
-
-		writel_relaxed(n_words, controller->base + QUP_MX_INPUT_CNT);
-		writel_relaxed(n_words, controller->base + QUP_MX_OUTPUT_CNT);
+		break;
+	case QUP_IO_M_MODE_BLOCK:
+		reinit_completion(&controller->done);
+		writel_relaxed(controller->n_words,
+			       controller->base + QUP_MX_INPUT_CNT);
+		writel_relaxed(controller->n_words,
+			       controller->base + QUP_MX_OUTPUT_CNT);
 		/* must be zero for BLOCK and BAM */
 		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
+		break;
+	default:
+		dev_err(controller->dev, "unknown mode = %d\n",
+				controller->mode);
+		return -EIO;
 	}
 
 	iomode = readl_relaxed(controller->base + QUP_IO_M_MODES);
@@ -709,6 +738,10 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	unsigned long timeout, flags;
 	int ret = -EIO;
 
+	ret = spi_qup_io_prep(spi, xfer);
+	if (ret)
+		return ret;
+
 	ret = spi_qup_io_config(spi, xfer);
 	if (ret)
 		return ret;
-- 
2.13.2
