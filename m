From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/2] spi: pxa2xx: shift clk_div in one place
Date: Tue, 24 Mar 2015 17:43:21 +0200
Message-ID: <1427211802-217454-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1427211802-217454-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427211802-217454-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch refactors ssp_get_clk_div() and pxa2xx_ssp_get_clk_div() to align
clk_div calculations, i.e. ssp_get_clk_div() and quark_x1000_set_clk_regvals()
will return plain clk_div and it will be shifted to proper position in
pxa2xx_ssp_get_clk_div().

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6f72ad0..dd56bf5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -730,23 +730,23 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 	rate = min_t(int, ssp_clk, rate);
 
 	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
-		return ((ssp_clk / (2 * rate) - 1) & 0xff) << 8;
+		return (ssp_clk / (2 * rate) - 1) & 0xff;
 	else
-		return ((ssp_clk / rate - 1) & 0xfff) << 8;
+		return (ssp_clk / rate - 1) & 0xfff;
 }
 
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 					   struct chip_data *chip, int rate)
 {
-	u32 clk_div;
+	unsigned int clk_div;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		quark_x1000_set_clk_regvals(rate, &chip->dds_rate, &clk_div);
-		return clk_div << 8;
 	default:
-		return ssp_get_clk_div(drv_data, rate);
+		clk_div = ssp_get_clk_div(drv_data, rate);
 	}
+	return clk_div << 8;
 }
 
 static void pump_transfers(unsigned long data)
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
