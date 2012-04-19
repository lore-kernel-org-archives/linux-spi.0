From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: Add initial support for spi-mxs
Date: Wed, 18 Apr 2012 21:30:34 -0300
Message-ID: <1334795434-8780-2-git-send-email-festevam@gmail.com>
References: <1334795434-8780-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, snijsure-4jo+YWezP1RWk0Htik3J/w@public.gmane.org,
	marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334795434-8780-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add initial support for the spi driver on mxs processors.

Currently only PIO mode is supported.

Tested with a sst25vf016b spi flash on a mx28evk board using mtd-utils.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
It still does not contain DT support, but I wanted to post it as is, so
that people can test it and I would also like to get some initial feedback.

 arch/arm/mach-mxs/include/mach/ssp-regs.h |   32 ++
 drivers/spi/Kconfig                       |    6 +
 drivers/spi/Makefile                      |    1 +
 drivers/spi/spi-mxs.c                     |  457 +++++++++++++++++++++++++++++
 4 files changed, 496 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/spi-mxs.c

diff --git a/arch/arm/mach-mxs/include/mach/ssp-regs.h b/arch/arm/mach-mxs/include/mach/ssp-regs.h
index 4bb0b27..fc467fa 100644
--- a/arch/arm/mach-mxs/include/mach/ssp-regs.h
+++ b/arch/arm/mach-mxs/include/mach/ssp-regs.h
@@ -27,6 +27,10 @@
 
 /* SSP registers */
 #define HW_SSP_CTRL0				0x000
+#define HW_SSP_CTRL0_SET			0x00000004
+#define HW_SSP_CTRL0_CLR			0x00000008
+#define HW_SSP_CTRL0_TOG			0x0000000c
+#define BM_SSP_CTRL0_LOCK_CS			0x08000000
 #define BM_SSP_CTRL0_RUN			(1 << 29)
 #define BM_SSP_CTRL0_SDIO_IRQ_CHECK		(1 << 28)
 #define BM_SSP_CTRL0_IGNORE_CRC			(1 << 26)
@@ -41,6 +45,10 @@
 #define BP_SSP_CTRL0_XFER_COUNT			0
 #define BM_SSP_CTRL0_XFER_COUNT			0xffff
 #define HW_SSP_CMD0				0x010
+#define HW_SSP_CMD0_SET				0x014
+#define HW_SSP_CMD0_CLR				0x018
+#define HW_SSP_CMD0_TOG				0x01c
+
 #define BM_SSP_CMD0_DBL_DATA_RATE_EN		(1 << 25)
 #define BM_SSP_CMD0_SLOW_CLKING_EN		(1 << 22)
 #define BM_SSP_CMD0_CONT_CLKING_EN		(1 << 21)
@@ -63,8 +71,12 @@
 #define BM_SSP_TIMING_TIMEOUT			(0xffff << 16)
 #define BP_SSP_TIMING_CLOCK_DIVIDE		8
 #define BM_SSP_TIMING_CLOCK_DIVIDE		(0xff << 8)
+#define BF_SSP_TIMING_CLOCK_DIVIDE(v)  \
+		(((v) << 8) & BM_SSP_TIMING_CLOCK_DIVIDE)
 #define BP_SSP_TIMING_CLOCK_RATE		0
 #define BM_SSP_TIMING_CLOCK_RATE		0xff
+#define BF_SSP_TIMING_CLOCK_RATE(v)  \
+		(((v) << 0) & BM_SSP_TIMING_CLOCK_RATE)
 #define HW_SSP_CTRL1				(ssp_is_old() ? 0x060 : 0x080)
 #define BM_SSP_CTRL1_SDIO_IRQ			(1 << 31)
 #define BM_SSP_CTRL1_SDIO_IRQ_EN		(1 << 30)
@@ -83,11 +95,30 @@
 #define BM_SSP_CTRL1_FIFO_OVERRUN_IRQ		(1 << 15)
 #define BM_SSP_CTRL1_FIFO_OVERRUN_IRQ_EN	(1 << 14)
 #define BM_SSP_CTRL1_DMA_ENABLE			(1 << 13)
+#define BM_SSP_CTRL1_PHASE			0x00000400
 #define BM_SSP_CTRL1_POLARITY			(1 << 9)
 #define BP_SSP_CTRL1_WORD_LENGTH		4
 #define BM_SSP_CTRL1_WORD_LENGTH		(0xf << 4)
+#define BF_SSP_CTRL1_WORD_LENGTH(v)  \
+		(((v) << 4) & BM_SSP_CTRL1_WORD_LENGTH)
+#define BV_SSP_CTRL1_WORD_LENGTH__RESERVED0	0x0
+#define BV_SSP_CTRL1_WORD_LENGTH__RESERVED1	0x1
+#define BV_SSP_CTRL1_WORD_LENGTH__RESERVED2	0x2
+#define BV_SSP_CTRL1_WORD_LENGTH__FOUR_BITS	0x3
+#define BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS	0x7
+#define BV_SSP_CTRL1_WORD_LENGTH__SIXTEEN_BITS	0xF
+#define BM_SSP_CTRL0_WAIT_FOR_CMD		0x00100000
 #define BP_SSP_CTRL1_SSP_MODE			0
 #define BM_SSP_CTRL1_SSP_MODE			0xf
+#define BF_SSP_CTRL1_SSP_MODE(v)  \
+		(((v) << 0) & BM_SSP_CTRL1_SSP_MODE)
+#define BV_SSP_CTRL1_SSP_MODE__SPI		0x0
+#define BV_SSP_CTRL1_SSP_MODE__SSI		0x1
+#define BV_SSP_CTRL1_SSP_MODE__SD_MMC		0x3
+#define BV_SSP_CTRL1_SSP_MODE__MS		0x4
+
+#define HW_SSP_DATA				0x090
+
 #define HW_SSP_SDRESP0				(ssp_is_old() ? 0x080 : 0x0a0)
 #define HW_SSP_SDRESP1				(ssp_is_old() ? 0x090 : 0x0b0)
 #define HW_SSP_SDRESP2				(ssp_is_old() ? 0x0a0 : 0x0c0)
@@ -95,6 +126,7 @@
 #define HW_SSP_STATUS				(ssp_is_old() ? 0x0c0 : 0x100)
 #define BM_SSP_STATUS_CARD_DETECT		(1 << 28)
 #define BM_SSP_STATUS_SDIO_IRQ			(1 << 17)
+#define BM_SSP_STATUS_FIFO_EMPTY		0x00000020
 #define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 0x130)
 #define BP_SSP_VERSION_MAJOR			24
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3ed7483..f951604 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -199,6 +199,12 @@ config SPI_MPC512x_PSC
 	  This enables using the Freescale MPC5121 Programmable Serial
 	  Controller in SPI master mode.
 
+config SPI_MXS
+	tristate "Freescale MXS SPI controller"
+	depends on ARCH_MXS
+	help
+	   SPI driver for Freescale MXS devices
+
 config SPI_FSL_LIB
 	tristate
 	depends on FSL_SOC
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a1d48e0..0e6fe03 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
 obj-$(CONFIG_SPI_MPC52xx)		+= spi-mpc52xx.o
+obj-$(CONFIG_SPI_MXS)			+= spi-mxs.o
 obj-$(CONFIG_SPI_NUC900)		+= spi-nuc900.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
new file mode 100644
index 0000000..3550ab6
--- /dev/null
+++ b/drivers/spi/spi-mxs.c
@@ -0,0 +1,457 @@
+/*
+ * Freescale MXS SPI master driver
+ *
+ * Heavily based on spi-stmp.c, which is:
+ * Author: dmitry pervushin <dimka-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <mach/mxs.h>
+#include <mach/ssp-regs.h>
+#include <mach/common.h>
+
+#define SSP_TIMEOUT		200	/* 200 ms */
+
+#define rev_struct		(ss->version)
+
+struct mxs_spi {
+	void __iomem *regs;	/* vaddr of the control registers */
+
+	u32 speed_khz;
+	u32 divider;
+
+	struct clk *clk;
+	struct device *master_dev;
+
+	struct work_struct work;
+	struct workqueue_struct *workqueue;
+	spinlock_t lock;
+	struct list_head queue;
+
+	u32 version;
+};
+
+static int mxs_spi_setup_transfer(struct spi_device *spi,
+				  struct spi_transfer *t)
+{
+	u8 bits_per_word;
+	u32 hz;
+	struct mxs_spi *ss;
+	u16 rate;
+
+	ss = spi_master_get_devdata(spi->master);
+
+	bits_per_word = spi->bits_per_word;
+	if (t && t->bits_per_word)
+		bits_per_word = t->bits_per_word;
+/*
+ * Calculate speed:
+ * - by default, use maximum speed from ssp clk
+ * - if device overrides it, use it
+ * - if transfer specifies other speed, use transfer's one
+ */
+	hz = 1000 * ss->speed_khz / ss->divider;
+	if (spi->max_speed_hz)
+		hz = min(hz, spi->max_speed_hz);
+	if (t && t->speed_hz)
+		hz = min(hz, t->speed_hz);
+
+	if (hz == 0) {
+		dev_err(&spi->dev, "Cannot continue with zero clock\n");
+		return -EINVAL;
+	}
+
+	if (bits_per_word != 8) {
+		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
+			__func__, bits_per_word);
+		return -EINVAL;
+	}
+
+	dev_dbg(&spi->dev, "Requested clk rate = %uHz, max = %ukHz/%d = %uHz\n",
+		hz, ss->speed_khz, ss->divider,
+		ss->speed_khz * 1000 / ss->divider);
+
+	if (ss->speed_khz * 1000 / ss->divider < hz) {
+		dev_err(&spi->dev, "%s, unsupported clock rate %uHz\n",
+			__func__, hz);
+		return -EINVAL;
+	}
+
+	rate = 1000 * ss->speed_khz / ss->divider / hz;
+
+	__raw_writel(BF_SSP_TIMING_CLOCK_DIVIDE(ss->divider) |
+		     BF_SSP_TIMING_CLOCK_RATE(rate - 1),
+		     ss->regs + HW_SSP_TIMING);
+
+	__raw_writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
+		     BF_SSP_CTRL1_WORD_LENGTH
+		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
+		     ((spi->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
+		     ((spi->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
+		     ss->regs + HW_SSP_CTRL1);
+
+	__raw_writel(0x0, ss->regs + HW_SSP_CMD0_SET);
+
+	return 0;
+}
+
+static void mxs_spi_cleanup(struct spi_device *spi)
+{
+	return;
+}
+
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA)
+static int mxs_spi_setup(struct spi_device *spi)
+{
+	struct mxs_spi *ss;
+	int err = 0;
+
+	ss = spi_master_get_devdata(spi->master);
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~MODEBITS)
+		return -EINVAL;
+
+	err = mxs_spi_setup_transfer(spi, NULL);
+	if (err)
+		dev_err(&spi->dev, "Failed to setup transfer: %d\n", err);
+
+	return err;
+}
+
+static inline u32 mxs_spi_cs(unsigned cs)
+{
+	return ((cs & 1) ? BM_SSP_CTRL0_WAIT_FOR_CMD : 0) |
+	    ((cs & 2) ? BM_SSP_CTRL0_WAIT_FOR_IRQ : 0);
+}
+
+static inline void mxs_spi_enable(struct mxs_spi *ss)
+{
+	__raw_writel(BM_SSP_CTRL0_LOCK_CS, ss->regs + HW_SSP_CTRL0_SET);
+	__raw_writel(BM_SSP_CTRL0_IGNORE_CRC, ss->regs + HW_SSP_CTRL0_CLR);
+}
+
+static inline void mxs_spi_disable(struct mxs_spi *ss)
+{
+	__raw_writel(BM_SSP_CTRL0_LOCK_CS, ss->regs + HW_SSP_CTRL0_CLR);
+	__raw_writel(BM_SSP_CTRL0_IGNORE_CRC, ss->regs + HW_SSP_CTRL0_SET);
+}
+
+int mxs_ssp_wait_set(struct mxs_spi *ss, int offset, int mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
+
+	while (!(readl_relaxed(&ss->regs + offset) & mask)) {
+		udelay(1);
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+int mxs_ssp_wait_clr(struct mxs_spi *ss, int offset, int mask)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
+
+	while ((readl_relaxed(&ss->regs + offset) & mask)) {
+		udelay(1);
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int mxs_spi_txrx_pio(struct mxs_spi *ss, int cs,
+			    unsigned char *buf, int len,
+			    int *first, int *last, int write)
+{
+	if (*first) {
+		mxs_spi_enable(ss);
+		*first = 0;
+	}
+
+	__raw_writel(mxs_spi_cs(cs), ss->regs + HW_SSP_CTRL0_SET);
+
+	while (len--) {
+		if (*last && len == 0) {
+			mxs_spi_disable(ss);
+			*last = 0;
+		}
+
+		if (ss->version > 3) {
+			__raw_writel(1, ss->regs + HW_SSP_XFER_SIZE);
+		} else {
+			__raw_writel(BM_SSP_CTRL0_XFER_COUNT,
+				     ss->regs + HW_SSP_CTRL0_CLR);
+			__raw_writel(1, ss->regs + HW_SSP_CTRL0_SET);
+		}
+
+		if (write)
+			__raw_writel(BM_SSP_CTRL0_READ,
+				     ss->regs + HW_SSP_CTRL0_CLR);
+		else
+			__raw_writel(BM_SSP_CTRL0_READ,
+				     ss->regs + HW_SSP_CTRL0_SET);
+
+		 /* Activate Run bit */
+		__raw_writel(BM_SSP_CTRL0_RUN, ss->regs + HW_SSP_CTRL0_SET);
+
+
+		if (mxs_ssp_wait_set(ss->regs, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN))
+			return -ETIMEDOUT;
+
+		if (write)
+			__raw_writel(*buf, ss->regs + HW_SSP_DATA);
+
+		/* Set TRANSFER */
+		__raw_writel(BM_SSP_CTRL0_DATA_XFER,
+			     ss->regs + HW_SSP_CTRL0_SET);
+
+		if (!write) {
+			if (mxs_ssp_wait_clr(ss->regs, HW_SSP_STATUS,
+						BM_SSP_STATUS_FIFO_EMPTY))
+				return -ETIMEDOUT;
+
+			*buf = (__raw_readl(ss->regs + HW_SSP_DATA) & 0xFF);
+		}
+
+		if (mxs_ssp_wait_clr(ss->regs, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN))
+			return -ETIMEDOUT;
+		/* advance to the next byte */
+		buf++;
+	}
+	return len < 0 ? 0 : -ETIMEDOUT;
+}
+
+static int mxs_spi_handle_message(struct mxs_spi *ss, struct spi_message *m)
+{
+	int first, last;
+	struct spi_transfer *t, *tmp_t;
+	int status = 0;
+	int cs;
+
+	first = last = 0;
+
+	cs = m->spi->chip_select;
+
+	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
+
+		mxs_spi_setup_transfer(m->spi, t);
+
+		if (&t->transfer_list == m->transfers.next)
+			first = !0;
+		if (&t->transfer_list == m->transfers.prev)
+			last = !0;
+		if (t->rx_buf && t->tx_buf) {
+			pr_debug("%s: cannot send and receive simultaneously\n",
+				 __func__);
+			return -EINVAL;
+		}
+		/*
+		 *  REVISIT:
+		 *  here driver completely ignores setting of t->cs_change
+		 */
+		if (t->tx_buf)
+			status = mxs_spi_txrx_pio(ss, cs, (void *)t->tx_buf,
+					     t->len, &first, &last, 1);
+		if (t->rx_buf)
+			status = mxs_spi_txrx_pio(ss, cs, t->rx_buf,
+					     t->len, &first, &last, 0);
+		m->actual_length += t->len;
+		if (status)
+			break;
+
+		first = last = 0;
+	}
+	return status;
+}
+
+/*
+ * mxs_spi_handle
+ *
+ * The workhorse of the driver - it handles messages from the list
+ */
+static void mxs_spi_handle(struct work_struct *w)
+{
+	struct mxs_spi *ss = container_of(w, struct mxs_spi, work);
+	unsigned long flags;
+	struct spi_message *m;
+
+	BUG_ON(w == NULL);
+
+	spin_lock_irqsave(&ss->lock, flags);
+	while (!list_empty(&ss->queue)) {
+		m = list_entry(ss->queue.next, struct spi_message, queue);
+		list_del_init(&m->queue);
+		spin_unlock_irqrestore(&ss->lock, flags);
+
+		m->status = mxs_spi_handle_message(ss, m);
+		if (m->complete)
+			m->complete(m->context);
+
+		spin_lock_irqsave(&ss->lock, flags);
+	}
+	spin_unlock_irqrestore(&ss->lock, flags);
+
+	return;
+}
+
+/*
+ * mxs_spi_transfer
+ *
+ * Called indirectly from spi_async, queues all the messages to
+ * spi_handle_message
+ *
+ */
+static int mxs_spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct mxs_spi *ss = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+	spin_lock_irqsave(&ss->lock, flags);
+	list_add_tail(&m->queue, &ss->queue);
+	queue_work(ss->workqueue, &ss->work);
+	spin_unlock_irqrestore(&ss->lock, flags);
+
+	return 0;
+}
+
+static int __devinit mxs_spi_probe(struct platform_device *dev)
+{
+	int ret;
+	struct spi_master *master;
+	struct mxs_spi *ss;
+	struct resource *res;
+
+	master = spi_alloc_master(&dev->dev, sizeof(struct mxs_spi));
+	ss = spi_master_get_devdata(master);
+	ss->master_dev = &dev->dev;
+
+	if (!master)
+		return -ENOMEM;
+
+	platform_set_drvdata(dev, master);
+
+	INIT_WORK(&ss->work, mxs_spi_handle);
+	INIT_LIST_HEAD(&ss->queue);
+	spin_lock_init(&ss->lock);
+	ss->workqueue = create_singlethread_workqueue(dev_name(&dev->dev));
+	master->transfer = mxs_spi_transfer;
+	master->setup = mxs_spi_setup;
+	master->cleanup = mxs_spi_cleanup;
+	master->mode_bits = MODEBITS;
+
+	master->bus_num = dev->id;
+	master->num_chipselect = 1;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	ss->regs = devm_request_and_ioremap(&dev->dev, res);
+	if (!ss->regs)
+		return -EBUSY;
+
+	mxs_reset_block(ss->regs);
+	ss->clk = clk_get(&dev->dev, NULL);
+	if (IS_ERR(ss->clk)) {
+		ret = PTR_ERR(ss->clk);
+		dev_err(&dev->dev, "cannot get spi clk\n");
+		goto out_put_master;
+	}
+
+	clk_prepare_enable(ss->clk);
+
+	ss->speed_khz = clk_get_rate(ss->clk) / 1000;
+	ss->divider = 2;
+	dev_dbg(&dev->dev, "Max possible speed %d = %ld/%d kHz\n",
+		 ss->speed_khz, clk_get_rate(ss->clk), ss->divider);
+
+	ss->version = __raw_readl(ss->regs + HW_SSP_VERSION) >> 24;
+
+	ret = spi_register_master(master);
+	if (ret) {
+		dev_err(&dev->dev, "cannot register spi master, %d\n", ret);
+		goto out_clk_put;
+	}
+
+	dev_info(&dev->dev, "driver probed\n");
+
+	return 0;
+
+out_clk_put:
+	clk_disable_unprepare(ss->clk);
+	clk_put(ss->clk);
+out_put_master:
+	spi_master_put(master);
+	if (ss->workqueue)
+		destroy_workqueue(ss->workqueue);
+	platform_set_drvdata(dev, NULL);
+
+	return ret;
+}
+
+static int __devexit mxs_spi_remove(struct platform_device *dev)
+{
+	struct mxs_spi *ss;
+	struct spi_master *master;
+
+	master = platform_get_drvdata(dev);
+	if (!master)
+		goto out0;
+	ss = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(ss->clk);
+	clk_put(ss->clk);
+	spi_unregister_master(master);
+
+	destroy_workqueue(ss->workqueue);
+	spi_master_put(master);
+	platform_set_drvdata(dev, NULL);
+out0:
+	return 0;
+}
+
+static struct platform_driver mxs_spi_driver = {
+	.probe = mxs_spi_probe,
+	.remove = __devexit_p(mxs_spi_remove),
+	.driver = {
+		   .name = "mxs-spi",
+		   .owner = THIS_MODULE,
+		   },
+};
+module_platform_driver(mxs_spi_driver);
+
+MODULE_AUTHOR("dmitry pervushin <dimka-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>");
+MODULE_AUTHOR("Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org");
+MODULE_DESCRIPTION("MXS SPI master driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxs-spi");
-- 
1.7.1


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
