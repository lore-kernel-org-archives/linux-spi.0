From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] spi: pxa2xx: missing break in pxa2xx_ssp_get_clk_div()
Date: Tue, 31 Mar 2015 16:49:38 +0300
Message-ID: <1427809778-99984-1-git-send-email-andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

We refactored this code but accidentally left out a break statement so
QUARK_X1000_SSP isn't handled correctly.

Fixes: 025ffe88ee60 ('spi: pxa2xx: shift clk_div in one place')
Tested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 60526a5..e3223ac 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -791,8 +791,10 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
+		break;
 	default:
 		clk_div = ssp_get_clk_div(drv_data, rate);
+		break;
 	}
 	return clk_div << 8;
 }
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
