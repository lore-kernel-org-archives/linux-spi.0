From: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Wed,  8 Apr 2015 16:36:01 -0500
Message-ID: <1428528961-7838-1-git-send-email-mwelling@ieee.org>
Cc: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch allows for GPIOs specified in the devicetree to be used as SPI chipselects
on TI OMAP2 SoCs.

Tested on the AM3354.

Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 4df8942..464dec9 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -35,6 +35,7 @@
 #include <linux/gcd.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 
@@ -246,6 +247,9 @@ static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 {
 	u32 l;
 
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_set_value(spi->cs_gpio, (cs_active) ? 0 : 1);
+
 	l = mcspi_cached_chconf0(spi);
 	if (cs_active)
 		l |= OMAP2_MCSPI_CHCONF_FORCE;
@@ -1015,6 +1019,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	if (gpio_is_valid(spi->cs_gpio)) {
+		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
+			gpio_direction_output(spi->cs_gpio,
+					!(spi->mode & SPI_CS_HIGH));
+	}
+
 	ret = omap2_mcspi_setup_transfer(spi, NULL);
 	pm_runtime_mark_last_busy(mcspi->dev);
 	pm_runtime_put_autosuspend(mcspi->dev);
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
