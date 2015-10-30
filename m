From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: pxa2xx: Rework self-initiated platform data creation for non-ACPI
Date: Fri, 30 Oct 2015 11:20:40 +0900
Message-ID: <E1ZrzJ2-0001ow-RQ@finisterre>
References: <1446038023-8819-5-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446038023-8819-5-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Rework self-initiated platform data creation for non-ACPI

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

>From 0db642151ad80967e9e1c2abf3e19bd7902ecdc9 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 28 Oct 2015 15:13:43 +0200
Subject: [PATCH] spi: pxa2xx: Rework self-initiated platform data creation for
 non-ACPI

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f759c08..2e95108 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1300,6 +1300,7 @@ static void cleanup(struct spi_device *spi)
 	kfree(chip);
 }
 
+#ifdef CONFIG_PCI
 #ifdef CONFIG_ACPI
 
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
@@ -1313,6 +1314,23 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
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
@@ -1347,7 +1365,7 @@ static bool pxa2xx_spi_idma_filter(struct dma_chan *chan, void *param)
 }
 
 static struct pxa2xx_spi_master *
-pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
+pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_master *pdata;
 	struct acpi_device *adev;
@@ -1355,19 +1373,18 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
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
@@ -1401,10 +1418,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
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
@@ -1412,9 +1426,9 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
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
@@ -1433,7 +1447,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 
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
