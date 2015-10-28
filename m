From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/5] spi: pxa2xx: Add output control for multiple Intel LPSS chip selects
Date: Wed, 28 Oct 2015 15:13:40 +0200
Message-ID: <1446038023-8819-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1446038023-8819-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446038023-8819-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Intel LPSS SPI host controllers in upcoming Intel platforms can have up
to 4 chip selects per port. Extend chip select control in
lpss_ssp_cs_control() by adding a code that selects the active chip
select output prior to changing the state. Detection for number of
enabled chip select signals will be added by another patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index affa05e90411..019f4dda2cf2 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -64,6 +64,8 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define LPSS_GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
 #define LPSS_CS_CONTROL_SW_MODE			BIT(0)
 #define LPSS_CS_CONTROL_CS_HIGH			BIT(1)
+#define LPSS_CS_CONTROL_CS_SEL_SHIFT		8
+#define LPSS_CS_CONTROL_CS_SEL_MASK		(3 << LPSS_CS_CONTROL_CS_SEL_SHIFT)
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
@@ -271,15 +273,34 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 {
 	const struct lpss_config *config;
-	u32 value;
+	u32 value, cs;
 
 	config = lpss_get_config(drv_data);
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-	if (enable)
+	if (enable) {
+		cs = drv_data->cur_msg->spi->chip_select;
+		cs <<= LPSS_CS_CONTROL_CS_SEL_SHIFT;
+		if (cs != (value & LPSS_CS_CONTROL_CS_SEL_MASK)) {
+			/*
+			 * When switching another chip select output active
+			 * the output must be selected first and wait 2 ssp_clk
+			 * cycles before changing state to active. Otherwise
+			 * a short glitch will occur on the previous chip
+			 * select since output select is latched but state
+			 * control is not.
+			 */
+			value &= ~LPSS_CS_CONTROL_CS_SEL_MASK;
+			value |= cs;
+			__lpss_ssp_write_priv(drv_data,
+					      config->reg_cs_ctrl, value);
+			ndelay(1000000000 /
+			       (drv_data->master->max_speed_hz / 2));
+		}
 		value &= ~LPSS_CS_CONTROL_CS_HIGH;
-	else
+	} else {
 		value |= LPSS_CS_CONTROL_CS_HIGH;
+	}
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 }
 
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
