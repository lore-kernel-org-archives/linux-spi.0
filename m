From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Add support for both chip selects on Intel Braswell" to the spi tree
Date: Tue, 09 Feb 2016 19:43:16 +0000
Message-ID: <E1aTEBw-0003Ku-2d@debutante>
References: <1454944471-50119-5-git-send-email-mika.westerberg@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454944471-50119-5-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Add support for both chip selects on Intel Braswell

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

>From 30f3a6ab44d8d06bb3d94f6320e4aa76df59d025 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 8 Feb 2016 17:14:31 +0200
Subject: [PATCH] spi: pxa2xx: Add support for both chip selects on Intel
 Braswell

Intel Braswell LPSS SPI controller actually has two chip selects and there
is no capabilities register where this could be found out. These two chip
selects are controlled by bits which are in slightly differrent location
than Broxton has.

Braswell Windows driver also starts chip select (ACPI DeviceSelection)
numbering from 1 so translate it to be suitable for Linux as well.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c   | 21 ++++++++++++++++++++-
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 81d68e01046a..0eb79368eabc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -83,6 +83,7 @@ struct lpss_config {
 	/* Chip select control */
 	unsigned cs_sel_shift;
 	unsigned cs_sel_mask;
+	unsigned cs_num;
 };
 
 /* Keep these sorted with enum pxa_ssp_type */
@@ -107,6 +108,19 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_lo = 160,
 		.tx_threshold_hi = 224,
 	},
+	{	/* LPSS_BSW_SSP */
+		.offset = 0x400,
+		.reg_general = 0x08,
+		.reg_ssp = 0x0c,
+		.reg_cs_ctrl = 0x18,
+		.reg_capabilities = -1,
+		.rx_threshold = 64,
+		.tx_threshold_lo = 160,
+		.tx_threshold_hi = 224,
+		.cs_sel_shift = 2,
+		.cs_sel_mask = 1 << 2,
+		.cs_num = 2,
+	},
 	{	/* LPSS_SPT_SSP */
 		.offset = 0x200,
 		.reg_general = -1,
@@ -142,6 +156,7 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	switch (drv_data->ssp_type) {
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
 	case LPSS_SPT_SSP:
 	case LPSS_BXT_SSP:
 		return true;
@@ -1189,6 +1204,7 @@ static int setup(struct spi_device *spi)
 		break;
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
 	case LPSS_SPT_SSP:
 	case LPSS_BXT_SSP:
 		config = lpss_get_config(drv_data);
@@ -1336,7 +1352,7 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "INT3430", LPSS_LPT_SSP },
 	{ "INT3431", LPSS_LPT_SSP },
 	{ "80860F0E", LPSS_BYT_SSP },
-	{ "8086228E", LPSS_BYT_SSP },
+	{ "8086228E", LPSS_BSW_SSP },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
@@ -1473,6 +1489,7 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_master *master, unsigned cs)
 		 * to match what Linux expects.
 		 */
 		case LPSS_BYT_SSP:
+		case LPSS_BSW_SSP:
 			return cs - 1;
 
 		default:
@@ -1622,6 +1639,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 			tmp &= LPSS_CAPS_CS_EN_MASK;
 			tmp >>= LPSS_CAPS_CS_EN_SHIFT;
 			platform_info->num_chipselect = ffz(tmp);
+		} else if (config->cs_num) {
+			platform_info->num_chipselect = config->cs_num;
 		}
 	}
 	master->num_chipselect = platform_info->num_chipselect;
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index c2f2574ff61c..2a097d176ba9 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -197,6 +197,7 @@ enum pxa_ssp_type {
 	QUARK_X1000_SSP,
 	LPSS_LPT_SSP, /* Keep LPSS types sorted with lpss_platforms[] */
 	LPSS_BYT_SSP,
+	LPSS_BSW_SSP,
 	LPSS_SPT_SSP,
 	LPSS_BXT_SSP,
 };
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
