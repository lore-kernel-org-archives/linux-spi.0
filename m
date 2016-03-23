From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/3] spi: pxa2xx: handle error of pxa2xx_spi_dma_prepare()
Date: Wed, 23 Mar 2016 17:29:22 +0200
Message-ID: <1458746964-9335-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

If by some reason pxa2xx_spi_dma_prepare() fails we have not to ignore its
error. In such case we abort the transfer and return the error to upper
level.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Reposting Andy's fix from December that got buried to list during
holidays.
---
 drivers/spi/spi-pxa2xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 85e59a406a4c..47bdbd350a24 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -928,6 +928,7 @@ static void pump_transfers(unsigned long data)
 	u32 dma_thresh = drv_data->cur_chip->dma_threshold;
 	u32 dma_burst = drv_data->cur_chip->dma_burst_size;
 	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
+	int err;
 
 	/* Get current state information */
 	message = drv_data->cur_msg;
@@ -1047,7 +1048,12 @@ static void pump_transfers(unsigned long data)
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
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
