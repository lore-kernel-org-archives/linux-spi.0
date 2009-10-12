From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3 v3] spi: add PCI interface driver
 for Designware SPI core
Date: Mon, 12 Oct 2009 14:19:34 +0800
Message-ID: <20091012141934.18727787@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton
	<akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, spi-devel-list
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

>From 08d9f64c47e2c76c6f417a6eb7f8f7f2ce45cb47 Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Sat, 10 Oct 2009 14:57:33 +0800
Subject: [PATCH 2/3] spi: add PCI interface driver for Designware SPI core

This add the PCI interface driver for DW SPI core, it has
been tested on Intel Moorestown platform

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig      |    4 +
 drivers/spi/Makefile     |    1 +
 drivers/spi/dw_spi_pci.c |  169 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/dw_spi_pci.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6eb9621..bd39e80 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -250,6 +250,10 @@ config SPI_DESIGNWARE
 	help
 	  general driver for SPI controller core from DesignWare
 
+config SPI_DW_PCI
+	tristate "PCI interface driver for DW SPI core"
+	depends on SPI_DESIGNWARE && PCI
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5cc4e19..51ebff0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 obj-$(CONFIG_SPI_STMP3XXX)		+= spi_stmp.o
 obj-$(CONFIG_SPI_DESIGNWARE)		+= dw_spi.o
+obj-$(CONFIG_SPI_DW_PCI)		+= dw_spi_pci.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff --git a/drivers/spi/dw_spi_pci.c b/drivers/spi/dw_spi_pci.c
new file mode 100644
index 0000000..24809c9
--- /dev/null
+++ b/drivers/spi/dw_spi_pci.c
@@ -0,0 +1,169 @@
+/*
+ * mrst_spi_pci.c - PCI interface driver for DW SPI Core
+ *
+ * Copyright (c) 2009, Intel Corporation.
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
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/spi/dw_spi.h>
+#include <linux/spi/spi.h>
+
+#define DRIVER_NAME "dw_spi_pci"
+
+struct dw_spi_pci {
+	struct pci_dev		*pdev;
+	struct dw_spi		dws;
+};
+
+static int __devinit spi_pci_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
+{
+	struct dw_spi_pci *dwpci;
+	struct dw_spi *dws;
+	int pci_bar = 0;
+	int ret;
+
+	printk(KERN_INFO "DW: found PCI SPI controller(ID: %04x:%04x)\n",
+		pdev->vendor, pdev->device);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	dwpci = kzalloc(sizeof(struct dw_spi_pci), GFP_KERNEL);
+	if (!dwpci) {
+		ret = -ENOMEM;
+		goto err_disable;
+	}
+
+	dwpci->pdev = pdev;
+	dws = &dwpci->dws;
+
+	/* Get basic io resource and map it */
+	dws->paddr = pci_resource_start(pdev, pci_bar);
+	dws->iolen = pci_resource_len(pdev, pci_bar);
+
+	ret = pci_request_region(pdev, pci_bar, dev_name(&pdev->dev));
+	if (ret)
+		goto err_kfree;
+
+	dws->regs = ioremap_nocache((unsigned long)dws->paddr,
+				pci_resource_len(pdev, pci_bar));
+	if (!dws->regs) {
+		ret = -ENOMEM;
+		goto err_release_reg;
+	}
+
+	dws->parent_dev = &pdev->dev;
+	dws->bus_num = 0;
+	dws->num_cs = 4;
+	dws->max_freq = 25000000;	/* for Moorestwon */
+	dws->irq = pdev->irq;
+
+	ret = dw_spi_add_host(dws);
+	if (ret)
+		goto err_unmap;
+
+	/* PCI hook and SPI hook use the same drv data */
+	pci_set_drvdata(pdev, dwpci);
+	return 0;
+
+err_unmap:
+	iounmap(dws->regs);
+err_release_reg:
+	pci_release_region(pdev, pci_bar);
+err_kfree:
+	kfree(dwpci);
+err_disable:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void __devexit spi_pci_remove(struct pci_dev *pdev)
+{
+	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+
+	pci_set_drvdata(pdev, NULL);
+	iounmap(dwpci->dws.regs);
+	pci_release_region(pdev, 0);
+	kfree(dwpci);
+	pci_disable_device(pdev);
+}
+
+#ifdef CONFIG_PM
+static int spi_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+	int ret;
+
+	ret = dw_spi_suspend_host(&dwpci->dws);
+	if (ret)
+		return ret;
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	return ret;
+}
+
+static int spi_resume(struct pci_dev *pdev)
+{
+	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
+	int ret;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+	return dw_spi_resume_host(&dwpci->dws);
+}
+#else
+#define mrst_spi_suspend	NULL
+#define mrst_spi_resume		NULL
+#endif
+
+static const struct pci_device_id pci_ids[] __devinitdata = {
+	/* Intel Moorestown platform SPI controller 0 */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
+	{},
+};
+
+static struct pci_driver dw_spi_driver = {
+	.name =		DRIVER_NAME,
+	.id_table =	pci_ids,
+	.probe =	spi_pci_probe,
+	.remove =	__devexit_p(spi_pci_remove),
+	.suspend =	spi_suspend,
+	.resume	=	spi_resume,
+};
+
+static int __init mrst_spi_init(void)
+{
+	return pci_register_driver(&dw_spi_driver);
+}
+
+static void __exit mrst_spi_exit(void)
+{
+	pci_unregister_driver(&dw_spi_driver);
+}
+
+module_init(mrst_spi_init);
+module_exit(mrst_spi_exit);
+
+MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("PCI interface driver for DW SPI Core");
+MODULE_LICENSE("GPL v2");
-- 
1.6.0.4

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
