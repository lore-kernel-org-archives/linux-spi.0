From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Fix transaction done signaling" to the spi tree
Date: Tue, 08 Aug 2017 12:18:24 +0100
Message-ID: <E1df2Wm-0006Lq-FG@finisterre>
References: <1497949857-1852-8-git-send-email-varada@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Varadarajan Narayanan <varada@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497949857-1852-8-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Fix transaction done signaling

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

>From ce7dfc71c1123a4bc7ddc628fc759ede0f58a2fe Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada@codeaurora.org>
Date: Fri, 28 Jul 2017 12:22:53 +0530
Subject: [PATCH] spi: qup: Fix transaction done signaling

Wait to signal done until we get all of the interrupts we are expecting
to get for a transaction.  If we don't wait for the input done flag, we
can be in between transactions when the done flag comes in and this can
mess up the next transaction.

While here cleaning up the code which sets controller->xfer = NULL and
restores it in the ISR. This looks to be some debug code which is not
required.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ef952946375a..a7c630c4788c 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -409,29 +409,16 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
-	struct spi_transfer *xfer;
+	struct spi_transfer *xfer = controller->xfer;
 	u32 opflags, qup_err, spi_err;
-	unsigned long flags;
 	int error = 0;
 
-	spin_lock_irqsave(&controller->lock, flags);
-	xfer = controller->xfer;
-	controller->xfer = NULL;
-	spin_unlock_irqrestore(&controller->lock, flags);
-
 	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
 	spi_err = readl_relaxed(controller->base + SPI_ERROR_FLAGS);
 	opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
 
 	writel_relaxed(qup_err, controller->base + QUP_ERROR_FLAGS);
 	writel_relaxed(spi_err, controller->base + SPI_ERROR_FLAGS);
-	writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
-
-	if (!xfer) {
-		dev_err_ratelimited(controller->dev, "unexpected irq %08x %08x %08x\n",
-				    qup_err, spi_err, opflags);
-		return IRQ_HANDLED;
-	}
 
 	if (qup_err) {
 		if (qup_err & QUP_ERROR_OUTPUT_OVER_RUN)
@@ -455,7 +442,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	if (!spi_qup_is_dma_xfer(controller->mode)) {
+	if (spi_qup_is_dma_xfer(controller->mode)) {
+		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
+	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
 			spi_qup_fifo_read(controller, xfer);
 
@@ -463,12 +452,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 			spi_qup_fifo_write(controller, xfer);
 	}
 
-	spin_lock_irqsave(&controller->lock, flags);
-	controller->error = error;
-	controller->xfer = xfer;
-	spin_unlock_irqrestore(&controller->lock, flags);
-
-	if (controller->rx_bytes == xfer->len || error)
+	if ((opflags & QUP_OP_MAX_INPUT_DONE_FLAG) || error)
 		complete(&controller->done);
 
 	return IRQ_HANDLED;
@@ -666,7 +650,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
-	controller->xfer = NULL;
 	if (!ret)
 		ret = controller->error;
 	spin_unlock_irqrestore(&controller->lock, flags);
-- 
2.13.2
