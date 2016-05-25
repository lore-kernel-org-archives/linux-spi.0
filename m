From: Rich Felker <dalias@libc.org>
Subject: [PATCH v3 10/12] spi: add driver for J-Core SPI controller
Date: Wed, 25 May 2016 05:43:03 +0000
Message-ID: <00b31c4d09c340bd69fd4bbbc0ea06371aecc502.1464148904.git.dalias@libc.org>
References: <cover.1464148904.git.dalias@libc.org>
Cc: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464148904.git.dalias@libc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The J-Core "spi2" device is a PIO-based SPI master controller. It
differs from "bitbang" devices in that that it's clocked in hardware
rather than via soft clock modulation over gpio, and performs
byte-at-a-time transfers between the cpu and SPI controller.

This driver will be extended to support future versions of the J-Core
SPI controller with DMA transfers when they become available.

Signed-off-by: Rich Felker <dalias@libc.org>
---

This version of the SPI patch eliminates USE_MESSAGE_MODE (the open
coding of transfer_one_message logic) and makes severl other minor
changes based on ml discussion of the v2 patch. The chipselect change
has not been made yet, except for rewriting the current logic to be
more clear. If the decision is that it's needed, I can do it easily,
but it needs testing still.

 drivers/spi/Kconfig     |   4 +
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-jcore.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/spi/spi-jcore.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9d8c84b..5bd2ccf 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -285,6 +285,10 @@ config SPI_IMX
 	  This enables using the Freescale i.MX SPI controllers in master
 	  mode.
 
+config SPI_JCORE
+	tristate "J-Core SPI Master"
+	depends on OF
+
 config SPI_LM70_LLP
 	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
 	depends on PARPORT
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index fbb255c..6a34124 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
+obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
new file mode 100644
index 0000000..f239087
--- /dev/null
+++ b/drivers/spi/spi-jcore.c
@@ -0,0 +1,209 @@
+/*
+ * J-Core SPI controller driver
+ *
+ * Copyright (C) 2012-2016 Smart Energy Instruments, Inc.
+ *
+ * Current version by Rich Felker
+ * Based loosely on initial version by Oleksandr G Zhadan
+ *
+ */
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+
+#define DRV_NAME "jcore_spi"
+
+#define MAX_SPI_SPEED	12500000	/* 12.5 MHz */
+
+#define CTRL_REG	0x0
+#define DATA_REG	0x4
+
+#define SPI_NOCHIP_CS	0
+#define SPI_FLASH_CS	1
+#define SPI_CONF_CS	2
+#define SPI_SD_CS	2
+#define SPI_CODEC_CS	3
+
+#define JCORE_SPI_CTRL_XMIT		0x02
+#define JCORE_SPI_STAT_BUSY		0x02
+#define JCORE_SPI_CTRL_LOOP		0x08
+#define JCORE_SPI_CTRL_CS_BITS		0x15
+
+#define JCORE_SPI_WAIT_RDY_MAX_LOOP	2000000
+
+struct jcore_spi {
+	struct spi_master *master;
+	void __iomem *base;
+	volatile unsigned int ctrlReg;
+	unsigned int csReg;
+	unsigned int speedReg;
+	unsigned int speed_hz;
+};
+
+static void jcore_spi_wait_till_ready(struct jcore_spi *hw, int timeout)
+{
+	while (timeout--) {
+		hw->ctrlReg = readl(hw->base + CTRL_REG);
+		if (!(hw->ctrlReg & JCORE_SPI_STAT_BUSY))
+			return;
+		cpu_relax();
+	}
+	dev_err(hw->master->dev.parent, "%s: Timeout..\n", __func__);
+}
+
+static void jcore_spi_program(struct jcore_spi *hw)
+{
+	jcore_spi_wait_till_ready(hw, JCORE_SPI_WAIT_RDY_MAX_LOOP);
+	writel(hw->csReg | hw->speedReg, hw->base + CTRL_REG);	
+}
+
+static void jcore_spi_chipsel(struct spi_device *spi, bool value)
+{
+	struct jcore_spi *hw = spi_master_get_devdata(spi->master);
+
+	dev_dbg(hw->master->dev.parent, "%s: CS=%d\n", __func__, value);
+
+	hw->csReg = JCORE_SPI_CTRL_CS_BITS ^ (!value << 2*spi->chip_select);
+
+	jcore_spi_program(hw);
+}
+
+static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
+{
+	if (speed == hw->speed_hz) return;
+	hw->speed_hz = speed;
+	hw->speedReg = ((MAX_SPI_SPEED / speed) - 1) << 27;
+	jcore_spi_program(hw);
+	dev_dbg(hw->master->dev.parent, "%s: speed=%d pre=0x%x\n",
+		__func__, speed, hw->speedReg);
+}
+
+static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi,
+			  struct spi_transfer *t)
+{
+	struct jcore_spi *hw = spi_master_get_devdata(master);
+
+	void *ctrl_reg = hw->base + CTRL_REG;
+	void *data_reg = hw->base + DATA_REG;
+	unsigned int timeout;
+	u32 xmit;
+	u32 status;
+
+	/* data buffers */
+	const unsigned char *tx;
+	unsigned char *rx;
+	unsigned int len;
+	unsigned int count;
+
+	jcore_spi_baudrate(hw, t->speed_hz);
+
+	xmit = hw->csReg | hw->speedReg | JCORE_SPI_CTRL_XMIT;
+	tx = t->tx_buf;
+	rx = t->rx_buf;
+	len = t->len;
+
+	for (count = 0; count < len; count++) {
+		timeout = JCORE_SPI_WAIT_RDY_MAX_LOOP;
+		do {
+			status = readl(ctrl_reg);
+		} while ((status & JCORE_SPI_STAT_BUSY) && --timeout);
+		if (!timeout)
+			break;
+
+		writel(tx ? *tx++ : 0, data_reg);
+		writel(xmit, ctrl_reg);
+
+		timeout = JCORE_SPI_WAIT_RDY_MAX_LOOP;
+		do {
+			status = readl(ctrl_reg);
+		} while ((status & JCORE_SPI_STAT_BUSY) && --timeout);
+		if (!timeout)
+			break;
+
+		if (rx)
+			*rx++ = readl(data_reg);
+	}
+
+	spi_finalize_current_transfer(master);
+
+	return count<len ? -EREMOTEIO : 0;
+}
+
+static int jcore_spi_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct jcore_spi *hw;
+	struct spi_master *master;
+	struct resource *res;
+	int err = -ENODEV;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct jcore_spi));
+	if (!master)
+		return err;
+
+	/* setup the master state. */
+	master->num_chipselect = 3;
+	master->mode_bits = SPI_MODE_3;
+	master->transfer_one = jcore_spi_txrx;
+	master->set_cs = jcore_spi_chipsel;
+	master->dev.of_node = node;
+
+	hw = spi_master_get_devdata(master);
+	hw->master = master;
+	platform_set_drvdata(pdev, hw);
+
+	/* find and map our resources */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto exit_busy;
+	if (!devm_request_mem_region
+	    (&pdev->dev, res->start, resource_size(res), pdev->name))
+		goto exit_busy;
+	hw->base =
+	    devm_ioremap_nocache(&pdev->dev, res->start, resource_size(res));
+	if (!hw->base)
+		goto exit_busy;
+
+	jcore_spi_baudrate(hw, 400000);
+
+	pdev->dev.dma_mask = 0;
+	/* register our spi controller */
+	err = devm_spi_register_master(&pdev->dev, master);
+	if (err)
+		goto exit;
+	dev_info(&pdev->dev, "base %p, noirq\n", hw->base);
+
+	return 0;
+
+exit_busy:
+	err = -EBUSY;
+exit:
+	platform_set_drvdata(pdev, NULL);
+	spi_master_put(master);
+	return err;
+}
+
+static const struct of_device_id jcore_spi_of_match[] = {
+	{ .compatible = "jcore,spi2" },
+	{},
+};
+
+static struct platform_driver jcore_spi_driver = {
+	.probe = jcore_spi_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = jcore_spi_of_match,
+	},
+};
+
+module_platform_driver(jcore_spi_driver);
+
+MODULE_DESCRIPTION("J-Core SPI driver");
+MODULE_AUTHOR("Rich Felker <dalias@libc.org>");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.8.1
