From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: dw-mid: set DMA burst on memory side
Date: Mon, 11 Apr 2016 19:30:12 +0300
Message-ID: <1460392212-101116-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

To optimize amount of bus writes on memory side set burst to be the same amount
of data on both sides.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index e31971f9..0e0c34e 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -157,6 +157,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_tx(struct dw_spi *dws,
 
 	txconf.direction = DMA_MEM_TO_DEV;
 	txconf.dst_addr = dws->dma_addr;
+	txconf.src_maxburst = 4 * dws->dma_width;
 	txconf.dst_maxburst = 16;
 	txconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	txconf.dst_addr_width = convert_dma_width(dws->dma_width);
@@ -203,6 +204,7 @@ static struct dma_async_tx_descriptor *dw_spi_dma_prepare_rx(struct dw_spi *dws,
 
 	rxconf.direction = DMA_DEV_TO_MEM;
 	rxconf.src_addr = dws->dma_addr;
+	rxconf.dst_maxburst = 4 * dws->dma_width;
 	rxconf.src_maxburst = 16;
 	rxconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	rxconf.src_addr_width = convert_dma_width(dws->dma_width);
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
