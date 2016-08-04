From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: add driver for J-Core SPI controller" to the spi tree
Date: Thu, 04 Aug 2016 22:09:29 +0100
Message-ID: <E1bVPtR-0007N8-Kf@debutante>
References: <a452a1588abbfb1f69390a6b882ea27a449b2391.1470187592.git.dalias@libc.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
To: Rich Felker <dalias@libc.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <a452a1588abbfb1f69390a6b882ea27a449b2391.1470187592.git.dalias@libc.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: add driver for J-Core SPI controller

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

>From 711e5a5a28a0ce47c1b8ad54f0abda5c651e6c7b Mon Sep 17 00:00:00 2001
From: Rich Felker <dalias@libc.org>
Date: Thu, 4 Aug 2016 04:30:37 +0000
Subject: [PATCH] spi: add driver for J-Core SPI controller

The J-Core "spi2" device is a PIO-based SPI master controller. It
differs from "bitbang" devices in that that it's clocked in hardware
rather than via soft clock modulation over gpio, and performs
byte-at-a-time transfers between the cpu and SPI controller.

This driver will be extended to support future versions of the J-Core
SPI controller with DMA transfers when they become available.

Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig     |   7 ++
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-jcore.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/spi/spi-jcore.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6fb8d4b7786..1abb3d767390 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -285,6 +285,13 @@ config SPI_IMX
 	  This enables using the Freescale i.MX SPI controllers in master
 	  mode.
 
+config SPI_JCORE
+	tristate "J-Core SPI Master"
+	depends on OF && (SUPERH || COMPILE_TEST)
+	help
+	  This enables support for the SPI master controller in the J-Core
+	  synthesizable, open source SoC.
+
 config SPI_LM70_LLP
 	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
 	depends on PARPORT
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 185367ef6576..8715fec8cffa 100644
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
index 000000000000..7d2044a106a2
--- /dev/null
+++ b/drivers/spi/spi-jcore.c
@@ -0,0 +1,232 @@
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
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+
+#define DRV_NAME	"jcore_spi"
+
+#define CTRL_REG	0x0
+#define DATA_REG	0x4
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
+	unsigned int cs_reg;
+	unsigned int speed_reg;
+	unsigned int speed_hz;
+	unsigned int clock_freq;
+};
+
+static int jcore_spi_wait(void __iomem *ctrl_reg)
+{
+	unsigned timeout = JCORE_SPI_WAIT_RDY_MAX_LOOP;
+
+	do {
+		if (!(readl(ctrl_reg) & JCORE_SPI_STAT_BUSY))
+			return 0;
+		cpu_relax();
+	} while (--timeout);
+
+	return -EBUSY;
+}
+
+static void jcore_spi_program(struct jcore_spi *hw)
+{
+	void __iomem *ctrl_reg = hw->base + CTRL_REG;
+
+	if (jcore_spi_wait(ctrl_reg))
+		dev_err(hw->master->dev.parent,
+			"timeout waiting to program ctrl reg.\n");
+
+	writel(hw->cs_reg | hw->speed_reg, ctrl_reg);
+}
+
+static void jcore_spi_chipsel(struct spi_device *spi, bool value)
+{
+	struct jcore_spi *hw = spi_master_get_devdata(spi->master);
+	u32 csbit = 1U << (2 * spi->chip_select);
+
+	dev_dbg(hw->master->dev.parent, "chipselect %d\n", spi->chip_select);
+
+	if (value)
+		hw->cs_reg |= csbit;
+	else
+		hw->cs_reg &= ~csbit;
+
+	jcore_spi_program(hw);
+}
+
+static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
+{
+	if (speed == hw->speed_hz) return;
+	hw->speed_hz = speed;
+	if (speed >= hw->clock_freq / 2)
+		hw->speed_reg = 0;
+	else
+		hw->speed_reg = ((hw->clock_freq / 2 / speed) - 1) << 27;
+	jcore_spi_program(hw);
+	dev_dbg(hw->master->dev.parent, "speed=%d reg=0x%x\n",
+		speed, hw->speed_reg);
+}
+
+static int jcore_spi_txrx(struct spi_master *master, struct spi_device *spi,
+			  struct spi_transfer *t)
+{
+	struct jcore_spi *hw = spi_master_get_devdata(master);
+
+	void __iomem *ctrl_reg = hw->base + CTRL_REG;
+	void __iomem *data_reg = hw->base + DATA_REG;
+	u32 xmit;
+
+	/* data buffers */
+	const unsigned char *tx;
+	unsigned char *rx;
+	unsigned int len;
+	unsigned int count;
+
+	jcore_spi_baudrate(hw, t->speed_hz);
+
+	xmit = hw->cs_reg | hw->speed_reg | JCORE_SPI_CTRL_XMIT;
+	tx = t->tx_buf;
+	rx = t->rx_buf;
+	len = t->len;
+
+	for (count = 0; count < len; count++) {
+		if (jcore_spi_wait(ctrl_reg))
+			break;
+
+		writel(tx ? *tx++ : 0, data_reg);
+		writel(xmit, ctrl_reg);
+
+		if (jcore_spi_wait(ctrl_reg))
+			break;
+
+		if (rx)
+			*rx++ = readl(data_reg);
+	}
+
+	spi_finalize_current_transfer(master);
+
+	if (count < len)
+		return -EREMOTEIO;
+
+	return 0;
+}
+
+static int jcore_spi_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct jcore_spi *hw;
+	struct spi_master *master;
+	struct resource *res;
+	u32 clock_freq;
+	struct clk *clk;
+	int err = -ENODEV;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct jcore_spi));
+	if (!master)
+		return err;
+
+	/* Setup the master state. */
+	master->num_chipselect = 3;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->transfer_one = jcore_spi_txrx;
+	master->set_cs = jcore_spi_chipsel;
+	master->dev.of_node = node;
+	master->bus_num = pdev->id;
+
+	hw = spi_master_get_devdata(master);
+	hw->master = master;
+	platform_set_drvdata(pdev, hw);
+
+	/* Find and map our resources */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto exit_busy;
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), pdev->name))
+		goto exit_busy;
+	hw->base = devm_ioremap_nocache(&pdev->dev, res->start,
+					resource_size(res));
+	if (!hw->base)
+		goto exit_busy;
+
+	/*
+	 * The SPI clock rate controlled via a configurable clock divider
+	 * which is applied to the reference clock. A 50 MHz reference is
+	 * most suitable for obtaining standard SPI clock rates, but some
+	 * designs may have a different reference clock, and the DT must
+	 * make the driver aware so that it can properly program the
+	 * requested rate. If the clock is omitted, 50 MHz is assumed.
+	 */
+	clock_freq = 50000000;
+	clk = devm_clk_get(&pdev->dev, "ref_clk");
+	if (!IS_ERR_OR_NULL(clk)) {
+		if (clk_enable(clk) == 0)
+			clock_freq = clk_get_rate(clk);
+		else
+			dev_warn(&pdev->dev, "could not enable ref_clk\n");
+	}
+	hw->clock_freq = clock_freq;
+
+	/* Initialize all CS bits to high. */
+	hw->cs_reg = JCORE_SPI_CTRL_CS_BITS;
+	jcore_spi_baudrate(hw, 400000);
+
+	/* Register our spi controller */
+	err = devm_spi_register_master(&pdev->dev, master);
+	if (err)
+		goto exit;
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
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.8.1

