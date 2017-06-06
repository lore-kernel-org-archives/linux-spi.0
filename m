From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Add support for Intel Cannonlake" to the spi tree
Date: Tue, 06 Jun 2017 20:07:11 +0100
Message-ID: <E1dIJot-0007Xh-TH@debutante>
References: <20170530143121.11313-1-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170530143121.11313-1-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Add support for Intel Cannonlake

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

>From fc0b2acc754a183aa79e2abb8bca8fd915832694 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 30 May 2017 17:31:21 +0300
Subject: [PATCH] spi: pxa2xx: Add support for Intel Cannonlake

Intel Cannonlake LPSS SPI has up to four chip selects per port like in
Broxton and is clocked like Sunrisepoint and Kaby Lake. Add a new type
LPSS_CNL_SSP and configuration that enable runtime chip select detection
and use the same FIFO thresholds than in Sunrisepoint.

Patch adds support for both Cannonlake SoC and PCH.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c   | 22 ++++++++++++++++++++++
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 47b65d7c4072..38d053682892 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -151,6 +151,18 @@ static const struct lpss_config lpss_platforms[] = {
 		.cs_sel_shift = 8,
 		.cs_sel_mask = 3 << 8,
 	},
+	{	/* LPSS_CNL_SSP */
+		.offset = 0x200,
+		.reg_general = -1,
+		.reg_ssp = 0x20,
+		.reg_cs_ctrl = 0x24,
+		.reg_capabilities = 0xfc,
+		.rx_threshold = 1,
+		.tx_threshold_lo = 32,
+		.tx_threshold_hi = 56,
+		.cs_sel_shift = 8,
+		.cs_sel_mask = 3 << 8,
+	},
 };
 
 static inline const struct lpss_config
@@ -167,6 +179,7 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	case LPSS_BSW_SSP:
 	case LPSS_SPT_SSP:
 	case LPSS_BXT_SSP:
+	case LPSS_CNL_SSP:
 		return true;
 	default:
 		return false;
@@ -1275,6 +1288,7 @@ static int setup(struct spi_device *spi)
 	case LPSS_BSW_SSP:
 	case LPSS_SPT_SSP:
 	case LPSS_BXT_SSP:
+	case LPSS_CNL_SSP:
 		config = lpss_get_config(drv_data);
 		tx_thres = config->tx_threshold_lo;
 		tx_hi_thres = config->tx_threshold_hi;
@@ -1470,6 +1484,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), LPSS_BXT_SSP },
+	/* CNL-LP */
+	{ PCI_VDEVICE(INTEL, 0x9daa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x9dab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x9dfb), LPSS_CNL_SSP },
+	/* CNL-H */
+	{ PCI_VDEVICE(INTEL, 0xa32a), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa32b), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa37b), LPSS_CNL_SSP },
 	{ },
 };
 
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index a0522328d7aa..8461b18e4608 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -196,6 +196,7 @@ enum pxa_ssp_type {
 	LPSS_BSW_SSP,
 	LPSS_SPT_SSP,
 	LPSS_BXT_SSP,
+	LPSS_CNL_SSP,
 };
 
 struct ssp_device {
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
