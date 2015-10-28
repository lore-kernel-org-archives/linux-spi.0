From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/5] spi: pxa2xx: Use LPSS prefix for defines that are Intel LPSS specific
Date: Wed, 28 Oct 2015 15:13:39 +0200
Message-ID: <1446038023-8819-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Rename a few defines that are specific to Intel LPSS SPI private
registers with LPSS prefix. It makes easier to distinguish them from
common defines.

Suggested-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 672963653d3b..affa05e90411 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -61,9 +61,9 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 				| QUARK_X1000_SSCR1_TFT		\
 				| SSCR1_SPH | SSCR1_SPO | SSCR1_LBM)
 
-#define GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
-#define SPI_CS_CONTROL_SW_MODE			BIT(0)
-#define SPI_CS_CONTROL_CS_HIGH			BIT(1)
+#define LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
+#define LPSS_CS_CONTROL_SW_MODE			BIT(0)
+#define LPSS_CS_CONTROL_CS_HIGH			BIT(1)
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
@@ -250,8 +250,8 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 
 	/* Enable software chip select control */
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-	value &= ~(SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH);
-	value |= SPI_CS_CONTROL_SW_MODE | SPI_CS_CONTROL_CS_HIGH;
+	value &= ~(LPSS_CS_CONTROL_SW_MODE | LPSS_CS_CONTROL_CS_HIGH);
+	value |= LPSS_CS_CONTROL_SW_MODE | LPSS_CS_CONTROL_CS_HIGH;
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 
 	/* Enable multiblock DMA transfers */
@@ -261,7 +261,7 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 		if (config->reg_general >= 0) {
 			value = __lpss_ssp_read_priv(drv_data,
 						     config->reg_general);
-			value |= GENERAL_REG_RXTO_HOLDOFF_DISABLE;
+			value |= LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE;
 			__lpss_ssp_write_priv(drv_data,
 					      config->reg_general, value);
 		}
@@ -277,9 +277,9 @@ static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
 	if (enable)
-		value &= ~SPI_CS_CONTROL_CS_HIGH;
+		value &= ~LPSS_CS_CONTROL_CS_HIGH;
 	else
-		value |= SPI_CS_CONTROL_CS_HIGH;
+		value |= LPSS_CS_CONTROL_CS_HIGH;
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 }
 
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
