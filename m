From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 3/5] spi: dw: refactor code that handles clk_div
Date: Tue, 24 Feb 2015 13:32:12 +0200
Message-ID: <1424777534-14246-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424777534-14246-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch does the following changes:

a) the calculation of clk_div is simplified to oneliner;

b) chip->clk_div is updated if clk_div is not zero, therefore the condition is
   simplified by using chip->clk_div in both cases;

c) while here, the redundant parentheses are removed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0febb97..0e0c48b 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -416,12 +416,11 @@ static void pump_transfers(unsigned long data)
 	if (transfer->speed_hz) {
 		speed = chip->speed_hz;
 
-		if ((transfer->speed_hz != speed) || (!chip->clk_div)) {
+		if ((transfer->speed_hz != speed) || !chip->clk_div) {
 			speed = transfer->speed_hz;
 
 			/* clk_div doesn't support odd number */
-			clk_div = dws->max_freq / speed;
-			clk_div = (clk_div + 1) & 0xfffe;
+			clk_div = (dws->max_freq / speed + 1) & 0xfffe;
 
 			chip->speed_hz = speed;
 			chip->clk_div = clk_div;
@@ -480,7 +479,7 @@ static void pump_transfers(unsigned long data)
 		if (dw_readw(dws, DW_SPI_CTRL0) != cr0)
 			dw_writew(dws, DW_SPI_CTRL0, cr0);
 
-		spi_set_clk(dws, clk_div ? clk_div : chip->clk_div);
+		spi_set_clk(dws, chip->clk_div);
 		spi_chip_sel(dws, spi, 1);
 
 		/* Set the interrupt mask, for poll mode just disable all int */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
