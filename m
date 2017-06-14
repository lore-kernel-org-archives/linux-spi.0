From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 07/18] spi: qup: Fix transaction done signaling
Date: Wed, 14 Jun 2017 11:22:20 +0530
Message-ID: <1497419551-21834-8-git-send-email-varada@codeaurora.org>
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

Wait to signal done until we get all of the interrupts we are expecting
to get for a transaction.  If we don't wait for the input done flag, we
can be inbetween transactions when the done flag comes in and this can
mess up the next transaction.

Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2124815..7c22ee4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -465,7 +465,8 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	controller->xfer = xfer;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
-	if (controller->rx_bytes == xfer->len || error)
+	if ((controller->rx_bytes == xfer->len &&
+		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)
 		complete(&controller->done);
 
 	return IRQ_HANDLED;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
