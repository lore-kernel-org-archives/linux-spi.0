From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: pxa2xx: handle error of pxa2xx_spi_dma_prepare()
Date: Wed, 23 Dec 2015 21:50:00 +0200
Message-ID: <1450900200-120644-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If by some reason pxa2xx_spi_dma_prepare() fails we have not to ignore its
error. In such case we abort the transfer and return the error to upper level.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 267a3a2..2e6915c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -890,6 +890,7 @@ static void pump_transfers(unsigned long data)
 	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
 	u32 dma_burst = drv_data->cur_chip->dma_burst_size;
 	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
+	int err;
 
 	/* Get current state information */
 	message = drv_data->cur_msg;
@@ -1024,7 +1025,12 @@ static void pump_transfers(unsigned long data)
 		/* Ensure we have the correct interrupt handler */
 		drv_data->transfer_handler = pxa2xx_spi_dma_transfer;
 
-		pxa2xx_spi_dma_prepare(drv_data, dma_burst);
+		err = pxa2xx_spi_dma_prepare(drv_data, dma_burst);
+		if (err) {
+			message->status = err;
+			giveback(drv_data);
+			return;
+		}
 
 		/* Clear status and start DMA engine */
 		cr1 = chip->cr1 | dma_thresh | drv_data->dma_cr1;
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
