From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: qup: Ensure done detection" to the spi tree
Date: Tue, 08 Aug 2017 12:17:57 +0100
Message-ID: <E1df2WL-0006EH-RR@finisterre>
References: <1497603538-12750-15-git-send-email-varada@codeaurora.org>
Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Abhishek Sahu <absahu-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1497603538-12750-15-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Ensure done detection

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

>From cd595b99af24b8efa4a6a8889ad65f4d270fd644 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Date: Fri, 28 Jul 2017 12:23:00 +0530
Subject: [PATCH] spi: qup: Ensure done detection

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-qup.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 3c2c2c0ed9ab..4c3c938360f4 100644
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
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
