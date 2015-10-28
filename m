From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/5] spi: pxa2xx: Rework self-initiated platform data creation for non-ACPI
Date: Wed, 28 Oct 2015 15:13:43 +0200
Message-ID: <1446038023-8819-5-git-send-email-jarkko.nikula@linux.intel.com>
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

Extend the pxa2xx_spi_acpi_get_pdata() so that it can create platform data
also on platforms that do not support ACPI or if CONFIG_ACPI is not set.
Now it is expected that "pxa2xx-spi" platform device is either created with
explicit platform data or has an ACPI companion device.

However there is only little in pxa2xx_spi_acpi_get_pdata() that is really
dependent on ACPI companion and it can be reworked to cover also cases
where "pxa2xx-spi" device doesn't have ACPI companion and is created
without platform data.

Do this by renaming the pxa2xx_spi_acpi_get_pdata(), moving it outside of
CONFIG_ACPI test and changing a few runtime tests there to support non-ACPI
case. Only port/bus ID setting based on ACPI _UID is dependent on ACPI and
is moved to own function inside CONFIG_ACPI.

Purpose of this to support non-ACPI case for those PCI enumerated compound
devices that integrate both LPSS SPI host controller and integrated DMA
engine under the same PCI ID and which are registered in MFD layer instead
of in spi-pxa2xx-pci.c.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1d5392e5a952..b25dc71b0ea9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1304,6 +1304,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
+#ifdef CONFIG_PCI
 #ifdef CONFIG_ACPI
 
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
@@ -1317,6 +1318,23 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
 
+static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+{
+	unsigned int devid;
+	int port_id = -1;
+
+	if (adev && adev->pnp.unique_id &&
+	    !kstrtouint(adev->pnp.unique_id, 0, &devid))
+		port_id = devid;
+	return port_id;
+}
+#else /* !CONFIG_ACPI */
+static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+{
+	return -1;
+}
+#endif
+
 /*
  * PCI IDs of compound devices that integrate both host controller and private
  * integrated DMA engine. Please note these are not used in module
@@ -1351,7 +1369,7 @@ static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 }
 
 static struct pxa2xx_spi_master *
-pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
+pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_master *pdata;
 	struct acpi_device *adev;
@@ -1359,19 +1377,18 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	struct resource *res;
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	unsigned int devid;
 	int type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
-	if (!adev)
-		return NULL;
 
 	if (dev_is_pci(pdev->dev.parent))
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
-	else
+	else if (adev)
 		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
+	else
+		return NULL;
 
 	if (adev_id)
 		type = (int)adev_id->driver_data;
@@ -1405,10 +1422,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
 	ssp->pdev = pdev;
-
-	ssp->port_id = -1;
-	if (adev->pnp.unique_id && !kstrtouint(adev->pnp.unique_id, 0, &devid))
-		ssp->port_id = devid;
+	ssp->port_id = pxa2xx_spi_get_port_id(adev);
 
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
@@ -1416,9 +1430,9 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
 	return pdata;
 }
 
-#else
+#else /* !CONFIG_PCI */
 static inline struct pxa2xx_spi_master *
-pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
+pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	return NULL;
 }
@@ -1437,7 +1451,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
-		platform_info = pxa2xx_spi_acpi_get_pdata(pdev);
+		platform_info = pxa2xx_spi_init_pdata(pdev);
 		if (!platform_info) {
 			dev_err(&pdev->dev, "missing platform data\n");
 			return -ENODEV;
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
