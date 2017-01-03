From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: dw-mid: switch to new dmaengine_terminate_* API (part 2)
Date: Tue,  3 Jan 2017 15:48:20 +0200
Message-ID: <20170103134820.159600-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit a3ff9582369e ("spi: dw-mid: switch to new dmaengine_terminate_*
API") converted mid_spi_dma_exit() but missed mid_spi_dma_stop().

This is follow up to convert the rest.

Fixes: a3ff9582369e ("spi: dw-mid: switch to new dmaengine_terminate_* API")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index e31971f91475..837cb8d0bac6 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -274,11 +274,11 @@ static int mid_spi_dma_transfer(struct dw_spi *dws, struct spi_transfer *xfer)
 static void mid_spi_dma_stop(struct dw_spi *dws)
 {
 	if (test_bit(TX_BUSY, &dws->dma_chan_busy)) {
-		dmaengine_terminate_all(dws->txchan);
+		dmaengine_terminate_sync(dws->txchan);
 		clear_bit(TX_BUSY, &dws->dma_chan_busy);
 	}
 	if (test_bit(RX_BUSY, &dws->dma_chan_busy)) {
-		dmaengine_terminate_all(dws->rxchan);
+		dmaengine_terminate_sync(dws->rxchan);
 		clear_bit(RX_BUSY, &dws->dma_chan_busy);
 	}
 }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
