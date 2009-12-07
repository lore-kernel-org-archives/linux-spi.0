From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] sh: MSIOF/mmc_spi platform data for the Ecovec24 board
Date: Mon, 07 Dec 2009 23:05:45 +0900
Message-ID: <20091207140545.6294.90256.sendpatchset@rxone.opensource.se>
Cc: spi-devel-general@lists.sourceforge.net,
	Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org,
	akpm@linux-foundation.org
To: linux-sh@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds MSIOF and mmc_spi platform data for
the CN11 port on the SuperH Ecovec24 board. No card
detect interrupt is available so the MMC code is
configured to poll. The WP signal is implemented
together with CD and power control. The board only
supports 3.3V power.

The platform data is wrapped in SDHI #ifdefs to
allow both the SDHI and the MSIOF to coexist. Only
one configuration is allowed at a time. The pin
routing is selected by a dip switch but we can
unfortunately not detect this setting at run time.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the MSIOF header file.

 arch/sh/boards/mach-ecovec24/setup.c |   97 +++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-12-07 22:37:51.000000000 +0900
@@ -19,6 +19,10 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/sh_msiof.h>
+#include <linux/spi/mmc_spi.h>
+#include <linux/mmc/host.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
@@ -421,6 +425,7 @@ static struct i2c_board_info ts_i2c_clie
 	.irq		= IRQ0,
 };
 
+#ifdef CONFIG_MFD_SH_MOBILE_SDHI
 /* SHDI0 */
 static void sdhi0_set_pwr(struct platform_device *pdev, int state)
 {
@@ -493,6 +498,73 @@ static struct platform_device sdhi1_devi
 	},
 };
 
+#else
+
+static int mmc_spi_get_ro(struct device *dev)
+{
+	return gpio_get_value(GPIO_PTY6);
+}
+
+static int mmc_spi_get_cd(struct device *dev)
+{
+	return !gpio_get_value(GPIO_PTY7);
+}
+
+static void mmc_spi_setpower(struct device *dev, unsigned int maskval)
+{
+	gpio_set_value(GPIO_PTB6, maskval ? 1 : 0);
+}
+
+static struct mmc_spi_platform_data mmc_spi_info = {
+	.get_ro = mmc_spi_get_ro,
+	.get_cd = mmc_spi_get_cd,
+	.caps = MMC_CAP_NEEDS_POLL,
+	.ocr_mask = MMC_VDD_32_33 | MMC_VDD_33_34, /* 3.3V only */
+	.setpower = mmc_spi_setpower,
+};
+
+static struct spi_board_info spi_bus[] = {
+	{
+		.modalias	= "mmc_spi",
+		.platform_data	= &mmc_spi_info,
+		.max_speed_hz	= 5000000,
+		.mode		= SPI_MODE_0,
+		.controller_data = (void *) GPIO_PTM4,
+	},
+};
+
+static struct sh_msiof_spi_info msiof0_data = {
+	.num_chipselect = 1,
+};
+
+static struct resource msiof0_resources[] = {
+	[0] = {
+		.name	= "MSIOF0",
+		.start	= 0xa4c40000,
+		.end	= 0xa4c40063,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 84,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device msiof0_device = {
+	.name		= "spi_sh_msiof",
+	.id		= 0, /* MSIOF0 */
+	.dev = {
+		.platform_data = &msiof0_data,
+	},
+	.num_resources	= ARRAY_SIZE(msiof0_resources),
+	.resource	= msiof0_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_MSIOF0,
+	},
+};
+
+#endif
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -503,8 +575,12 @@ static struct platform_device *ecovec_de
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
+#ifdef CONFIG_MFD_SH_MOBILE_SDHI
 	&sdhi0_device,
 	&sdhi1_device,
+#else
+	&msiof0_device,
+#endif
 };
 
 #define EEPROM_ADDR 0x50
@@ -773,7 +849,8 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR5);
 	gpio_direction_input(GPIO_PTR6);
 
-	/* enable SDHI0 (needs DS2.4 set to ON) */
+#ifdef CONFIG_MFD_SH_MOBILE_SDHI
+	/* enable SDHI0 on CN11 (needs DS2.4 set to ON) */
 	gpio_request(GPIO_FN_SDHI0CD,  NULL);
 	gpio_request(GPIO_FN_SDHI0WP,  NULL);
 	gpio_request(GPIO_FN_SDHI0CMD, NULL);
@@ -785,7 +862,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_PTB6, NULL);
 	gpio_direction_output(GPIO_PTB6, 0);
 
-	/* enable SDHI1 (needs DS2.6,7 set to ON,OFF) */
+	/* enable SDHI1 on CN12 (needs DS2.6,7 set to ON,OFF) */
 	gpio_request(GPIO_FN_SDHI1CD,  NULL);
 	gpio_request(GPIO_FN_SDHI1WP,  NULL);
 	gpio_request(GPIO_FN_SDHI1CMD, NULL);
@@ -799,6 +876,22 @@ static int __init arch_setup(void)
 
 	/* I/O buffer drive ability is high for SDHI1 */
 	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
+#else
+	/* enable MSIOF0 on CN11 (needs DS2.4 set to OFF) */
+	gpio_request(GPIO_FN_MSIOF0_TXD, NULL);
+	gpio_request(GPIO_FN_MSIOF0_RXD, NULL);
+	gpio_request(GPIO_FN_MSIOF0_TSCK, NULL);
+	gpio_request(GPIO_PTM4, NULL); /* software CS control of TSYNC pin */
+	gpio_direction_output(GPIO_PTM4, 1); /* active low CS */
+	gpio_request(GPIO_PTB6, NULL); /* 3.3V power control */
+	gpio_direction_output(GPIO_PTB6, 0); /* disable power by default */
+	gpio_request(GPIO_PTY6, NULL); /* write protect */
+	gpio_direction_input(GPIO_PTY6);
+	gpio_request(GPIO_PTY7, NULL); /* card detect */
+	gpio_direction_input(GPIO_PTY7);
+
+	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
+#endif
 
 	/* enable I2C device */
 	i2c_register_board_info(1, i2c1_devices,
