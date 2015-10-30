From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/7] spi: pxa2xx: Add support for Intel Broxton
Date: Fri, 30 Oct 2015 11:20:43 +0900
Message-ID: <E1ZrzJ5-0001pT-Bo@finisterre>
References: <1445521485-2029-7-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-7-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Add support for Intel Broxton

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

>From b7c08cf85c9a3a4b05474b7acacc9fbce8fb3eaf Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 28 Oct 2015 15:13:42 +0200
Subject: [PATCH] spi: pxa2xx: Add support for Intel Broxton

LPSS SPI in Intel Broxton is otherwise the same than in Intel Sunrisepoint
but it supports up to four chip selects per port and has different FIFO
thresholds. Patch adds support for two Broxton SoC variants.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c   | 20 ++++++++++++++++++++
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a5c2dce..f759c08 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -116,6 +116,16 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_lo = 32,
 		.tx_threshold_hi = 56,
 	},
+	{	/* LPSS_BXT_SSP */
+		.offset = 0x200,
+		.reg_general = -1,
+		.reg_ssp = 0x20,
+		.reg_cs_ctrl = 0x24,
+		.reg_capabilities = 0xfc,
+		.rx_threshold = 1,
+		.tx_threshold_lo = 16,
+		.tx_threshold_hi = 48,
+	},
 };
 
 static inline const struct lpss_config
@@ -130,6 +140,7 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
 	case LPSS_SPT_SSP:
+	case LPSS_BXT_SSP:
 		return true;
 	default:
 		return false;
@@ -1152,6 +1163,7 @@ static int setup(struct spi_device *spi)
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
 	case LPSS_SPT_SSP:
+	case LPSS_BXT_SSP:
 		config = lpss_get_config(drv_data);
 		tx_thres = config->tx_threshold_lo;
 		tx_hi_thres = config->tx_threshold_hi;
@@ -1313,6 +1325,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa129), LPSS_SPT_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa12a), LPSS_SPT_SSP },
+	/* BXT */
+	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x0ac6), LPSS_BXT_SSP },
+	/* APL */
+	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x5ac6), LPSS_BXT_SSP },
 	{ },
 };
 
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 92273776..c2f2574 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -198,6 +198,7 @@ enum pxa_ssp_type {
 	LPSS_LPT_SSP, /* Keep LPSS types sorted with lpss_platforms[] */
 	LPSS_BYT_SSP,
 	LPSS_SPT_SSP,
+	LPSS_BXT_SSP,
 };
 
 struct ssp_device {
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
