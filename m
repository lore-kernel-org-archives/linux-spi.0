From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: octeon: Add ThunderX driver" to the spi tree
Date: Fri, 19 Aug 2016 16:26:25 +0100
Message-ID: <E1balgf-0002Dn-DQ@debutante>
References: <20160819140320.12954-1-jglauber@cavium.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160819140320.12954-1-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: octeon: Add ThunderX driver

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7347a6c7af8d9b5edf587678e80c7e5bc24ec2d5 Mon Sep 17 00:00:00 2001
From: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Date: Fri, 19 Aug 2016 16:03:20 +0200
Subject: [PATCH] spi: octeon: Add ThunderX driver

Add ThunderX SPI driver using the shared part from the Octeon
driver. The main difference of the ThunderX driver is that it
is a PCI device so probing is different. The system clock settings
can be specified in device tree.

Signed-off-by: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig               |   7 +++
 drivers/spi/Makefile              |   2 +
 drivers/spi/spi-cavium-thunderx.c | 118 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-cavium.h          |   3 +
 4 files changed, 130 insertions(+)
 create mode 100644 drivers/spi/spi-cavium-thunderx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6fb8d4b7786..8108971af601 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -631,6 +631,13 @@ config SPI_TEGRA20_SLINK
 	help
 	  SPI driver for Nvidia Tegra20/Tegra30 SLINK Controller interface.
 
+config SPI_THUNDERX
+	tristate "Cavium ThunderX SPI controller"
+	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
+	help
+	  SPI host driver for the hardware found on Cavium ThunderX
+	  SOCs.
+
 config SPI_TOPCLIFF_PCH
 	tristate "Intel EG20T PCH/LAPIS Semicon IOH(ML7213/ML7223/ML7831) SPI"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 185367ef6576..133364b069e6 100644
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
index 000000000000..eff2a130ef0c
--- /dev/null
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -0,0 +1,118 @@
+/*
+ * Cavium ThunderX SPI driver.
+ *
+ * Copyright (C) 2016 Cavium Inc.
+ * Authors: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/spi/spi.h>
+
+#include "spi-cavium.h"
+
+#define DRV_NAME "spi-thunderx"
+
+#define SYS_FREQ_DEFAULT 700000000 /* 700 Mhz */
+
+static int thunderx_spi_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_master *master;
+	struct octeon_spi *p;
+	int ret;
+
+	master = spi_alloc_master(dev, sizeof(struct octeon_spi));
+	if (!master)
+		return -ENOMEM;
+
+	p = spi_master_get_devdata(master);
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		goto error;
+
+	ret = pci_request_regions(pdev, DRV_NAME);
+	if (ret)
+		goto error;
+
+	p->register_base = pcim_iomap(pdev, 0, pci_resource_len(pdev, 0));
+	if (!p->register_base) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	p->regs.config = 0x1000;
+	p->regs.status = 0x1008;
+	p->regs.tx = 0x1010;
+	p->regs.data = 0x1080;
+
+	p->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(p->clk)) {
+		ret = PTR_ERR(p->clk);
+		goto error;
+	}
+
+	ret = clk_prepare_enable(p->clk);
+	if (ret)
+		goto error;
+
+	p->sys_freq = clk_get_rate(p->clk);
+	if (!p->sys_freq)
+		p->sys_freq = SYS_FREQ_DEFAULT;
+	dev_info(dev, "Set system clock to %u\n", p->sys_freq);
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
+
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
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
+}
+
+static const struct pci_device_id thunderx_spi_pci_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, 0xa00b) },
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
index 88c5f36e7ea7..1f91d61b745b 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
