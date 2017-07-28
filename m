From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v6 13/14] spi: qup: Ensure done detection
Date: Fri, 28 Jul 2017 12:23:00 +0530
Message-ID: <1501224781-19519-14-git-send-email-varada@codeaurora.org>
References: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Andy Gross <agross@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch fixes an issue where a SPI transaction has completed, but the
done condition is missed.  This occurs because at the time of interrupt the
MAX_INPUT_DONE_FLAG is not asserted.  However, in the process of reading
blocks of data from the FIFO, the last portion of data comes in.

The opflags read at the beginning of the irq handler no longer matches the
current opflag state.  To get around this condition, the block read
function should update the opflags so that done detection is correct after
the return.

Signed-off-by: Andy Gross <agross@codeaurora.org>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 3c2c2c0..4c3c938 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -266,7 +266,7 @@ static void spi_qup_read_from_fifo(struct spi_qup *controller, u32 num_words)
 	}
 }
 
-static void spi_qup_read(struct spi_qup *controller)
+static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 {
 	u32 remainder, words_per_block, num_words;
 	bool is_block_mode = controller->mode == QUP_IO_M_MODE_BLOCK;
@@ -305,10 +305,12 @@ static void spi_qup_read(struct spi_qup *controller)
 
 	/*
 	 * Due to extra stickiness of the QUP_OP_IN_SERVICE_FLAG during block
-	 * mode reads, it has to be cleared again at the very end
+	 * reads, it has to be cleared again at the very end.  However, be sure
+	 * to refresh opflags value because MAX_INPUT_DONE_FLAG may now be
+	 * present and this is used to determine if transaction is complete
 	 */
-	if (is_block_mode && spi_qup_is_flag_set(controller,
-				QUP_OP_MAX_INPUT_DONE_FLAG))
+	*opflags = readl_relaxed(controller->base + QUP_OPERATIONAL);
+	if (is_block_mode && *opflags & QUP_OP_MAX_INPUT_DONE_FLAG)
 		writel_relaxed(QUP_OP_IN_SERVICE_FLAG,
 			       controller->base + QUP_OPERATIONAL);
 
@@ -613,7 +615,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
-			spi_qup_read(controller);
+			spi_qup_read(controller, &opflags);
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
 			spi_qup_write(controller);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
