From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] spi: pl022: Fix broken spidev when DMA is enabled
Date: Tue, 7 Oct 2014 21:38:47 -0700
Message-ID: <1412743127-4523-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	JD Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The PL022 SPI driver maps the DMA RX buffer before the DMA TX buffer. In
most cases, the sequence of the mapping does not matter. But in cases
where TX and RX happen to use the same buffer, e.g., spidev, it causes
the cached TX data not written to memory, because the same memory has
been marked invalid when dma_map_sg on the RX buffer is called

The solution is to reverse the sequence so it maps the TX buffer before
the RX buffer

Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: JD (Jiandong) Zheng <jdzheng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Tested-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-pl022.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1189cfd..edb7298 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -773,10 +773,10 @@ static void *next_transfer(struct pl022 *pl022)
 static void unmap_free_dma_scatter(struct pl022 *pl022)
 {
 	/* Unmap and free the SG tables */
-	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
-		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	dma_unmap_sg(pl022->dma_rx_channel->device->dev, pl022->sgt_rx.sgl,
 		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	dma_unmap_sg(pl022->dma_tx_channel->device->dev, pl022->sgt_tx.sgl,
+		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	sg_free_table(&pl022->sgt_rx);
 	sg_free_table(&pl022->sgt_tx);
 }
@@ -1026,16 +1026,16 @@ static int configure_dma(struct pl022 *pl022)
 			  pl022->cur_transfer->len, &pl022->sgt_tx);
 
 	/* Map DMA buffers */
-	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
-	if (!rx_sglen)
-		goto err_rx_sgmap;
-
 	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
 			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
 	if (!tx_sglen)
 		goto err_tx_sgmap;
 
+	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
+			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+	if (!rx_sglen)
+		goto err_rx_sgmap;
+
 	/* Send both scatterlists */
 	rxdesc = dmaengine_prep_slave_sg(rxchan,
 				      pl022->sgt_rx.sgl,
@@ -1070,12 +1070,12 @@ err_txdesc:
 	dmaengine_terminate_all(txchan);
 err_rxdesc:
 	dmaengine_terminate_all(rxchan);
+	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
+		     pl022->sgt_rx.nents, DMA_FROM_DEVICE);
+err_rx_sgmap:
 	dma_unmap_sg(txchan->device->dev, pl022->sgt_tx.sgl,
 		     pl022->sgt_tx.nents, DMA_TO_DEVICE);
 err_tx_sgmap:
-	dma_unmap_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
-		     pl022->sgt_tx.nents, DMA_FROM_DEVICE);
-err_rx_sgmap:
 	sg_free_table(&pl022->sgt_tx);
 err_alloc_tx_sg:
 	sg_free_table(&pl022->sgt_rx);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
