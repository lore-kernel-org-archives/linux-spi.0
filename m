From: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: convert spi-bfin-v3.c to a multiplatform driver
Date: Fri, 4 Apr 2014 16:27:17 +0800
Message-ID: <1396600037-2811-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>,
	Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Spi v3 controller is not only used on Blackfin. So rename it
and use ioread/iowrite api to make it work on other platform.

Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/blackfin/mach-bf609/boards/ezkit.c            |   22 +-
 drivers/spi/Kconfig                                |    4 +-
 drivers/spi/Makefile                               |    2 +-
 drivers/spi/{spi-bfin-v3.c => spi-adi-v3.c}        |  420 ++++++++++----------
 .../bfin_spi3.h => include/linux/spi/adi_spi3.h    |   20 +-
 5 files changed, 242 insertions(+), 226 deletions(-)
 rename drivers/spi/{spi-bfin-v3.c => spi-adi-v3.c} (61%)
 rename arch/blackfin/include/asm/bfin_spi3.h => include/linux/spi/adi_spi3.h (97%)

diff --git a/arch/blackfin/mach-bf609/boards/ezkit.c b/arch/blackfin/mach-bf609/boards/ezkit.c
index 8de8bc6..87cf6e5 100644
--- a/arch/blackfin/mach-bf609/boards/ezkit.c
+++ b/arch/blackfin/mach-bf609/boards/ezkit.c
@@ -20,7 +20,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_data/pinctrl-adi2.h>
-#include <asm/bfin_spi3.h>
+#include <linux/spi/adi_spi3.h>
 #include <asm/dma.h>
 #include <asm/gpio.h>
 #include <asm/nand.h>
@@ -768,13 +768,13 @@ static struct flash_platform_data bfin_spi_flash_data = {
 	.type = "w25q32",
 };
 
-static struct bfin_spi3_chip spi_flash_chip_info = {
+static struct adi_spi3_chip spi_flash_chip_info = {
 	.enable_dma = true,         /* use dma transfer with this chip*/
 };
 #endif
 
 #if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
-static struct bfin_spi3_chip spidev_chip_info = {
+static struct adi_spi3_chip spidev_chip_info = {
 	.enable_dma = true,
 };
 #endif
@@ -1746,7 +1746,7 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 	},
 #endif
 };
-#if IS_ENABLED(CONFIG_SPI_BFIN_V3)
+#if IS_ENABLED(CONFIG_SPI_ADI_V3)
 /* SPI (0) */
 static struct resource bfin_spi0_resource[] = {
 	{
@@ -1787,13 +1787,13 @@ static struct resource bfin_spi1_resource[] = {
 };
 
 /* SPI controller data */
-static struct bfin_spi3_master bf60x_spi_master_info0 = {
+static struct adi_spi3_master bf60x_spi_master_info0 = {
 	.num_chipselect = MAX_CTRL_CS + MAX_BLACKFIN_GPIOS,
 	.pin_req = {P_SPI0_SCK, P_SPI0_MISO, P_SPI0_MOSI, 0},
 };
 
 static struct platform_device bf60x_spi_master0 = {
-	.name = "bfin-spi3",
+	.name = "adi-spi3",
 	.id = 0, /* Bus number */
 	.num_resources = ARRAY_SIZE(bfin_spi0_resource),
 	.resource = bfin_spi0_resource,
@@ -1802,13 +1802,13 @@ static struct platform_device bf60x_spi_master0 = {
 	},
 };
 
-static struct bfin_spi3_master bf60x_spi_master_info1 = {
+static struct adi_spi3_master bf60x_spi_master_info1 = {
 	.num_chipselect = MAX_CTRL_CS + MAX_BLACKFIN_GPIOS,
 	.pin_req = {P_SPI1_SCK, P_SPI1_MISO, P_SPI1_MOSI, 0},
 };
 
 static struct platform_device bf60x_spi_master1 = {
-	.name = "bfin-spi3",
+	.name = "adi-spi3",
 	.id = 1, /* Bus number */
 	.num_resources = ARRAY_SIZE(bfin_spi1_resource),
 	.resource = bfin_spi1_resource,
@@ -2000,7 +2000,7 @@ static struct platform_device *ezkit_devices[] __initdata = {
 	&bfin_sdh_device,
 #endif
 
-#if IS_ENABLED(CONFIG_SPI_BFIN_V3)
+#if IS_ENABLED(CONFIG_SPI_ADI_V3)
 	&bf60x_spi_master0,
 	&bf60x_spi_master1,
 #endif
@@ -2066,8 +2066,8 @@ static struct pinctrl_map __initdata bfin_pinmux_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("bfin_sir.1",  "pinctrl-adi2.0", NULL, "uart1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("bfin-sdh.0",  "pinctrl-adi2.0", NULL, "rsi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("stmmaceth.0",  "pinctrl-adi2.0", NULL, "eth0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("bfin-spi3.0",  "pinctrl-adi2.0", NULL, "spi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("bfin-spi3.1",  "pinctrl-adi2.0", NULL, "spi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("adi-spi3.0",  "pinctrl-adi2.0", NULL, "spi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("adi-spi3.1",  "pinctrl-adi2.0", NULL, "spi1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-bfin-twi.0",  "pinctrl-adi2.0", NULL, "twi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-bfin-twi.1",  "pinctrl-adi2.0", NULL, "twi1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("bfin-rotary",  "pinctrl-adi2.0", NULL, "rotary"),
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index efe1960..db2b8e5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -91,8 +91,8 @@ config SPI_BFIN5XX
 	help
 	  This is the SPI controller master driver for Blackfin 5xx processor.
 
-config SPI_BFIN_V3
-	tristate "SPI controller v3 for Blackfin"
+config SPI_ADI_V3
+	tristate "SPI controller v3 for ADI"
 	depends on BF60x
 	help
 	  This is the SPI controller v3 master driver
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index bd79266..71e65df 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_SPI_BCM2835)		+= spi-bcm2835.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
 obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
-obj-$(CONFIG_SPI_BFIN_V3)               += spi-bfin-v3.o
+obj-$(CONFIG_SPI_ADI_V3)                += spi-adi-v3.o
 obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
diff --git a/drivers/spi/spi-bfin-v3.c b/drivers/spi/spi-adi-v3.c
similarity index 61%
rename from drivers/spi/spi-bfin-v3.c
rename to drivers/spi/spi-adi-v3.c
index 4089d0e..0c2914c 100644
--- a/drivers/spi/spi-bfin-v3.c
+++ b/drivers/spi/spi-adi-v3.c
@@ -1,7 +1,7 @@
 /*
  * Analog Devices SPI3 controller driver
  *
- * Copyright (c) 2013 Analog Devices Inc.
+ * Copyright (c) 2014 Analog Devices Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -26,35 +26,34 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/adi_spi3.h>
 #include <linux/types.h>
 
-#include <asm/bfin_spi3.h>
-#include <asm/cacheflush.h>
 #include <asm/dma.h>
 #include <asm/portmux.h>
 
-enum bfin_spi_state {
+enum adi_spi_state {
 	START_STATE,
 	RUNNING_STATE,
 	DONE_STATE,
 	ERROR_STATE
 };
 
-struct bfin_spi_master;
+struct adi_spi_master;
 
-struct bfin_spi_transfer_ops {
-	void (*write) (struct bfin_spi_master *);
-	void (*read) (struct bfin_spi_master *);
-	void (*duplex) (struct bfin_spi_master *);
+struct adi_spi_transfer_ops {
+	void (*write) (struct adi_spi_master *);
+	void (*read) (struct adi_spi_master *);
+	void (*duplex) (struct adi_spi_master *);
 };
 
 /* runtime info for spi master */
-struct bfin_spi_master {
+struct adi_spi_master {
 	/* SPI framework hookup */
 	struct spi_master *master;
 
 	/* Regs base of SPI controller */
-	struct bfin_spi_regs __iomem *regs;
+	struct adi_spi_regs __iomem *regs;
 
 	/* Pin request list */
 	u16 *pin_req;
@@ -65,7 +64,7 @@ struct bfin_spi_master {
 	/* Current message transfer state info */
 	struct spi_message *cur_msg;
 	struct spi_transfer *cur_transfer;
-	struct bfin_spi_device *cur_chip;
+	struct adi_spi_device *cur_chip;
 	unsigned transfer_len;
 
 	/* transfer buffer */
@@ -90,12 +89,12 @@ struct bfin_spi_master {
 	u32 ssel;
 
 	unsigned long sclk;
-	enum bfin_spi_state state;
+	enum adi_spi_state state;
 
-	const struct bfin_spi_transfer_ops *ops;
+	const struct adi_spi_transfer_ops *ops;
 };
 
-struct bfin_spi_device {
+struct adi_spi_device {
 	u32 control;
 	u32 clock;
 	u32 ssel;
@@ -105,17 +104,25 @@ struct bfin_spi_device {
 	u32 cs_gpio;
 	u32 tx_dummy_val; /* tx value for rx only transfer */
 	bool enable_dma;
-	const struct bfin_spi_transfer_ops *ops;
+	const struct adi_spi_transfer_ops *ops;
 };
 
-static void bfin_spi_enable(struct bfin_spi_master *drv_data)
+static void adi_spi_enable(struct adi_spi_master *drv_data)
 {
-	bfin_write_or(&drv_data->regs->control, SPI_CTL_EN);
+	u32 ctl;
+
+	ctl = ioread32(&drv_data->regs->control);
+	ctl |= SPI_CTL_EN;
+	iowrite32(ctl, &drv_data->regs->control);
 }
 
-static void bfin_spi_disable(struct bfin_spi_master *drv_data)
+static void adi_spi_disable(struct adi_spi_master *drv_data)
 {
-	bfin_write_and(&drv_data->regs->control, ~SPI_CTL_EN);
+	u32 ctl;
+
+	ctl = ioread32(&drv_data->regs->control);
+	ctl &= ~SPI_CTL_EN;
+	iowrite32(ctl, &drv_data->regs->control);
 }
 
 /* Caculate the SPI_CLOCK register value based on input HZ */
@@ -128,35 +135,43 @@ static u32 hz_to_spi_clock(u32 sclk, u32 speed_hz)
 	return spi_clock;
 }
 
-static int bfin_spi_flush(struct bfin_spi_master *drv_data)
+static int adi_spi_flush(struct adi_spi_master *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
 	/* wait for stop and clear stat */
-	while (!(bfin_read(&drv_data->regs->status) & SPI_STAT_SPIF) && --limit)
+	while (!(ioread32(&drv_data->regs->status) & SPI_STAT_SPIF) && --limit)
 		cpu_relax();
 
-	bfin_write(&drv_data->regs->status, 0xFFFFFFFF);
+	iowrite32(0xFFFFFFFF, &drv_data->regs->status);
 
 	return limit;
 }
 
 /* Chip select operation functions for cs_change flag */
-static void bfin_spi_cs_active(struct bfin_spi_master *drv_data, struct bfin_spi_device *chip)
+static void adi_spi_cs_active(struct adi_spi_master *drv_data, struct adi_spi_device *chip)
 {
-	if (likely(chip->cs < MAX_CTRL_CS))
-		bfin_write_and(&drv_data->regs->ssel, ~chip->ssel);
-	else
+	if (likely(chip->cs < MAX_CTRL_CS)) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg &= ~chip->ssel;
+		iowrite32(reg, &drv_data->regs->ssel);
+	} else {
 		gpio_set_value(chip->cs_gpio, 0);
+	}
 }
 
-static void bfin_spi_cs_deactive(struct bfin_spi_master *drv_data,
-				struct bfin_spi_device *chip)
+static void adi_spi_cs_deactive(struct adi_spi_master *drv_data,
+				struct adi_spi_device *chip)
 {
-	if (likely(chip->cs < MAX_CTRL_CS))
-		bfin_write_or(&drv_data->regs->ssel, chip->ssel);
-	else
+	if (likely(chip->cs < MAX_CTRL_CS)) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg |= chip->ssel;
+		iowrite32(reg, &drv_data->regs->ssel);
+	} else {
 		gpio_set_value(chip->cs_gpio, 1);
+	}
 
 	/* Move delay here for consistency */
 	if (chip->cs_chg_udelay)
@@ -164,187 +179,192 @@ static void bfin_spi_cs_deactive(struct bfin_spi_master *drv_data,
 }
 
 /* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
-static inline void bfin_spi_cs_enable(struct bfin_spi_master *drv_data,
-					struct bfin_spi_device *chip)
+static inline void adi_spi_cs_enable(struct adi_spi_master *drv_data,
+					struct adi_spi_device *chip)
 {
-	if (chip->cs < MAX_CTRL_CS)
-		bfin_write_or(&drv_data->regs->ssel, chip->ssel >> 8);
+	if (chip->cs < MAX_CTRL_CS) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg |= chip->ssel >> 8;
+		iowrite32(reg, &drv_data->regs->ssel);
+	}
 }
 
-static inline void bfin_spi_cs_disable(struct bfin_spi_master *drv_data,
-					struct bfin_spi_device *chip)
+static inline void adi_spi_cs_disable(struct adi_spi_master *drv_data,
+					struct adi_spi_device *chip)
 {
-	if (chip->cs < MAX_CTRL_CS)
-		bfin_write_and(&drv_data->regs->ssel, ~(chip->ssel >> 8));
+	if (chip->cs < MAX_CTRL_CS) {
+		u32 reg;
+		reg = ioread32(&drv_data->regs->ssel);
+		reg &= ~(chip->ssel >> 8);
+		iowrite32(reg, &drv_data->regs->ssel);
+	}
 }
 
 /* stop controller and re-config current chip*/
-static void bfin_spi_restore_state(struct bfin_spi_master *drv_data)
+static void adi_spi_restore_state(struct adi_spi_master *drv_data)
 {
-	struct bfin_spi_device *chip = drv_data->cur_chip;
+	struct adi_spi_device *chip = drv_data->cur_chip;
 
 	/* Clear status and disable clock */
-	bfin_write(&drv_data->regs->status, 0xFFFFFFFF);
-	bfin_write(&drv_data->regs->rx_control, 0x0);
-	bfin_write(&drv_data->regs->tx_control, 0x0);
-	bfin_spi_disable(drv_data);
-
-	SSYNC();
+	iowrite32(0xFFFFFFFF, &drv_data->regs->status);
+	iowrite32(0x0, &drv_data->regs->rx_control);
+	iowrite32(0x0, &drv_data->regs->tx_control);
+	adi_spi_disable(drv_data);
 
 	/* Load the registers */
-	bfin_write(&drv_data->regs->control, chip->control);
-	bfin_write(&drv_data->regs->clock, chip->clock);
+	iowrite32(chip->control, &drv_data->regs->control);
+	iowrite32(chip->clock, &drv_data->regs->clock);
 
-	bfin_spi_enable(drv_data);
+	adi_spi_enable(drv_data);
 	drv_data->tx_num = drv_data->rx_num = 0;
 	/* we always choose tx transfer initiate */
-	bfin_write(&drv_data->regs->rx_control, SPI_RXCTL_REN);
-	bfin_write(&drv_data->regs->tx_control,
-			SPI_TXCTL_TEN | SPI_TXCTL_TTI);
-	bfin_spi_cs_active(drv_data, chip);
+	iowrite32(SPI_RXCTL_REN, &drv_data->regs->rx_control);
+	iowrite32(SPI_TXCTL_TEN | SPI_TXCTL_TTI, &drv_data->regs->tx_control);
+	adi_spi_cs_active(drv_data, chip);
 }
 
 /* discard invalid rx data and empty rfifo */
-static inline void dummy_read(struct bfin_spi_master *drv_data)
+static inline void dummy_read(struct adi_spi_master *drv_data)
 {
-	while (!(bfin_read(&drv_data->regs->status) & SPI_STAT_RFE))
-		bfin_read(&drv_data->regs->rfifo);
+	while (!(ioread32(&drv_data->regs->status) & SPI_STAT_RFE))
+		ioread32(&drv_data->regs->rfifo);
 }
 
-static void bfin_spi_u8_write(struct bfin_spi_master *drv_data)
+static void adi_spi_u8_write(struct adi_spi_master *drv_data)
 {
 	dummy_read(drv_data);
 	while (drv_data->tx < drv_data->tx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u8 *)(drv_data->tx++)));
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		iowrite32(*(u8 *)(drv_data->tx++), &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		bfin_read(&drv_data->regs->rfifo);
+		ioread32(&drv_data->regs->rfifo);
 	}
 }
 
-static void bfin_spi_u8_read(struct bfin_spi_master *drv_data)
+static void adi_spi_u8_read(struct adi_spi_master *drv_data)
 {
 	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
 
 	dummy_read(drv_data);
 	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, tx_val);
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		iowrite32(tx_val, &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		*(u8 *)(drv_data->rx++) = bfin_read(&drv_data->regs->rfifo);
+		*(u8 *)(drv_data->rx++) = ioread32(&drv_data->regs->rfifo);
 	}
 }
 
-static void bfin_spi_u8_duplex(struct bfin_spi_master *drv_data)
+static void adi_spi_u8_duplex(struct adi_spi_master *drv_data)
 {
 	dummy_read(drv_data);
 	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u8 *)(drv_data->tx++)));
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		iowrite32(*(u8 *)(drv_data->tx++), &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		*(u8 *)(drv_data->rx++) = bfin_read(&drv_data->regs->rfifo);
+		*(u8 *)(drv_data->rx++) = ioread32(&drv_data->regs->rfifo);
 	}
 }
 
-static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u8 = {
-	.write  = bfin_spi_u8_write,
-	.read   = bfin_spi_u8_read,
-	.duplex = bfin_spi_u8_duplex,
+static const struct adi_spi_transfer_ops adi_spi_transfer_ops_u8 = {
+	.write  = adi_spi_u8_write,
+	.read   = adi_spi_u8_read,
+	.duplex = adi_spi_u8_duplex,
 };
 
-static void bfin_spi_u16_write(struct bfin_spi_master *drv_data)
+static void adi_spi_u16_write(struct adi_spi_master *drv_data)
 {
 	dummy_read(drv_data);
 	while (drv_data->tx < drv_data->tx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u16 *)drv_data->tx));
+		iowrite32(*(u16 *)drv_data->tx, &drv_data->regs->tfifo);
 		drv_data->tx += 2;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		bfin_read(&drv_data->regs->rfifo);
+		ioread32(&drv_data->regs->rfifo);
 	}
 }
 
-static void bfin_spi_u16_read(struct bfin_spi_master *drv_data)
+static void adi_spi_u16_read(struct adi_spi_master *drv_data)
 {
 	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
 
 	dummy_read(drv_data);
 	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, tx_val);
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		iowrite32(tx_val, &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		*(u16 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
+		*(u16 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
 		drv_data->rx += 2;
 	}
 }
 
-static void bfin_spi_u16_duplex(struct bfin_spi_master *drv_data)
+static void adi_spi_u16_duplex(struct adi_spi_master *drv_data)
 {
 	dummy_read(drv_data);
 	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u16 *)drv_data->tx));
+		iowrite32(*(u16 *)drv_data->tx, &drv_data->regs->tfifo);
 		drv_data->tx += 2;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		*(u16 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
+		*(u16 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
 		drv_data->rx += 2;
 	}
 }
 
-static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u16 = {
-	.write  = bfin_spi_u16_write,
-	.read   = bfin_spi_u16_read,
-	.duplex = bfin_spi_u16_duplex,
+static const struct adi_spi_transfer_ops adi_spi_transfer_ops_u16 = {
+	.write  = adi_spi_u16_write,
+	.read   = adi_spi_u16_read,
+	.duplex = adi_spi_u16_duplex,
 };
 
-static void bfin_spi_u32_write(struct bfin_spi_master *drv_data)
+static void adi_spi_u32_write(struct adi_spi_master *drv_data)
 {
 	dummy_read(drv_data);
 	while (drv_data->tx < drv_data->tx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u32 *)drv_data->tx));
+		iowrite32(*(u32 *)drv_data->tx, &drv_data->regs->tfifo);
 		drv_data->tx += 4;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		bfin_read(&drv_data->regs->rfifo);
+		ioread32(&drv_data->regs->rfifo);
 	}
 }
 
-static void bfin_spi_u32_read(struct bfin_spi_master *drv_data)
+static void adi_spi_u32_read(struct adi_spi_master *drv_data)
 {
 	u32 tx_val = drv_data->cur_chip->tx_dummy_val;
 
 	dummy_read(drv_data);
 	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, tx_val);
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		iowrite32(tx_val, &drv_data->regs->tfifo);
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		*(u32 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
+		*(u32 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
 		drv_data->rx += 4;
 	}
 }
 
-static void bfin_spi_u32_duplex(struct bfin_spi_master *drv_data)
+static void adi_spi_u32_duplex(struct adi_spi_master *drv_data)
 {
 	dummy_read(drv_data);
 	while (drv_data->rx < drv_data->rx_end) {
-		bfin_write(&drv_data->regs->tfifo, (*(u32 *)drv_data->tx));
+		iowrite32(*(u32 *)drv_data->tx, &drv_data->regs->tfifo);
 		drv_data->tx += 4;
-		while (bfin_read(&drv_data->regs->status) & SPI_STAT_RFE)
+		while (ioread32(&drv_data->regs->status) & SPI_STAT_RFE)
 			cpu_relax();
-		*(u32 *)drv_data->rx = bfin_read(&drv_data->regs->rfifo);
+		*(u32 *)drv_data->rx = ioread32(&drv_data->regs->rfifo);
 		drv_data->rx += 4;
 	}
 }
 
-static const struct bfin_spi_transfer_ops bfin_bfin_spi_transfer_ops_u32 = {
-	.write  = bfin_spi_u32_write,
-	.read   = bfin_spi_u32_read,
-	.duplex = bfin_spi_u32_duplex,
+static const struct adi_spi_transfer_ops adi_spi_transfer_ops_u32 = {
+	.write  = adi_spi_u32_write,
+	.read   = adi_spi_u32_read,
+	.duplex = adi_spi_u32_duplex,
 };
 
 
 /* test if there is more transfer to be done */
-static void bfin_spi_next_transfer(struct bfin_spi_master *drv)
+static void adi_spi_next_transfer(struct adi_spi_master *drv)
 {
 	struct spi_message *msg = drv->cur_msg;
 	struct spi_transfer *t = drv->cur_transfer;
@@ -360,15 +380,15 @@ static void bfin_spi_next_transfer(struct bfin_spi_master *drv)
 	}
 }
 
-static void bfin_spi_giveback(struct bfin_spi_master *drv_data)
+static void adi_spi_giveback(struct adi_spi_master *drv_data)
 {
-	struct bfin_spi_device *chip = drv_data->cur_chip;
+	struct adi_spi_device *chip = drv_data->cur_chip;
 
-	bfin_spi_cs_deactive(drv_data, chip);
+	adi_spi_cs_deactive(drv_data, chip);
 	spi_finalize_current_message(drv_data->master);
 }
 
-static int bfin_spi_setup_transfer(struct bfin_spi_master *drv)
+static int adi_spi_setup_transfer(struct adi_spi_master *drv)
 {
 	struct spi_transfer *t = drv->cur_transfer;
 	u32 cr, cr_width;
@@ -393,34 +413,33 @@ static int bfin_spi_setup_transfer(struct bfin_spi_master *drv)
 	switch (t->bits_per_word) {
 	case 8:
 		cr_width = SPI_CTL_SIZE08;
-		drv->ops = &bfin_bfin_spi_transfer_ops_u8;
+		drv->ops = &adi_spi_transfer_ops_u8;
 		break;
 	case 16:
 		cr_width = SPI_CTL_SIZE16;
-		drv->ops = &bfin_bfin_spi_transfer_ops_u16;
+		drv->ops = &adi_spi_transfer_ops_u16;
 		break;
 	case 32:
 		cr_width = SPI_CTL_SIZE32;
-		drv->ops = &bfin_bfin_spi_transfer_ops_u32;
+		drv->ops = &adi_spi_transfer_ops_u32;
 		break;
 	default:
 		return -EINVAL;
 	}
-	cr = bfin_read(&drv->regs->control) & ~SPI_CTL_SIZE;
+	cr = ioread32(&drv->regs->control) & ~SPI_CTL_SIZE;
 	cr |= cr_width;
-	bfin_write(&drv->regs->control, cr);
+	iowrite32(cr, &drv->regs->control);
 
 	/* speed setup */
-	bfin_write(&drv->regs->clock,
-			hz_to_spi_clock(drv->sclk, t->speed_hz));
+	iowrite32(hz_to_spi_clock(drv->sclk, t->speed_hz), &drv->regs->clock);
 	return 0;
 }
 
-static int bfin_spi_dma_xfer(struct bfin_spi_master *drv_data)
+static int adi_spi_dma_xfer(struct adi_spi_master *drv_data)
 {
 	struct spi_transfer *t = drv_data->cur_transfer;
 	struct spi_message *msg = drv_data->cur_msg;
-	struct bfin_spi_device *chip = drv_data->cur_chip;
+	struct adi_spi_device *chip = drv_data->cur_chip;
 	u32 dma_config;
 	unsigned long word_count, word_size;
 	void *tx_buf, *rx_buf;
@@ -498,17 +517,16 @@ static int bfin_spi_dma_xfer(struct bfin_spi_master *drv_data)
 	set_dma_config(drv_data->rx_dma, dma_config | WNR);
 	enable_dma(drv_data->tx_dma);
 	enable_dma(drv_data->rx_dma);
-	SSYNC();
 
-	bfin_write(&drv_data->regs->rx_control, SPI_RXCTL_REN | SPI_RXCTL_RDR_NE);
-	SSYNC();
-	bfin_write(&drv_data->regs->tx_control,
-			SPI_TXCTL_TEN | SPI_TXCTL_TTI | SPI_TXCTL_TDR_NF);
+	iowrite32(SPI_RXCTL_REN | SPI_RXCTL_RDR_NE,
+			&drv_data->regs->rx_control);
+	iowrite32(SPI_TXCTL_TEN | SPI_TXCTL_TTI | SPI_TXCTL_TDR_NF,
+			&drv_data->regs->tx_control);
 
 	return 0;
 }
 
-static int bfin_spi_pio_xfer(struct bfin_spi_master *drv_data)
+static int adi_spi_pio_xfer(struct adi_spi_master *drv_data)
 {
 	struct spi_message *msg = drv_data->cur_msg;
 
@@ -529,19 +547,19 @@ static int bfin_spi_pio_xfer(struct bfin_spi_master *drv_data)
 			return -EIO;
 	}
 
-	if (!bfin_spi_flush(drv_data))
+	if (!adi_spi_flush(drv_data))
 		return -EIO;
 	msg->actual_length += drv_data->transfer_len;
 	tasklet_schedule(&drv_data->pump_transfers);
 	return 0;
 }
 
-static void bfin_spi_pump_transfers(unsigned long data)
+static void adi_spi_pump_transfers(unsigned long data)
 {
-	struct bfin_spi_master *drv_data = (struct bfin_spi_master *)data;
+	struct adi_spi_master *drv_data = (struct adi_spi_master *)data;
 	struct spi_message *msg = NULL;
 	struct spi_transfer *t = NULL;
-	struct bfin_spi_device *chip = NULL;
+	struct adi_spi_device *chip = NULL;
 	int ret;
 
 	/* Get current state information */
@@ -552,7 +570,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	/* Handle for abort */
 	if (drv_data->state == ERROR_STATE) {
 		msg->status = -EIO;
-		bfin_spi_giveback(drv_data);
+		adi_spi_giveback(drv_data);
 		return;
 	}
 
@@ -560,14 +578,14 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		if (t->delay_usecs)
 			udelay(t->delay_usecs);
 		if (t->cs_change)
-			bfin_spi_cs_deactive(drv_data, chip);
-		bfin_spi_next_transfer(drv_data);
+			adi_spi_cs_deactive(drv_data, chip);
+		adi_spi_next_transfer(drv_data);
 		t = drv_data->cur_transfer;
 	}
 	/* Handle end of message */
 	if (drv_data->state == DONE_STATE) {
 		msg->status = 0;
-		bfin_spi_giveback(drv_data);
+		adi_spi_giveback(drv_data);
 		return;
 	}
 
@@ -577,34 +595,34 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		return;
 	}
 
-	ret = bfin_spi_setup_transfer(drv_data);
+	ret = adi_spi_setup_transfer(drv_data);
 	if (ret) {
 		msg->status = ret;
-		bfin_spi_giveback(drv_data);
+		adi_spi_giveback(drv_data);
 	}
 
-	bfin_write(&drv_data->regs->status, 0xFFFFFFFF);
-	bfin_spi_cs_active(drv_data, chip);
+	iowrite32(0xFFFFFFFF, &drv_data->regs->status);
+	adi_spi_cs_active(drv_data, chip);
 	drv_data->state = RUNNING_STATE;
 
 	if (chip->enable_dma)
-		ret = bfin_spi_dma_xfer(drv_data);
+		ret = adi_spi_dma_xfer(drv_data);
 	else
-		ret = bfin_spi_pio_xfer(drv_data);
+		ret = adi_spi_pio_xfer(drv_data);
 	if (ret) {
 		msg->status = ret;
-		bfin_spi_giveback(drv_data);
+		adi_spi_giveback(drv_data);
 	}
 }
 
-static int bfin_spi_transfer_one_message(struct spi_master *master,
+static int adi_spi_transfer_one_message(struct spi_master *master,
 					struct spi_message *m)
 {
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
 
 	drv_data->cur_msg = m;
 	drv_data->cur_chip = spi_get_ctldata(drv_data->cur_msg->spi);
-	bfin_spi_restore_state(drv_data);
+	adi_spi_restore_state(drv_data);
 
 	drv_data->state = START_STATE;
 	drv_data->cur_transfer = list_entry(drv_data->cur_msg->transfers.next,
@@ -630,15 +648,15 @@ static const u16 ssel[][MAX_SPI_SSEL] = {
 	P_SPI2_SSEL6, P_SPI2_SSEL7},
 };
 
-static int bfin_spi_setup(struct spi_device *spi)
+static int adi_spi_setup(struct spi_device *spi)
 {
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(spi->master);
-	struct bfin_spi_device *chip = spi_get_ctldata(spi);
-	u32 bfin_ctl_reg = SPI_CTL_ODM | SPI_CTL_PSSE;
+	struct adi_spi_master *drv_data = spi_master_get_devdata(spi->master);
+	struct adi_spi_device *chip = spi_get_ctldata(spi);
+	u32 ctl_reg = SPI_CTL_ODM | SPI_CTL_PSSE;
 	int ret = -EINVAL;
 
 	if (!chip) {
-		struct bfin_spi3_chip *chip_info = spi->controller_data;
+		struct adi_spi3_chip *chip_info = spi->controller_data;
 
 		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 		if (!chip) {
@@ -646,7 +664,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 			return -ENOMEM;
 		}
 		if (chip_info) {
-			if (chip_info->control & ~bfin_ctl_reg) {
+			if (chip_info->control & ~ctl_reg) {
 				dev_err(&spi->dev,
 					"do not set bits that the SPI framework manages\n");
 				goto error;
@@ -657,6 +675,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 			chip->enable_dma = chip_info->enable_dma;
 		}
 		chip->cs = spi->chip_select;
+
 		if (chip->cs < MAX_CTRL_CS) {
 			chip->ssel = (1 << chip->cs) << 8;
 			ret = peripheral_request(ssel[spi->master->bus_num]
@@ -678,7 +697,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	}
 
 	/* force a default base state */
-	chip->control &= bfin_ctl_reg;
+	chip->control &= ctl_reg;
 
 	if (spi->mode & SPI_CPOL)
 		chip->control |= SPI_CTL_CPOL;
@@ -692,8 +711,8 @@ static int bfin_spi_setup(struct spi_device *spi)
 
 	chip->clock = hz_to_spi_clock(drv_data->sclk, spi->max_speed_hz);
 
-	bfin_spi_cs_enable(drv_data, chip);
-	bfin_spi_cs_deactive(drv_data, chip);
+	adi_spi_cs_enable(drv_data, chip);
+	adi_spi_cs_deactive(drv_data, chip);
 
 	return 0;
 error:
@@ -705,10 +724,10 @@ error:
 	return ret;
 }
 
-static void bfin_spi_cleanup(struct spi_device *spi)
+static void adi_spi_cleanup(struct spi_device *spi)
 {
-	struct bfin_spi_device *chip = spi_get_ctldata(spi);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(spi->master);
+	struct adi_spi_device *chip = spi_get_ctldata(spi);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(spi->master);
 
 	if (!chip)
 		return;
@@ -716,7 +735,7 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 	if (chip->cs < MAX_CTRL_CS) {
 		peripheral_free(ssel[spi->master->bus_num]
 					[chip->cs-1]);
-		bfin_spi_cs_disable(drv_data, chip);
+		adi_spi_cs_disable(drv_data, chip);
 	} else {
 		gpio_free(chip->cs_gpio);
 	}
@@ -725,10 +744,11 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 	spi_set_ctldata(spi, NULL);
 }
 
-static irqreturn_t bfin_spi_tx_dma_isr(int irq, void *dev_id)
+static irqreturn_t adi_spi_tx_dma_isr(int irq, void *dev_id)
 {
-	struct bfin_spi_master *drv_data = dev_id;
+	struct adi_spi_master *drv_data = dev_id;
 	u32 dma_stat = get_dma_curr_irqstat(drv_data->tx_dma);
+	u32 tx_ctl;
 
 	clear_dma_irqstat(drv_data->tx_dma);
 	if (dma_stat & DMA_DONE) {
@@ -739,13 +759,15 @@ static irqreturn_t bfin_spi_tx_dma_isr(int irq, void *dev_id)
 		if (drv_data->tx)
 			drv_data->state = ERROR_STATE;
 	}
-	bfin_write_and(&drv_data->regs->tx_control, ~SPI_TXCTL_TDR_NF);
+	tx_ctl = ioread32(&drv_data->regs->tx_control);
+	tx_ctl &= ~SPI_TXCTL_TDR_NF;
+	iowrite32(tx_ctl, &drv_data->regs->tx_control);
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t bfin_spi_rx_dma_isr(int irq, void *dev_id)
+static irqreturn_t adi_spi_rx_dma_isr(int irq, void *dev_id)
 {
-	struct bfin_spi_master *drv_data = dev_id;
+	struct adi_spi_master *drv_data = dev_id;
 	struct spi_message *msg = drv_data->cur_msg;
 	u32 dma_stat = get_dma_curr_irqstat(drv_data->rx_dma);
 
@@ -760,8 +782,8 @@ static irqreturn_t bfin_spi_rx_dma_isr(int irq, void *dev_id)
 		dev_err(&drv_data->master->dev,
 				"spi rx dma error: %d\n", dma_stat);
 	}
-	bfin_write(&drv_data->regs->tx_control, 0);
-	bfin_write(&drv_data->regs->rx_control, 0);
+	iowrite32(0, &drv_data->regs->tx_control);
+	iowrite32(0, &drv_data->regs->rx_control);
 	if (drv_data->rx_num != drv_data->tx_num)
 		dev_dbg(&drv_data->master->dev,
 				"dma interrupt missing: tx=%d,rx=%d\n",
@@ -770,12 +792,12 @@ static irqreturn_t bfin_spi_rx_dma_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int bfin_spi_probe(struct platform_device *pdev)
+static int adi_spi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct bfin_spi3_master *info = dev_get_platdata(dev);
+	struct adi_spi3_master *info = dev_get_platdata(dev);
 	struct spi_master *master;
-	struct bfin_spi_master *drv_data;
+	struct adi_spi_master *drv_data;
 	struct resource *mem, *res;
 	unsigned int tx_dma, rx_dma;
 	unsigned long sclk;
@@ -819,9 +841,9 @@ static int bfin_spi_probe(struct platform_device *pdev)
 
 	master->bus_num = pdev->id;
 	master->num_chipselect = info->num_chipselect;
-	master->cleanup = bfin_spi_cleanup;
-	master->setup = bfin_spi_setup;
-	master->transfer_one_message = bfin_spi_transfer_one_message;
+	master->cleanup = adi_spi_cleanup;
+	master->setup = adi_spi_setup;
+	master->transfer_one_message = adi_spi_transfer_one_message;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
 
@@ -845,28 +867,28 @@ static int bfin_spi_probe(struct platform_device *pdev)
 		dev_err(dev, "can not request SPI TX DMA channel\n");
 		goto err_put_master;
 	}
-	set_dma_callback(tx_dma, bfin_spi_tx_dma_isr, drv_data);
+	set_dma_callback(tx_dma, adi_spi_tx_dma_isr, drv_data);
 
 	ret = request_dma(rx_dma, "SPI_RX_DMA");
 	if (ret) {
 		dev_err(dev, "can not request SPI RX DMA channel\n");
 		goto err_free_tx_dma;
 	}
-	set_dma_callback(drv_data->rx_dma, bfin_spi_rx_dma_isr, drv_data);
+	set_dma_callback(drv_data->rx_dma, adi_spi_rx_dma_isr, drv_data);
 
 	/* request CLK, MOSI and MISO */
-	ret = peripheral_request_list(drv_data->pin_req, "bfin-spi3");
+	ret = peripheral_request_list(drv_data->pin_req, "adi-spi3");
 	if (ret < 0) {
 		dev_err(dev, "can not request spi pins\n");
 		goto err_free_rx_dma;
 	}
 
-	bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL_CPHA);
-	bfin_write(&drv_data->regs->ssel, 0x0000FE00);
-	bfin_write(&drv_data->regs->delay, 0x0);
+	iowrite32(SPI_CTL_MSTR | SPI_CTL_CPHA, &drv_data->regs->control);
+	iowrite32(0x0000FE00, &drv_data->regs->ssel);
+	iowrite32(0x0, &drv_data->regs->delay);
 
 	tasklet_init(&drv_data->pump_transfers,
-			bfin_spi_pump_transfers, (unsigned long)drv_data);
+			adi_spi_pump_transfers, (unsigned long)drv_data);
 	/* register with the SPI framework */
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
@@ -888,43 +910,41 @@ err_put_master:
 	return ret;
 }
 
-static int bfin_spi_remove(struct platform_device *pdev)
+static int adi_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
-
-	bfin_spi_disable(drv_data);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
 
+	adi_spi_disable(drv_data);
 	peripheral_free_list(drv_data->pin_req);
 	free_dma(drv_data->rx_dma);
 	free_dma(drv_data->tx_dma);
-
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int bfin_spi_suspend(struct device *dev)
+static int adi_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
 
 	spi_master_suspend(master);
 
-	drv_data->control = bfin_read(&drv_data->regs->control);
-	drv_data->ssel = bfin_read(&drv_data->regs->ssel);
+	drv_data->control = ioread32(&drv_data->regs->control);
+	drv_data->ssel = ioread32(&drv_data->regs->ssel);
 
-	bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL_CPHA);
-	bfin_write(&drv_data->regs->ssel, 0x0000FE00);
+	iowrite32(SPI_CTL_MSTR | SPI_CTL_CPHA, &drv_data->regs->control);
+	iowrite32(0x0000FE00, &drv_data->regs->ssel);
 	dma_disable_irq(drv_data->rx_dma);
 	dma_disable_irq(drv_data->tx_dma);
 
 	return 0;
 }
 
-static int bfin_spi_resume(struct device *dev)
+static int adi_spi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct bfin_spi_master *drv_data = spi_master_get_devdata(master);
+	struct adi_spi_master *drv_data = spi_master_get_devdata(master);
 	int ret = 0;
 
 	/* bootrom may modify spi and dma status when resume in spi boot mode */
@@ -932,8 +952,8 @@ static int bfin_spi_resume(struct device *dev)
 
 	dma_enable_irq(drv_data->rx_dma);
 	dma_enable_irq(drv_data->tx_dma);
-	bfin_write(&drv_data->regs->control, drv_data->control);
-	bfin_write(&drv_data->regs->ssel, drv_data->ssel);
+	iowrite32(drv_data->control, &drv_data->regs->control);
+	iowrite32(drv_data->ssel, &drv_data->regs->ssel);
 
 	ret = spi_master_resume(master);
 	if (ret) {
@@ -944,21 +964,21 @@ static int bfin_spi_resume(struct device *dev)
 	return ret;
 }
 #endif
-static const struct dev_pm_ops bfin_spi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(bfin_spi_suspend, bfin_spi_resume)
+static const struct dev_pm_ops adi_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(adi_spi_suspend, adi_spi_resume)
 };
 
-MODULE_ALIAS("platform:bfin-spi3");
-static struct platform_driver bfin_spi_driver = {
+MODULE_ALIAS("platform:adi-spi3");
+static struct platform_driver adi_spi_driver = {
 	.driver	= {
-		.name	= "bfin-spi3",
+		.name	= "adi-spi3",
 		.owner	= THIS_MODULE,
-		.pm     = &bfin_spi_pm_ops,
+		.pm     = &adi_spi_pm_ops,
 	},
-	.remove		= bfin_spi_remove,
+	.remove		= adi_spi_remove,
 };
 
-module_platform_driver_probe(bfin_spi_driver, bfin_spi_probe);
+module_platform_driver_probe(adi_spi_driver, adi_spi_probe);
 
 MODULE_DESCRIPTION("Analog Devices SPI3 controller driver");
 MODULE_AUTHOR("Scott Jiang <Scott.Jiang.Linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
diff --git a/arch/blackfin/include/asm/bfin_spi3.h b/include/linux/spi/adi_spi3.h
similarity index 97%
rename from arch/blackfin/include/asm/bfin_spi3.h
rename to include/linux/spi/adi_spi3.h
index 0957e65a..c84123a 100644
--- a/arch/blackfin/include/asm/bfin_spi3.h
+++ b/include/linux/spi/adi_spi3.h
@@ -1,7 +1,7 @@
 /*
  * Analog Devices SPI3 controller driver
  *
- * Copyright (c) 2011 Analog Devices Inc.
+ * Copyright (c) 2014 Analog Devices Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,14 +11,10 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifndef _SPI_CHANNEL_H_
-#define _SPI_CHANNEL_H_
+#ifndef _ADI_SPI3_H_
+#define _ADI_SPI3_H_
 
 #include <linux/types.h>
 
@@ -209,9 +205,9 @@
 #define SPI_ILAT_CLR_TFI            0x00000800    /* Transmit Finish Indication */
 
 /*
- * bfin spi3 registers layout
+ * adi spi3 registers layout
  */
-struct bfin_spi_regs {
+struct adi_spi_regs {
 	u32 revid;
 	u32 control;
 	u32 rx_control;
@@ -240,7 +236,7 @@ struct bfin_spi_regs {
 #define MAX_CTRL_CS          8  /* cs in spi controller */
 
 /* device.platform_data for SSP controller devices */
-struct bfin_spi3_master {
+struct adi_spi3_master {
 	u16 num_chipselect;
 	u16 pin_req[7];
 };
@@ -248,11 +244,11 @@ struct bfin_spi3_master {
 /* spi_board_info.controller_data for SPI slave devices,
  * copied to spi_device.platform_data ... mostly for dma tuning
  */
-struct bfin_spi3_chip {
+struct adi_spi3_chip {
 	u32 control;
 	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
 	u32 tx_dummy_val; /* tx value for rx only transfer */
 	bool enable_dma;
 };
 
-#endif /* _SPI_CHANNEL_H_ */
+#endif /* _ADI_SPI3_H_ */
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
