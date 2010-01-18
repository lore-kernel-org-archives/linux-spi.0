From: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] Memory-mapped Dwsignware SPI driver
Date: Mon, 18 Jan 2010 11:50:01 -0500
Message-ID: <20100118164921.23527.74770.stgit@station520.octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Adds a memory-mapped I/O dw_spi platform device.

Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/Kconfig       |   16 ++++
 drivers/spi/Makefile      |    1 
 drivers/spi/dw_spi_mmio.c |  164 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+), 3 deletions(-)
 create mode 100644 drivers/spi/dw_spi_mmio.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f55eb01..79c8d5f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -308,14 +308,24 @@ config SPI_NUC900
 #
 
 config SPI_DESIGNWARE
-	bool "DesignWare SPI controller core support"
+	tristate "DesignWare SPI controller core support"
 	depends on SPI_MASTER
 	help
 	  general driver for SPI controller core from DesignWare
 
+choice
+	prompt "Designware bus type"
+	depends on SPI_DESIGNWARE
+	default SPI_DW_PCI
+
 config SPI_DW_PCI
-	tristate "PCI interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE && PCI
+	bool "PCI interface driver for DW SPI core"
+	depends on PCI
+
+config SPI_DW_MMIO
+	bool "Memory-mapped io interface driver for DW SPI core"
+
+endchoice
 
 #
 # There are lots of SPI device types, with sensors and memory
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index f3d2810..c3e5ce7 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= dw_spi.o
 obj-$(CONFIG_SPI_DW_PCI)		+= dw_spi_pci.o
+obj-$(CONFIG_SPI_DW_MMIO)		+= dw_spi_mmio.o
 obj-$(CONFIG_SPI_GPIO)			+= spi_gpio.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi_lm70llp.o
diff --git a/drivers/spi/dw_spi_mmio.c b/drivers/spi/dw_spi_mmio.c
new file mode 100644
index 0000000..9abeb45
--- /dev/null
+++ b/drivers/spi/dw_spi_mmio.c
@@ -0,0 +1,164 @@
+/*
+ * dw_spi_mmio.c - Memory-mapped interface driver for DW SPI Core
+ *
+ * Copyright (c) 2010, Octasic semiconductor.
+ *
+ * Somewhat derived from PCI implementation,
+ * Copyright (c) 2009, Intel Corporation.
+ *
+ * ...and from designware i2c driver
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (C) 2007 MontaVista Software Inc.
+ * Copyright (C) 2009 Provigent Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation,
+ * Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/spi/dw_spi.h>
+#include <linux/spi/spi.h>
+
+#define DRIVER_NAME "dw_spi_mmio"
+
+struct dw_spi_mmio {
+	struct dw_spi	dws;
+	struct clk		*clk;
+};
+
+static int __devinit dw_spi_mmio_probe(struct platform_device *pdev)
+{
+	struct dw_spi_mmio *dwsmmio;
+	struct dw_spi *dws;
+	struct resource *mem, *ioarea;
+	int ret;
+
+	dwsmmio = kzalloc(sizeof(struct dw_spi_mmio), GFP_KERNEL);
+	if (!dwsmmio) {
+		ret = -ENOMEM;
+		goto err_end;
+	}
+
+	dws = &dwsmmio->dws;
+
+	/* Get basic io resource and map it */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(&pdev->dev, "no mem resource?\n");
+		ret = -EINVAL;
+		goto err_kfree;
+	}
+
+	ioarea = request_mem_region(mem->start, resource_size(mem),
+			pdev->name);
+	if (!ioarea) {
+		dev_err(&pdev->dev, "SPI region already claimed\n");
+		ret = -EBUSY;
+		goto err_kfree;
+	}
+
+	dws->regs = ioremap_nocache(mem->start, resource_size(mem));
+	if (!dws->regs) {
+		dev_err(&pdev->dev, "SPI region already mapped\n");
+		ret = -ENOMEM;
+		goto err_release_reg;
+	}
+
+	dws->irq = platform_get_irq(pdev, 0);
+	if (dws->irq < 0) {
+		dev_err(&pdev->dev, "no irq resource?\n");
+		ret = dws->irq; /* -ENXIO */
+		goto err_unmap;
+	}
+
+	dwsmmio->clk = clk_get(&pdev->dev, NULL);
+	if (!dwsmmio->clk) {
+		ret = -ENODEV;
+		goto err_irq;
+	}
+	clk_enable(dwsmmio->clk);
+
+	dws->parent_dev = &pdev->dev;
+	dws->bus_num = 0;
+	dws->num_cs = 4;
+	dws->max_freq = clk_get_rate(dwsmmio->clk);
+
+	ret = dw_spi_add_host(dws);
+	if (ret)
+		goto err_clk;
+
+	platform_set_drvdata(pdev, dwsmmio);
+	return 0;
+
+err_clk:
+	clk_disable(dwsmmio->clk);
+	clk_put(dwsmmio->clk);
+	dwsmmio->clk = NULL;
+err_irq:
+	free_irq(dws->irq, dws);
+err_unmap:
+	iounmap(dws->regs);
+err_release_reg:
+	release_mem_region(mem->start, resource_size(mem));
+err_kfree:
+	kfree(dwsmmio);
+err_end:
+	return ret;
+}
+
+static int __devexit dw_spi_mmio_remove(struct platform_device *pdev)
+{
+	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
+	struct resource *mem;
+
+	platform_set_drvdata(pdev, NULL);
+
+	clk_disable(dwsmmio->clk);
+	clk_put(dwsmmio->clk);
+	dwsmmio->clk = NULL;
+
+	free_irq(dwsmmio->dws.irq, &dwsmmio->dws);
+	iounmap(dwsmmio->dws.regs);
+	kfree(dwsmmio);
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem->start, resource_size(mem));
+	return 0;
+}
+
+static struct platform_driver dw_spi_mmio_driver = {
+	.remove		= __devexit_p(dw_spi_mmio_remove),
+	.driver		= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init dw_spi_mmio_init(void)
+{
+	return platform_driver_probe(&dw_spi_mmio_driver, dw_spi_mmio_probe);
+}
+
+static void __exit dw_spi_mmio_exit(void)
+{
+	platform_driver_unregister(&dw_spi_mmio_driver);
+}
+
+module_init(dw_spi_mmio_init);
+module_exit(dw_spi_mmio_exit);
+
+MODULE_AUTHOR("Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>");
+MODULE_DESCRIPTION("Memory-mapped I/O interface driver for DW SPI Core");
+MODULE_LICENSE("GPL v2");


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
