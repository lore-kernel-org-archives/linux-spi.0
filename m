From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 3/3] spi: pxa2xx: Make LPSS SPI general register optional
Date: Thu,  4 Jun 2015 16:55:12 +0300
Message-ID: <1433426112-19021-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1433426112-19021-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433426112-19021-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

General register located in LPSS SPI private register space is not found in
upcoming Intel LPSS platforms. Access it conditionally depending is it
defined in configuration.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3fec31dbf972..f97cd42fbc22 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -245,9 +245,13 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	if (drv_data->master_info->enable_dma) {
 		__lpss_ssp_write_priv(drv_data, config->reg_ssp, 1);
 
-		value = __lpss_ssp_read_priv(drv_data, config->reg_general);
-		value |= GENERAL_REG_RXTO_HOLDOFF_DISABLE;
-		__lpss_ssp_write_priv(drv_data, config->reg_general, value);
+		if (config->reg_general >= 0) {
+			value = __lpss_ssp_read_priv(drv_data,
+						     config->reg_general);
+			value |= GENERAL_REG_RXTO_HOLDOFF_DISABLE;
+			__lpss_ssp_write_priv(drv_data,
+					      config->reg_general, value);
+		}
 	}
 }
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
