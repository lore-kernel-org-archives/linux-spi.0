From: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: add support for aeroflex gaisler spimctrl
Date: Thu, 28 Apr 2011 22:41:35 +0200
Message-ID: <1304023295-5829-1-git-send-email-jan@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
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

This patch adds support for Aeroflex Gaisler SPI memory controller (SPIMCTRL).
SPIMCTRL memory maps a SPI flash device into AMBA address space. The core
also has a register interface where any command can be sent to the device.

The controller is typically found on LEON/GRLIB SoCs.

Tested on GR-LEON4-ITX development board.

Patch is against spi/next.

Signed-off-by: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/Kconfig       |    8 +
 drivers/spi/Makefile      |    1 +
 drivers/spi/ag_spimctrl.c |  354 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/ag_spimctrl.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fc14b8d..a1846da 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -53,6 +53,14 @@ if SPI_MASTER
 
 comment "SPI Master Controller Drivers"
 
+config SPI_AG_SPIMCTRL
+	tristate "Aeroflex Gaisler SPI memory controller"
+        depends on SPARC_LEON
+	select SPI_BITBANG
+	help
+	  This is the driver for Aeroflex Gaisler's SPI memory controller
+	  (SPIMCTRL) found on some LEON/GRLIB SoCs.
+
 config SPI_ALTERA
 	tristate "Altera SPI Controller"
 	select SPI_BITBANG
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index fd2fc5f..8a11a19 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_AG_SPIMCTRL)		+= ag_spimctrl.o
 obj-$(CONFIG_SPI_ALTERA)		+= spi_altera.o
 obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
 obj-$(CONFIG_SPI_ATH79)			+= ath79_spi.o
diff --git a/drivers/spi/ag_spimctrl.c b/drivers/spi/ag_spimctrl.c
new file mode 100644
index 0000000..022c1e8
--- /dev/null
+++ b/drivers/spi/ag_spimctrl.c
@@ -0,0 +1,354 @@
+/*
+ * Driver for Aeroflex Gaisler SPIMCTRL
+ *
+ * SPIMCTRL maps SPI flash devices in a read-only memory area and also provides
+ * a register interface that allows any SPI command to be sent. This driver only
+ * makes use of the register interface.
+ *
+ * Copyright (c) 2011 Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
+ *
+ * This driver is based on:
+ *
+ * Altera SPI driver
+ * Copyright (C) 2008 Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
+ * which in turn was based on spi_s3c24xx.c, which is:
+ * Copyright (c) 2006 Ben Dooks
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/io.h>
+#include <linux/of_irq.h>
+
+#define DRV_NAME "ag_spimctrl"
+
+
+/* Registers are in memory bank 1 */
+#define AG_SPIM_REGBANK	0
+
+/* Core has one chip-select only */
+#define AG_SPIM_NUMCS	1
+
+/* Register offsets */
+#define AG_SPIM_CTRL	0x04
+#define AG_SPIM_STAT	0x08
+#define AG_SPIM_RX	0x0C
+#define AG_SPIM_TX	0x10
+
+/* Register fields */
+#define AG_SPIM_CTRL_CSN	(1 << 3)
+#define AG_SPIM_CTRL_IEN	(1 << 1)
+#define AG_SPIM_CTRL_USRC	(1 << 0)
+
+#define AG_SPIM_STAT_BUSY	(1 << 1)
+#define AG_SPIM_STAT_DONE	(1 << 0)
+
+
+struct ag_spimctrl {
+	/* bitbang has to be first */
+	struct spi_bitbang bitbang;
+	struct completion done;
+
+	void __iomem *base;
+	int irq;
+	int len;
+	int count;
+	u32 ctrl;
+
+	/* data buffers */
+	const unsigned char *tx;
+	unsigned char *rx;
+};
+
+static inline void ag_spim_write(u32 val, void __iomem *addr)
+{
+	iowrite32be(val, addr);
+}
+
+static inline u32 ag_spim_read(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+
+static inline struct ag_spimctrl *ag_spimctrl_spi_to_hw(struct spi_device *sdev)
+{
+	return spi_master_get_devdata(sdev->master);
+}
+
+static void ag_spimctrl_chipsel(struct spi_device *spi, int value)
+{
+	struct ag_spimctrl *hw = ag_spimctrl_spi_to_hw(spi);
+	u32 ctrl = hw->ctrl;
+
+	if (spi->mode & SPI_CS_HIGH) {
+		switch (value) {
+		case BITBANG_CS_INACTIVE:
+			hw->ctrl &= ~AG_SPIM_CTRL_CSN;
+			break;
+
+		case BITBANG_CS_ACTIVE:
+			hw->ctrl |= AG_SPIM_CTRL_CSN;
+			break;
+		}
+	} else {
+		switch (value) {
+		case BITBANG_CS_INACTIVE:
+			hw->ctrl |= AG_SPIM_CTRL_CSN;
+			break;
+
+		case BITBANG_CS_ACTIVE:
+			hw->ctrl &= ~AG_SPIM_CTRL_CSN;
+			break;
+		}
+	}
+	if (ctrl != hw->ctrl)
+		ag_spim_write(hw->ctrl, hw->base + AG_SPIM_CTRL);
+}
+
+static int ag_spimctrl_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	/* the controller does not support mode changes so we just ignore them.
+	 * we can assume that the controller is attached to a memory device and
+	 * that the controller can communicate with this device.
+	 */
+
+	if (t && t->bits_per_word % 8)
+		return -EINVAL;
+
+	if (spi->bits_per_word % 8)
+		return -EINVAL;
+
+	if (spi->chip_select > AG_SPIM_NUMCS)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ag_spimctrl_setup(struct spi_device *spi)
+{
+	return ag_spimctrl_setupxfer(spi, NULL);
+}
+
+static void ag_spimctrl_cleanup(struct spi_device *spi)
+{
+	struct ag_spimctrl *hw = ag_spimctrl_spi_to_hw(spi);
+
+	hw->ctrl &= ~AG_SPIM_CTRL_USRC;
+	ag_spim_write(hw->ctrl, hw->base + AG_SPIM_CTRL);
+}
+
+static int ag_spimctrl_txrx(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct ag_spimctrl *hw = ag_spimctrl_spi_to_hw(spi);
+
+	hw->tx = t->tx_buf;
+	hw->rx = t->rx_buf;
+	hw->count = 0;
+	hw->len = t->len;
+
+	if (hw->irq != NO_IRQ) {
+		/* interrupt driven transfer, send the first byte */
+		ag_spim_write(hw->tx ? *hw->tx++ : 0, hw->base + AG_SPIM_TX);
+		wait_for_completion(&hw->done);
+	} else {
+		/* polling */
+		do {
+			/* clear done bit, transmit, wait for receive .. */
+			ag_spim_write(AG_SPIM_STAT_DONE,
+				hw->base + AG_SPIM_STAT);
+
+			ag_spim_write(hw->tx ? *hw->tx++ : 0,
+				hw->base + AG_SPIM_TX);
+
+			while (!(ag_spim_read(hw->base + AG_SPIM_STAT) &
+					AG_SPIM_STAT_DONE))
+				cpu_relax();
+
+			if (hw->rx)
+				hw->rx[hw->count] =
+					ag_spim_read(hw->base + AG_SPIM_RX);
+
+			hw->count++;
+		} while (hw->count < hw->len);
+	}
+
+	return hw->count;
+}
+
+static irqreturn_t ag_spimctrl_irq(int irq, void *dev)
+{
+	struct ag_spimctrl *hw = dev;
+	u32 rxd;
+
+	if (hw->rx) {
+		rxd = ag_spim_read(hw->base + AG_SPIM_RX);
+		hw->rx[hw->count] = rxd;
+	}
+
+	hw->count++;
+
+	if (hw->count < hw->len)
+		ag_spim_write(hw->tx ? *hw->tx++ : 0, hw->base + AG_SPIM_TX);
+	else
+		complete(&hw->done);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit ag_spimctrl_probe(struct platform_device *pdev)
+{
+	struct ag_spimctrl *hw;
+	struct spi_master *master;
+	int err = -ENODEV;
+	u32 status;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct ag_spimctrl));
+	if (!master)
+		return err;
+
+	/* setup the master state */
+	master->bus_num = pdev->id;
+	master->num_chipselect = AG_SPIM_NUMCS;
+	master->mode_bits = SPI_CS_HIGH;
+	master->setup = ag_spimctrl_setup;
+	master->cleanup = ag_spimctrl_cleanup;
+
+	hw = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, hw);
+
+	/* setup the state for the bitbang driver */
+	hw->bitbang.master = spi_master_get(master);
+	if (!hw->bitbang.master)
+		goto exit;
+	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
+
+	hw->bitbang.setup_transfer = ag_spimctrl_setupxfer;
+	hw->bitbang.chipselect = ag_spimctrl_chipsel;
+	hw->bitbang.txrx_bufs = ag_spimctrl_txrx;
+
+	/* find and map our resources */
+	hw->base = of_ioremap(&pdev->resource[AG_SPIM_REGBANK], 0,
+			resource_size(&pdev->resource[AG_SPIM_REGBANK]),
+			"ag-spimctrl regs");
+	if (!hw->base) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	/* check current hw state. if controller is busy, leave it alone */
+	status = ag_spim_read(hw->base + AG_SPIM_STAT);
+	if (status & AG_SPIM_STAT_BUSY) {
+		err = -EBUSY;
+		goto exit_iounmap;
+	}
+
+	/* save control register value to keep settings */
+	hw->ctrl = ag_spim_read(hw->base + AG_SPIM_CTRL);
+
+	/* irq is optional */
+	hw->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (hw->irq != NO_IRQ) {
+		init_completion(&hw->done);
+		err = request_irq(hw->irq, ag_spimctrl_irq, 0, pdev->name, hw);
+		if (err)
+			goto exit_iounmap;
+		/* enable interrupt, written to hw below*/
+		hw->ctrl |= AG_SPIM_CTRL_IEN;
+	}
+
+	/* enter user mode so SPI comm. can be done via reg. interface */
+	if (!(hw->ctrl & AG_SPIM_CTRL_USRC)) {
+		hw->ctrl |= AG_SPIM_CTRL_USRC;
+		ag_spim_write(hw->ctrl, hw->base + AG_SPIM_CTRL);
+	}
+
+	/* register our spi controller */
+	err = spi_bitbang_start(&hw->bitbang);
+	if (err)
+		goto exit_iounmap;
+
+	dev_info(&pdev->dev, "base at 0x%p, irq %d, bus %d\n",
+		hw->base, hw->irq, master->bus_num);
+
+	return 0;
+
+exit_iounmap:
+	of_iounmap(&pdev->resource[AG_SPIM_REGBANK], hw->base,
+		resource_size(&pdev->resource[AG_SPIM_REGBANK]));
+exit:
+	spi_master_put(master);
+	platform_set_drvdata(pdev, NULL);
+	return err;
+}
+
+static int __devexit ag_spimctrl_remove(struct platform_device *pdev)
+{
+	struct ag_spimctrl *hw = platform_get_drvdata(pdev);
+	struct spi_master *master = hw->bitbang.master;
+
+	spi_bitbang_stop(&hw->bitbang);
+
+	/* bring hw out of user mode */
+	hw->ctrl &= ~AG_SPIM_CTRL_USRC;
+	ag_spim_write(hw->ctrl, hw->base + AG_SPIM_CTRL);
+
+	spi_master_put(master);
+
+	if (hw->irq != NO_IRQ)
+		free_irq(hw->irq, hw);
+	of_iounmap(&pdev->resource[AG_SPIM_REGBANK], hw->base,
+		resource_size(&pdev->resource[AG_SPIM_REGBANK]));
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ag_spimctrl_of_match[] = {
+	{ .name = "GAISLER_SPIMCTRL",},
+	{ .name = "01_045",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ag_spimctrl_of_match);
+#else /* CONFIG_OF */
+#define ag_spimctrl_of_match NULL
+#endif /* CONFIG_OF */
+
+static struct platform_driver ag_spimctrl_driver = {
+	.probe = ag_spimctrl_probe,
+	.remove = __devexit_p(ag_spimctrl_remove),
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = NULL,
+		.of_match_table = ag_spimctrl_of_match,
+	},
+};
+
+static int __init ag_spimctrl_init(void)
+{
+	return platform_driver_register(&ag_spimctrl_driver);
+}
+module_init(ag_spimctrl_init);
+
+static void __exit ag_spimctrl_exit(void)
+{
+	platform_driver_unregister(&ag_spimctrl_driver);
+}
+module_exit(ag_spimctrl_exit);
+
+MODULE_DESCRIPTION("Aeroflex Gaisler SPIMCTRL driver");
+MODULE_AUTHOR("Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
1.7.0.4


------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
