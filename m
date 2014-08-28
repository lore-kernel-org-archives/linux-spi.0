From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/5] spi: dw-pci: apply pci_bar and re-use pci_name
Date: Thu, 28 Aug 2014 18:07:23 +0300
Message-ID: <1409238446-19436-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1409238446-19436-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409238446-19436-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Nevertheless pci_bar is 0 let's explicitly use it when map IO regions. While
here, use pci_name instead of dev_name.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 9a74926..2b69228 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -54,7 +54,7 @@ static int spi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Get basic io resource and map it */
 	dws->paddr = pci_resource_start(pdev, pci_bar);
 
-	ret = pcim_iomap_regions(pdev, 1, dev_name(&pdev->dev));
+	ret = pcim_iomap_regions(pdev, 1 << pci_bar, pci_name(pdev));
 	if (ret)
 		return ret;
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
