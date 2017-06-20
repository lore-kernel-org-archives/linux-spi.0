From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v3 14/15] spi: qup: Ensure done detection
Date: Tue, 20 Jun 2017 14:40:56 +0530
Message-ID: <1497949857-1852-15-git-send-email-varada@codeaurora.org>
References: <1497949857-1852-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497949857-1852-1-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch fixes an issue where a SPI transaction has completed, but the
done condition is missed.  This occurs because at the time of interrupt the
MAX_INPUT_DONE_FLAG is not asserted.  However, in the process of reading
blocks of data from the FIFO, the last portion of data comes in.

The opflags read at the beginning of the irq handler no longer matches the
current opflag state.  To get around this condition, the block read
function should update the opflags so that done detection is correct after
the return.

Signed-off-by: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index a39a0d2..ca5206e 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -268,7 +268,7 @@ static void spi_qup_read_from_fifo(struct spi_qup *controller, u32 num_words)
 	}
 }
 
-static void spi_qup_read(struct spi_qup *controller)
+static void spi_qup_read(struct spi_qup *controller, u32 *opflags)
 {
 	u32 remainder, words_per_block, num_words;
 	bool is_block_mode = controller->mode == QUP_IO_M_MODE_BLOCK;
@@ -307,10 +307,12 @@ static void spi_qup_read(struct spi_qup *controller)
 
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
 
@@ -617,7 +619,7 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		writel_relaxed(opflags, controller->base + QUP_OPERATIONAL);
 	} else {
 		if (opflags & QUP_OP_IN_SERVICE_FLAG)
-			spi_qup_read(controller);
+			spi_qup_read(controller, &opflags);
 
 		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
 			spi_qup_write(controller);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
