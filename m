From: Bert Vermeulen <bert@biot.com>
Subject: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Fri, 20 Mar 2015 13:16:32 +0100
Message-ID: <1426853793-24454-2-git-send-email-bert@biot.com>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
Cc: Bert Vermeulen <bert@biot.com>
To: ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1426853793-24454-1-git-send-email-bert@biot.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 drivers/spi/Kconfig     |   6 +
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-rb4xx.c | 419 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   1 +
 4 files changed, 427 insertions(+)
 create mode 100644 drivers/spi/spi-rb4xx.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbe..aa76ce5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -429,6 +429,12 @@ config SPI_ROCKCHIP
 	  The main usecase of this controller is to use spi flash as boot
 	  device.
 
+config SPI_RB4XX
+	tristate "Mikrotik RB4XX SPI master"
+	depends on SPI_MASTER && ATH79_MACH_RB4XX
+	help
+	  SPI controller driver for the Mikrotik RB4xx series boards.
+
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d8cbf65..0218f39 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
+obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
new file mode 100644
index 0000000..6208bb7
--- /dev/null
+++ b/drivers/spi/spi-rb4xx.c
@@ -0,0 +1,419 @@
+/*
+ * SPI controller driver for the Mikrotik RB4xx boards
+ *
+ * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * This file was based on the patches for Linux 2.6.27.39 published by
+ * MikroTik for their RouterBoard 4xx series devices.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ath79.h>
+
+#define DRV_NAME	"rb4xx-spi"
+#define DRV_DESC	"Mikrotik RB4xx SPI controller driver"
+#define DRV_VERSION	"0.1.0"
+
+#define SPI_CTRL_FASTEST	0x40
+#define SPI_HZ			33333334
+
+#undef RB4XX_SPI_DEBUG
+
+struct rb4xx_spi {
+	void __iomem		*base;
+	struct spi_master	*master;
+
+	unsigned		spi_ctrl;
+
+	struct clk		*ahb_clk;
+	unsigned long		ahb_freq;
+
+	spinlock_t		lock;
+	struct list_head	queue;
+	int			busy:1;
+	int			cs_wait;
+};
+
+static unsigned spi_clk_low = AR71XX_SPI_IOC_CS1;
+
+#ifdef RB4XX_SPI_DEBUG
+static inline void do_spi_delay(void)
+{
+	ndelay(20000);
+}
+#else
+static inline void do_spi_delay(void) { }
+#endif
+
+static inline void do_spi_init(struct spi_device *spi)
+{
+	unsigned cs = AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1;
+
+	if (!(spi->mode & SPI_CS_HIGH))
+		cs ^= (spi->chip_select == 2) ? AR71XX_SPI_IOC_CS1 :
+						AR71XX_SPI_IOC_CS0;
+
+	spi_clk_low = cs;
+}
+
+static inline void do_spi_finish(void __iomem *base)
+{
+	do_spi_delay();
+	__raw_writel(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1,
+		     base + AR71XX_SPI_REG_IOC);
+}
+
+static inline void do_spi_clk(void __iomem *base, int bit)
+{
+	unsigned bval = spi_clk_low | ((bit & 1) ? AR71XX_SPI_IOC_DO : 0);
+
+	do_spi_delay();
+	__raw_writel(bval, base + AR71XX_SPI_REG_IOC);
+	do_spi_delay();
+	__raw_writel(bval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG_IOC);
+}
+
+static void do_spi_byte(void __iomem *base, unsigned char byte)
+{
+	do_spi_clk(base, byte >> 7);
+	do_spi_clk(base, byte >> 6);
+	do_spi_clk(base, byte >> 5);
+	do_spi_clk(base, byte >> 4);
+	do_spi_clk(base, byte >> 3);
+	do_spi_clk(base, byte >> 2);
+	do_spi_clk(base, byte >> 1);
+	do_spi_clk(base, byte);
+
+	pr_debug("spi_byte sent 0x%02x got 0x%02x\n",
+		 (unsigned)byte,
+		 (unsigned char)__raw_readl(base + AR71XX_SPI_REG_RDS));
+}
+
+static inline void do_spi_clk_fast(void __iomem *base, unsigned bit1,
+				   unsigned bit2)
+{
+	unsigned bval = (spi_clk_low |
+			 ((bit1 & 1) ? AR71XX_SPI_IOC_DO : 0) |
+			 ((bit2 & 1) ? AR71XX_SPI_IOC_CS2 : 0));
+	do_spi_delay();
+	__raw_writel(bval, base + AR71XX_SPI_REG_IOC);
+	do_spi_delay();
+	__raw_writel(bval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG_IOC);
+}
+
+static void do_spi_byte_fast(void __iomem *base, unsigned char byte)
+{
+	do_spi_clk_fast(base, byte >> 7, byte >> 6);
+	do_spi_clk_fast(base, byte >> 5, byte >> 4);
+	do_spi_clk_fast(base, byte >> 3, byte >> 2);
+	do_spi_clk_fast(base, byte >> 1, byte >> 0);
+
+	pr_debug("spi_byte_fast sent 0x%02x got 0x%02x\n",
+		 (unsigned)byte,
+		 (unsigned char) __raw_readl(base + AR71XX_SPI_REG_RDS));
+}
+
+static int rb4xx_spi_txrx(void __iomem *base, struct spi_transfer *t)
+{
+	const unsigned char *rxv_ptr = NULL;
+	const unsigned char *tx_ptr = t->tx_buf;
+	unsigned char *rx_ptr = t->rx_buf;
+	unsigned i;
+
+	pr_debug("spi_txrx len %u tx %u rx %u\n", t->len,
+		 (t->tx_buf ? 1 : 0),
+		 (t->rx_buf ? 1 : 0));
+
+	for (i = 0; i < t->len; ++i) {
+		unsigned char sdata = tx_ptr ? tx_ptr[i] : 0;
+
+		if (t->fast_write)
+			do_spi_byte_fast(base, sdata);
+		else
+			do_spi_byte(base, sdata);
+
+		if (rx_ptr) {
+			rx_ptr[i] = __raw_readl(base + AR71XX_SPI_REG_RDS) & 0xff;
+		} else if (rxv_ptr) {
+			unsigned char c = __raw_readl(base + AR71XX_SPI_REG_RDS);
+
+			if (rxv_ptr[i] != c)
+				return i;
+		}
+	}
+
+	return i;
+}
+
+static int rb4xx_spi_msg(struct rb4xx_spi *rbspi, struct spi_message *m)
+{
+	struct spi_transfer *t = NULL;
+	void __iomem *base = rbspi->base;
+
+	m->status = 0;
+	if (list_empty(&m->transfers))
+		return -1;
+
+	__raw_writel(AR71XX_SPI_FS_GPIO, base + AR71XX_SPI_REG_FS);
+	__raw_writel(SPI_CTRL_FASTEST, base + AR71XX_SPI_REG_CTRL);
+	do_spi_init(m->spi);
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		int len;
+
+		len = rb4xx_spi_txrx(base, t);
+		if (len != t->len) {
+			m->status = -EMSGSIZE;
+			break;
+		}
+		m->actual_length += len;
+
+		if (t->cs_change) {
+			if (list_is_last(&t->transfer_list, &m->transfers)) {
+				/* wait for continuation */
+				return m->spi->chip_select;
+			}
+			do_spi_finish(base);
+			ndelay(100);
+		}
+	}
+
+	do_spi_finish(base);
+	__raw_writel(rbspi->spi_ctrl, base + AR71XX_SPI_REG_CTRL);
+	__raw_writel(0, base + AR71XX_SPI_REG_FS);
+	return -1;
+}
+
+static void rb4xx_spi_process_queue_locked(struct rb4xx_spi *rbspi,
+					   unsigned long *flags)
+{
+	int cs = rbspi->cs_wait;
+
+	rbspi->busy = 1;
+	while (!list_empty(&rbspi->queue)) {
+		struct spi_message *m;
+
+		list_for_each_entry(m, &rbspi->queue, queue)
+			if (cs < 0 || cs == m->spi->chip_select)
+				break;
+
+		if (&m->queue == &rbspi->queue)
+			break;
+
+		list_del_init(&m->queue);
+		spin_unlock_irqrestore(&rbspi->lock, *flags);
+
+		cs = rb4xx_spi_msg(rbspi, m);
+		m->complete(m->context);
+
+		spin_lock_irqsave(&rbspi->lock, *flags);
+	}
+
+	rbspi->cs_wait = cs;
+	rbspi->busy = 0;
+
+	if (cs >= 0) {
+		/* TODO: add timer to unlock cs after 1s inactivity */
+	}
+}
+
+static int rb4xx_spi_transfer(struct spi_device *spi,
+			      struct spi_message *m)
+{
+	struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+
+	spin_lock_irqsave(&rbspi->lock, flags);
+	list_add_tail(&m->queue, &rbspi->queue);
+	if (rbspi->busy ||
+	    (rbspi->cs_wait >= 0 && rbspi->cs_wait != m->spi->chip_select)) {
+		/* job will be done later */
+		spin_unlock_irqrestore(&rbspi->lock, flags);
+		return 0;
+	}
+
+	/* process job in current context */
+	rb4xx_spi_process_queue_locked(rbspi, &flags);
+	spin_unlock_irqrestore(&rbspi->lock, flags);
+
+	return 0;
+}
+
+static int rb4xx_spi_setup(struct spi_device *spi)
+{
+	struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
+	unsigned long flags;
+
+	if (spi->mode & ~(SPI_CS_HIGH)) {
+		dev_err(&spi->dev, "mode %x not supported\n",
+			(unsigned) spi->mode);
+		return -EINVAL;
+	}
+
+	if (spi->bits_per_word != 8 && spi->bits_per_word != 0) {
+		dev_err(&spi->dev, "bits_per_word %u not supported\n",
+			(unsigned) spi->bits_per_word);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&rbspi->lock, flags);
+	if (rbspi->cs_wait == spi->chip_select && !rbspi->busy) {
+		rbspi->cs_wait = -1;
+		rb4xx_spi_process_queue_locked(rbspi, &flags);
+	}
+	spin_unlock_irqrestore(&rbspi->lock, flags);
+
+	return 0;
+}
+
+static unsigned get_spi_ctrl(struct rb4xx_spi *rbspi)
+{
+	unsigned div;
+
+	div = (rbspi->ahb_freq - 1) / (2 * SPI_HZ);
+
+	/*
+	 * CPU has a bug at (div == 0) - first bit read is random
+	 */
+	if (div == 0)
+		++div;
+
+	return SPI_CTRL_FASTEST + div;
+}
+
+static int rb4xx_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct rb4xx_spi *rbspi;
+	struct resource *r;
+	int err = 0;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*rbspi));
+	if (!master) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	master->bus_num = 0;
+	master->num_chipselect = 3;
+	master->setup = rb4xx_spi_setup;
+	master->transfer = rb4xx_spi_transfer;
+
+	rbspi = spi_master_get_devdata(master);
+
+	rbspi->ahb_clk = clk_get(&pdev->dev, "ahb");
+	if (IS_ERR(rbspi->ahb_clk)) {
+		err = PTR_ERR(rbspi->ahb_clk);
+		goto err_put_master;
+	}
+
+	err = clk_enable(rbspi->ahb_clk);
+	if (err)
+		goto err_clk_put;
+
+	rbspi->ahb_freq = clk_get_rate(rbspi->ahb_clk);
+	if (!rbspi->ahb_freq) {
+		err = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	platform_set_drvdata(pdev, rbspi);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		err = -ENOENT;
+		goto err_clk_disable;
+	}
+
+	rbspi->base = ioremap(r->start, r->end - r->start + 1);
+	if (!rbspi->base) {
+		err = -ENXIO;
+		goto err_clk_disable;
+	}
+
+	rbspi->master = master;
+	rbspi->spi_ctrl = get_spi_ctrl(rbspi);
+	rbspi->cs_wait = -1;
+
+	spin_lock_init(&rbspi->lock);
+	INIT_LIST_HEAD(&rbspi->queue);
+
+	err = spi_register_master(master);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register SPI master\n");
+		goto err_iounmap;
+	}
+
+	return 0;
+
+err_iounmap:
+	iounmap(rbspi->base);
+err_clk_disable:
+	clk_disable(rbspi->ahb_clk);
+err_clk_put:
+	clk_put(rbspi->ahb_clk);
+err_put_master:
+	platform_set_drvdata(pdev, NULL);
+	spi_master_put(master);
+err_out:
+	return err;
+}
+
+static int rb4xx_spi_remove(struct platform_device *pdev)
+{
+	struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
+
+	iounmap(rbspi->base);
+	clk_disable(rbspi->ahb_clk);
+	clk_put(rbspi->ahb_clk);
+	platform_set_drvdata(pdev, NULL);
+	spi_master_put(rbspi->master);
+
+	return 0;
+}
+
+static struct platform_driver rb4xx_spi_drv = {
+	.probe		= rb4xx_spi_probe,
+	.remove		= rb4xx_spi_remove,
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init rb4xx_spi_init(void)
+{
+	return platform_driver_register(&rb4xx_spi_drv);
+}
+subsys_initcall(rb4xx_spi_init);
+
+static void __exit rb4xx_spi_exit(void)
+{
+	platform_driver_unregister(&rb4xx_spi_drv);
+}
+
+module_exit(rb4xx_spi_exit);
+
+MODULE_DESCRIPTION(DRV_DESC);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 856d34d..0d55661 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -616,6 +616,7 @@ struct spi_transfer {
 	struct sg_table rx_sg;
 
 	unsigned	cs_change:1;
+	unsigned	fast_write:1;
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
-- 
1.9.1
