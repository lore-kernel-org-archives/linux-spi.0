From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch v1] spi: imx: fix spi resource leak with dma transfer
Date: Mon, 18 Jan 2016 15:44:01 +0800
Message-ID: <1453103041-23197-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <frank.li-3arQi8VN3Tc@public.gmane.org>,
	<fugang.duan-3arQi8VN3Tc@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In spi_imx_dma_transfer(), when desc_rx = dmaengine_prep_slave_sg()
fails, the context goes to label no_dma and then return. However,
the memory allocated for desc_tx has not been freed yet, which leads
to resource leak.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index d98c33c..6a4ff27 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -929,7 +929,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
-			goto no_dma;
+			goto tx_nodma;
 
 		desc_tx->callback = spi_imx_dma_tx_callback;
 		desc_tx->callback_param = (void *)spi_imx;
@@ -941,7 +941,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx)
-			goto no_dma;
+			goto rx_nodma;
 
 		desc_rx->callback = spi_imx_dma_rx_callback;
 		desc_rx->callback_param = (void *)spi_imx;
@@ -1008,7 +1008,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 
 	return ret;
 
-no_dma:
+rx_nodma:
+	dmaengine_terminate_all(master->dma_tx);
+tx_nodma:
 	pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
 		     dev_driver_string(&master->dev),
 		     dev_name(&master->dev));
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
