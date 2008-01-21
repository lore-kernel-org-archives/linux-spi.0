From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] spi: add support for SPI over SuperH SCI pins
Date: Mon, 21 Jan 2008 19:49:13 +0900
Message-ID: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
Cc: lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>,
	dbrownell@users.sourceforge.net, magnus.damm@gmail.com,
	linux-sh@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

spi: add support for SPI over SuperH SCI pins

This patch adds support for SPI over SCI pins. SCI is a very simple serial
controller block that can be found on older SuperH processors. In theory it
is possible to use the SCI hardware block in syncronous mode, but this version
of the driver simply hooks up the bit banging code on the SCI pins.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/spi/Kconfig      |    7 +
 drivers/spi/Makefile     |    1 
 drivers/spi/spi_sh_sci.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

--- 0001/drivers/spi/Kconfig
+++ work/drivers/spi/Kconfig	2008-01-21 16:59:39.000000000 +0900
@@ -175,6 +175,13 @@ config SPI_S3C24XX_GPIO
 	  the inbuilt hardware cannot provide the transfer mode, or
 	  where the board is using non hardware connected pins.
 
+config SPI_SH_SCI
+	tristate "SuperH SCI SPI controller"
+	depends on SPI_MASTER && SUPERH
+	select SPI_BITBANG
+	help
+	  SPI driver for SuperH SCI blocks.
+
 config SPI_TXX9
 	tristate "Toshiba TXx9 SPI controller"
 	depends on SPI_MASTER && GENERIC_GPIO && CPU_TX49XX
--- 0001/drivers/spi/Makefile
+++ work/drivers/spi/Makefile	2008-01-21 16:59:39.000000000 +0900
@@ -27,6 +27,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
+obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
--- /dev/null
+++ work/drivers/spi/spi_sh_sci.c	2008-01-21 17:04:02.000000000 +0900
@@ -0,0 +1,217 @@
+/* linux/drivers/spi/spi_sh_sci.c
+ *
+ * SH SCI SPI interface
+ *
+ * Based on S3C24XX GPIO based SPI driver
+ *
+ * Copyright (c) 2006 Ben Dooks
+ * Copyright (c) 2006 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/spi.h>
+#include <asm/io.h>
+
+struct sh_sci_spi {
+	struct spi_bitbang bitbang;
+
+	unsigned long mapbase;
+	struct sh_spi_info *info;
+	struct platform_device *dev;
+};
+
+#define SCSPTR(sg) (sg->mapbase + 0x1c)
+#define PIN_SCK (1 << 2)
+#define PIN_TXD (1 << 0)
+#define PIN_RXD PIN_TXD
+#define PIN_INIT ((1 << 1) | (1 << 3))
+
+static inline struct sh_sci_spi *spidev_to_sg(struct spi_device *spi)
+{
+	return spi->controller_data;
+}
+
+static inline void setbits(struct sh_sci_spi *sg, int bits, int on)
+{
+	unsigned char val;
+
+	val = ctrl_inb(SCSPTR(sg));
+	if (on)
+		val |= bits;
+	else
+		val &= ~bits;
+	ctrl_outb(val, SCSPTR(sg));
+}
+
+static inline unsigned char getbits(struct sh_sci_spi *sg, int bits)
+{
+	return ctrl_inb(SCSPTR(sg)) & bits;
+}
+
+static inline void setsck(struct spi_device *dev, int on)
+{
+	setbits(spidev_to_sg(dev), PIN_SCK, on);
+}
+
+static inline void setmosi(struct spi_device *dev, int on)
+{
+	setbits(spidev_to_sg(dev), PIN_TXD, on);
+}
+
+static inline u32 getmiso(struct spi_device *dev)
+{
+	return getbits(spidev_to_sg(dev), PIN_RXD) ? 1 : 0;
+}
+
+#define spidelay(x) ndelay(x)
+
+#define	EXPAND_BITBANG_TXRX
+#include <linux/spi/spi_bitbang.h>
+
+static u32 sh_sci_spi_txrx_mode0(struct spi_device *spi,
+				      unsigned nsecs, u32 word, u8 bits)
+{
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+}
+
+static u32 sh_sci_spi_txrx_mode1(struct spi_device *spi,
+				      unsigned nsecs, u32 word, u8 bits)
+{
+	return bitbang_txrx_be_cpha1(spi, nsecs, 0, word, bits);
+}
+
+static u32 sh_sci_spi_txrx_mode2(struct spi_device *spi,
+				      unsigned nsecs, u32 word, u8 bits)
+{
+	return bitbang_txrx_be_cpha0(spi, nsecs, 1, word, bits);
+}
+
+static u32 sh_sci_spi_txrx_mode3(struct spi_device *spi,
+				      unsigned nsecs, u32 word, u8 bits)
+{
+	return bitbang_txrx_be_cpha1(spi, nsecs, 1, word, bits);
+}
+
+
+static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
+{
+	struct sh_sci_spi *sg = spidev_to_sg(dev);
+
+	if (sg->info && sg->info->chip_select)
+		(sg->info->chip_select)(sg->info, dev->chip_select, value);
+}
+
+static int sh_sci_spi_probe(struct platform_device *dev)
+{
+	struct resource	*r;
+	struct sh_spi_info *info;
+	struct spi_master *master;
+	struct sh_sci_spi *sp;
+	int ret;
+	int i;
+
+	master = spi_alloc_master(&dev->dev, sizeof(struct sh_sci_spi));
+	if (master == NULL) {
+		dev_err(&dev->dev, "failed to allocate spi master\n");
+		ret = -ENOMEM;
+		goto err0;
+	}
+
+	sp = spi_master_get_devdata(master);
+
+	platform_set_drvdata(dev, sp);
+
+	/* copy in the platform data */
+	info = sp->info = dev->dev.platform_data;
+
+	/* setup spi bitbang adaptor */
+	sp->bitbang.master = spi_master_get(master);
+	sp->bitbang.master->bus_num = info->bus_num;
+	sp->bitbang.master->num_chipselect = info->num_chipselect;
+	sp->bitbang.chipselect = sh_sci_spi_chipselect;
+
+	sp->bitbang.txrx_word[SPI_MODE_0] = sh_sci_spi_txrx_mode0;
+	sp->bitbang.txrx_word[SPI_MODE_1] = sh_sci_spi_txrx_mode1;
+	sp->bitbang.txrx_word[SPI_MODE_2] = sh_sci_spi_txrx_mode2;
+	sp->bitbang.txrx_word[SPI_MODE_3] = sh_sci_spi_txrx_mode3;
+
+	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENOENT;
+		goto err1;
+	}
+	sp->mapbase = r->start;
+	setbits(sp, PIN_INIT, 1);
+
+	ret = spi_bitbang_start(&sp->bitbang);
+	if (ret)
+		goto err2;
+
+	/* register the chips to go with the board */
+
+	for (i = 0; i < sp->info->board_size; i++) {
+		dev_info(&dev->dev, "registering %p: %s\n",
+			 &sp->info->board_info[i],
+			 sp->info->board_info[i].modalias);
+
+		sp->info->board_info[i].controller_data = sp;
+		spi_new_device(master, sp->info->board_info + i);
+	}
+	return 0;
+ err2:
+	setbits(sp, PIN_INIT, 0);
+ err1:
+	spi_master_put(sp->bitbang.master);
+ err0:
+	return ret;
+}
+
+static int sh_sci_spi_remove(struct platform_device *dev)
+{
+	struct sh_sci_spi *sp = platform_get_drvdata(dev);
+
+	spi_bitbang_stop(&sp->bitbang);
+	setbits(sp, PIN_INIT, 0);
+	spi_master_put(sp->bitbang.master);
+	return 0;
+}
+
+static struct platform_driver sh_sci_spi_drv = {
+	.probe		= sh_sci_spi_probe,
+	.remove		= sh_sci_spi_remove,
+	.driver		= {
+		.name	= "spi_sh_sci",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init sh_sci_spi_init(void)
+{
+	return platform_driver_register(&sh_sci_spi_drv);
+}
+
+static void __exit sh_sci_spi_exit(void)
+{
+	platform_driver_unregister(&sh_sci_spi_drv);
+}
+
+module_init(sh_sci_spi_init);
+module_exit(sh_sci_spi_exit);
+
+MODULE_DESCRIPTION("SH SCI SPI Driver");
+MODULE_AUTHOR("Magnus Damm");
+MODULE_LICENSE("GPL");
