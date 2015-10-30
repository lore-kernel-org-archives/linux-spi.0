From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: pxa2xx: Use LPSS prefix for defines that are Intel LPSS specific
Date: Fri, 30 Oct 2015 11:20:50 +0900
Message-ID: <E1ZrzJC-0001rE-Lx@finisterre>
References: <1446038023-8819-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446038023-8819-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Use LPSS prefix for defines that are Intel LPSS specific

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

>From 624ea72ebddc1f61d32c9e6265f8d6f6dacd26d6 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 28 Oct 2015 15:13:39 +0200
Subject: [PATCH] spi: pxa2xx: Use LPSS prefix for defines that are Intel LPSS
 specific

Rename a few defines that are specific to Intel LPSS SPI private
registers with LPSS prefix. It makes easier to distinguish them from
common defines.

Suggested-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0f6a6c8..9060aee 100644
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
