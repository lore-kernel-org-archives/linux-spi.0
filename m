From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: atmel: remove compat for non DT board when requesting dma chan
Date: Fri, 14 Nov 2014 17:12:53 +0100
Message-ID: <1415981574-11165-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

All boards with a dma controller have DT support so using
dma_request_slave_channel_compat is no more needed.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 649dcb5..f1760fa 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -414,23 +414,6 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as,
 	return err;
 }
 
-static bool filter(struct dma_chan *chan, void *pdata)
-{
-	struct atmel_spi_dma *sl_pdata = pdata;
-	struct at_dma_slave *sl;
-
-	if (!sl_pdata)
-		return false;
-
-	sl = &sl_pdata->dma_slave;
-	if (sl->dma_dev == chan->device->dev) {
-		chan->private = sl;
-		return true;
-	} else {
-		return false;
-	}
-}
-
 static int atmel_spi_configure_dma(struct atmel_spi *as)
 {
 	struct dma_slave_config	slave_config;
@@ -441,9 +424,7 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	as->dma.chan_tx = dma_request_slave_channel_compat(mask, filter,
-							   &as->dma,
-							   dev, "tx");
+	as->dma.chan_tx = dma_request_slave_channel(dev, "tx");
 	if (!as->dma.chan_tx) {
 		dev_err(dev,
 			"DMA TX channel not available, SPI unable to use DMA\n");
@@ -451,9 +432,7 @@ static int atmel_spi_configure_dma(struct atmel_spi *as)
 		goto error;
 	}
 
-	as->dma.chan_rx = dma_request_slave_channel_compat(mask, filter,
-							   &as->dma,
-							   dev, "rx");
+	as->dma.chan_rx = dma_request_slave_channel(dev, "rx");
 
 	if (!as->dma.chan_rx) {
 		dev_err(dev,
-- 
2.0.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
