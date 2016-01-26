From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/4] spi: pxa2xx: Move chip select control bits into lpss_config structure
Date: Tue, 26 Jan 2016 13:18:30 +0200
Message-ID: <1453807111-103111-4-git-send-email-mika.westerberg@linux.intel.com>
References: <1453807111-103111-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Bastien Nocera <bugzilla-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1453807111-103111-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some Intel LPSS SPI controllers, like the one in Braswell has these bits in
a different location so move these bits to be part of the LPSS
configuration.

Since not all LPSS SPI controllers support multiple native chip selects we
refactor selecting chip select to its own function and check
control->cs_sel_mask before switching to another chip select.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 65 ++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index baa98365a490..d6a7855cf148 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -65,8 +65,6 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
 #define LPSS_CS_CONTROL_SW_MODE			BIT(0)
 #define LPSS_CS_CONTROL_CS_HIGH			BIT(1)
-#define LPSS_CS_CONTROL_CS_SEL_SHIFT		8
-#define LPSS_CS_CONTROL_CS_SEL_MASK		(3 << LPSS_CS_CONTROL_CS_SEL_SHIFT)
 #define LPSS_CAPS_CS_EN_SHIFT			9
 #define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
@@ -82,6 +80,9 @@ struct lpss_config {
 	u32 rx_threshold;
 	u32 tx_threshold_lo;
 	u32 tx_threshold_hi;
+	/* Chip select control */
+	unsigned cs_sel_shift;
+	unsigned cs_sel_mask;
 };
 
 /* Keep these sorted with enum pxa_ssp_type */
@@ -125,6 +126,8 @@ static const struct lpss_config lpss_platforms[] = {
 		.rx_threshold = 1,
 		.tx_threshold_lo = 16,
 		.tx_threshold_hi = 48,
+		.cs_sel_shift = 8,
+		.cs_sel_mask = 3 << 8,
 	},
 };
 
@@ -288,37 +291,51 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	}
 }
 
+static void lpss_ssp_select_cs(struct driver_data *drv_data,
+			       const struct lpss_config *config)
+{
+	u32 value, cs;
+
+	if (!config->cs_sel_mask)
+		return;
+
+	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
+
+	cs = drv_data->cur_msg->spi->chip_select;
+	cs <<= config->cs_sel_shift;
+	if (cs != (value & config->cs_sel_mask)) {
+		/*
+		 * When switching another chip select output active
+		 * the output must be selected first and wait 2 ssp_clk
+		 * cycles before changing state to active. Otherwise
+		 * a short glitch will occur on the previous chip
+		 * select since output select is latched but state
+		 * control is not.
+		 */
+		value &= ~config->cs_sel_mask;
+		value |= cs;
+		__lpss_ssp_write_priv(drv_data,
+				      config->reg_cs_ctrl, value);
+		ndelay(1000000000 /
+		       (drv_data->master->max_speed_hz / 2));
+	}
+}
+
 static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 {
 	const struct lpss_config *config;
-	u32 value, cs;
+	u32 value;
 
 	config = lpss_get_config(drv_data);
 
+	if (enable)
+		lpss_ssp_select_cs(drv_data, config);
+
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-	if (enable) {
-		cs = drv_data->cur_msg->spi->chip_select;
-		cs <<= LPSS_CS_CONTROL_CS_SEL_SHIFT;
-		if (cs != (value & LPSS_CS_CONTROL_CS_SEL_MASK)) {
-			/*
-			 * When switching another chip select output active
-			 * the output must be selected first and wait 2 ssp_clk
-			 * cycles before changing state to active. Otherwise
-			 * a short glitch will occur on the previous chip
-			 * select since output select is latched but state
-			 * control is not.
-			 */
-			value &= ~LPSS_CS_CONTROL_CS_SEL_MASK;
-			value |= cs;
-			__lpss_ssp_write_priv(drv_data,
-					      config->reg_cs_ctrl, value);
-			ndelay(1000000000 /
-			       (drv_data->master->max_speed_hz / 2));
-		}
+	if (enable)
 		value &= ~LPSS_CS_CONTROL_CS_HIGH;
-	} else {
+	else
 		value |= LPSS_CS_CONTROL_CS_HIGH;
-	}
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 }
 
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
