From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH 12/15] spi: qup: refactor spi_qup_prep_sg
Date: Fri, 16 Jun 2017 14:28:55 +0530
Message-ID: <1497603538-12750-13-git-send-email-varada@codeaurora.org>
References: <1497603538-12750-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497603538-12750-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Take specific sgl and nent to be prepared.  This is in
preparation for splitting DMA into multiple transacations, this
contains no code changes just refactoring.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e6a43df..adf16e4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -382,26 +382,19 @@ static void spi_qup_write(struct spi_qup *controller)
 	} while (remainder);
 }
 
-static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
-			   enum dma_transfer_direction dir,
+static int spi_qup_prep_sg(struct spi_master *master, struct scatterlist *sgl,
+			   unsigned int nents, enum dma_transfer_direction dir,
 			   dma_async_tx_callback callback, void *data)
 {
 	unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
 	struct dma_async_tx_descriptor *desc;
-	struct scatterlist *sgl;
 	struct dma_chan *chan;
 	dma_cookie_t cookie;
-	unsigned int nents;
 
-	if (dir == DMA_MEM_TO_DEV) {
+	if (dir == DMA_MEM_TO_DEV)
 		chan = master->dma_tx;
-		nents = xfer->tx_sg.nents;
-		sgl = xfer->tx_sg.sgl;
-	} else {
+	else
 		chan = master->dma_rx;
-		nents = xfer->rx_sg.nents;
-		sgl = xfer->rx_sg.sgl;
-	}
 
 	desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
 	if (IS_ERR_OR_NULL(desc))
@@ -444,8 +437,9 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	}
 
 	if (xfer->rx_buf) {
-		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM,
-					spi_qup_dma_done, &qup->rxc);
+		ret = spi_qup_prep_sg(master, xfer->rx_sg.sgl,
+				      xfer->rx_sg.nents, DMA_DEV_TO_MEM,
+				      spi_qup_dma_done, &qup->rxc);
 		if (ret)
 			return ret;
 
@@ -453,8 +447,9 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	}
 
 	if (xfer->tx_buf) {
-		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV,
-					spi_qup_dma_done, &qup->txc);
+		ret = spi_qup_prep_sg(master, xfer->tx_sg.sgl,
+				      xfer->tx_sg.nents, DMA_MEM_TO_DEV,
+				      spi_qup_dma_done, &qup->txc);
 		if (ret)
 			return ret;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
