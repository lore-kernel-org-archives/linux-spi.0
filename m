From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v3 1/5] spi: dw-pci: move info message at the end of probe
Date: Fri, 29 Aug 2014 12:41:39 +0300
Message-ID: <1409305303-32631-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1409305303-32631-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409305303-32631-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Let's print info message when controller is found and properly initialized.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index e149604..6123e37 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -40,9 +40,6 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	int pci_bar = 0;
 	int ret;
 
-	dev_info(&pdev->dev, "found PCI SPI controller(ID: %04x:%04x)\n",
-		pdev->vendor, pdev->device);
-
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
@@ -85,6 +82,9 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	/* PCI hook and SPI hook use the same drv data */
 	pci_set_drvdata(pdev, dwpci);
 
+	dev_info(&pdev->dev, "found PCI SPI controller(ID: %04x:%04x)\n",
+		pdev->vendor, pdev->device);
+
 	return 0;
 }
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
