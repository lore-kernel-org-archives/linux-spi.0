From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: imx: read back the RX/TX watermark levels earlier
Date: Wed,  1 Apr 2015 10:46:15 +0200
Message-ID: <1427877975-816-1-git-send-email-l.stach@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

They are used to decide if the controller can do DMA on a buffer
of a specific length and thus are needed before any transfer is attempted.

This fixes a memory leak where the SPI core uses the drivers can_dma()
callback to determine if a buffer needs to be mapped. As the watermark
levels aren't correct at that point the driver falsely claims to be able to
DMA the buffer when it fact it isn't.
After the transfer has been done the core uses the same callback to
determine if it needs to unmap the buffers. As the driver now correctly
claims to not being able to DMA the buffer the core doesn't attempt to
unmap the buffer which leaves the SGT leaking.

Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 6fea4af51c41..aea3a67e5ce1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -370,8 +370,6 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	if (spi_imx->dma_is_inited) {
 		dma = readl(spi_imx->base + MX51_ECSPI_DMA);
 
-		spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
-		spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
 		spi_imx->rxt_wml = spi_imx_get_fifosize(spi_imx) / 2;
 		rx_wml_cfg = spi_imx->rx_wml << MX51_ECSPI_DMA_RX_WML_OFFSET;
 		tx_wml_cfg = spi_imx->tx_wml << MX51_ECSPI_DMA_TX_WML_OFFSET;
@@ -868,6 +866,8 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	master->max_dma_len = MAX_SDMA_BD_BYTES;
 	spi_imx->bitbang.master->flags = SPI_MASTER_MUST_RX |
 					 SPI_MASTER_MUST_TX;
+	spi_imx->tx_wml = spi_imx_get_fifosize(spi_imx) / 2;
+	spi_imx->rx_wml = spi_imx_get_fifosize(spi_imx) / 2;
 	spi_imx->dma_is_inited = 1;
 
 	return 0;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
