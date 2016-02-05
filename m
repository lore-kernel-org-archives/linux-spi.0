From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: dw-mid: switch to new dmaengine_terminate_* API
Date: Fri,  5 Feb 2016 16:46:26 +0200
Message-ID: <1454683586-74628-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert dmaengine_terminate_all() calls to synchronous versions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 9185f6c..e31971f9 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -89,10 +89,10 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 	if (!dws->dma_inited)
 		return;
 
-	dmaengine_terminate_all(dws->txchan);
+	dmaengine_terminate_sync(dws->txchan);
 	dma_release_channel(dws->txchan);
 
-	dmaengine_terminate_all(dws->rxchan);
+	dmaengine_terminate_sync(dws->rxchan);
 	dma_release_channel(dws->rxchan);
 }
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
