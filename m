From: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Subject: [PATCH 2/3] spi-topcliff-pch: Fix DMA channel
Date: Wed, 19 Feb 2014 10:36:08 +0100
Message-ID: <1392802569-11148-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1392802569-11148-1-git-send-email-alexander.stein@systec-electronic.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392802569-11148-1-git-send-email-alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

bus_num might be asigned dynamically to e.g. 32766. In this case the
calculated DMA channel based on SPI bus number is bogus. Use SPI channel
number instead for calculation.

Signed-off-by: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index d038a7b..7cb71b0 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -921,7 +921,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	/* Set Tx DMA */
 	param = &dma->param_tx;
 	param->dma_dev = &dma_dev->dev;
-	param->chan_id = data->master->bus_num * 2; /* Tx = 0, 2 */
+	param->chan_id = data->ch * 2; /* Tx = 0, 2 */;
 	param->tx_reg = data->io_base_addr + PCH_SPDWR;
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
@@ -936,7 +936,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	/* Set Rx DMA */
 	param = &dma->param_rx;
 	param->dma_dev = &dma_dev->dev;
-	param->chan_id = data->master->bus_num * 2 + 1; /* Rx = Tx + 1 */
+	param->chan_id = data->ch * 2 + 1; /* Rx = Tx + 1 */;
 	param->rx_reg = data->io_base_addr + PCH_SPDRR;
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
