From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC don't push] spi: pxa2xx: Add support for Intel Sunrisepoint
Date: Thu,  2 Jul 2015 11:07:56 +0300
Message-ID: <1435824476-13369-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Major difference in LPSS SPI between Intel Sunrisepoint PCH and earlier
platforms is an integrated DMA (iDMA) engine. iDMA is an IP that is private
for each LPSS host controller (UART/SPI/I2C). Other differences are private
register space offset, a few private registers that are in different
location and FIFO thresholds.

Intel Sunrisepoint LPSS SPI and iDMA devices are probed and registered in
MFD layer as platform devices. Here these compound devices are detected by
matching against known PCI IDs. This allows us to share
pxa2xx_spi_acpi_get_pdata() for setting up the platform data instead of
duplicating it in MFD part.

This patch adds configuration for Intel Sunrisepoint LPSS SPI, above
detection and DMA filter function that picks the DMA channel only from an
associated iDMA block.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
I wanted to send this an RFC because I'll be out of office a few weeks and
the MFD patchset and idma64 driver this patch depends logically is not
applied yet. The latest version of MFD patchset is here:
https://lkml.org/lkml/2015/6/15/160
This patch doesn't have build or runtime dependency to the patchset but
should not be applied before we know above pieces are heading into
upstream.
Core idea here is to match against known PCI IDs for getting the LPSS type
and share the pxa2xx_spi_acpi_get_pdata() for setting up data for
"pxa2xx-spi".
It looked quite code duplication to construct platform data (which is
struct pxa2xx_spi_master including struct ssp_device) in MFD part where
actual need is just one integer.
---
 drivers/spi/spi-pxa2xx.c   | 59 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7293d6d875c5..2c9fa409d2bf 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
@@ -97,6 +98,15 @@ static const struct lpss_config lpss_platforms[] = {
 		.tx_threshold_lo = 160,
 		.tx_threshold_hi = 224,
 	},
+	{	/* LPSS_SPT_SSP */
+		.offset = 0x200,
+		.reg_general = -1,
+		.reg_ssp = 0x20,
+		.reg_cs_ctrl = 0x24,
+		.rx_threshold = 1,
+		.tx_threshold_lo = 32,
+		.tx_threshold_hi = 56,
+	},
 };
 
 static inline const struct lpss_config
@@ -110,6 +120,7 @@ static bool is_lpss_ssp(const struct driver_data *drv_data)
 	switch (drv_data->ssp_type) {
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
+	case LPSS_SPT_SSP:
 		return true;
 	default:
 		return false;
@@ -1107,6 +1118,7 @@ static int setup(struct spi_device *spi)
 		break;
 	case LPSS_LPT_SSP:
 	case LPSS_BYT_SSP:
+	case LPSS_SPT_SSP:
 		config = lpss_get_config(drv_data);
 		tx_thres = config->tx_threshold_lo;
 		tx_hi_thres = config->tx_threshold_hi;
@@ -1276,6 +1288,30 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
 
+/*
+ * PCI IDs of compound devices that integrate both host controller and private
+ * integrated DMA engine. Please note these are not used in module
+ * autoloading and probing in this module but matching the LPSS SSP type.
+ */
+static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
+	/* SPT-LP */
+	{ PCI_VDEVICE(INTEL, 0x9d29), LPSS_SPT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x9d2a), LPSS_SPT_SSP },
+	/* SPT-H */
+	{ PCI_VDEVICE(INTEL, 0xa129), LPSS_SPT_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa12a), LPSS_SPT_SSP },
+};
+
+static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
+{
+	struct device *dev = param;
+
+	if (dev != chan->device->dev->parent)
+		return false;
+
+	return true;
+}
+
 static struct pxa2xx_spi_master *
 pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 {
@@ -1283,16 +1319,25 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	struct acpi_device *adev;
 	struct ssp_device *ssp;
 	struct resource *res;
-	const struct acpi_device_id *id;
+	const struct acpi_device_id *adev_id = NULL;
+	const struct pci_device_id *pcidev_id = NULL;
 	int devid, type;
 
 	if (!ACPI_HANDLE(&pdev->dev) ||
 	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
 		return NULL;
 
-	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
-	if (id)
-		type = (int)id->driver_data;
+	if (dev_is_pci(pdev->dev.parent))
+		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
+					 to_pci_dev(pdev->dev.parent));
+	else
+		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
+					    &pdev->dev);
+
+	if (adev_id)
+		type = (int)adev_id->driver_data;
+	else if (pcidev_id)
+		type = (int)pcidev_id->driver_data;
 	else
 		return NULL;
 
@@ -1311,6 +1356,12 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	if (IS_ERR(ssp->mmio_base))
 		return NULL;
 
+	if (pcidev_id) {
+		pdata->tx_param = pdev->dev.parent;
+		pdata->rx_param = pdev->dev.parent;
+		pdata->dma_filter = pxa2xx_spi_idma_filter;
+	}
+
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index 0485bab061fd..92273776bce6 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -197,6 +197,7 @@ enum pxa_ssp_type {
 	QUARK_X1000_SSP,
 	LPSS_LPT_SSP, /* Keep LPSS types sorted with lpss_platforms[] */
 	LPSS_BYT_SSP,
+	LPSS_SPT_SSP,
 };
 
 struct ssp_device {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
