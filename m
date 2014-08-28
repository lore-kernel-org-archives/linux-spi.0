From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 3/4] spi: dw-pci: convert to use dev_pm_ops
Date: Thu, 28 Aug 2014 10:21:03 +0300
Message-ID: <1409210464-29039-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1409210464-29039-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409210464-29039-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert system PM callbacks to use dev_pm_ops. In addition remove the PCI calls
related to a power state since the bus code cares about this already.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 473bd52..3774261 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -95,38 +95,26 @@ static void spi_pci_remove(struct pci_dev *pdev)
 	dw_spi_remove_host(&dwpci->dws);
 }
 
-#ifdef CONFIG_PM
-static int spi_suspend(struct pci_dev *pdev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int spi_suspend(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
-	int ret;
 
-	ret = dw_spi_suspend_host(&dwpci->dws);
-	if (ret)
-		return ret;
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-	return ret;
+	return dw_spi_suspend_host(&dwpci->dws);
 }
 
-static int spi_resume(struct pci_dev *pdev)
+static int spi_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
-	int ret;
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	ret = pci_enable_device(pdev);
-	if (ret)
-		return ret;
 	return dw_spi_resume_host(&dwpci->dws);
 }
-#else
-#define spi_suspend	NULL
-#define spi_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(dw_spi_pm_ops, spi_suspend, spi_resume);
+
 static const struct pci_device_id pci_ids[] = {
 	/* Intel MID platform SPI controller 0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
@@ -138,8 +126,9 @@ static struct pci_driver dw_spi_driver = {
 	.id_table =	pci_ids,
 	.probe =	spi_pci_probe,
 	.remove =	spi_pci_remove,
-	.suspend =	spi_suspend,
-	.resume	=	spi_resume,
+	.driver         = {
+		.pm     = &dw_spi_pm_ops,
+	},
 };
 
 module_pci_driver(dw_spi_driver);
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
