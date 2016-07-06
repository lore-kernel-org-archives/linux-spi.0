From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: pxa2xx: Clear all RFT bits in reset_sccr1() on Intel Quark
Date: Wed,  6 Jul 2016 12:08:11 +0300
Message-ID: <1467796091-142927-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It seems the commit e5262d0568dc ("spi: spi-pxa2xx: SPI support for Intel Quark
X1000") misses one place to be adapted for Intel Quark, i.e. in reset_sccr1().

Clear all RFT bits when call reset_sccr1() on Intel Quark.

Fixes: e5262d0568dc ("spi: spi-pxa2xx: SPI support for Intel Quark X1000")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 583bd53..7bb7db0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -585,7 +585,14 @@ static void reset_sccr1(struct driver_data *drv_data)
 	u32 sccr1_reg;
 
 	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
-	sccr1_reg &= ~SSCR1_RFT;
+	switch (drv_data->ssp_type) {
+	case QUARK_X1000_SSP:
+		sccr1_reg &= ~QUARK_X1000_SSCR1_RFT;
+		break;
+	default:
+		sccr1_reg &= ~SSCR1_RFT;
+		break;
+	}
 	sccr1_reg |= chip->threshold;
 	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
