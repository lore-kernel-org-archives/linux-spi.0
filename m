From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH v2 09/16] spi: add SPI controller driver for the Atheros
	AR71XX/AR724X/AR913X SoCs
Date: Wed, 22 Dec 2010 21:30:54 +0100
Message-ID: <1293049861-28913-10-git-send-email-juhosg@openwrt.org>
References: <1293049861-28913-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"Luis R. Rodriguez" <lrodriguez-DlyHzToyqoxBDgjK7y7TUQ@public.gmane.org>,
	Cliff Holden <Cliff.Holden-R2DSYHpuZhhBDgjK7y7TUQ@public.gmane.org>, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kathy Giori <Kathy.Giori-R2DSYHpuZhhBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1293049861-28913-1-git-send-email-juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The Atheros AR71XX/AR724X/AR913X SoCs have a built-in SPI controller. This
patch implements a driver for that.

Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---

Changes since RFC:
    - remove DRV_DESC definition and use its previous value directly in the
      MODULE_DESCRIPTION() macro,
    - use io{read,write}32 accesors instead of __raw_{read,write}l,
    - use __dev{init,exit,exit_p} annotations where in the appropriate places,
    - initialize 'master->bus_num' field to -1 if no platform data specified,
      so that a bus number can be dynamically assigned,
    - rename ath79_spi_drv to ath79_spi_driver to avoid section mismatch 
      warnings

Changes since v1:
    - rebased against 2.6.37-rc7

 .../include/asm/mach-ath79/ath79_spi_platform.h    |   19 ++
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/ath79_spi.c                            |  290 ++++++++++++++++++++
 4 files changed, 318 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
 create mode 100644 drivers/spi/ath79_spi.c

diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
new file mode 100644
index 0000000..aa71216
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
@@ -0,0 +1,19 @@
+/*
+ *  Platform data definition for Atheros AR71XX/AR724X/AR913X SPI controller
+ *
+ *  Copyright (C) 2008-2010 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ */
+
+#ifndef _ATH79_SPI_PLATFORM_H
+#define _ATH79_SPI_PLATFORM_H
+
+struct ath79_spi_platform_data {
+	unsigned	bus_num;
+	unsigned	num_chipselect;
+};
+
+#endif /* _ATH79_SPI_PLATFORM_H */
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 78f9fd0..f2093e1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -53,6 +53,14 @@ if SPI_MASTER
 
 comment "SPI Master Controller Drivers"
 
+config SPI_ATH79
+	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
+	depends on ATH79 && GENERIC_GPIO
+	select SPI_BITBANG
+	help
+	  This enables support for the SPI controller present on the
+	  Atheros AR71XX/AR724X/AR913X SoCs.
+
 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
 	depends on (ARCH_AT91 || AVR32)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8bc1a5a..875bc3d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
+obj-$(CONFIG_SPI_ATH79)			+= ath79_spi.o
 obj-$(CONFIG_SPI_BFIN)			+= spi_bfin5xx.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.o
diff --git a/drivers/spi/ath79_spi.c b/drivers/spi/ath79_spi.c
new file mode 100644
index 0000000..96f169a
--- /dev/null
+++ b/drivers/spi/ath79_spi.c
@@ -0,0 +1,290 @@
+/*
+ * SPI controller driver for the Atheros AR71XX/AR724X/AR913X SoCs
+ *
+ * Copyright (C) 2009-2010 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
+ *
+ * This driver has been based on the spi-gpio.c:
+ *	Copyright (C) 2006,2008 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/bitops.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-ath79/ar71xx_regs.h>
+#include <asm/mach-ath79/ath79_spi_platform.h>
+
+#define DRV_NAME	"ath79-spi"
+
+struct ath79_spi {
+	struct	spi_bitbang	bitbang;
+	u32			ioc_base;
+	u32			reg_ctrl;
+
+	void __iomem		*base;
+
+	struct platform_device	*pdev;
+};
+
+static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
+{
+	return ioread32(sp->base + reg);
+}
+
+static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
+{
+	iowrite32(val, sp->base + reg);
+}
+
+static inline struct ath79_spi *spidev_to_sp(struct spi_device *spi)
+{
+	return spi_master_get_devdata(spi->master);
+}
+
+static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
+{
+	struct ath79_spi *sp = spidev_to_sp(spi);
+	int cs_high = (spi->mode & SPI_CS_HIGH) ? is_active : !is_active;
+
+	if (is_active) {
+		/* set initial clock polarity */
+		if (spi->mode & SPI_CPOL)
+			sp->ioc_base |= AR71XX_SPI_IOC_CLK;
+		else
+			sp->ioc_base &= ~AR71XX_SPI_IOC_CLK;
+
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
+	}
+
+	if (spi->chip_select) {
+		unsigned long gpio = (unsigned long) spi->controller_data;
+
+		/* SPI is normally active-low */
+		gpio_set_value(gpio, cs_high);
+	} else {
+		if (cs_high)
+			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
+		else
+			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
+
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
+	}
+
+}
+
+static int ath79_spi_setup_cs(struct spi_device *spi)
+{
+	struct ath79_spi *sp = spidev_to_sp(spi);
+
+	/* enable GPIO mode */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
+
+	/* save CTRL register */
+	sp->reg_ctrl = ath79_spi_rr(sp, AR71XX_SPI_REG_CTRL);
+	sp->ioc_base = ath79_spi_rr(sp, AR71XX_SPI_REG_IOC);
+
+	/* TODO: setup speed? */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
+
+	if (spi->chip_select) {
+		unsigned long gpio = (unsigned long) spi->controller_data;
+		int status = 0;
+
+		status = gpio_request(gpio, dev_name(&spi->dev));
+		if (status)
+			return status;
+
+		status = gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH);
+		if (status) {
+			gpio_free(gpio);
+			return status;
+		}
+	} else {
+		if (spi->mode & SPI_CS_HIGH)
+			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
+		else
+			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
+	}
+
+	return 0;
+}
+
+static void ath79_spi_cleanup_cs(struct spi_device *spi)
+{
+	struct ath79_spi *sp = spidev_to_sp(spi);
+
+	if (spi->chip_select) {
+		unsigned long gpio = (unsigned long) spi->controller_data;
+		gpio_free(gpio);
+	}
+
+	/* restore CTRL register */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, sp->reg_ctrl);
+	/* disable GPIO mode */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
+}
+
+static int ath79_spi_setup(struct spi_device *spi)
+{
+	int status = 0;
+
+	if (spi->bits_per_word > 32)
+		return -EINVAL;
+
+	if (!spi->controller_state) {
+		status = ath79_spi_setup_cs(spi);
+		if (status)
+			return status;
+	}
+
+	status = spi_bitbang_setup(spi);
+	if (status && !spi->controller_state)
+		ath79_spi_cleanup_cs(spi);
+
+	return status;
+}
+
+static void ath79_spi_cleanup(struct spi_device *spi)
+{
+	ath79_spi_cleanup_cs(spi);
+	spi_bitbang_cleanup(spi);
+}
+
+static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned nsecs,
+			       u32 word, u8 bits)
+{
+	struct ath79_spi *sp = spidev_to_sp(spi);
+	u32 ioc = sp->ioc_base;
+
+	/* clock starts at inactive polarity */
+	for (word <<= (32 - bits); likely(bits); bits--) {
+		u32 out;
+
+		if (word & (1 << 31))
+			out = ioc | AR71XX_SPI_IOC_DO;
+		else
+			out = ioc & ~AR71XX_SPI_IOC_DO;
+
+		/* setup MSB (to slave) on trailing edge */
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, out);
+		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, out | AR71XX_SPI_IOC_CLK);
+
+		word <<= 1;
+	}
+
+	return ath79_spi_rr(sp, AR71XX_SPI_REG_RDS);
+}
+
+static __devinit int ath79_spi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct ath79_spi *sp;
+	struct ath79_spi_platform_data *pdata;
+	struct resource	*r;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*sp));
+	if (master == NULL) {
+		dev_err(&pdev->dev, "failed to allocate spi master\n");
+		return -ENOMEM;
+	}
+
+	sp = spi_master_get_devdata(master);
+	platform_set_drvdata(pdev, sp);
+
+	pdata = pdev->dev.platform_data;
+
+	master->setup = ath79_spi_setup;
+	master->cleanup = ath79_spi_cleanup;
+	if (pdata) {
+		master->bus_num = pdata->bus_num;
+		master->num_chipselect = pdata->num_chipselect;
+	} else {
+		master->bus_num = -1;
+		master->num_chipselect = 1;
+	}
+
+	sp->bitbang.master = spi_master_get(master);
+	sp->bitbang.chipselect = ath79_spi_chipselect;
+	sp->bitbang.txrx_word[SPI_MODE_0] = ath79_spi_txrx_mode0;
+	sp->bitbang.setup_transfer = spi_bitbang_setup_transfer;
+	sp->bitbang.flags = SPI_CS_HIGH;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (r == NULL) {
+		ret = -ENOENT;
+		goto err_put_master;
+	}
+
+	sp->base = ioremap(r->start, r->end - r->start + 1);
+	if (!sp->base) {
+		ret = -ENXIO;
+		goto err_put_master;
+	}
+
+	ret = spi_bitbang_start(&sp->bitbang);
+	if (ret)
+		goto err_unmap;
+
+	return 0;
+
+err_unmap:
+	iounmap(sp->base);
+err_put_master:
+	platform_set_drvdata(pdev, NULL);
+	spi_master_put(sp->bitbang.master);
+
+	return ret;
+}
+
+static __devexit int ath79_spi_remove(struct platform_device *pdev)
+{
+	struct ath79_spi *sp = platform_get_drvdata(pdev);
+
+	spi_bitbang_stop(&sp->bitbang);
+	iounmap(sp->base);
+	platform_set_drvdata(pdev, NULL);
+	spi_master_put(sp->bitbang.master);
+
+	return 0;
+}
+
+static struct platform_driver ath79_spi_driver = {
+	.probe		= ath79_spi_probe,
+	.remove		= __devexit_p(ath79_spi_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static __init int ath79_spi_init(void)
+{
+	return platform_driver_register(&ath79_spi_driver);
+}
+module_init(ath79_spi_init);
+
+static __exit void ath79_spi_exit(void)
+{
+	platform_driver_unregister(&ath79_spi_driver);
+}
+module_exit(ath79_spi_exit);
+
+MODULE_DESCRIPTION("SPI controller driver for Atheros AR71XX/AR724X/AR91X");
+MODULE_AUTHOR("Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
1.7.2.1


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
