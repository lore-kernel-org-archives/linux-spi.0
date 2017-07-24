From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 12/14] spi: qup: allow multiple DMA transactions per spi xfer
Date: Mon, 24 Jul 2017 13:17:23 +0530
Message-ID: <1500882445-29008-13-git-send-email-varada@codeaurora.org>
References: <1500882445-29008-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500882445-29008-1-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Much like the block mode changes, we are breaking up DMA transactions
into 64K chunks so we can reset the QUP engine.

Signed-off-by: Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 93 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 3ac9b25..3c2c2c0 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -418,12 +418,35 @@ static void spi_qup_dma_terminate(struct spi_master *master,
 		dmaengine_terminate_all(master->dma_rx);
 }
 
+static u32 spi_qup_sgl_get_nents_len(struct scatterlist *sgl, u32 max,
+				     u32 *nents)
+{
+	struct scatterlist *sg;
+	u32 total = 0;
+
+	*nents = 0;
+
+	for (sg = sgl; sg; sg = sg_next(sg)) {
+		unsigned int len = sg_dma_len(sg);
+
+		/* check for overflow as well as limit */
+		if (((total + len) < total) || ((total + len) > max))
+			break;
+
+		total += len;
+		(*nents)++;
+	}
+
+	return total;
+}
+
 static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 			  unsigned long timeout)
 {
 	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
 	struct spi_master *master = spi->master;
 	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct scatterlist *tx_sgl, *rx_sgl;
 	int ret;
 
 	if (xfer->rx_buf)
@@ -431,43 +454,57 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	else if (xfer->tx_buf)
 		tx_done = spi_qup_dma_done;
 
-	ret = spi_qup_io_config(spi, xfer);
-	if (ret)
-		return ret;
+	rx_sgl = xfer->rx_sg.sgl;
+	tx_sgl = xfer->tx_sg.sgl;
 
-	/* before issuing the descriptors, set the QUP to run */
-	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
-	if (ret) {
-		dev_warn(qup->dev, "%s(%d): cannot set RUN state\n",
-				__func__, __LINE__);
-		return ret;
-	}
+	do {
+		u32 rx_nents, tx_nents;
+
+		if (rx_sgl)
+			qup->n_words = spi_qup_sgl_get_nents_len(rx_sgl,
+					SPI_MAX_XFER, &rx_nents) / qup->w_size;
+		if (tx_sgl)
+			qup->n_words = spi_qup_sgl_get_nents_len(tx_sgl,
+					SPI_MAX_XFER, &tx_nents) / qup->w_size;
+		if (!qup->n_words)
+			return -EIO;
 
-	if (xfer->rx_buf) {
-		ret = spi_qup_prep_sg(master, xfer->rx_sg.sgl,
-				      xfer->rx_sg.nents, DMA_DEV_TO_MEM,
-				      rx_done);
+		ret = spi_qup_io_config(spi, xfer);
 		if (ret)
 			return ret;
 
-		dma_async_issue_pending(master->dma_rx);
-	}
-
-	if (xfer->tx_buf) {
-		ret = spi_qup_prep_sg(master, xfer->tx_sg.sgl,
-				      xfer->tx_sg.nents, DMA_MEM_TO_DEV,
-				      tx_done);
-		if (ret)
+		/* before issuing the descriptors, set the QUP to run */
+		ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+		if (ret) {
+			dev_warn(qup->dev, "cannot set RUN state\n");
 			return ret;
+		}
+		if (rx_sgl) {
+			ret = spi_qup_prep_sg(master, rx_sgl, rx_nents,
+					      DMA_DEV_TO_MEM, rx_done);
+			if (ret)
+				return ret;
+			dma_async_issue_pending(master->dma_rx);
+		}
 
-		dma_async_issue_pending(master->dma_tx);
-	}
+		if (tx_sgl) {
+			ret = spi_qup_prep_sg(master, tx_sgl, tx_nents,
+					      DMA_MEM_TO_DEV, tx_done);
+			if (ret)
+				return ret;
+
+			dma_async_issue_pending(master->dma_tx);
+		}
+
+		if (!wait_for_completion_timeout(&qup->done, timeout))
+			return -ETIMEDOUT;
 
-	if (rx_done && !wait_for_completion_timeout(&qup->done, timeout))
-		return -ETIMEDOUT;
+		for (; rx_sgl && rx_nents--; rx_sgl = sg_next(rx_sgl))
+			;
+		for (; tx_sgl && tx_nents--; tx_sgl = sg_next(tx_sgl))
+			;
 
-	if (tx_done && !wait_for_completion_timeout(&qup->done, timeout))
-		return -ETIMEDOUT;
+	} while (rx_sgl || tx_sgl);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
