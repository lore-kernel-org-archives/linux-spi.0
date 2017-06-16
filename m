From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 04/15] spi: qup: Add completion timeout for fifo/block mode
Date: Fri, 16 Jun 2017 14:28:47 +0530
Message-ID: <1497603538-12750-5-git-send-email-varada@codeaurora.org>
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

Signed-off-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 272e48e..d3ccf53 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -330,7 +330,8 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
-static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -362,7 +363,8 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -381,6 +383,9 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
 
 	spi_qup_fifo_write(qup, xfer);
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
@@ -624,7 +629,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
 
-
 	spin_lock_irqsave(&controller->lock, flags);
 	controller->xfer     = xfer;
 	controller->error    = 0;
@@ -635,10 +639,10 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	if (spi_qup_is_dma_xfer(controller->mode)) {
 		reinit_completion(&controller->rxc);
 		reinit_completion(&controller->txc);
-		ret = spi_qup_do_dma(master, xfer);
+		ret = spi_qup_do_dma(master, xfer, timeout);
 	} else {
 		reinit_completion(&controller->done);
-		ret = spi_qup_do_pio(master, xfer);
+		ret = spi_qup_do_pio(master, xfer, timeout);
 	}
 
 	if (ret)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
