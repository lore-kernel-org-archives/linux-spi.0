From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch v1 1/2] spi: imx: add lpspi bus driver
Date: Mon, 14 Nov 2016 13:22:46 +0800
Message-ID: <1479100967-1894-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds lpspi driver to support new i.MX products which use
lpspi instead of ecspi.

The lpspi can continue operating in stop mode when an appropriate
clock is available. It is also designed for low CPU overhead with
DMA offloading of FIFO register accesses.

Signed-off-by: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Reviewed-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/Kconfig         |   7 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-fsl-lpspi.c | 474 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 482 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6891091..ec71ff1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -264,6 +264,13 @@ config SPI_FALCON
 	  has only been tested with m25p80 type chips. The hardware has no
 	  support for other types of SPI peripherals.
 
+config SPI_FSL_LPSPI
+	tristate "Freescale i.MX LPSPI controller"
+	depends on ARCH_MXC || COMPILE_TEST
+	select SPI_BITBANG
+	help
+	  This enables Freescale i.MX LPSPI controllers in master mode.
+
 config SPI_GPIO
 	tristate "GPIO-based bitbanging SPI Master"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index aa939d9..1e890d9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SPI_FSL_CPM)		+= spi-fsl-cpm.o
 obj-$(CONFIG_SPI_FSL_DSPI)		+= spi-fsl-dspi.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
 obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
+obj-$(CONFIG_SPI_FSL_LPSPI)		+= spi-fsl-lpspi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
 obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
new file mode 100644
index 0000000..b6bbb3c
--- /dev/null
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -0,0 +1,474 @@
+/*
+ * Freescale i.MX7ULP LPSPI driver
+ *
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/types.h>
+
+#define DRIVER_NAME "fsl_lpspi"
+
+/* i.MX7ULP LPSPI registers */
+#define IMX7ULP_VERID	0x0
+#define IMX7ULP_PARAM	0x4
+#define IMX7ULP_CR	0x10
+#define IMX7ULP_SR	0x14
+#define IMX7ULP_IER	0x18
+#define IMX7ULP_DER	0x1c
+#define IMX7ULP_CFGR0	0x20
+#define IMX7ULP_CFGR1	0x24
+#define IMX7ULP_DMR0	0x30
+#define IMX7ULP_DMR1	0x34
+#define IMX7ULP_CCR	0x40
+#define IMX7ULP_FCR	0x58
+#define IMX7ULP_FSR	0x5c
+#define IMX7ULP_TCR	0x60
+#define IMX7ULP_TDR	0x64
+#define IMX7ULP_RSR	0x70
+#define IMX7ULP_RDR	0x74
+
+/* General control register field define */
+#define CR_RRF		BIT(9)
+#define CR_RTF		BIT(8)
+#define CR_RST		BIT(1)
+#define CR_MEN		BIT(0)
+#define SR_TCF		BIT(10)
+#define SR_RDF		BIT(1)
+#define SR_TDF		BIT(0)
+#define IER_TCIE	BIT(10)
+#define IER_RDIE	BIT(1)
+#define IER_TDIE	BIT(0)
+#define CFGR1_PCSCFG	BIT(27)
+#define CFGR1_PCSPOL	BIT(8)
+#define CFGR1_NOSTALL	BIT(3)
+#define CFGR1_MASTER	BIT(0)
+#define RSR_RXEMPTY	BIT(1)
+#define TCR_CPOL	BIT(31)
+#define TCR_CPHA	BIT(30)
+#define TCR_CONT	BIT(21)
+#define TCR_CONTC	BIT(20)
+#define TCR_RXMSK	BIT(19)
+#define TCR_TXMSK	BIT(18)
+
+static int clkdivs[] = {1, 2, 4, 8, 16, 32, 64, 128};
+
+struct lpspi_config {
+	u8 bpw;
+	u8 chip_select;
+	u8 prescale;
+	u16 mode;
+	u32 speed_hz;
+};
+
+struct fsl_lpspi_data {
+	struct spi_bitbang bitbang;
+	struct device *dev;
+
+	struct completion xfer_done;
+	void __iomem *base;
+	struct clk *clk;
+
+	void *rx_buf;
+	const void *tx_buf;
+	void (*tx)(struct fsl_lpspi_data *);
+	void (*rx)(struct fsl_lpspi_data *);
+	struct lpspi_config config;
+
+	u8 txfifosize;
+	u8 rxfifosize;
+	u32 remain;
+};
+
+static const struct of_device_id fsl_lpspi_dt_ids[] = {
+	{ .compatible = "fsl,imx7ulp-spi", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);
+
+#define LPSPI_BUF_RX(type)						\
+static void fsl_lpspi_buf_rx_##type(struct fsl_lpspi_data *fsl_lpspi)	\
+{									\
+	unsigned int val = readl(fsl_lpspi->base + IMX7ULP_RDR);	\
+									\
+	if (fsl_lpspi->rx_buf) {					\
+		*(type *)fsl_lpspi->rx_buf = val;			\
+		fsl_lpspi->rx_buf += sizeof(type);                      \
+	}								\
+}
+
+#define LPSPI_BUF_TX(type)						\
+static void fsl_lpspi_buf_tx_##type(struct fsl_lpspi_data *fsl_lpspi)	\
+{									\
+	type val = 0;							\
+									\
+	if (fsl_lpspi->tx_buf) {					\
+		val = *(type *)fsl_lpspi->tx_buf;			\
+		fsl_lpspi->tx_buf += sizeof(type);			\
+	}								\
+									\
+	fsl_lpspi->remain -= sizeof(type);				\
+	writel(val, fsl_lpspi->base + IMX7ULP_TDR);			\
+}
+
+LPSPI_BUF_RX(u8)
+LPSPI_BUF_TX(u8)
+LPSPI_BUF_RX(u16)
+LPSPI_BUF_TX(u16)
+LPSPI_BUF_RX(u32)
+LPSPI_BUF_TX(u32)
+
+static void fsl_lpspi_intctrl(
+		struct fsl_lpspi_data *fsl_lpspi, unsigned int enable)
+{
+	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
+}
+
+static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u8 txfifo_cnt;
+	u32 temp;
+
+	txfifo_cnt = readl(fsl_lpspi->base + IMX7ULP_FSR) & 0xff;
+
+	while (txfifo_cnt < fsl_lpspi->txfifosize) {
+		if (!fsl_lpspi->remain)
+			break;
+		fsl_lpspi->tx(fsl_lpspi);
+		txfifo_cnt++;
+	}
+
+	if (txfifo_cnt < fsl_lpspi->txfifosize) {
+		temp = readl(fsl_lpspi->base + IMX7ULP_TCR);
+		temp &= ~TCR_CONTC;
+		writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+
+		fsl_lpspi_intctrl(fsl_lpspi, IER_TCIE);
+	} else {
+		fsl_lpspi_intctrl(fsl_lpspi, IER_TDIE);
+	}
+}
+
+static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_data *fsl_lpspi)
+{
+	while (!(readl(fsl_lpspi->base + IMX7ULP_RSR) & RSR_RXEMPTY))
+		fsl_lpspi->rx(fsl_lpspi);
+}
+
+static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u32 temp = 0;
+
+	temp |= TCR_CONT;
+	temp |= fsl_lpspi->config.bpw - 1;
+	temp |= fsl_lpspi->config.prescale << 27;
+	temp |= (fsl_lpspi->config.mode & 0x11) << 30;
+	temp |= (fsl_lpspi->config.chip_select & 0x3) << 24;
+
+	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+
+	dev_dbg(fsl_lpspi->dev, "TCR=0x%x\n", temp);
+}
+
+static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u8 txwatermark, rxwatermark;
+	u32 temp;
+
+	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
+	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
+	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
+	rxwatermark = fsl_lpspi->txfifosize >> 1;
+	txwatermark = fsl_lpspi->rxfifosize >> 1;
+	temp = txwatermark | rxwatermark << 16;
+
+	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
+
+	dev_dbg(fsl_lpspi->dev, "FCR=0x%x\n", temp);
+}
+
+static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
+{
+	struct lpspi_config config = fsl_lpspi->config;
+	unsigned int perclk_rate, scldiv;
+	u8 prescale;
+
+	perclk_rate = clk_get_rate(fsl_lpspi->clk);
+	for (prescale = 0; prescale < 8; prescale++) {
+		scldiv = perclk_rate / (clkdivs[prescale] * config.speed_hz) - 2;
+		if (scldiv < 256) {
+			fsl_lpspi->config.prescale = prescale;
+			break;
+		}
+	}
+
+	if (prescale == 8 && scldiv >= 256)
+		return -EINVAL;
+
+	writel(scldiv, fsl_lpspi->base + IMX7ULP_CCR);
+
+	dev_dbg(fsl_lpspi->dev, "perclk=%d, speed=%d, prescale =%d, scldiv=%d\n",
+			perclk_rate, config.speed_hz, prescale, scldiv);
+
+	return 0;
+}
+
+static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
+{
+	u32 temp;
+	int ret;
+
+	temp = CR_RST;
+	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
+	writel(0, fsl_lpspi->base + IMX7ULP_CR);
+
+	ret = fsl_lpspi_set_bitrate(fsl_lpspi);
+	if (ret)
+		return ret;
+
+	fsl_lpspi_set_watermark(fsl_lpspi);
+
+	temp = CFGR1_PCSCFG | CFGR1_MASTER | CFGR1_NOSTALL;
+	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
+		temp |= CFGR1_PCSPOL;
+	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
+
+	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
+	temp |= CR_RRF | CR_RTF | CR_MEN;
+	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
+
+	return 0;
+}
+
+static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
+{
+	struct fsl_lpspi_data *fsl_lpspi = dev_id;
+	u32 temp;
+
+	fsl_lpspi_intctrl(fsl_lpspi, 0);
+	temp = readl(fsl_lpspi->base + IMX7ULP_SR);
+
+	fsl_lpspi_read_rx_fifo(fsl_lpspi);
+
+	if ((temp & SR_TDF) && !(temp & SR_TCF)) {
+		fsl_lpspi_write_tx_fifo(fsl_lpspi);
+		return IRQ_HANDLED;
+	}
+
+	if (temp & SR_TCF) {
+		complete(&fsl_lpspi->xfer_done);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int fsl_lpspi_setupxfer(struct spi_device *spi,
+					struct spi_transfer *t)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(spi->master);
+
+	fsl_lpspi->config.mode = spi->mode;
+	fsl_lpspi->config.bpw = t ? t->bits_per_word : spi->bits_per_word;
+	fsl_lpspi->config.speed_hz = t ? t->speed_hz : spi->max_speed_hz;
+	fsl_lpspi->config.chip_select = spi->chip_select;
+
+	if (!fsl_lpspi->config.speed_hz)
+		fsl_lpspi->config.speed_hz = spi->max_speed_hz;
+	if (!fsl_lpspi->config.bpw)
+		fsl_lpspi->config.bpw = spi->bits_per_word;
+
+	/* Initialize the functions for transfer */
+	if (fsl_lpspi->config.bpw <= 8) {
+		fsl_lpspi->rx = fsl_lpspi_buf_rx_u8;
+		fsl_lpspi->tx = fsl_lpspi_buf_tx_u8;
+	} else if (fsl_lpspi->config.bpw <= 16) {
+		fsl_lpspi->rx = fsl_lpspi_buf_rx_u16;
+		fsl_lpspi->tx = fsl_lpspi_buf_tx_u16;
+	} else {
+		fsl_lpspi->rx = fsl_lpspi_buf_rx_u32;
+		fsl_lpspi->tx = fsl_lpspi_buf_tx_u32;
+	}
+
+	fsl_lpspi_config(fsl_lpspi);
+
+	return 0;
+}
+
+static int fsl_lpspi_transfer(struct spi_device *spi,
+				struct spi_transfer *transfer)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(spi->master);
+
+	fsl_lpspi->tx_buf = transfer->tx_buf;
+	fsl_lpspi->rx_buf = transfer->rx_buf;
+	fsl_lpspi->remain = transfer->len;
+
+	reinit_completion(&fsl_lpspi->xfer_done);
+	fsl_lpspi_set_cmd(fsl_lpspi);
+	fsl_lpspi_write_tx_fifo(fsl_lpspi);
+	wait_for_completion(&fsl_lpspi->xfer_done);
+
+	return transfer->len;
+}
+
+/* The following empty functions are decided by spi framework */
+static void fsl_lpspi_chipselect(struct spi_device *spi, int is_active)
+{
+}
+
+static int fsl_lpspi_setup(struct spi_device *spi)
+{
+	return 0;
+}
+
+static void fsl_lpspi_cleanup(struct spi_device *spi)
+{
+}
+
+static int
+fsl_lpspi_prepare_message(struct spi_master *master, struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+
+	return clk_enable(fsl_lpspi->clk);
+}
+
+static int
+fsl_lpspi_unprepare_message(struct spi_master *master, struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+
+	clk_disable(fsl_lpspi->clk);
+
+	return 0;
+}
+
+static int fsl_lpspi_probe(struct platform_device *pdev)
+{
+	struct fsl_lpspi_data *fsl_lpspi;
+	struct spi_master *master;
+	struct resource *res;
+	int ret, irq;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_lpspi_data));
+	if (!master)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, master);
+
+	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	master->bus_num = pdev->id;
+
+	fsl_lpspi = spi_master_get_devdata(master);
+	fsl_lpspi->bitbang.master = master;
+	fsl_lpspi->dev = &pdev->dev;
+
+	fsl_lpspi->bitbang.chipselect = fsl_lpspi_chipselect;
+	fsl_lpspi->bitbang.master->setup = fsl_lpspi_setup;
+	fsl_lpspi->bitbang.master->cleanup = fsl_lpspi_cleanup;
+	fsl_lpspi->bitbang.setup_transfer = fsl_lpspi_setupxfer;
+	fsl_lpspi->bitbang.txrx_bufs = fsl_lpspi_transfer;
+	fsl_lpspi->bitbang.master->prepare_message = fsl_lpspi_prepare_message;
+	fsl_lpspi->bitbang.master->unprepare_message = fsl_lpspi_unprepare_message;
+	fsl_lpspi->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	fsl_lpspi->bitbang.master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+
+	init_completion(&fsl_lpspi->xfer_done);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	fsl_lpspi->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fsl_lpspi->base)) {
+		ret = PTR_ERR(fsl_lpspi->base);
+		goto out_master_put;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto out_master_put;
+	}
+
+	fsl_lpspi->clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk)) {
+		ret = PTR_ERR(fsl_lpspi->clk);
+		goto out_master_put;
+	}
+
+	master->dev.of_node = pdev->dev.of_node;
+	ret = spi_bitbang_start(&fsl_lpspi->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		goto out_master_put;
+	}
+
+	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
+			       dev_name(&pdev->dev), fsl_lpspi);
+	if (ret) {
+		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
+		goto out_master_put;
+	}
+
+	ret = clk_prepare(fsl_lpspi->clk);
+	if (ret)
+		goto out_master_put;
+
+	return ret;
+
+out_master_put:
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int fsl_lpspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+
+	spi_bitbang_stop(&fsl_lpspi->bitbang);
+
+	clk_unprepare(fsl_lpspi->clk);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static struct platform_driver fsl_lpspi_driver = {
+	.driver = {
+		   .name = DRIVER_NAME,
+		   .of_match_table = fsl_lpspi_dt_ids,
+		   },
+	.probe = fsl_lpspi_probe,
+	.remove = fsl_lpspi_remove,
+};
+module_platform_driver(fsl_lpspi_driver);
+
+MODULE_DESCRIPTION("LPSPI Master Controller driver");
+MODULE_AUTHOR("Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
