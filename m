From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 4/5] spi: dw: always reprogram CTRL0
Date: Tue, 24 Feb 2015 13:32:13 +0200
Message-ID: <1424777534-14246-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1424777534-14246-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of an additional reading from the register let's update it even if the
value is kept the same.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0e0c48b..281121f 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -476,8 +476,7 @@ static void pump_transfers(unsigned long data)
 	if (dw_readw(dws, DW_SPI_CTRL0) != cr0 || cs_change || clk_div || imask) {
 		spi_enable_chip(dws, 0);
 
-		if (dw_readw(dws, DW_SPI_CTRL0) != cr0)
-			dw_writew(dws, DW_SPI_CTRL0, cr0);
+		dw_writew(dws, DW_SPI_CTRL0, cr0);
 
 		spi_set_clk(dws, chip->clk_div);
 		spi_chip_sel(dws, spi, 1);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
