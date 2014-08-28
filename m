From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 4/5] spi: dw-pci: provide platform specific data via driver_data
Date: Thu, 28 Aug 2014 18:07:25 +0300
Message-ID: <1409238446-19436-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1409238446-19436-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409238446-19436-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of checking for device and vendor IDs inside probe function let's
provide a helper function via driver_data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 55181ce..0480d47 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -32,10 +32,19 @@ struct dw_spi_pci {
 	struct dw_spi	dws;
 };
 
+struct spi_pci_desc {
+	int	(*setup)(struct device *, struct dw_spi *);
+};
+
+static struct spi_pci_desc spi_pci_mid_desc = {
+	.setup = dw_spi_mid_init,
+};
+
 static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct dw_spi_pci *dwpci;
 	struct dw_spi *dws;
+	struct spi_pci_desc *desc = (struct spi_pci_desc *)ent->driver_data;
 	int pci_bar = 0;
 	int ret;
 
@@ -65,11 +74,11 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dws->irq = pdev->irq;
 
 	/*
-	 * Specific handling for Intel MID paltforms, like dma setup,
+	 * Specific handling for paltforms, like dma setup,
 	 * clock rate, FIFO depth.
 	 */
-	if (pdev->device == 0x0800) {
-		ret = dw_spi_mid_init(&pdev->dev, dws);
+	if (desc && desc->setup) {
+		ret = desc->setup(&pdev->dev, dws);
 		if (ret)
 			return ret;
 	}
@@ -116,7 +125,7 @@ static SIMPLE_DEV_PM_OPS(dw_spi_pm_ops, spi_suspend, spi_resume);
 
 static const struct pci_device_id pci_ids[] = {
 	/* Intel MID platform SPI controller 0 */
-	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
+	{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&spi_pci_mid_desc},
 	{},
 };
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
