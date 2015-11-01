From: Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 6/7] spi: imx: return error from dma channel request
Date: Sun,  1 Nov 2015 15:41:40 +0100
Message-ID: <1446388901-6073-7-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1446388901-6073-1-git-send-email-anton.bondarenko.sama@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org,
	s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446388901-6073-1-git-send-email-anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

On SDMA initialization return exactly the same error, which is
reported by dma_request_slave_channel_reason(), it is a preceding
change to defer SPI DMA initialization, if SDMA module is not yet
available.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Anton Bondarenko <anton_bondarenko-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index dc492e2..6035ddd 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -923,18 +923,20 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
 
 	/* Prepare for TX DMA: */
-	master->dma_tx = dma_request_slave_channel(dev, "tx");
-	if (!master->dma_tx) {
-		dev_err(dev, "cannot get the TX DMA channel!\n");
-		ret = -EINVAL;
+	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		dev_info(dev, "cannot get the TX DMA channel!\n");
+		ret = PTR_ERR(master->dma_tx);
+		master->dma_tx = NULL;
 		goto err;
 	}
 
 	/* Prepare for RX : */
-	master->dma_rx = dma_request_slave_channel(dev, "rx");
-	if (!master->dma_rx) {
-		dev_dbg(dev, "cannot get the DMA channel.\n");
-		ret = -EINVAL;
+	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(master->dma_rx)) {
+		dev_info(dev, "cannot get the DMA channel.\n");
+		ret = PTR_ERR(master->dma_rx);
+		master->dma_rx = NULL;
 		goto err;
 	}
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
