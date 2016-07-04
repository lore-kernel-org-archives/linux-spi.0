From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 4/4] spi: pxa2xx-pci: Sort header block alphabetically
Date: Mon,  4 Jul 2016 12:44:27 +0300
Message-ID: <1467625467-103785-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1467625467-103785-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467625467-103785-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simply sort header block alphabetically.

While here, sort devices by PCI ID and add a copyright line for Intel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 4e3c5a7..5953edc 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -1,25 +1,26 @@
 /*
  * CE4100's SPI device is more or less the same one as found on PXA
  *
+ * Copyright (C) 2016, Intel Corporation
  */
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
-#include <linux/module.h>
 #include <linux/spi/pxa2xx_spi.h>
-#include <linux/clk-provider.h>
 
 #include <linux/dmaengine.h>
 #include <linux/platform_data/dma-dw.h>
 
 enum {
-	PORT_CE4100,
+	PORT_QUARK_X1000,
 	PORT_BYT,
 	PORT_MRFLD,
 	PORT_BSW0,
 	PORT_BSW1,
 	PORT_BSW2,
-	PORT_QUARK_X1000,
+	PORT_CE4100,
 	PORT_LPT,
 };
 
@@ -242,13 +243,13 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
-	{ PCI_VDEVICE(INTEL, 0x2e6a), PORT_CE4100 },
 	{ PCI_VDEVICE(INTEL, 0x0935), PORT_QUARK_X1000 },
 	{ PCI_VDEVICE(INTEL, 0x0f0e), PORT_BYT },
 	{ PCI_VDEVICE(INTEL, 0x1194), PORT_MRFLD },
 	{ PCI_VDEVICE(INTEL, 0x228e), PORT_BSW0 },
 	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
 	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
+	{ PCI_VDEVICE(INTEL, 0x2e6a), PORT_CE4100 },
 	{ PCI_VDEVICE(INTEL, 0x9ce6), PORT_LPT },
 	{ },
 };
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
