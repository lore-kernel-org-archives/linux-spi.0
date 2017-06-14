From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 10/18] spi: qup: Fix DMA mode interrupt handling
Date: Wed, 14 Jun 2017 11:22:23 +0530
Message-ID: <1497419551-21834-11-git-send-email-varada@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is needed for v1, where the i/o completion is not
handled in the dma driver.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 872de28..bd53e82 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -510,9 +510,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 
 	writel_relaxed(qup_err, controller->base + QUP_ERROR_FLAGS);
 	writel_relaxed(spi_err, controller->base + SPI_ERROR_FLAGS);
-	writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 
 	if (!xfer) {
+		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 		dev_err_ratelimited(controller->dev, "unexpected irq %08x %08x %08x\n",
 				    qup_err, spi_err, opflags);
 		return IRQ_HANDLED;
@@ -540,7 +540,15 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	if (!spi_qup_is_dma_xfer(controller->mode)) {
+	if (spi_qup_is_dma_xfer(controller->mode)) {
+		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
+		if (opflags & QUP_OP_IN_SERVICE_FLAG &&
+		    opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
+			complete(&controller->rxc);
+		if (opflags & QUP_OP_OUT_SERVICE_FLAG &&
+		    opflags & QUP_OP_MAX_OUTPUT_DONE_FLAG)
+			complete(&controller->txc);
+	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
 			spi_qup_read(controller, xfer);
 
@@ -553,6 +561,9 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	controller->xfer = xfer;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
+	/* re-read opflags as flags may have changed due to actions above */
+	opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
+
 	if ((controller->rx_bytes == xfer->len &&
 		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)
 		complete(&controller->done);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
