From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 09/10] spi: dw-pci: remove unused pdev member from struct dw_spi_pci
Date: Wed, 14 Oct 2015 23:12:24 +0300
Message-ID: <1444853545-59868-10-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The pdev member is not used anywhere, thus remove it. Moreover struct
dw_spi_pci becomes an equivalent of struct dw_spi and therefore remove entire
struct dw_spi_pci.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index e096a29..eea442e 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -23,11 +23,6 @@
 
 #define DRIVER_NAME "dw_spi_pci"
 
-struct dw_spi_pci {
-	struct pci_dev	*pdev;
-	struct dw_spi	dws;
-};
-
 struct spi_pci_desc {
 	int	(*setup)(struct dw_spi *);
 	u16	num_cs;
@@ -48,7 +43,6 @@ static struct spi_pci_desc spi_pci_mid_desc_2 = {
 
 static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
-	struct dw_spi_pci *dwpci;
 	struct dw_spi *dws;
 	struct spi_pci_desc *desc = (struct spi_pci_desc *)ent->driver_data;
 	int pci_bar = 0;
@@ -58,14 +52,10 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
-	dwpci = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_pci),
-			GFP_KERNEL);
-	if (!dwpci)
+	dws = devm_kzalloc(&pdev->dev, sizeof(*dws), GFP_KERNEL);
+	if (!dws)
 		return -ENOMEM;
 
-	dwpci->pdev = pdev;
-	dws = &dwpci->dws;
-
 	/* Get basic io resource and map it */
 	dws->paddr = pci_resource_start(pdev, pci_bar);
 
@@ -74,7 +64,6 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return ret;
 
 	dws->regs = pcim_iomap_table(pdev)[pci_bar];
-
 	dws->irq = pdev->irq;
 
 	/*
@@ -99,7 +88,7 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return ret;
 
 	/* PCI hook and SPI hook use the same drv data */
-	pci_set_drvdata(pdev, dwpci);
+	pci_set_drvdata(pdev, dws);
 
 	dev_info(&pdev->dev, "found PCI SPI controller(ID: %04x:%04x)\n",
 		pdev->vendor, pdev->device);
@@ -122,26 +111,26 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 static void spi_pci_remove(struct pci_dev *pdev)
 {
-	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+	struct dw_spi *dws = pci_get_drvdata(pdev);
 
-	dw_spi_remove_host(&dwpci->dws);
+	dw_spi_remove_host(dws);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int spi_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+	struct dw_spi *dws = pci_get_drvdata(pdev);
 
-	return dw_spi_suspend_host(&dwpci->dws);
+	return dw_spi_suspend_host(dws);
 }
 
 static int spi_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+	struct dw_spi *dws = pci_get_drvdata(pdev);
 
-	return dw_spi_resume_host(&dwpci->dws);
+	return dw_spi_resume_host(dws);
 }
 #endif
 
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
