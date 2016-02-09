From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Move chip select control bits into lpss_config structure" to the spi tree
Date: Tue, 09 Feb 2016 19:43:16 +0000
Message-ID: <E1aTEBw-0003LN-Vq@debutante>
References: <1454944471-50119-4-git-send-email-mika.westerberg@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454944471-50119-4-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Move chip select control bits into lpss_config structure

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From c1e4a53c6b8161ded3a44e3352ef38206d0967ea Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 8 Feb 2016 17:14:30 +0200
Subject: [PATCH] spi: pxa2xx: Move chip select control bits into lpss_config
 structure

Some Intel LPSS SPI controllers, like the one in Braswell has these bits in
a different location so move these bits to be part of the LPSS
configuration.

Since not all LPSS SPI controllers support multiple native chip selects we
refactor selecting chip select to its own function and check
control->cs_sel_mask before switching to another chip select.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 64 ++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7d6d3b74d25b..81d68e01046a 100644
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
 
@@ -288,37 +291,50 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
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
+		 * When switching another chip select output active the
+		 * output must be selected first and wait 2 ssp_clk cycles
+		 * before changing state to active. Otherwise a short
+		 * glitch will occur on the previous chip select since
+		 * output select is latched but state control is not.
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
