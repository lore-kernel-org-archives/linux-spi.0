From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv2 1/3] spi: pxa2xx: Differentiate Intel LPSS types
Date: Thu,  4 Jun 2015 16:55:10 +0300
Message-ID: <1433426112-19021-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Intel LPSS SPI properties differ between between platforms. Now private
registers offset 0x400 or 0x800 is autodetected but there is need to
support also other offset and handle a few other differences.

Prepare for that by splitting the LPSS_SSP type into compatible hardware
types and set it now based on PCI or ACPI ID. That type will be used to set
properties that differ between current and upcoming platforms.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c |  8 ++++----
 drivers/spi/spi-pxa2xx.c     | 44 ++++++++++++++++++++++++++++++--------------
 include/linux/pxa2xx_ssp.h   |  3 ++-
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index fa7399e84bbb..3cfd4357489a 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -62,7 +62,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.max_clk_rate = 3686400,
 	},
 	[PORT_BYT] = {
-		.type = LPSS_SSP,
+		.type = LPSS_BYT_SSP,
 		.port_id = 0,
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
@@ -70,7 +70,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.rx_param = &byt_rx_param,
 	},
 	[PORT_BSW0] = {
-		.type = LPSS_SSP,
+		.type = LPSS_BYT_SSP,
 		.port_id = 0,
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
@@ -78,7 +78,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.rx_param = &bsw0_rx_param,
 	},
 	[PORT_BSW1] = {
-		.type = LPSS_SSP,
+		.type = LPSS_BYT_SSP,
 		.port_id = 1,
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
@@ -86,7 +86,7 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.rx_param = &bsw1_rx_param,
 	},
 	[PORT_BSW2] = {
-		.type = LPSS_SSP,
+		.type = LPSS_BYT_SSP,
 		.port_id = 2,
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e3223ac75a7c..a85b7496a3cd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -74,7 +74,13 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 static bool is_lpss_ssp(const struct driver_data *drv_data)
 {
-	return drv_data->ssp_type == LPSS_SSP;
+	switch (drv_data->ssp_type) {
+	case LPSS_LPT_SSP:
+	case LPSS_BYT_SSP:
+		return true;
+	default:
+		return false;
+	}
 }
 
 static bool is_quark_x1000_ssp(const struct driver_data *drv_data)
@@ -1085,7 +1091,8 @@ static int setup(struct spi_device *spi)
 		tx_hi_thres = 0;
 		rx_thres = RX_THRESH_QUARK_X1000_DFLT;
 		break;
-	case LPSS_SSP:
+	case LPSS_LPT_SSP:
+	case LPSS_BYT_SSP:
 		tx_thres = LPSS_TX_LOTHRESH_DFLT;
 		tx_hi_thres = LPSS_TX_HITHRESH_DFLT;
 		rx_thres = LPSS_RX_THRESH_DFLT;
@@ -1242,6 +1249,18 @@ static void cleanup(struct spi_device *spi)
 }
 
 #ifdef CONFIG_ACPI
+
+static struct acpi_device_id pxa2xx_spi_acpi_match[] = {
+	{ "INT33C0", LPSS_LPT_SSP },
+	{ "INT33C1", LPSS_LPT_SSP },
+	{ "INT3430", LPSS_LPT_SSP },
+	{ "INT3431", LPSS_LPT_SSP },
+	{ "80860F0E", LPSS_BYT_SSP },
+	{ "8086228E", LPSS_BYT_SSP },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
+
 static struct pxa2xx_spi_master *
 pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 {
@@ -1249,12 +1268,19 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	struct acpi_device *adev;
 	struct ssp_device *ssp;
 	struct resource *res;
-	int devid;
+	const struct acpi_device_id *id;
+	int devid, type;
 
 	if (!ACPI_HANDLE(&pdev->dev) ||
 	    acpi_bus_get_device(ACPI_HANDLE(&pdev->dev), &adev))
 		return NULL;
 
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (id)
+		type = (int)id->driver_data;
+	else
+		return NULL;
+
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
@@ -1272,7 +1298,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	ssp->irq = platform_get_irq(pdev, 0);
-	ssp->type = LPSS_SSP;
+	ssp->type = type;
 	ssp->pdev = pdev;
 
 	ssp->port_id = -1;
@@ -1285,16 +1311,6 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	return pdata;
 }
 
-static struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "INT33C0", 0 },
-	{ "INT33C1", 0 },
-	{ "INT3430", 0 },
-	{ "INT3431", 0 },
-	{ "80860F0E", 0 },
-	{ "8086228E", 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
 #else
 static inline struct pxa2xx_spi_master *
 pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index dab545bb66b3..95a4b3bd7a5c 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -194,8 +194,9 @@ enum pxa_ssp_type {
 	PXA168_SSP,
 	PXA910_SSP,
 	CE4100_SSP,
-	LPSS_SSP,
 	QUARK_X1000_SSP,
+	LPSS_LPT_SSP,
+	LPSS_BYT_SSP,
 };
 
 struct ssp_device {
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
