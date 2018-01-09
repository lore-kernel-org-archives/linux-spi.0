From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCHv1 2/3] spi: Add spi driver for Socionext Synquacer platform
Date: Tue,  9 Jan 2018 18:40:48 +0530
Message-ID: <1515503448-9025-1-git-send-email-jassisinghbrar@gmail.com>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515503383-8909-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This patch adds support for controller found on synquacer platforms.

Signed-off-by: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig         |  11 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-synquacer.c | 664 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 676 insertions(+)
 create mode 100644 drivers/spi/spi-synquacer.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6037839..9e04bbe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -659,6 +659,17 @@ config SPI_SUN6I
 	help
 	  This enables using the SPI controller on the Allwinner A31 SoCs.
 
+config SPI_SYNQUACER
+	tristate "Socionext's Synquacer HighSpeed SPI controller"
+	depends on ARCH_SYNQUACER || COMPILE_TEST
+	select SPI_BITBANG
+	help
+	  SPI driver for Socionext's High speed SPI controller which provides
+	  various operating modes for interfacing to serial peripheral devices
+	  that use the de-facto standard SPI protocol.
+
+	  It also supports the new dual-bit and quad-bit SPI protocol.
+
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
 	depends on ARCH_MXS
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 34c5f28..7c222f2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_SPI_STM32) 		+= spi-stm32.o
 obj-$(CONFIG_SPI_ST_SSC4)		+= spi-st-ssc4.o
 obj-$(CONFIG_SPI_SUN4I)			+= spi-sun4i.o
 obj-$(CONFIG_SPI_SUN6I)			+= spi-sun6i.o
+obj-$(CONFIG_SPI_SYNQUACER)		+= spi-synquacer.o
 obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o
 obj-$(CONFIG_SPI_TEGRA20_SFLASH)	+= spi-tegra20-sflash.o
 obj-$(CONFIG_SPI_TEGRA20_SLINK)		+= spi-tegra20-slink.o
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
new file mode 100644
index 0000000..c6a9139
--- /dev/null
+++ b/drivers/spi/spi-synquacer.c
@@ -0,0 +1,664 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synquacer HSSPI controller driver
+ *
+ * Copyright (c) 2015-2018 Socionext Inc.
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#define MCTRL		0x0
+#define MEN	BIT(0)
+#define CSEN	BIT(1)
+#define IPCLK	BIT(3)
+#define MES	BIT(4)
+#define SYNCON	BIT(5)
+
+#define PCC0		0x4
+#define PCC(n)		(PCC0 + (n) * 4)
+#define RTM	BIT(3)
+#define ACES	BIT(2)
+#define SAFESYNC	BIT(16)
+#define CPHA	BIT(0)
+#define CPOL	BIT(1)
+#define SSPOL	BIT(4)
+#define SDIR	BIT(7)
+#define SS2CD	5
+#define SENDIAN	BIT(8)
+#define CDRS_SHIFT	9
+#define CDRS_MASK	0x7f
+
+#define TXF		0x14
+#define TXE		0x18
+#define TXC		0x1c
+#define RXF		0x20
+#define RXE		0x24
+#define RXC		0x28
+
+#define FAULTF		0x2c
+#define FAULTC		0x30
+
+#define DMCFG		0x34
+#define SSDC		BIT(1)
+#define MSTARTEN	BIT(2)
+
+#define	DMSTART		0x38
+#define TRIGGER		BIT(0)
+#define DMSTOP		BIT(8)
+#define CS_MASK		3
+#define CS_SHIFT	16
+#define DATA_TXRX	0
+#define DATA_RX		1
+#define DATA_TX		2
+#define DATA_MASK	3
+#define DATA_SHIFT	26
+#define BUS_WIDTH	24
+
+#define	DMBCC		0x3c
+#define DMSTATUS	0x40
+#define RX_DATA_MASK	0x1f
+#define RX_DATA_SHIFT	8
+#define TX_DATA_MASK	0x1f
+#define TX_DATA_SHIFT	16
+
+#define TXBITCNT	0x44
+
+#define FIFOCFG		0x4c
+#define BPW_MASK	0x3
+#define BPW_SHIFT	8
+#define RX_FLUSH	BIT(11)
+#define TX_FLUSH	BIT(12)
+#define RX_TRSHLD_MASK		0xf
+#define RX_TRSHLD_SHIFT		0
+#define TX_TRSHLD_MASK		0xf
+#define TX_TRSHLD_SHIFT		4
+
+#define TXFIFO		0x50
+#define RXFIFO		0x90
+#define MID		0xfc
+
+#define FIFO_DEPTH	16
+#define TX_TRSHLD	4
+#define RX_TRSHLD	(FIFO_DEPTH - TX_TRSHLD)
+
+#define TXBIT	BIT(1)
+#define RXBIT	BIT(2)
+
+struct synquacer_spi {
+	spinlock_t lock;
+	struct device *dev;
+	struct spi_master *master;
+
+	unsigned int cs;
+	unsigned int bpw;
+	unsigned int busy;
+	unsigned int mode;
+	unsigned int speed;
+	bool aces, rtm;
+	void *rx_buf;
+	const void *tx_buf;
+	struct clk *clk;
+	void __iomem *regs;
+	unsigned int tx_words, rx_words;
+	unsigned int bus_width;
+	unsigned int old_transf_mode;
+};
+
+static void read_fifo(struct synquacer_spi *sspi)
+{
+	u32 len = readl_relaxed(sspi->regs + DMSTATUS);
+	int i;
+
+	len = (len >> RX_DATA_SHIFT) & RX_DATA_MASK;
+	len = min_t(unsigned int, len, sspi->rx_words);
+
+	switch (sspi->bpw) {
+	case 8:
+		{
+		u8 *buf = sspi->rx_buf;
+
+		for (i = 0; i < len; i++)
+			*buf++ = readb_relaxed(sspi->regs + RXFIFO);
+		sspi->rx_buf = buf;
+		break;
+		}
+	case 16:
+		{
+		u16 *buf = sspi->rx_buf;
+
+		for (i = 0; i < len; i++)
+			*buf++ = readw_relaxed(sspi->regs + RXFIFO);
+		sspi->rx_buf = buf;
+		break;
+		}
+	default:
+		{
+		u32 *buf = sspi->rx_buf;
+
+		for (i = 0; i < len; i++)
+			*buf++ = readl_relaxed(sspi->regs + RXFIFO);
+		sspi->rx_buf = buf;
+		break;
+		}
+	}
+
+	sspi->rx_words -= len;
+}
+
+static void write_fifo(struct synquacer_spi *sspi)
+{
+	u32 len = readl_relaxed(sspi->regs + DMSTATUS);
+	int i;
+
+	len = (len >> TX_DATA_SHIFT) & TX_DATA_MASK;
+	len = min_t(unsigned int, FIFO_DEPTH - len, sspi->tx_words);
+
+	switch (sspi->bpw) {
+	case 8:
+		{
+		const u8 *buf = sspi->tx_buf;
+
+		for (i = 0; i < len; i++)
+			writeb_relaxed(*buf++, sspi->regs + TXFIFO);
+		sspi->tx_buf = buf;
+		break;
+		}
+	case 16:
+		{
+		const u16 *buf = sspi->tx_buf;
+
+		for (i = 0; i < len; i++)
+			writew_relaxed(*buf++, sspi->regs + TXFIFO);
+		sspi->tx_buf = buf;
+		break;
+		}
+	default:
+		{
+		const u32 *buf = sspi->tx_buf;
+
+		for (i = 0; i < len; i++)
+			writel_relaxed(*buf++, sspi->regs + TXFIFO);
+		sspi->tx_buf = buf;
+		break;
+		}
+	}
+	sspi->tx_words -= len;
+}
+
+static int synquacer_spi_config(struct spi_master *master,
+				  struct spi_device *spi,
+				  struct spi_transfer *xfer)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	unsigned int speed, mode, bpw, cs, bus_width;
+	unsigned long rate, transf_mode;
+	u32 val, div;
+
+	/* Full Duplex only on 1bit wide bus */
+	if (xfer->rx_buf && xfer->tx_buf &&
+			(xfer->rx_nbits != 1 || xfer->tx_nbits != 1)) {
+		dev_err(sspi->dev, "RX and TX bus widths must match!\n");
+		return -EINVAL;
+	}
+
+	if (xfer->tx_buf) {
+		bus_width = xfer->tx_nbits;
+		transf_mode = TXBIT;
+	} else {
+		bus_width = xfer->rx_nbits;
+		transf_mode = RXBIT;
+	}
+
+	mode = spi->mode;
+	cs = spi->chip_select;
+	speed = xfer->speed_hz ? : spi->max_speed_hz;
+	bpw = xfer->bits_per_word ? : spi->bits_per_word;
+
+	/* return if nothing to change */
+	if (speed == sspi->speed &&
+			bus_width == sspi->bus_width && bpw == sspi->bpw &&
+			mode == sspi->mode && cs == sspi->cs &&
+			transf_mode == sspi->old_transf_mode) {
+		return 0;
+	}
+
+	rate = clk_get_rate(sspi->clk);
+
+	div = DIV_ROUND_UP(rate, speed);
+	if (div > 127) {
+		dev_err(sspi->dev, "Requested rate too low (%u)\n",
+			sspi->speed);
+		return -EINVAL;
+	}
+
+	if (xfer->tx_buf)
+		sspi->old_transf_mode = TXBIT;
+	else
+		sspi->old_transf_mode = RXBIT;
+
+	val = readl_relaxed(sspi->regs + PCC(cs));
+	val &= ~SAFESYNC;
+	if (bpw == 8 &&	(mode & (SPI_TX_DUAL | SPI_RX_DUAL)) && div < 3)
+		val |= SAFESYNC;
+	if (bpw == 8 &&	(mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 6)
+		val |= SAFESYNC;
+	if (bpw == 16 && (mode & (SPI_TX_QUAD | SPI_RX_QUAD)) && div < 3)
+		val |= SAFESYNC;
+
+	if (mode & SPI_CPHA)
+		val |= CPHA;
+	else
+		val &= ~CPHA;
+
+	if (mode & SPI_CPOL)
+		val |= CPOL;
+	else
+		val &= ~CPOL;
+
+	if (mode & SPI_CS_HIGH)
+		val |= SSPOL;
+	else
+		val &= ~SSPOL;
+
+	if (mode & SPI_LSB_FIRST)
+		val |= SDIR;
+	else
+		val &= ~SDIR;
+
+	if (sspi->aces)
+		val |= ACES;
+	else
+		val &= ~ACES;
+
+	if (sspi->rtm)
+		val |= RTM;
+	else
+		val &= ~RTM;
+
+	val |= (3 << SS2CD);
+	val |= SENDIAN;
+
+	val &= ~(CDRS_MASK << CDRS_SHIFT);
+	val |= ((div >> 1) << CDRS_SHIFT);
+
+	writel_relaxed(val, sspi->regs + PCC(cs));
+
+	val = readl_relaxed(sspi->regs + FIFOCFG);
+	val &= ~(BPW_MASK << BPW_SHIFT);
+	val |= ((bpw / 8 - 1) << BPW_SHIFT);
+	writel_relaxed(val, sspi->regs + FIFOCFG);
+
+	val = readl_relaxed(sspi->regs + DMSTART);
+	val &= ~(DATA_MASK << DATA_SHIFT);
+
+	if (xfer->tx_buf && xfer->rx_buf)
+		val |= (DATA_TXRX << DATA_SHIFT);
+	else if (xfer->rx_buf)
+		val |= (DATA_RX << DATA_SHIFT);
+	else
+		val |= (DATA_TX << DATA_SHIFT);
+
+	val &= ~(3 << BUS_WIDTH);
+	val |= ((bus_width >> 1) << BUS_WIDTH);
+	writel_relaxed(val, sspi->regs + DMSTART);
+
+	sspi->bpw = bpw;
+	sspi->mode = mode;
+	sspi->speed = speed;
+	sspi->cs = spi->chip_select;
+	sspi->bus_width = bus_width;
+
+	return 0;
+}
+
+static int synquacer_spi_transfer_one(struct spi_master *master,
+				  struct spi_device *spi,
+				  struct spi_transfer *xfer)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	unsigned long bpw, flags;
+	int ret, words;
+	u32 val;
+
+	val = readl_relaxed(sspi->regs + FIFOCFG);
+	val |= RX_FLUSH;
+	val |= TX_FLUSH;
+	writel_relaxed(val, sspi->regs + FIFOCFG);
+
+	/* See if we can transfer 4-bytes as 1 word even if not asked */
+	bpw = xfer->bits_per_word ? : spi->bits_per_word;
+	if (bpw == 8 && !(xfer->len % 4) && !(spi->mode & SPI_LSB_FIRST)) {
+		bpw = xfer->bits_per_word;
+		xfer->bits_per_word = 32;
+	} else {
+		bpw = xfer->bits_per_word;
+	}
+
+	ret = synquacer_spi_config(master, spi, xfer);
+	if (ret) {
+		xfer->bits_per_word = bpw;
+		return ret;
+	}
+	sspi->tx_buf = xfer->tx_buf;
+	sspi->rx_buf = xfer->rx_buf;
+
+	if (sspi->bpw == 8)
+		words = xfer->len / 1;
+	else if (sspi->bpw == 16)
+		words = xfer->len / 2;
+	else
+		words = xfer->len / 4;
+
+	spin_lock_irqsave(&sspi->lock, flags);
+	if (xfer->tx_buf) {
+		sspi->busy |= TXBIT;
+		sspi->tx_words = words;
+	} else {
+		sspi->busy &= ~TXBIT;
+		sspi->tx_words = 0;
+	}
+
+	if (xfer->rx_buf) {
+		sspi->busy |= RXBIT;
+		sspi->rx_words = words;
+	} else {
+		sspi->busy &= ~RXBIT;
+		sspi->rx_words = 0;
+	}
+	spin_unlock_irqrestore(&sspi->lock, flags);
+
+	if (xfer->tx_buf)
+		write_fifo(sspi);
+
+	if (xfer->rx_buf) {
+		val = readl_relaxed(sspi->regs + FIFOCFG);
+		val &= ~(RX_TRSHLD_MASK << RX_TRSHLD_SHIFT);
+		val |= ((sspi->rx_words > FIFO_DEPTH ?
+			RX_TRSHLD : sspi->rx_words) << RX_TRSHLD_SHIFT);
+		writel_relaxed(val, sspi->regs + FIFOCFG);
+	}
+
+	writel_relaxed(~0, sspi->regs + TXC);
+	writel_relaxed(~0, sspi->regs + RXC);
+
+	/* Trigger */
+	val = readl_relaxed(sspi->regs + DMSTART);
+	val |= TRIGGER;
+	writel_relaxed(val, sspi->regs + DMSTART);
+
+	while (sspi->busy & (RXBIT | TXBIT)) {
+		if (sspi->rx_words)
+			read_fifo(sspi);
+		else
+			sspi->busy &= ~RXBIT;
+
+		if (sspi->tx_words)
+			write_fifo(sspi);
+		else {
+			u32 len;
+
+			do { /* wait for shifter to empty out */
+				cpu_relax();
+				len = readl_relaxed(sspi->regs + DMSTATUS);
+				len = (len >> TX_DATA_SHIFT) & TX_DATA_MASK;
+			} while (xfer->tx_buf && len);
+			sspi->busy &= ~TXBIT;
+		}
+	}
+
+	/* restore */
+	xfer->bits_per_word = bpw;
+
+	return 0;
+}
+
+static void synquacer_spi_set_cs(struct spi_device *spi, bool enable)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(spi->master);
+	u32 val;
+
+	val = readl_relaxed(sspi->regs + DMSTART);
+	val &= ~(CS_MASK << CS_SHIFT);
+	val |= spi->chip_select << CS_SHIFT;
+
+	if (!enable) {
+		writel_relaxed(val, sspi->regs + DMSTART);
+
+		val = readl_relaxed(sspi->regs + DMSTART);
+		val &= ~DMSTOP;
+		writel_relaxed(val, sspi->regs + DMSTART);
+	} else {
+		val |= DMSTOP;
+		writel_relaxed(val, sspi->regs + DMSTART);
+
+		if (sspi->rx_buf) {
+			u32 buf[16];
+
+			sspi->rx_buf = buf;
+			sspi->rx_words = 16;
+			read_fifo(sspi);
+		}
+	}
+}
+
+static int synquacer_spi_enable(struct spi_master *master)
+{
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	u32 val;
+
+	/* Disable module */
+	writel_relaxed(0, sspi->regs + MCTRL);
+	val = 0xfffff;
+	while (--val && (readl_relaxed(sspi->regs + MCTRL) & MES))
+		cpu_relax();
+	if (!val)
+		return -EBUSY;
+
+	writel_relaxed(0, sspi->regs + TXE);
+	writel_relaxed(0, sspi->regs + RXE);
+	val = readl_relaxed(sspi->regs + TXF);
+	writel_relaxed(val, sspi->regs + TXC);
+	val = readl_relaxed(sspi->regs + RXF);
+	writel_relaxed(val, sspi->regs + RXC);
+	val = readl_relaxed(sspi->regs + FAULTF);
+	writel_relaxed(val, sspi->regs + FAULTC);
+
+	val = readl_relaxed(sspi->regs + DMCFG);
+	val &= ~SSDC;
+	val &= ~MSTARTEN;
+	writel_relaxed(val, sspi->regs + DMCFG);
+
+	val = readl_relaxed(sspi->regs + MCTRL);
+	if (!strcmp(__clk_get_name(sspi->clk), "iHCLK"))
+		val &= ~IPCLK;
+	else
+		val |= IPCLK;
+
+	val &= ~CSEN;
+	val |= MEN;
+	val |= SYNCON;
+	writel_relaxed(val, sspi->regs + MCTRL);
+
+	return 0;
+}
+
+static int synquacer_spi_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct spi_master *master;
+	struct synquacer_spi *sspi;
+	struct resource *res;
+	u32 num_cs = 1;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
+	if (!master)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, master);
+
+	sspi = spi_master_get_devdata(master);
+	sspi->dev = &pdev->dev;
+	sspi->master = master;
+	spin_lock_init(&sspi->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sspi->regs = devm_ioremap_resource(sspi->dev, res);
+	if (IS_ERR(sspi->regs)) {
+		ret = PTR_ERR(sspi->regs);
+		goto put_spi;
+	}
+
+	sspi->clk = devm_clk_get(sspi->dev, "iHCLK");
+	if (IS_ERR(sspi->clk)) {
+		sspi->clk = devm_clk_get(sspi->dev, "iPCLK");
+		if (IS_ERR(sspi->clk)) {
+			dev_err(&pdev->dev, "No source clock\n");
+			ret = PTR_ERR(sspi->clk);
+			goto put_spi;
+		}
+	}
+
+	sspi->aces = of_property_read_bool(np, "socionext,set-aces");
+	sspi->rtm = of_property_read_bool(np, "socionext,use-rtm");
+
+	of_property_read_u32(np, "num-cs", &num_cs);
+	master->num_chipselect = num_cs;
+
+	ret = clk_prepare_enable(sspi->clk);
+	if (ret)
+		goto put_spi;
+
+	master->dev.of_node = np;
+	master->auto_runtime_pm = true;
+	master->bus_num = pdev->id;
+
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
+				SPI_TX_QUAD | SPI_RX_QUAD;
+	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24)
+					 | SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
+	master->max_speed_hz = clk_get_rate(sspi->clk);
+	master->min_speed_hz = master->max_speed_hz / 254;
+
+	master->set_cs = synquacer_spi_set_cs;
+	master->transfer_one = synquacer_spi_transfer_one;
+
+	ret = synquacer_spi_enable(master);
+	if (ret)
+		goto fail_enable;
+
+	pm_runtime_set_active(sspi->dev);
+	pm_runtime_enable(sspi->dev);
+
+	ret = devm_spi_register_master(sspi->dev, master);
+	if (ret)
+		goto disable_pm;
+
+	return 0;
+
+disable_pm:
+	pm_runtime_disable(sspi->dev);
+fail_enable:
+	clk_disable_unprepare(sspi->clk);
+put_spi:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int synquacer_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+
+	pm_runtime_disable(sspi->dev);
+	clk_disable_unprepare(sspi->clk);
+	spi_master_put(master);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int synquacer_spi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		clk_disable_unprepare(sspi->clk);
+
+	return ret;
+}
+
+static int synquacer_spi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct synquacer_spi *sspi = spi_master_get_devdata(master);
+	int ret;
+
+	if (!pm_runtime_suspended(dev)) {
+		/* Ensure reconfigure during next xfer */
+		sspi->speed = 0;
+
+		ret = clk_prepare_enable(sspi->clk);
+		if (ret < 0) {
+			dev_err(dev, "failed to enable clk (%d)\n", ret);
+			return ret;
+		}
+
+		ret = synquacer_spi_enable(master);
+		if (ret) {
+			dev_err(dev, "failed to enable spi (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	ret = spi_master_resume(master);
+	if (ret < 0)
+		clk_disable_unprepare(sspi->clk);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops synquacer_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(synquacer_spi_suspend, synquacer_spi_resume)
+};
+
+static const struct of_device_id synquacer_spi_of_match[] = {
+	{.compatible = "socionext,synquacer-spi",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, synquacer_spi_of_match);
+
+static struct platform_driver synquacer_spi_driver = {
+	.driver = {
+		.name = "synquacer-spi",
+		.pm = &synquacer_spi_pm_ops,
+		.of_match_table = of_match_ptr(synquacer_spi_of_match),
+	},
+	.probe = synquacer_spi_probe,
+	.remove = synquacer_spi_remove,
+};
+module_platform_driver(synquacer_spi_driver);
+
+MODULE_DESCRIPTION("Socionext Synquacer HS-SPI controller driver");
+MODULE_AUTHOR("Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
