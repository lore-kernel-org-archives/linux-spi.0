From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: pxa2xx: Add output control for multiple Intel LPSS chip selects
Date: Fri, 30 Oct 2015 11:20:48 +0900
Message-ID: <E1ZrzJA-0001qh-D3@finisterre>
References: <1446038023-8819-2-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446038023-8819-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Add output control for multiple Intel LPSS chip selects

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

>From d0283eb2dbc11ec08375fdf6a436e96d25b3a593 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 28 Oct 2015 15:13:40 +0200
Subject: [PATCH] spi: pxa2xx: Add output control for multiple Intel LPSS chip
 selects

Intel LPSS SPI host controllers in upcoming Intel platforms can have up
to 4 chip selects per port. Extend chip select control in
lpss_ssp_cs_control() by adding a code that selects the active chip
select output prior to changing the state. Detection for number of
enabled chip select signals will be added by another patch.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9060aee..040f6bb 100644
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
