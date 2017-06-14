From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 11/18] spi: qup: properly detect extra interrupts
Date: Wed, 14 Jun 2017 11:22:24 +0530
Message-ID: <1497419551-21834-12-git-send-email-varada@codeaurora.org>
References: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497419551-21834-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

It's possible for a SPI transaction to complete and get another
interrupt and have it processed on the same spi_transfer before the
transfer_one can set it to NULL.

This masks unexpected interrupts, so let's set the spi_transfer to
NULL in the interrupt once the transaction is done. So we can
properly detect these bad interrupts and print warning messages.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index bd53e82..1a2a9d9 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -496,13 +496,13 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	struct spi_qup *controller = dev_id;
 	struct spi_transfer *xfer;
 	u32 opflags, qup_err, spi_err;
-	unsigned long flags;
 	int error = 0;
+	bool done = 0;
 
-	spin_lock_irqsave(&controller->lock, flags);
+	spin_lock(&controller->lock);
 	xfer = controller->xfer;
 	controller->xfer = NULL;
-	spin_unlock_irqrestore(&controller->lock, flags);
+	spin_unlock(&controller->lock);
 
 	qup_err = readl_relaxed(controller->base + QUP_ERROR_FLAGS);
 	spi_err = readl_relaxed(controller->base + SPI_ERROR_FLAGS);
@@ -556,16 +556,19 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 			spi_qup_write(controller, xfer);
 	}
 
-	spin_lock_irqsave(&controller->lock, flags);
-	controller->error = error;
-	controller->xfer = xfer;
-	spin_unlock_irqrestore(&controller->lock, flags);
-
 	/* re-read opflags as flags may have changed due to actions above */
 	opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
 
 	if ((controller->rx_bytes == xfer->len &&
 		(opflags & QUP_OP_MAX_INPUT_DONE_FLAG)) ||  error)
+		done = true;
+
+	spin_lock(&controller->lock);
+	controller->error = error;
+	controller->xfer = done ? NULL : xfer;
+	spin_unlock(&controller->lock);
+
+	if (done)
 		complete(&controller->done);
 
 	return IRQ_HANDLED;
@@ -765,7 +768,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
-	controller->xfer = NULL;
 	if (!ret)
 		ret = controller->error;
 	spin_unlock_irqrestore(&controller->lock, flags);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
