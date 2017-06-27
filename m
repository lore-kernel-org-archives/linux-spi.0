From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v4 13/14] spi: qup: allow multiple DMA transactions per spi xfer
Date: Tue, 27 Jun 2017 15:15:30 +0530
Message-ID: <1498556731-13087-14-git-send-email-varada@codeaurora.org>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1498556731-13087-1-git-send-email-varada@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Much like the block mode changes, we are breaking up DMA transactions
into 64K chunks so we can reset the QUP engine.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 104 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2423ee5..a39a0d2 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -417,50 +417,98 @@ static void spi_qup_dma_terminate(struct spi_master *master,
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
 	struct spi_master *master = spi->master;
 	struct spi_qup *qup = spi_master_get_devdata(master);
+	struct scatterlist *tx_sgl, *rx_sgl;
 	int ret;
 
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
-				      spi_qup_dma_done, &qup->rxc);
+		ret = spi_qup_io_config(spi, xfer);
 		if (ret)
 			return ret;
 
-		dma_async_issue_pending(master->dma_rx);
-	}
-
-	if (xfer->tx_buf) {
-		ret = spi_qup_prep_sg(master, xfer->tx_sg.sgl,
-				      xfer->tx_sg.nents, DMA_MEM_TO_DEV,
-				      spi_qup_dma_done, &qup->txc);
-		if (ret)
+		/* before issuing the descriptors, set the QUP to run */
+		ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+		if (ret) {
+			dev_warn(qup->dev, "cannot set RUN state\n");
 			return ret;
+		}
+		if (rx_sgl) {
+			ret = spi_qup_prep_sg(master, rx_sgl, rx_nents,
+					      DMA_DEV_TO_MEM,
+					      spi_qup_dma_done, &qup->rxc);
+			if (ret)
+				return ret;
+			dma_async_issue_pending(master->dma_rx);
+		}
 
-		dma_async_issue_pending(master->dma_tx);
-	}
+		if (tx_sgl) {
+			ret = spi_qup_prep_sg(master, tx_sgl, tx_nents,
+					      DMA_MEM_TO_DEV,
+					      spi_qup_dma_done, &qup->txc);
+			if (ret)
+				return ret;
+
+			dma_async_issue_pending(master->dma_tx);
+		}
+
+		if (rx_sgl &&
+		    !wait_for_completion_timeout(&qup->rxc, timeout)) {
+			pr_emerg(" rx timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		if (tx_sgl &&
+		    !wait_for_completion_timeout(&qup->txc, timeout)) {
+			pr_emerg(" tx timed out\n");
+			return -ETIMEDOUT;
+		}
 
-	if (xfer->rx_buf && !wait_for_completion_timeout(&qup->rxc, timeout))
-		return -ETIMEDOUT;
+		for (; rx_sgl && rx_nents--; rx_sgl = sg_next(rx_sgl))
+			;
+		for (; tx_sgl && tx_nents--; tx_sgl = sg_next(tx_sgl))
+			;
 
-	if (xfer->tx_buf && !wait_for_completion_timeout(&qup->txc, timeout))
-		return -ETIMEDOUT;
+	} while (rx_sgl || tx_sgl);
 
 	return 0;
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
