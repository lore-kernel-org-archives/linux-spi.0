From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v4 03/14] spi: qup: Add completion structures for DMA
Date: Tue, 27 Jun 2017 15:15:20 +0530
Message-ID: <1498556731-13087-4-git-send-email-varada@codeaurora.org>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498556731-13087-1-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use different 'completion' structures to track the completion
of DMA Tx/Rx and PIO.

Signed-off-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index abe799b..59e799f 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -142,6 +142,8 @@ struct spi_qup {
 
 	struct spi_transfer	*xfer;
 	struct completion	done;
+	struct completion	txc;
+	struct completion	rxc;
 	int			error;
 	int			w_size;	/* bytes per SPI word */
 	int			n_words;
@@ -283,16 +285,13 @@ static void spi_qup_fifo_write(struct spi_qup *controller,
 
 static void spi_qup_dma_done(void *data)
 {
-	struct spi_qup *qup = data;
-
-	complete(&qup->done);
+	complete(data);
 }
 
 static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
 			   enum dma_transfer_direction dir,
-			   dma_async_tx_callback callback)
+			   dma_async_tx_callback callback, void *data)
 {
-	struct spi_qup *qup = spi_master_get_devdata(master);
 	unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
 	struct dma_async_tx_descriptor *desc;
 	struct scatterlist *sgl;
@@ -315,7 +314,7 @@ static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
 		return -EINVAL;
 
 	desc->callback = callback;
-	desc->callback_param = qup;
+	desc->callback_param = data;
 
 	cookie = dmaengine_submit(desc);
 
@@ -333,16 +332,12 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 
 static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 {
-	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
+	struct spi_qup *qup = spi_master_get_devdata(master);
 	int ret;
 
-	if (xfer->rx_buf)
-		rx_done = spi_qup_dma_done;
-	else if (xfer->tx_buf)
-		tx_done = spi_qup_dma_done;
-
 	if (xfer->rx_buf) {
-		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM, rx_done);
+		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM,
+					spi_qup_dma_done, &qup->rxc);
 		if (ret)
 			return ret;
 
@@ -350,7 +345,8 @@ static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
 	}
 
 	if (xfer->tx_buf) {
-		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV, tx_done);
+		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV,
+					spi_qup_dma_done, &qup->txc);
 		if (ret)
 			return ret;
 
@@ -622,7 +618,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	timeout = DIV_ROUND_UP(xfer->len * 8, timeout);
 	timeout = 100 * msecs_to_jiffies(timeout);
 
-	reinit_completion(&controller->done);
 
 	spin_lock_irqsave(&controller->lock, flags);
 	controller->xfer     = xfer;
@@ -631,10 +626,14 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	controller->tx_bytes = 0;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
-	if (spi_qup_is_dma_xfer(controller->mode))
+	if (spi_qup_is_dma_xfer(controller->mode)) {
+		reinit_completion(&controller->rxc);
+		reinit_completion(&controller->txc);
 		ret = spi_qup_do_dma(master, xfer);
-	else
+	} else {
+		reinit_completion(&controller->done);
 		ret = spi_qup_do_pio(master, xfer);
+	}
 
 	if (ret)
 		goto exit;
@@ -860,6 +859,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 		master->set_cs = spi_qup_set_cs;
 
 	spin_lock_init(&controller->lock);
+	init_completion(&controller->rxc);
+	init_completion(&controller->txc);
 	init_completion(&controller->done);
 
 	iomode = readl_relaxed(base + QUP_IO_M_MODES);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
