From: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Subject: [PATCH] spi: driver for Marvell Orion SPI
	controllers
Date: Thu, 26 Jun 2008 20:39:11 +0200
Message-ID: <20080626183911.GC16994@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nico-mo2vmkxb4K0@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

This adds a SPI driver for the SPI controller found in various
Marvell Orion ARM SoCs.

Signed-off-by: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Index: linux-2.6.26-rc8/drivers/spi/Kconfig
===================================================================
--- linux-2.6.26-rc8.orig/drivers/spi/Kconfig
+++ linux-2.6.26-rc8/drivers/spi/Kconfig
@@ -149,6 +149,12 @@ config SPI_OMAP24XX
 	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 	  (McSPI) modules.
 
+config SPI_ORION
+	tristate "Orion SPI master (EXPERIMENTAL)"
+	depends on SPI_MASTER && PLAT_ORION && EXPERIMENTAL
+	help
+	  This enables using the SPI master controller on the Orion chips.
+
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
 	depends on SPI_MASTER && ARCH_PXA && EXPERIMENTAL
Index: linux-2.6.26-rc8/drivers/spi/Makefile
===================================================================
--- linux-2.6.26-rc8.orig/drivers/spi/Makefile
+++ linux-2.6.26-rc8/drivers/spi/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi_lm70llp.o
+obj-$(CONFIG_SPI_ORION)			+= orion_spi.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= omap_uwire.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= omap2_mcspi.o
Index: linux-2.6.26-rc8/drivers/spi/orion_spi.c
===================================================================
--- /dev/null
+++ linux-2.6.26-rc8/drivers/spi/orion_spi.c
@@ -0,0 +1,594 @@
+/*
+ * Marvell Orion SPI controller driver
+ *
+ * Author: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ * Copyright (C) 2007-2008 Marvell Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/orion_spi.h>
+#include <asm/unaligned.h>
+
+#define DRIVER_NAME			"orion_spi"
+
+#define SPI_REG(orion_spi, reg)		(((u32)orion_spi->base) + (reg))
+
+#define ORION_SPI_MAX_FREQ 		20000000
+#define ORION_SPI_DEF_FREQ		20000000
+#define ORION_SPI_DEF_BPW		16
+#define ORION_NUM_CHIPSELECTS		1
+#define ORION_SPI_WAIT_RDY_MAX_LOOP	2000 /* in usec */
+#define DUMMY_8_BIT_TX_VAL		0xFF
+#define DUMMY_16_BIT_TX_VAL		0xFFFF
+
+#define ORION_SPI_IF_CTRL_REG		0x00
+#define ORION_SPI_IF_CONFIG_REG		0x04
+#define ORION_SPI_DATA_OUT_REG		0x08
+#define ORION_SPI_DATA_IN_REG		0x0c
+#define ORION_SPI_INT_CAUSE_REG		0x10
+
+#define ORION_SPI_IF_8_16_BIT_MODE	(1 << 5)
+#define ORION_SPI_CLK_PRESCALE_MASK	0x1F
+
+struct orion_spi {
+	struct work_struct	work;
+
+	/* Lock access to transfer list.	*/
+	spinlock_t		lock;
+
+	struct list_head	msg_queue;
+	struct spi_master	*master;
+	void __iomem		*base;
+	struct orion_spi_info 	*spi_info;
+};
+
+struct orion_spi_state {
+	u32	data_width;
+};
+
+static struct workqueue_struct *orion_spi_wq;
+
+static inline void
+orion_spi_setbits(struct orion_spi *orion_spi, u32 reg, u32 mask)
+{
+	u32 reg_addr = SPI_REG(orion_spi, reg);
+	u32 val;
+
+	val = readl(reg_addr);
+	val |= mask;
+	writel(val, reg_addr);
+}
+
+static inline void
+orion_spi_clrbits(struct orion_spi *orion_spi, u32 reg, u32 mask)
+{
+	u32 reg_addr = SPI_REG(orion_spi, reg);
+	u32 val;
+
+	val = readl(reg_addr);
+	val &= ~mask;
+	writel(val, reg_addr);
+}
+
+static int orion_spi_set_transfer_size(struct orion_spi *orion_spi, int size)
+{
+	if (size == 16) {
+		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+				  ORION_SPI_IF_8_16_BIT_MODE);
+	} else if (size == 8) {
+		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+				  ORION_SPI_IF_8_16_BIT_MODE);
+	} else {
+		pr_debug("Bad bits per word value %d (only 8 or 16 are "
+			 "allowed).\n", size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static u8 prescale[] = { 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 };
+
+static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int rate)
+{
+	u32 min_offset = 0xFFFFFFFF;
+	u8 best_idx = 100;
+	int i;
+	u32 cpu_clk;
+	u32 reg;
+	struct orion_spi *orion_spi;
+	struct orion_spi_info *spi_info;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+	spi_info = orion_spi->spi_info;
+
+	cpu_clk = spi_info->tclk;
+
+	/* Find the best prescale configuration - less or equal */
+	for (i = 0; i < ARRAY_SIZE(prescale); i++) {
+		u32 tmp_rate = cpu_clk / prescale[i];
+
+		/* check for higher - irrelevant */
+		if (tmp_rate > rate)
+			continue;
+
+		/* check for exact fit */
+		if (tmp_rate == rate) {
+			best_idx = i;
+			break;
+		}
+
+		/* check if this is better than the previous one */
+		if ((rate - tmp_rate) < min_offset) {
+			min_offset = (rate - (cpu_clk / prescale[i]));
+			best_idx = i;
+		}
+	}
+
+	if (best_idx > ARRAY_SIZE(prescale))
+		return -EINVAL;
+
+	/* Convert the array index to SPI clock divisor value.	*/
+	reg = readl(SPI_REG(orion_spi, ORION_SPI_IF_CONFIG_REG));
+	reg = ((reg & ~ORION_SPI_CLK_PRESCALE_MASK) | (best_idx + 0x12));
+	writel(reg, SPI_REG(orion_spi, ORION_SPI_IF_CONFIG_REG));
+
+	return 0;
+}
+
+/*
+ * called only when no transfer is active to this device
+ */
+static int orion_spi_setup_transfer(struct spi_device *spi,
+				    struct spi_transfer *t)
+{
+	struct orion_spi *orion_spi;
+	struct orion_spi_state *spi_state = spi->controller_state;
+	unsigned int speed = spi->max_speed_hz;
+	unsigned int bits_per_word = spi->bits_per_word;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+
+	if ((t != NULL) && t->speed_hz)
+		speed = t->speed_hz;
+
+	if ((t != NULL) && t->bits_per_word)
+		bits_per_word = t->bits_per_word;
+
+	if (orion_spi_baudrate_set(spi, speed) != 0)
+		return -EINVAL;
+
+	if (orion_spi_set_transfer_size(orion_spi, bits_per_word) != 0)
+		return -EINVAL;
+
+	spi_state->data_width = t->bits_per_word;
+
+	return 0;
+}
+
+static void orion_spi_set_cs(struct orion_spi *orion_spi, int enable)
+{
+	if (enable)
+		orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+	else
+		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+}
+
+static inline int orion_spi_wait_till_ready(struct orion_spi *orion_spi)
+{
+	int i;
+
+	for (i = 0; i < ORION_SPI_WAIT_RDY_MAX_LOOP; i++) {
+		if (readl(SPI_REG(orion_spi, ORION_SPI_INT_CAUSE_REG)))
+			return 1;
+		else
+			udelay(1);
+	}
+
+	return -1;
+}
+
+static int
+orion_spi_write_read_8bit(struct spi_device *spi,
+			  const u8 **tx_buf, u8 **rx_buf)
+{
+	u32 tx_reg, rx_reg, int_reg;
+	struct orion_spi *orion_spi;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+	tx_reg = SPI_REG(orion_spi, ORION_SPI_DATA_OUT_REG);
+	rx_reg = SPI_REG(orion_spi, ORION_SPI_DATA_IN_REG);
+	int_reg = SPI_REG(orion_spi, ORION_SPI_INT_CAUSE_REG);
+
+	/* clear the interrupt cause register */
+	writel(0x0, int_reg);
+
+	if (tx_buf && *tx_buf)
+		writel(*(*tx_buf)++, tx_reg);
+	else
+		writel(DUMMY_8_BIT_TX_VAL, tx_reg);
+
+	if (orion_spi_wait_till_ready(orion_spi) < 0)
+		return -1;
+
+	if (rx_buf && *rx_buf)
+		*(*rx_buf)++ = readl(rx_reg);
+
+	return 1;
+}
+
+static int
+orion_spi_write_read_16bit(struct spi_device *spi,
+			   const u16 **tx_buf, u16 **rx_buf)
+{
+	u32 tx_reg, rx_reg, int_reg;
+	struct orion_spi *orion_spi;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+	tx_reg = SPI_REG(orion_spi, ORION_SPI_DATA_OUT_REG);
+	rx_reg = SPI_REG(orion_spi, ORION_SPI_DATA_IN_REG);
+	int_reg = SPI_REG(orion_spi, ORION_SPI_INT_CAUSE_REG);
+
+	/* clear the interrupt cause register */
+	writel(0x0, int_reg);
+
+	if (tx_buf && *tx_buf)
+		writel(__cpu_to_le16(get_unaligned((*tx_buf)++)), tx_reg);
+	else
+		writel(DUMMY_16_BIT_TX_VAL, tx_reg);
+
+	if (orion_spi_wait_till_ready(orion_spi) < 0) {
+		dev_err(&spi->dev, "TXS timed out\n");
+		return -1;
+	}
+
+	if (rx_buf && *rx_buf)
+		put_unaligned(__le16_to_cpu(readl(rx_reg)), (*rx_buf)++);
+
+	return 1;
+}
+
+static unsigned int
+orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	struct orion_spi_state *spi_state = spi->controller_state;
+	struct orion_spi *orion_spi;
+	unsigned int count;
+	void __iomem *base;
+	int word_len;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+	base = orion_spi->base;
+	word_len = spi_state->data_width;
+	count = xfer->len;
+
+	if (word_len == 8) {
+		const u8 *tx = xfer->tx_buf;
+		u8 *rx = xfer->rx_buf;
+
+		do {
+			if (orion_spi_write_read_8bit(spi, &tx, &rx) < 0)
+				goto out;
+			count--;
+		} while (count);
+	} else if (word_len == 16) {
+		const u16 *tx = xfer->tx_buf;
+		u16 *rx = xfer->rx_buf;
+
+		while (count > 1) {
+			if (orion_spi_write_read_16bit(spi, &tx, &rx) < 0)
+				goto out;
+			count -= 2;
+		}
+
+		if (count == 1) {
+			/* Set mode to 8 bit. */
+			orion_spi_set_transfer_size(orion_spi, 8);
+			if (orion_spi_write_read_8bit(spi, (const u8 **)&tx,
+						(u8 **)&rx) < 0)
+				goto out;
+
+			/* Set mode to 16 bit. */
+			orion_spi_set_transfer_size(orion_spi, 16);
+			count--;
+		}
+	}
+
+out:
+	return xfer->len - count;
+}
+
+
+static void orion_spi_work(struct work_struct *work)
+{
+	struct orion_spi *orion_spi =
+		container_of(work, struct orion_spi, work);
+
+	spin_lock_irq(&orion_spi->lock);
+	while (!list_empty(&orion_spi->msg_queue)) {
+		struct spi_message *m;
+		struct spi_device *spi;
+		struct spi_transfer *t = NULL;
+		int par_override = 0;
+		int status = 0;
+		int cs_active = 0;
+
+		m = container_of(orion_spi->msg_queue.next, struct spi_message,
+				 queue);
+
+		list_del_init(&m->queue);
+		spin_unlock_irq(&orion_spi->lock);
+
+		spi = m->spi;
+
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
+				status = -EINVAL;
+				break;
+			}
+
+			if (par_override || t->speed_hz || t->bits_per_word) {
+				par_override = 1;
+				status = orion_spi_setup_transfer(spi, t);
+				if (status < 0)
+					break;
+				if (!t->speed_hz && !t->bits_per_word)
+					par_override = 0;
+			}
+
+			if (!cs_active) {
+				orion_spi_set_cs(orion_spi, 1);
+				cs_active = 1;
+			}
+
+			if (t->len)
+				m->actual_length +=
+					orion_spi_write_read(spi, t);
+
+			if (t->delay_usecs)
+				udelay(t->delay_usecs);
+
+			if (t->cs_change) {
+				orion_spi_set_cs(orion_spi, 0);
+				cs_active = 0;
+			}
+		}
+
+		/* Restore defaults if they were overriden */
+		if (par_override) {
+			par_override = 0;
+			status = orion_spi_setup_transfer(spi, NULL);
+		}
+
+		if (cs_active)
+			orion_spi_set_cs(orion_spi, 0);
+
+		m->status = status;
+		m->complete(m->context);
+
+		spin_lock_irq(&orion_spi->lock);
+	}
+
+	spin_unlock_irq(&orion_spi->lock);
+}
+
+static int __init orion_spi_reset(struct orion_spi *orion_spi)
+{
+	/* Verify that the CS is deasserted */
+	orion_spi_set_cs(orion_spi, 0);
+
+	return 0;
+}
+
+static int orion_spi_setup(struct spi_device *spi)
+{
+	struct orion_spi_state *spi_state;
+	struct orion_spi *orion_spi;
+	struct orion_spi_info *spi_info;
+
+	spi_state = spi->controller_state;
+	orion_spi = spi_master_get_devdata(spi->master);
+	spi_info = orion_spi->spi_info;
+
+	if (spi->bits_per_word == 0) {
+		spi->bits_per_word = ORION_SPI_DEF_BPW;
+	} else if (spi->bits_per_word < 8 || spi->bits_per_word > 16) {
+		dev_dbg(&spi->dev, "setup: unsupported %d bit words\n",
+			spi->bits_per_word);
+		return -EINVAL;
+	}
+
+	if (orion_spi_set_transfer_size(orion_spi, spi->bits_per_word) != 0)
+		return -EINVAL;
+
+	if (!spi_state) {
+		spi_state = kzalloc(sizeof(*spi_state), GFP_KERNEL);
+		if (!spi_state)
+			return -ENOMEM;
+		spi->controller_state = spi_state;
+	}
+	spi_state->data_width = spi->bits_per_word;
+
+	dev_dbg(&spi->dev, "setup: Set MAX Speed to %d ", spi->max_speed_hz);
+	if (orion_spi_baudrate_set(spi, spi->max_speed_hz) == 0)
+		dev_dbg(&spi->dev, "OK");
+	else
+		dev_dbg(&spi->dev, "Failed");
+
+	return 0;
+}
+
+static int orion_spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct orion_spi *orion_spi;
+	unsigned long flags;
+	struct spi_transfer *t;
+
+	m->actual_length = 0;
+	m->status = 0;
+
+	/* reject invalid messages and transfers */
+	if (list_empty(&m->transfers) || !m->complete)
+		return -EINVAL;
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		const void *tx_buf = t->tx_buf;
+		void *rx_buf = t->rx_buf;
+		unsigned len = t->len;
+
+		if (t->speed_hz > ORION_SPI_MAX_FREQ
+				|| (len && !(rx_buf || tx_buf))
+				|| (t->bits_per_word &&
+					(t->bits_per_word < 8
+					|| t->bits_per_word > 16))) {
+			dev_dbg(&spi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
+					t->speed_hz,
+					len,
+					tx_buf ? "tx" : "",
+					rx_buf ? "rx" : "",
+					t->bits_per_word);
+			return -EINVAL;
+		}
+	}
+
+	orion_spi = spi_master_get_devdata(spi->master);
+
+	spin_lock_irqsave(&orion_spi->lock, flags);
+	list_add_tail(&m->queue, &orion_spi->msg_queue);
+	queue_work(orion_spi_wq, &orion_spi->work);
+	spin_unlock_irqrestore(&orion_spi->lock, flags);
+
+	return 0;
+}
+
+static void orion_spi_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+
+static int __init orion_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct orion_spi *spi;
+	struct resource *r;
+	struct orion_spi_info *spi_info;
+	int status = 0;
+
+	spi_info = pdev->dev.platform_data;
+
+	master = spi_alloc_master(&pdev->dev, sizeof *spi);
+	if (master == NULL) {
+		dev_dbg(&pdev->dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	if (pdev->id != -1)
+		master->bus_num = pdev->id;
+
+	master->setup = orion_spi_setup;
+	master->transfer = orion_spi_transfer;
+	master->cleanup = orion_spi_cleanup;
+	master->num_chipselect = ORION_NUM_CHIPSELECTS;
+
+	dev_set_drvdata(&pdev->dev, master);
+
+	spi = spi_master_get_devdata(master);
+	spi->master = master;
+	spi->spi_info = spi_info;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		status = -ENODEV;
+		goto out;
+	}
+
+	if (!request_mem_region(r->start, (r->end - r->start) + 1,
+				pdev->dev.bus_id)) {
+		status = -EBUSY;
+		goto out;
+	}
+	spi->base = ioremap(r->start, SZ_1K);
+
+	INIT_WORK(&spi->work, orion_spi_work);
+
+	spin_lock_init(&spi->lock);
+	INIT_LIST_HEAD(&spi->msg_queue);
+
+	if (orion_spi_reset(spi) < 0)
+		goto out_rel_mem;
+
+	status = spi_register_master(master);
+	if (status < 0)
+		goto out_rel_mem;
+
+	return status;
+
+out_rel_mem:
+	release_mem_region(r->start, (r->end - r->start) + 1);
+
+out:
+	spi_master_put(master);
+	return status;
+}
+
+
+static int __exit orion_spi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct orion_spi *spi;
+	struct resource *r;
+
+	master = dev_get_drvdata(&pdev->dev);
+	spi = spi_master_get_devdata(master);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(r->start, (r->end - r->start) + 1);
+
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+static struct platform_driver orion_spi_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.remove		= __exit_p(orion_spi_remove),
+};
+
+static int __init orion_spi_init(void)
+{
+	orion_spi_wq = create_singlethread_workqueue(
+				orion_spi_driver.driver.name);
+	if (orion_spi_wq == NULL)
+		return -1;
+
+	return platform_driver_probe(&orion_spi_driver, orion_spi_probe);
+}
+module_init(orion_spi_init);
+
+static void __exit orion_spi_exit(void)
+{
+	platform_driver_unregister(&orion_spi_driver);
+
+	destroy_workqueue(orion_spi_wq);
+}
+module_exit(orion_spi_exit);
+
+MODULE_DESCRIPTION("Orion SPI driver");
+MODULE_AUTHOR("Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:orion_spi");
Index: linux-2.6.26-rc8/include/linux/spi/orion_spi.h
===================================================================
--- /dev/null
+++ linux-2.6.26-rc8/include/linux/spi/orion_spi.h
@@ -0,0 +1,17 @@
+/*
+ * include/linux/spi/orion_spi.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_SPI_ORION_SPI_H
+#define __LINUX_SPI_ORION_SPI_H
+
+struct orion_spi_info {
+	u32	tclk;
+};
+
+
+#endif

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
