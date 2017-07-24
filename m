From: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v5 11/14] spi: qup: refactor spi_qup_prep_sg
Date: Mon, 24 Jul 2017 13:17:22 +0530
Message-ID: <1500882445-29008-12-git-send-email-varada@codeaurora.org>
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

Take specific sgl and nent to be prepared.  This is in
preparation for splitting DMA into multiple transacations, this
contains no code changes just refactoring.

Signed-off-by: Matthew McClintock <mmcclint-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/spi/spi-qup.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 67e7463..3ac9b25 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
