From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v4 04/14] spi: qup: Add completion timeout
Date: Tue, 27 Jun 2017 15:15:21 +0530
Message-ID: <1498556731-13087-5-git-send-email-varada@codeaurora.org>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498556731-13087-1-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add i/o completion timeout for DMA and PIO modes.

Signed-off-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 59e799f..d3ccf53 100644
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
@@ -353,10 +354,17 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 		dma_async_issue_pending(master->dma_tx);
 	}
 
+	if (xfer->rx_buf && !wait_for_completion_timeout(&qup->rxc, timeout))
+		return -ETIMEDOUT;
+
+	if (xfer->tx_buf && !wait_for_completion_timeout(&qup->txc, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
-static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
+static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer,
+			  unsigned long timeout)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
@@ -375,6 +383,9 @@ static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
 
 	spi_qup_fifo_write(qup, xfer);
 
+	if (!wait_for_completion_timeout(&qup->done, timeout))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
@@ -618,7 +629,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
 
-
 	spin_lock_irqsave(&controller->lock, flags);
 	controller->xfer     = xfer;
 	controller->error    = 0;
@@ -629,10 +639,10 @@ static int spi_qup_transfer_one(struct spi_master *master,
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
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
