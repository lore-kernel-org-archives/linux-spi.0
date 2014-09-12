From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 3/6] spi: dw-mid: check that DMA was inited before exit
Date: Fri, 12 Sep 2014 15:11:58 +0300
Message-ID: <1410523921-16732-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1410523921-16732-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1410523921-16732-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If the driver was compiled with DMA support, but DMA channels weren't acquired
by some reason, mid_spi_dma_exit() will crash the kernel.

Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 6d207af..0d88e4a 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -89,6 +89,8 @@ err_exit:
 
 static void mid_spi_dma_exit(struct dw_spi *dws)
 {
+	if (!dws->dma_inited)
+		return;
 	dma_release_channel(dws->txchan);
 	dma_release_channel(dws->rxchan);
 }
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
