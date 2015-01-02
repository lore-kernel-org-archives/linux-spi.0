From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: dw-mid: fix FIFO size
Date: Fri,  2 Jan 2015 16:27:53 +0200
Message-ID: <1420208873-23465-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The FIFO size is 40 accordingly to the specifications, but this means 0x40,
i.e. 64 bytes. This patch fixes the typo and enables FIFO size autodetection
for Intel MID devices.

Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
Cc: linux-stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index 07b50ac..1cb7804 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -276,7 +276,6 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	iounmap(clk_reg);
 
 	dws->num_cs = 16;
-	dws->fifo_len = 40;	/* FIFO has 40 words buffer */
 
 #ifdef CONFIG_SPI_DW_MID_DMA
 	dws->dma_tx = &mid_dma_tx;
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
