From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: imx: Fix small DMA transfers
Date: Fri, 24 Jul 2015 15:01:08 +0200
Message-ID: <1437742868-23430-1-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DMA transfers must be greater than the watermark level size. spi_imx->rx_wml
and spi_imx->tx_wml contain the watermark level in 32bit words whereas struct
spi_transfer contains the transfer len in bytes. Fix the check if DMA is
possible for a transfer accordingly. This fixes transfers with sizes between
33 and 128 bytes for which previously was claimed that DMA is possible.

Fixes: f62caccd12c17e4 (spi: spi-imx: add DMA support)
Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/spi-imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f08e812..412b9c8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -201,8 +201,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->rx_wml)
-	    && (transfer->len > spi_imx->tx_wml))
+	if (spi_imx->dma_is_inited
+	    && transfer->len > spi_imx->rx_wml * sizeof(u32)
+	    && transfer->len > spi_imx->tx_wml * sizeof(u32))
 		return true;
 	return false;
 }
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
