From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/5] spi: dw: get TX level without an additional variable
Date: Tue, 24 Feb 2015 13:32:11 +0200
Message-ID: <1424777534-14246-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424777534-14246-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is no need to have an additional variable to get a TX level. The patch
refactors this piece of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 29157f0..0febb97 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -365,7 +365,7 @@ static void pump_transfers(unsigned long data)
 	u8 bits = 0;
 	u8 imask = 0;
 	u8 cs_change = 0;
-	u16 txint_level = 0;
+	u16 txlevel = 0;
 	u16 clk_div = 0;
 	u32 speed = 0;
 	u32 cr0 = 0;
@@ -461,10 +461,7 @@ static void pump_transfers(unsigned long data)
 	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
 	 */
 	if (!dws->dma_mapped && !chip->poll_mode) {
-		int templen = dws->len / dws->n_bytes;
-
-		txint_level = dws->fifo_len / 2;
-		txint_level = (templen > txint_level) ? txint_level : templen;
+		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
 
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
 			 SPI_INT_RXUI | SPI_INT_RXOI;
@@ -490,8 +487,8 @@ static void pump_transfers(unsigned long data)
 		spi_mask_intr(dws, 0xff);
 		if (imask)
 			spi_umask_intr(dws, imask);
-		if (txint_level)
-			dw_writew(dws, DW_SPI_TXFLTR, txint_level);
+		if (txlevel)
+			dw_writew(dws, DW_SPI_TXFLTR, txlevel);
 
 		spi_enable_chip(dws, 1);
 	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
