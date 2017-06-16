From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 07/15] spi: qup: Fix transaction done signaling
Date: Fri, 16 Jun 2017 14:28:50 +0530
Message-ID: <1497603538-12750-8-git-send-email-varada@codeaurora.org>
References: <1497603538-12750-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497603538-12750-1-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Wait to signal done until we get all of the interrupts we are expecting
to get for a transaction.  If we don't wait for the input done flag, we
can be in between transactions when the done flag comes in and this can
mess up the next transaction.

While here cleaning up the code which sets controller->xfer = NULL and
restores it in the ISR. This looks to be some debug code which is not
required.

Signed-off-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2124815..9324093 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -406,29 +406,15 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
-	struct spi_transfer *xfer;
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
@@ -452,7 +438,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	if (!spi_qup_is_dma_xfer(controller->mode)) {
+	if (spi_qup_is_dma_xfer(controller->mode)) {
+		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
+	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
 			spi_qup_fifo_read(controller, xfer);
 
@@ -460,12 +448,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
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
@@ -665,7 +648,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
-	controller->xfer = NULL;
 	if (!ret)
 		ret = controller->error;
 	spin_unlock_irqrestore(&controller->lock, flags);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
