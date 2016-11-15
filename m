From: Gao Pan <pandy.gao-3arQi8VN3Tc@public.gmane.org>
Subject: [Patch V2 1/2] spi: imx: add lpspi bus driver
Date: Tue, 15 Nov 2016 21:33:50 +0800
Message-ID: <1479216831-8709-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <pandy.gao-3arQi8VN3Tc@public.gmane.org>,
        <frank.li-3arQi8VN3Tc@public.gmane.org>, <fugang.duan-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
V2:
 -use normal spi interface rather than bitbang

 drivers/spi/Kconfig         |   6 +
 drivers/spi/Makefile        |   1 +
 drivers/spi/spi-fsl-lpspi.c | 565 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 572 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6891091..ccce8fe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -264,6 +264,12 @@ config SPI_FALCON
 	  has only been tested with m25p80 type chips. The hardware has no
 	  support for other types of SPI peripherals.
 
+config SPI_FSL_LPSPI
+	tristate "Freescale i.MX LPSPI controller"
+	depends on ARCH_MXC || COMPILE_TEST
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
index 0000000..5bde871
--- /dev/null
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -0,0 +1,565 @@
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
+#define TRANLEN_MAX	0x10000 /* Max transaction length */
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
+	struct device *dev;
+	void __iomem *base;
+	struct clk *clk;
+
+	u8 *local_buf;
+	void *rx_buf;
+	const void *tx_buf;
+
+	void (*tx)(struct fsl_lpspi_data *);
+	void (*rx)(struct fsl_lpspi_data *);
+
+	u32 remain;
+	u8 txfifosize;
+	u8 rxfifosize;
+	struct lpspi_config config;
+	struct completion xfer_done;
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
+	temp &= ~TCR_CONTC;
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
+static void fsl_lpspi_setup_transfer(struct spi_device *spi,
+						struct spi_transfer *t)
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
+}
+
+static void fsl_lpspi_copy_to_buf(struct spi_message *m,
+					struct fsl_lpspi_data *fsl_lpspi)
+{
+	struct spi_transfer *t;
+	u8 *buf = fsl_lpspi->local_buf;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->tx_buf)
+			memcpy(buf, t->tx_buf, t->len);
+		else
+			memset(buf, 0, t->len);
+		buf += t->len;
+	}
+}
+
+static void fsl_lpspi_copy_from_buf(struct spi_message *m,
+					struct fsl_lpspi_data *fsl_lpspi)
+{
+	struct spi_transfer *t;
+	u8 *buf = fsl_lpspi->local_buf;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->rx_buf)
+			memcpy(t->rx_buf, buf, t->len);
+		buf += t->len;
+	}
+}
+
+static int fsl_lpspi_transfer(struct spi_message *m,
+				struct spi_transfer *transfer)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(m->spi->master);
+	struct spi_device *spi = m->spi;
+	int ret;
+
+	/* intergrate all transfers into one */
+	fsl_lpspi_copy_to_buf(m, fsl_lpspi);
+
+	fsl_lpspi_setup_transfer(spi, transfer);
+
+	fsl_lpspi->tx_buf = transfer->tx_buf;
+	fsl_lpspi->rx_buf = transfer->rx_buf;
+	fsl_lpspi->remain = transfer->len;
+	reinit_completion(&fsl_lpspi->xfer_done);
+
+	fsl_lpspi_set_cmd(fsl_lpspi);
+	fsl_lpspi_write_tx_fifo(fsl_lpspi);
+
+	ret = wait_for_completion_timeout(&fsl_lpspi->xfer_done, 2 * HZ);
+	if (!ret) {
+		dev_err(fsl_lpspi->dev, "wait for completion timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	fsl_lpspi_copy_from_buf(m, fsl_lpspi);
+
+	return 0;
+}
+
+static int fsl_lpspi_check_message(struct spi_message *m)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(m->spi->master);
+	struct spi_transfer *t, *first;
+
+	if (m->frame_length > TRANLEN_MAX) {
+		dev_err(fsl_lpspi->dev, "message too long, size is %u bytes\n",
+			m->frame_length);
+		return -EMSGSIZE;
+	}
+
+	first = list_first_entry(&m->transfers, struct spi_transfer,
+				transfer_list);
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (first->bits_per_word != t->bits_per_word ||
+				first->speed_hz != t->speed_hz) {
+			dev_err(fsl_lpspi->dev, "bits_per_word/speed_hz should be the same for all transfers\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
+					struct spi_message *m)
+{
+	struct fsl_lpspi_data *fsl_lpspi = spi_master_get_devdata(master);
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t, trans;
+	int ret;
+
+	dev_dbg(&spi->dev, "msg submitted for %s\n", dev_name(&spi->dev));
+
+	ret = fsl_lpspi_check_message(m);
+	if (ret)
+		goto out;
+
+	t = list_first_entry(&m->transfers, struct spi_transfer, transfer_list);
+
+	trans.len = m->frame_length;
+	trans.speed_hz = t->speed_hz;
+	trans.bits_per_word = t->bits_per_word;
+	trans.tx_buf = fsl_lpspi->local_buf;
+	trans.rx_buf = fsl_lpspi->local_buf;
+
+	if (trans.len)
+		ret = fsl_lpspi_transfer(m, &trans);
+
+	m->actual_length = ret ? 0 : trans.len;
+
+out:
+	if (m->status == -EINPROGRESS)
+		m->status = ret;
+
+	spi_finalize_current_message(master);
+
+	return ret;
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
+	fsl_lpspi->dev = &pdev->dev;
+
+	master->transfer_one_message = fsl_lpspi_transfer_one_msg;
+	master->prepare_message = fsl_lpspi_prepare_message;
+	master->unprepare_message = fsl_lpspi_unprepare_message;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	master->bus_num = pdev->id;
+	master->dev.of_node = pdev->dev.of_node;
+
+	init_completion(&fsl_lpspi->xfer_done);
+	fsl_lpspi->local_buf = devm_kmalloc(&pdev->dev, TRANLEN_MAX, GFP_KERNEL);
+	if (!fsl_lpspi->local_buf) {
+		ret = -ENOMEM;
+		goto out_master_put;
+	}
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
+	ret = devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
+			       dev_name(&pdev->dev), fsl_lpspi);
+	if (ret) {
+		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
+		goto out_master_put;
+	}
+
+	fsl_lpspi->clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk)) {
+		ret = PTR_ERR(fsl_lpspi->clk);
+		goto out_master_put;
+	}
+
+	ret = clk_prepare(fsl_lpspi->clk);
+	if (ret)
+		goto out_master_put;
+
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "spi_register_master error.\n");
+		goto clk_unprepare;
+	}
+
+	return 0;
+
+clk_unprepare:
+	clk_unprepare(fsl_lpspi->clk);
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
+	clk_unprepare(fsl_lpspi->clk);
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
