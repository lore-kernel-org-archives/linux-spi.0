From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/2] spi: dw-mid: fix number of CS lines
Date: Fri,  2 Jan 2015 17:48:52 +0200
Message-ID: <1420213732-5141-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420213732-5141-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420213732-5141-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

According to specification the SPI1 has 5 bits for chip selects. The current
code limits it to 4 bits. The patch fixes that constant.

Fixes: 7063c0d942a1 (spi/dw_spi: add DMA support)
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-mid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index a67d37c..bd72ec6 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -270,7 +270,7 @@ int dw_spi_mid_init(struct dw_spi *dws)
 	dws->max_freq = MRST_SPI_CLK_BASE / (clk_cdiv + 1);
 	iounmap(clk_reg);
 
-	dws->num_cs = 16;
+	dws->num_cs = 32;
 
 #ifdef CONFIG_SPI_DW_MID_DMA
 	dws->dma_priv = kzalloc(sizeof(struct mid_dma), GFP_KERNEL);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
