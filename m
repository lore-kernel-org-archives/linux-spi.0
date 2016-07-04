From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 3/4] spi: pxa2xx-pci: Remove unused code
Date: Mon,  4 Jul 2016 12:44:26 +0300
Message-ID: <1467625467-103785-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1467625467-103785-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467625467-103785-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

pcim_iomap_table() can't fail when called after pcim_iomap_regions(). Moreover,
we already dereference returned value and kernel will crash if it is not
correct.

Remove obvious leftover of commit 0202775bc3a2 ("spi/pxa2xx-pci: switch to use
pcim_* interfaces").

Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index b025eaf..4e3c5a7 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -202,10 +202,6 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
 	ssp->mmio_base = pcim_iomap_table(dev)[0];
-	if (!ssp->mmio_base) {
-		dev_err(&dev->dev, "failed to ioremap() registers\n");
-		return -EIO;
-	}
 	ssp->irq = dev->irq;
 	ssp->port_id = (c->port_id >= 0) ? c->port_id : dev->devfn;
 	ssp->type = c->type;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
