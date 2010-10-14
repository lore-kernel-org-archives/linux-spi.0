From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [RFC PATCH 2/3] spi/xilinx: fold platform_driver support into main
	body
Date: Thu, 14 Oct 2010 10:20:04 -0600
Message-ID: <20101014162004.18966.25016.stgit@localhost6.localdomain6>
References: <20101014161724.18966.42340.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, richard.rojfors-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org,
	john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101014161724.18966.42340.stgit-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch merges the platform driver support into the main body of
xilinx_spi.c in preparation for merging the OF and non-OF support
code.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---
 drivers/spi/Kconfig            |    7 ---
 drivers/spi/Makefile           |    1 
 drivers/spi/xilinx_spi.c       |   79 ++++++++++++++++++++++++++++--
 drivers/spi/xilinx_spi_pltfm.c |  104 ----------------------------------------
 4 files changed, 73 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/spi/xilinx_spi_pltfm.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9949c25..cebe425 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -345,13 +345,6 @@ config SPI_XILINX_OF
 	help
 	  This is the OF driver for the SPI controller IP from the Xilinx EDK.
 
-config SPI_XILINX_PLTFM
-	tristate "Xilinx SPI controller platform device"
-	depends on SPI_XILINX
-	help
-	  This is the platform driver for the SPI controller IP
-	  from the Xilinx EDK.
-
 config SPI_NUC900
 	tristate "Nuvoton NUC900 series SPI"
 	depends on ARCH_W90X900 && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 557aaad..90e0e6a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi_topcliff_pch.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_XILINX_OF)		+= xilinx_spi_of.o
-obj-$(CONFIG_SPI_XILINX_PLTFM)		+= xilinx_spi_pltfm.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 obj-$(CONFIG_SPI_SH_MSIOF)		+= spi_sh_msiof.o
 obj-$(CONFIG_SPI_STMP3XXX)		+= spi_stmp.o
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index efb28ba..bb3b520 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -1,20 +1,22 @@
 /*
- * xilinx_spi.c
- *
  * Xilinx SPI controller driver (master mode only)
  *
  * Author: MontaVista Software, Inc.
  *	source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
  *
- * 2002-2007 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
+ * Copyright (c) 2010 Secret Lab Technologies, Ltd.
+ * Copyright (c) 2009 Intel Corporation
+ * 2002-2007 (c) MontaVista Software, Inc.
+
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-
+#include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/io.h>
@@ -456,6 +458,71 @@ void xilinx_spi_deinit(struct spi_master *master)
 }
 EXPORT_SYMBOL(xilinx_spi_deinit);
 
+static int __devinit xilinx_spi_probe(struct platform_device *dev)
+{
+	struct xspi_platform_data *pdata;
+	struct resource *r;
+	int irq;
+	struct spi_master *master;
+	u8 i;
+
+	pdata = dev->dev.platform_data;
+	if (!pdata)
+		return -ENODEV;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!r)
+		return -ENODEV;
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0)
+		return -ENXIO;
+
+	master = xilinx_spi_init(&dev->dev, r, irq, dev->id,
+				 pdata->num_chipselect, pdata->little_endian,
+				 pdata->bits_per_word);
+	if (!master)
+		return -ENODEV;
+
+	for (i = 0; i < pdata->num_devices; i++)
+		spi_new_device(master, pdata->devices + i);
+
+	platform_set_drvdata(dev, master);
+	return 0;
+}
+
+static int __devexit xilinx_spi_remove(struct platform_device *dev)
+{
+	xilinx_spi_deinit(platform_get_drvdata(dev));
+	platform_set_drvdata(dev, 0);
+
+	return 0;
+}
+
+/* work with hotplug and coldplug */
+MODULE_ALIAS("platform:" XILINX_SPI_NAME);
+
+static struct platform_driver xilinx_spi_driver = {
+	.probe = xilinx_spi_probe,
+	.remove = __devexit_p(xilinx_spi_remove),
+	.driver = {
+		.name = XILINX_SPI_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init xilinx_spi_pltfm_init(void)
+{
+	return platform_driver_register(&xilinx_spi_driver);
+}
+module_init(xilinx_spi_pltfm_init);
+
+static void __exit xilinx_spi_pltfm_exit(void)
+{
+	platform_driver_unregister(&xilinx_spi_driver);
+}
+module_exit(xilinx_spi_pltfm_exit);
+
 MODULE_AUTHOR("MontaVista Software, Inc. <source-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>");
 MODULE_DESCRIPTION("Xilinx SPI driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/spi/xilinx_spi_pltfm.c b/drivers/spi/xilinx_spi_pltfm.c
deleted file mode 100644
index a16722a..0000000
--- a/drivers/spi/xilinx_spi_pltfm.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * Support for Xilinx SPI platform devices
- * Copyright (c) 2009 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-/* Supports:
- * Xilinx SPI devices as platform devices
- *
- * Inspired by xilinx_spi.c, 2002-2007 (c) MontaVista Software, Inc.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-
-#include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
-#include <linux/spi/xilinx_spi.h>
-
-#include "xilinx_spi.h"
-
-static int __devinit xilinx_spi_probe(struct platform_device *dev)
-{
-	struct xspi_platform_data *pdata;
-	struct resource *r;
-	int irq;
-	struct spi_master *master;
-	u8 i;
-
-	pdata = dev->dev.platform_data;
-	if (!pdata)
-		return -ENODEV;
-
-	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!r)
-		return -ENODEV;
-
-	irq = platform_get_irq(dev, 0);
-	if (irq < 0)
-		return -ENXIO;
-
-	master = xilinx_spi_init(&dev->dev, r, irq, dev->id,
-				 pdata->num_chipselect, pdata->little_endian,
-				 pdata->bits_per_word);
-	if (!master)
-		return -ENODEV;
-
-	for (i = 0; i < pdata->num_devices; i++)
-		spi_new_device(master, pdata->devices + i);
-
-	platform_set_drvdata(dev, master);
-	return 0;
-}
-
-static int __devexit xilinx_spi_remove(struct platform_device *dev)
-{
-	xilinx_spi_deinit(platform_get_drvdata(dev));
-	platform_set_drvdata(dev, 0);
-
-	return 0;
-}
-
-/* work with hotplug and coldplug */
-MODULE_ALIAS("platform:" XILINX_SPI_NAME);
-
-static struct platform_driver xilinx_spi_driver = {
-	.probe	= xilinx_spi_probe,
-	.remove	= __devexit_p(xilinx_spi_remove),
-	.driver = {
-		.name = XILINX_SPI_NAME,
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init xilinx_spi_pltfm_init(void)
-{
-	return platform_driver_register(&xilinx_spi_driver);
-}
-module_init(xilinx_spi_pltfm_init);
-
-static void __exit xilinx_spi_pltfm_exit(void)
-{
-	platform_driver_unregister(&xilinx_spi_driver);
-}
-module_exit(xilinx_spi_pltfm_exit);
-
-MODULE_AUTHOR("Mocean Laboratories <info-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>");
-MODULE_DESCRIPTION("Xilinx SPI platform driver");
-MODULE_LICENSE("GPL v2");


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
