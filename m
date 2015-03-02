From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: [PATCH] spi: spi-imx: use correct enumeration type
Date: Tue,  3 Mar 2015 00:28:31 +0100
Message-ID: <1425338911-11407-1-git-send-email-stefan@agner.ch>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	llvmlinux-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The fourth argument of dmaengine_prep_slave_sg needs to be of the
enumeration type dma_transfer_direction instead of dma_data_direction.
Since the used enumeration values actually stay the same, this is not
an actual issue at runtime.

Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
---
This showed up when I tried using LLVM/clang to build a kernel for
a Freescale Vybrid based board.

 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 961b97d..220f566 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -899,7 +899,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 
 	if (tx) {
 		desc_tx = dmaengine_prep_slave_sg(master->dma_tx,
-					tx->sgl, tx->nents, DMA_TO_DEVICE,
+					tx->sgl, tx->nents, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_tx)
 			goto no_dma;
@@ -911,7 +911,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 
 	if (rx) {
 		desc_rx = dmaengine_prep_slave_sg(master->dma_rx,
-					rx->sgl, rx->nents, DMA_FROM_DEVICE,
+					rx->sgl, rx->nents, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc_rx)
 			goto no_dma;
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
