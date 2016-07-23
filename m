From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 6/6] spi: octeon: Add thunderx driver
Date: Sat, 23 Jul 2016 12:42:55 +0200
Message-ID: <f87d7a5ef8a713fb6e64c5d9471e7e5bf2051d18.1469174814.git.jglauber@cavium.com>
References: <cover.1469174814.git.jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	"Steven J. Hill" <steven.hill@cavium.com>,
	David Daney <david.daney@cavium.com>,
	Jan Glauber <jglauber@cavium.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1469174814.git.jglauber@cavium.com>
In-Reply-To: <cover.1469174814.git.jglauber@cavium.com>
References: <cover.1469174814.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add ThunderX SPI driver using the shared part from the Octeon
driver. The main difference of the ThunderX driver is that it
is a PCI device so probing is different. The system clock settings
can be specified in device tree.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/spi/Kconfig               |   7 ++
 drivers/spi/Makefile              |   2 +
 drivers/spi/spi-cavium-thunderx.c | 158 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-cavium.h          |   3 +
 4 files changed, 170 insertions(+)
 create mode 100644 drivers/spi/spi-cavium-thunderx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b931ec..db02ba7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -630,6 +630,13 @@ config SPI_TEGRA20_SLINK
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
+config SPI_THUNDERX
+	tristate "Cavium ThunderX SPI controller"
+	depends on 64BIT && PCI && !CAVIUM_OCTEON_SOC
+	help
+	  SPI host driver for the hardware found on Cavium ThunderX
+	  SOCs.
+
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 185367e..133364b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -91,6 +91,8 @@ obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o
 obj-$(CONFIG_SPI_TEGRA20_SFLASH)	+= spi-tegra20-sflash.o
 obj-$(CONFIG_SPI_TEGRA20_SLINK)		+= spi-tegra20-slink.o
 obj-$(CONFIG_SPI_TLE62X0)		+= spi-tle62x0.o
+spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
+obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
 obj-$(CONFIG_SPI_TXX9)			+= spi-txx9.o
 obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
new file mode 100644
index 0000000..7eb9141
--- /dev/null
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -0,0 +1,158 @@
+/*
+ * Cavium ThunderX SPI driver.
+ *
+ * Copyright (C) 2016 Cavium Inc.
+ * Authors: Jan Glauber <jglauber@cavium.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/spi/spi.h>
+
+#include "spi-cavium.h"
+
+#define DRV_NAME "spi-thunderx"
+
+#define SYS_FREQ_DEFAULT		700000000
+
+static void thunderx_spi_clock_enable(struct device *dev, struct octeon_spi *p)
+{
+	int ret;
+
+	p->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(p->clk)) {
+		p->clk = NULL;
+		goto skip;
+	}
+
+	ret = clk_prepare_enable(p->clk);
+	if (ret)
+		goto skip;
+	p->sys_freq = clk_get_rate(p->clk);
+
+skip:
+	if (!p->sys_freq)
+		p->sys_freq = SYS_FREQ_DEFAULT;
+
+	dev_info(dev, "Set system clock to %u\n", p->sys_freq);
+}
+
+static void thunderx_spi_clock_disable(struct device *dev, struct clk *clk)
+{
+	if (!clk)
+		return;
+	clk_disable_unprepare(clk);
+	devm_clk_put(dev, clk);
+}
+
+static int thunderx_spi_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct octeon_spi *p;
+	int ret = -ENOENT;
+
+	master = spi_alloc_master(dev, sizeof(struct octeon_spi));
+	if (!master)
+		return -ENOMEM;
+	p = spi_master_get_devdata(master);
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(dev, "Failed to enable PCI device\n");
+		goto out_free;
+	}
+
+	ret = pci_request_regions(pdev, DRV_NAME);
+	if (ret) {
+		dev_err(dev, "PCI request regions failed 0x%x\n", ret);
+		goto out_disable;
+	}
+
+	p->register_base = pci_ioremap_bar(pdev, 0);
+	if (!p->register_base) {
+		dev_err(dev, "Cannot map reg base\n");
+		ret = -EINVAL;
+		goto out_region;
+	}
+
+	p->regs.config = 0x1000;
+	p->regs.status = 0x1008;
+	p->regs.tx = 0x1010;
+	p->regs.data = 0x1080;
+
+	thunderx_spi_clock_enable(dev, p);
+
+	master->num_chipselect = 4;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH |
+			    SPI_LSB_FIRST | SPI_3WIRE;
+	master->transfer_one_message = octeon_spi_transfer_one_message;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
+	master->dev.of_node = pdev->dev.of_node;
+
+	pci_set_drvdata(pdev, master);
+	ret = devm_spi_register_master(dev, master);
+	if (ret) {
+		dev_err(&pdev->dev, "Register master failed: %d\n", ret);
+		goto out_unmap;
+	}
+
+	dev_info(&pdev->dev, "Cavium SPI bus driver probed\n");
+	return 0;
+
+out_unmap:
+	thunderx_spi_clock_disable(dev, p->clk);
+	iounmap(p->register_base);
+out_region:
+	pci_release_regions(pdev);
+out_disable:
+	pci_disable_device(pdev);
+out_free:
+	spi_master_put(master);
+	return ret;
+}
+
+static void thunderx_spi_remove(struct pci_dev *pdev)
+{
+	struct spi_master *master = pci_get_drvdata(pdev);
+	struct octeon_spi *p;
+
+	p = spi_master_get_devdata(master);
+	if (!p)
+		return;
+
+	/* Put everything in a known state. */
+	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	thunderx_spi_clock_disable(&pdev->dev, p->clk);
+	iounmap(p->register_base);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+}
+
+#define PCI_DEVICE_ID_THUNDERX_SPI      0xa00b
+
+static const struct pci_device_id thunderx_spi_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVICE_ID_THUNDERX_SPI) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, thunderx_spi_pci_id_table);
+
+static struct pci_driver thunderx_spi_driver = {
+	.name		= DRV_NAME,
+	.id_table	= thunderx_spi_pci_id_table,
+	.probe		= thunderx_spi_probe,
+	.remove		= thunderx_spi_remove,
+};
+
+module_pci_driver(thunderx_spi_driver);
+
+MODULE_DESCRIPTION("Cavium, Inc. ThunderX SPI bus driver");
+MODULE_AUTHOR("Jan Glauber");
+MODULE_LICENSE("GPL");
diff --git a/drivers/spi/spi-cavium.h b/drivers/spi/spi-cavium.h
index 88c5f36..1f91d61 100644
--- a/drivers/spi/spi-cavium.h
+++ b/drivers/spi/spi-cavium.h
@@ -1,6 +1,8 @@
 #ifndef __SPI_CAVIUM_H
 #define __SPI_CAVIUM_H
 
+#include <linux/clk.h>
+
 #define OCTEON_SPI_MAX_BYTES 9
 #define OCTEON_SPI_MAX_CLOCK_HZ 16000000
 
@@ -17,6 +19,7 @@ struct octeon_spi {
 	u64 cs_enax;
 	int sys_freq;
 	struct octeon_spi_regs regs;
+	struct clk *clk;
 };
 
 #define OCTEON_SPI_CFG(x)	(x->regs.config)
-- 
2.9.0.rc0.21.g7777322
