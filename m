From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6, 3/8] spi: brcmstb-qspi: Broadcom settop platform driver
Date: Wed, 24 Aug 2016 18:04:24 -0400
Message-ID: <1472076269-4731-4-git-send-email-kdasu.kdev@gmail.com>
References: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
Cc: bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472076269-4731-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding the settop SoC platfrom driver, this driver is compatible
with the settop MSPI+BSPI and MSPI only blocks implemented on the
SoCs. Driver calls the spi-bcm-qspi probe(), remove() and pm_ops.

Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Makefile           |  2 +-
 drivers/spi/spi-brcmstb-qspi.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 drivers/spi/spi-brcmstb-qspi.c

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4a715f3..3e753db 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -21,7 +21,7 @@ obj-$(CONFIG_SPI_BCM2835AUX)		+= spi-bcm2835aux.o
 obj-$(CONFIG_SPI_BCM53XX)		+= spi-bcm53xx.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
-obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-bcm-qspi.o
+obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-brcmstb-qspi.o spi-bcm-qspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
 obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
diff --git a/drivers/spi/spi-brcmstb-qspi.c b/drivers/spi/spi-brcmstb-qspi.c
new file mode 100644
index 0000000..c7df92e
--- /dev/null
+++ b/drivers/spi/spi-brcmstb-qspi.c
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2016 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation (the "GPL").
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License version 2 (GPLv2) for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * version 2 (GPLv2) along with this source code.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include "spi-bcm-qspi.h"
+
+static const struct of_device_id brcmstb_qspi_of_match[] = {
+	{ .compatible = "brcm,spi-brcmstb-qspi" },
+	{ .compatible = "brcm,spi-brcmstb-mspi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, brcmstb_qspi_of_match);
+
+static int brcmstb_qspi_probe(struct platform_device *pdev)
+{
+	return bcm_qspi_probe(pdev, NULL);
+}
+
+static int brcmstb_qspi_remove(struct platform_device *pdev)
+{
+	return bcm_qspi_remove(pdev);
+}
+
+static struct platform_driver brcmstb_qspi_driver = {
+	.probe			= brcmstb_qspi_probe,
+	.remove			= brcmstb_qspi_remove,
+	.driver = {
+		.name		= "brcmstb_qspi",
+		.pm		= &bcm_qspi_pm_ops,
+		.of_match_table = brcmstb_qspi_of_match,
+	}
+};
+module_platform_driver(brcmstb_qspi_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Kamal Dasu");
+MODULE_DESCRIPTION("Broadcom SPI driver for settop SoC");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
