From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 4/4] spi: pxa2xx: Add support for both chip selects on Intel Braswell
Date: Tue, 26 Jan 2016 13:18:31 +0200
Message-ID: <1453807111-103111-5-git-send-email-mika.westerberg@linux.intel.com>
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

Intel Braswell LPSS SPI controller actually has two chip selects and there
is no capabilities register where this could be found out. These two chip
selects are controlled by bits which are in slightly differrent location
than Broxton has.

Braswell Windows driver also starts chip select (ACPI DeviceSelection)
numbering from 1 so translate it to be suitable for Linux as well.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c   | 21 ++++++++++++++++++++-
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index d6a7855cf148..e05d0dc2eb11 100644
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
@@ -1183,6 +1198,7 @@ static int setup(struct spi_device *spi)
 		break;
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
 	case LPSS_SPT_SSP:
 	case LPSS_BXT_SSP:
 		config = lpss_get_config(drv_data);
@@ -1330,7 +1346,7 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "INT3430", LPSS_LPT_SSP },
 	{ "INT3431", LPSS_LPT_SSP },
 	{ "80860F0E", LPSS_BYT_SSP },
-	{ "8086228E", LPSS_BYT_SSP },
+	{ "8086228E", LPSS_BSW_SSP },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
@@ -1357,6 +1373,7 @@ static int pxa2xx_spi_fw_translate_cs(struct spi_master *master, unsigned cs)
 	 * expects.
 	 */
 	case LPSS_BYT_SSP:
+	case LPSS_BSW_SSP:
 		return cs - 1;
 
 	default:
@@ -1613,6 +1630,8 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
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
