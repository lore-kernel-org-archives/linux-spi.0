From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v6 11/14] spi: qup: refactor spi_qup_prep_sg
Date: Fri, 28 Jul 2017 12:22:58 +0530
Message-ID: <1501224781-19519-12-git-send-email-varada@codeaurora.org>
References: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Take specific sgl and nent to be prepared.  This is in
preparation for splitting DMA into multiple transacations, this
contains no code changes just refactoring.

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 707b1ec..1af3b41 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -382,27 +382,20 @@ static void spi_qup_write(struct spi_qup *controller)
 	} while (remainder);
 }
 
-static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
-			   enum dma_transfer_direction dir,
+static int spi_qup_prep_sg(struct spi_master *master, struct scatterlist *sgl,
+			   unsigned int nents, enum dma_transfer_direction dir,
 			   dma_async_tx_callback callback)
 {
 	struct spi_qup *qup = spi_master_get_devdata(master);
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
@@ -451,7 +444,9 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	}
 
 	if (xfer->rx_buf) {
-		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM, rx_done);
+		ret = spi_qup_prep_sg(master, xfer->rx_sg.sgl,
+				      xfer->rx_sg.nents, DMA_DEV_TO_MEM,
+				      rx_done);
 		if (ret)
 			return ret;
 
@@ -459,7 +454,9 @@ static int spi_qup_do_dma(struct spi_device *spi, struct spi_transfer *xfer,
 	}
 
 	if (xfer->tx_buf) {
-		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV, tx_done);
+		ret = spi_qup_prep_sg(master, xfer->tx_sg.sgl,
+				      xfer->tx_sg.nents, DMA_MEM_TO_DEV,
+				      tx_done);
 		if (ret)
 			return ret;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
