From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2] spi: spi-ep93xx: simplify GPIO chip selects
Date: Thu, 16 Feb 2017 11:26:14 -0700
Message-ID: <20170216182614.47941-1-hsweeten@visionengravers.com>
Cc: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This driver requires a GPIO line to be used for the chip select of
each SPI device.

Remove the ep93xx_spi_chip_ops definition from the platform data
and use the spi core GPIO handling for the chip selects.

Fix all the ep93xx platforms that use this driver and remove the
old Documentation.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/spi/ep93xx_spi             | 105 -----------------------
 arch/arm/mach-ep93xx/edb93xx.c           |  31 ++-----
 arch/arm/mach-ep93xx/simone.c            |  64 +++-----------
 arch/arm/mach-ep93xx/vision_ep9307.c     |  88 +++----------------
 drivers/spi/spi-ep93xx.c                 | 139 ++++++++++---------------------
 include/linux/platform_data/spi-ep93xx.h |  17 +---
 6 files changed, 74 insertions(+), 370 deletions(-)
 delete mode 100644 Documentation/spi/ep93xx_spi

diff --git a/Documentation/spi/ep93xx_spi b/Documentation/spi/ep93xx_spi
deleted file mode 100644
index 832ddce..0000000
--- a/Documentation/spi/ep93xx_spi
+++ /dev/null
@@ -1,105 +0,0 @@
-Cirrus EP93xx SPI controller driver HOWTO
-=========================================
-
-ep93xx_spi driver brings SPI master support for EP93xx SPI controller.  Chip
-selects are implemented with GPIO lines.
-
-NOTE: If possible, don't use SFRMOUT (SFRM1) signal as a chip select. It will
-not work correctly (it cannot be controlled by software). Use GPIO lines
-instead.
-
-Sample configuration
-====================
-
-Typically driver configuration is done in platform board files (the files under
-arch/arm/mach-ep93xx/*.c). In this example we configure MMC over SPI through
-this driver on TS-7260 board. You can adapt the code to suit your needs.
-
-This example uses EGPIO9 as SD/MMC card chip select (this is wired in DIO1
-header on the board).
-
-You need to select CONFIG_MMC_SPI to use mmc_spi driver.
-
-arch/arm/mach-ep93xx/ts72xx.c:
-
-...
-#include <linux/gpio.h>
-#include <linux/spi/spi.h>
-
-#include <linux/platform_data/spi-ep93xx.h>
-
-/* this is our GPIO line used for chip select */
-#define MMC_CHIP_SELECT_GPIO EP93XX_GPIO_LINE_EGPIO9
-
-static int ts72xx_mmc_spi_setup(struct spi_device *spi)
-{
-	int err;
-
-	err = gpio_request(MMC_CHIP_SELECT_GPIO, spi->modalias);
-	if (err)
-		return err;
-
-	gpio_direction_output(MMC_CHIP_SELECT_GPIO, 1);
-
-	return 0;
-}
-
-static void ts72xx_mmc_spi_cleanup(struct spi_device *spi)
-{
-	gpio_set_value(MMC_CHIP_SELECT_GPIO, 1);
-	gpio_direction_input(MMC_CHIP_SELECT_GPIO);
-	gpio_free(MMC_CHIP_SELECT_GPIO);
-}
-
-static void ts72xx_mmc_spi_cs_control(struct spi_device *spi, int value)
-{
-	gpio_set_value(MMC_CHIP_SELECT_GPIO, value);
-}
-
-static struct ep93xx_spi_chip_ops ts72xx_mmc_spi_ops = {
-	.setup		= ts72xx_mmc_spi_setup,
-	.cleanup	= ts72xx_mmc_spi_cleanup,
-	.cs_control	= ts72xx_mmc_spi_cs_control,
-};
-
-static struct spi_board_info ts72xx_spi_devices[] __initdata = {
-	{
-		.modalias		= "mmc_spi",
-		.controller_data	= &ts72xx_mmc_spi_ops,
-		/*
-		 * We use 10 MHz even though the maximum is 7.4 MHz. The driver
-		 * will limit it automatically to max. frequency.
-		 */
-		.max_speed_hz		= 10 * 1000 * 1000,
-		.bus_num		= 0,
-		.chip_select		= 0,
-		.mode			= SPI_MODE_0,
-	},
-};
-
-static struct ep93xx_spi_info ts72xx_spi_info = {
-	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_devices),
-};
-
-static void __init ts72xx_init_machine(void)
-{
-	...
-	ep93xx_register_spi(&ts72xx_spi_info, ts72xx_spi_devices,
-			    ARRAY_SIZE(ts72xx_spi_devices));
-}
-
-The driver can use DMA for the transfers also. In this case ts72xx_spi_info
-becomes:
-
-static struct ep93xx_spi_info ts72xx_spi_info = {
-	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_devices),
-	.use_dma	= true;
-};
-
-Note that CONFIG_EP93XX_DMA should be enabled as well.
-
-Thanks to
-=========
-Martin Guy, H. Hartley Sweeten and others who helped me during development of
-the driver. Simplemachines.it donated me a Sim.One board which I used testing
-the driver on EP9307.
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index ad92d9f..0ac1763 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -27,7 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/spi/spi.h>
@@ -106,33 +105,10 @@ static struct cs4271_platform_data edb93xx_cs4271_data = {
 	.gpio_nreset	= -EINVAL,	/* filled in later */
 };
 
-static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
-{
-	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
-				GPIOF_OUT_INIT_HIGH, spi->modalias);
-}
-
-static void edb93xx_cs4271_hw_cleanup(struct spi_device *spi)
-{
-	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
-}
-
-static void edb93xx_cs4271_hw_cs_control(struct spi_device *spi, int value)
-{
-	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
-}
-
-static struct ep93xx_spi_chip_ops edb93xx_cs4271_hw = {
-	.setup		= edb93xx_cs4271_hw_setup,
-	.cleanup	= edb93xx_cs4271_hw_cleanup,
-	.cs_control	= edb93xx_cs4271_hw_cs_control,
-};
-
 static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
 	{
 		.modalias		= "cs4271",
 		.platform_data		= &edb93xx_cs4271_data,
-		.controller_data	= &edb93xx_cs4271_hw,
 		.max_speed_hz		= 6000000,
 		.bus_num		= 0,
 		.chip_select		= 0,
@@ -140,8 +116,13 @@ static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
 	},
 };
 
+static int edb93xx_spi_chipselects[] __initdata = {
+	EP93XX_GPIO_LINE_EGPIO6,
+};
+
 static struct ep93xx_spi_info edb93xx_spi_info __initdata = {
-	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
+	.chipselect	= edb93xx_spi_chipselects,
+	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_chipselects),
 };
 
 static void __init edb93xx_register_spi(void)
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 65ec16e..ebc6bed 100644
--- a/arch/arm/mach-ep93xx/simone.c
+++ b/arch/arm/mach-ep93xx/simone.c
@@ -25,7 +25,6 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <mach/gpio-ep93xx.h>
@@ -43,56 +42,6 @@ static struct ep93xxfb_mach_info __initdata simone_fb_info = {
 	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
 };
 
-/*
- * Up to v1.3, the Sim.One used SFRMOUT as SD card chip select, but this goes
- * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
- * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
- */
-#define MMC_CHIP_SELECT_GPIO EP93XX_GPIO_LINE_EGPIO1
-
-/*
- * MMC SPI chip select GPIO handling. If you are using SFRMOUT (SFRM1) signal,
- * you can leave these empty and pass NULL as .controller_data.
- */
-
-static int simone_mmc_spi_setup(struct spi_device *spi)
-{
-	unsigned int gpio = MMC_CHIP_SELECT_GPIO;
-	int err;
-
-	err = gpio_request(gpio, spi->modalias);
-	if (err)
-		return err;
-
-	err = gpio_direction_output(gpio, 1);
-	if (err) {
-		gpio_free(gpio);
-		return err;
-	}
-
-	return 0;
-}
-
-static void simone_mmc_spi_cleanup(struct spi_device *spi)
-{
-	unsigned int gpio = MMC_CHIP_SELECT_GPIO;
-
-	gpio_set_value(gpio, 1);
-	gpio_direction_input(gpio);
-	gpio_free(gpio);
-}
-
-static void simone_mmc_spi_cs_control(struct spi_device *spi, int value)
-{
-	gpio_set_value(MMC_CHIP_SELECT_GPIO, value);
-}
-
-static struct ep93xx_spi_chip_ops simone_mmc_spi_ops = {
-	.setup		= simone_mmc_spi_setup,
-	.cleanup	= simone_mmc_spi_cleanup,
-	.cs_control	= simone_mmc_spi_cs_control,
-};
-
 static struct mmc_spi_platform_data simone_mmc_spi_data = {
 	.detect_delay	= 500,
 	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -104,7 +53,6 @@ static struct mmc_spi_platform_data simone_mmc_spi_data = {
 static struct spi_board_info simone_spi_devices[] __initdata = {
 	{
 		.modalias		= "mmc_spi",
-		.controller_data	= &simone_mmc_spi_ops,
 		.platform_data		= &simone_mmc_spi_data,
 		/*
 		 * We use 10 MHz even though the maximum is 3.7 MHz. The driver
@@ -117,8 +65,18 @@ static struct spi_board_info simone_spi_devices[] __initdata = {
 	},
 };
 
+/*
+ * Up to v1.3, the Sim.One used SFRMOUT as SD card chip select, but this goes
+ * low between multi-message command blocks. From v1.4, it uses a GPIO instead.
+ * v1.3 parts will still work, since the signal on SFRMOUT is automatic.
+ */
+static int simone_spi_chipselects[] __initdata = {
+	EP93XX_GPIO_LINE_EGPIO1,
+};
+
 static struct ep93xx_spi_info simone_spi_info __initdata = {
-	.num_chipselect	= ARRAY_SIZE(simone_spi_devices),
+	.chipselect	= simone_spi_chipselects,
+	.num_chipselect	= ARRAY_SIZE(simone_spi_chipselects),
 	.use_dma = 1,
 };
 
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 5cced59..1daf944 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -175,33 +175,9 @@ static struct cs4271_platform_data vision_cs4271_data = {
 	.gpio_nreset	= EP93XX_GPIO_LINE_H(2),
 };
 
-static int vision_cs4271_hw_setup(struct spi_device *spi)
-{
-	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
-				GPIOF_OUT_INIT_HIGH, spi->modalias);
-}
-
-static void vision_cs4271_hw_cleanup(struct spi_device *spi)
-{
-	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
-}
-
-static void vision_cs4271_hw_cs_control(struct spi_device *spi, int value)
-{
-	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
-}
-
-static struct ep93xx_spi_chip_ops vision_cs4271_hw = {
-	.setup		= vision_cs4271_hw_setup,
-	.cleanup	= vision_cs4271_hw_cleanup,
-	.cs_control	= vision_cs4271_hw_cs_control,
-};
-
 /*************************************************************************
  * SPI Flash
  *************************************************************************/
-#define VISION_SPI_FLASH_CS	EP93XX_GPIO_LINE_EGPIO7
-
 static struct mtd_partition vision_spi_flash_partitions[] = {
 	{
 		.name	= "SPI bootstrap",
@@ -224,68 +200,20 @@ static struct flash_platform_data vision_spi_flash_data = {
 	.nr_parts	= ARRAY_SIZE(vision_spi_flash_partitions),
 };
 
-static int vision_spi_flash_hw_setup(struct spi_device *spi)
-{
-	return gpio_request_one(VISION_SPI_FLASH_CS, GPIOF_INIT_HIGH,
-				spi->modalias);
-}
-
-static void vision_spi_flash_hw_cleanup(struct spi_device *spi)
-{
-	gpio_free(VISION_SPI_FLASH_CS);
-}
-
-static void vision_spi_flash_hw_cs_control(struct spi_device *spi, int value)
-{
-	gpio_set_value(VISION_SPI_FLASH_CS, value);
-}
-
-static struct ep93xx_spi_chip_ops vision_spi_flash_hw = {
-	.setup		= vision_spi_flash_hw_setup,
-	.cleanup	= vision_spi_flash_hw_cleanup,
-	.cs_control	= vision_spi_flash_hw_cs_control,
-};
-
 /*************************************************************************
  * SPI SD/MMC host
  *************************************************************************/
-#define VISION_SPI_MMC_CS	EP93XX_GPIO_LINE_G(2)
-#define VISION_SPI_MMC_WP	EP93XX_GPIO_LINE_F(0)
-#define VISION_SPI_MMC_CD	EP93XX_GPIO_LINE_EGPIO15
-
 static struct mmc_spi_platform_data vision_spi_mmc_data = {
 	.detect_delay	= 100,
 	.powerup_msecs	= 100,
 	.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
 	.flags		= MMC_SPI_USE_CD_GPIO | MMC_SPI_USE_RO_GPIO,
-	.cd_gpio	= VISION_SPI_MMC_CD,
+	.cd_gpio	= EP93XX_GPIO_LINE_EGPIO15,
 	.cd_debounce	= 1,
-	.ro_gpio	= VISION_SPI_MMC_WP,
+	.ro_gpio	= EP93XX_GPIO_LINE_F(0),
 	.caps2		= MMC_CAP2_RO_ACTIVE_HIGH,
 };
 
-static int vision_spi_mmc_hw_setup(struct spi_device *spi)
-{
-	return gpio_request_one(VISION_SPI_MMC_CS, GPIOF_INIT_HIGH,
-				spi->modalias);
-}
-
-static void vision_spi_mmc_hw_cleanup(struct spi_device *spi)
-{
-	gpio_free(VISION_SPI_MMC_CS);
-}
-
-static void vision_spi_mmc_hw_cs_control(struct spi_device *spi, int value)
-{
-	gpio_set_value(VISION_SPI_MMC_CS, value);
-}
-
-static struct ep93xx_spi_chip_ops vision_spi_mmc_hw = {
-	.setup		= vision_spi_mmc_hw_setup,
-	.cleanup	= vision_spi_mmc_hw_cleanup,
-	.cs_control	= vision_spi_mmc_hw_cs_control,
-};
-
 /*************************************************************************
  * SPI Bus
  *************************************************************************/
@@ -293,7 +221,6 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	{
 		.modalias		= "cs4271",
 		.platform_data		= &vision_cs4271_data,
-		.controller_data	= &vision_cs4271_hw,
 		.max_speed_hz		= 6000000,
 		.bus_num		= 0,
 		.chip_select		= 0,
@@ -301,7 +228,6 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	}, {
 		.modalias		= "sst25l",
 		.platform_data		= &vision_spi_flash_data,
-		.controller_data	= &vision_spi_flash_hw,
 		.max_speed_hz		= 20000000,
 		.bus_num		= 0,
 		.chip_select		= 1,
@@ -309,7 +235,6 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	}, {
 		.modalias		= "mmc_spi",
 		.platform_data		= &vision_spi_mmc_data,
-		.controller_data	= &vision_spi_mmc_hw,
 		.max_speed_hz		= 20000000,
 		.bus_num		= 0,
 		.chip_select		= 2,
@@ -317,8 +242,15 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	},
 };
 
+static int vision_spi_chipselects[] __initdata = {
+	EP93XX_GPIO_LINE_EGPIO6,
+	EP93XX_GPIO_LINE_EGPIO7,
+	EP93XX_GPIO_LINE_G(2),
+};
+
 static struct ep93xx_spi_info vision_spi_master __initdata = {
-	.num_chipselect	= ARRAY_SIZE(vision_spi_board_info),
+	.chipselect	= vision_spi_chipselects,
+	.num_chipselect	= ARRAY_SIZE(vision_spi_chipselects),
 	.use_dma	= 1,
 };
 
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 17a6387..b5d7660 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/scatterlist.h>
+#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
@@ -107,16 +108,6 @@ struct ep93xx_spi {
 	void				*zeropage;
 };
 
-/**
- * struct ep93xx_spi_chip - SPI device hardware settings
- * @spi: back pointer to the SPI device
- * @ops: private chip operations
- */
-struct ep93xx_spi_chip {
-	const struct spi_device		*spi;
-	struct ep93xx_spi_chip_ops	*ops;
-};
-
 /* converts bits per word to CR0.DSS value */
 #define bits_per_word_to_dss(bpw)	((bpw) - 1)
 
@@ -229,104 +220,36 @@ static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
 	return -EINVAL;
 }
 
-static void ep93xx_spi_cs_control(struct spi_device *spi, bool control)
-{
-	struct ep93xx_spi_chip *chip = spi_get_ctldata(spi);
-	int value = (spi->mode & SPI_CS_HIGH) ? control : !control;
-
-	if (chip->ops && chip->ops->cs_control)
-		chip->ops->cs_control(spi, value);
-}
-
-/**
- * ep93xx_spi_setup() - setup an SPI device
- * @spi: SPI device to setup
- *
- * This function sets up SPI device mode, speed etc. Can be called multiple
- * times for a single device. Returns %0 in case of success, negative error in
- * case of failure. When this function returns success, the device is
- * deselected.
- */
-static int ep93xx_spi_setup(struct spi_device *spi)
+static void ep93xx_spi_cs_control(struct spi_device *spi, bool enable)
 {
-	struct ep93xx_spi *espi = spi_master_get_devdata(spi->master);
-	struct ep93xx_spi_chip *chip;
+	if (spi->mode & SPI_CS_HIGH)
+		enable = !enable;
 
-	chip = spi_get_ctldata(spi);
-	if (!chip) {
-		dev_dbg(&espi->pdev->dev, "initial setup for %s\n",
-			spi->modalias);
-
-		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-		if (!chip)
-			return -ENOMEM;
-
-		chip->spi = spi;
-		chip->ops = spi->controller_data;
-
-		if (chip->ops && chip->ops->setup) {
-			int ret = chip->ops->setup(spi);
-
-			if (ret) {
-				kfree(chip);
-				return ret;
-			}
-		}
-
-		spi_set_ctldata(spi, chip);
-	}
-
-	ep93xx_spi_cs_control(spi, false);
-	return 0;
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_set_value(spi->cs_gpio, !enable);
 }
 
-/**
- * ep93xx_spi_cleanup() - cleans up master controller specific state
- * @spi: SPI device to cleanup
- *
- * This function releases master controller specific state for given @spi
- * device.
- */
-static void ep93xx_spi_cleanup(struct spi_device *spi)
-{
-	struct ep93xx_spi_chip *chip;
-
-	chip = spi_get_ctldata(spi);
-	if (chip) {
-		if (chip->ops && chip->ops->cleanup)
-			chip->ops->cleanup(spi);
-		spi_set_ctldata(spi, NULL);
-		kfree(chip);
-	}
-}
-
-/**
- * ep93xx_spi_chip_setup() - configures hardware according to given @chip
- * @espi: ep93xx SPI controller struct
- * @chip: chip specific settings
- * @speed_hz: transfer speed
- * @bits_per_word: transfer bits_per_word
- */
 static int ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
-				 const struct ep93xx_spi_chip *chip,
-				 u32 speed_hz, u8 bits_per_word)
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
 {
-	u8 dss = bits_per_word_to_dss(bits_per_word);
+	u8 dss = bits_per_word_to_dss(xfer->bits_per_word);
 	u8 div_cpsr = 0;
 	u8 div_scr = 0;
 	u16 cr0;
 	int err;
 
-	err = ep93xx_spi_calc_divisors(espi, speed_hz, &div_cpsr, &div_scr);
+	err = ep93xx_spi_calc_divisors(espi, xfer->speed_hz,
+				       &div_cpsr, &div_scr);
 	if (err)
 		return err;
 
 	cr0 = div_scr << SSPCR0_SCR_SHIFT;
-	cr0 |= (chip->spi->mode & (SPI_CPHA|SPI_CPOL)) << SSPCR0_MODE_SHIFT;
+	cr0 |= (spi->mode & (SPI_CPHA | SPI_CPOL)) << SSPCR0_MODE_SHIFT;
 	cr0 |= dss;
 
 	dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
-		chip->spi->mode, div_cpsr, div_scr, dss);
+		spi->mode, div_cpsr, div_scr, dss);
 	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x\n", cr0);
 
 	ep93xx_spi_write_u8(espi, SSPCPSR, div_cpsr);
@@ -603,12 +526,11 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 					struct spi_message *msg,
 					struct spi_transfer *t)
 {
-	struct ep93xx_spi_chip *chip = spi_get_ctldata(msg->spi);
 	int err;
 
 	msg->state = t;
 
-	err = ep93xx_spi_chip_setup(espi, chip, t->speed_hz, t->bits_per_word);
+	err = ep93xx_spi_chip_setup(espi, msg->spi, t);
 	if (err) {
 		dev_err(&espi->pdev->dev,
 			"failed to setup chip for transfer\n");
@@ -863,8 +785,13 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	struct resource *res;
 	int irq;
 	int error;
+	int i;
 
 	info = dev_get_platdata(&pdev->dev);
+	if (!info) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -EINVAL;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -882,14 +809,36 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->setup = ep93xx_spi_setup;
 	master->transfer_one_message = ep93xx_spi_transfer_one_message;
-	master->cleanup = ep93xx_spi_cleanup;
 	master->bus_num = pdev->id;
-	master->num_chipselect = info->num_chipselect;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 
+	master->num_chipselect = info->num_chipselect;
+	master->cs_gpios = devm_kzalloc(&master->dev,
+					sizeof(int) * master->num_chipselect,
+					GFP_KERNEL);
+	if (!master->cs_gpios) {
+		error = -ENOMEM;
+		goto fail_release_master;
+	}
+
+	for (i = 0; i < master->num_chipselect; i++) {
+		master->cs_gpios[i] = info->chipselect[i];
+
+		if (!gpio_is_valid(master->cs_gpios[i]))
+			continue;
+
+		error = devm_gpio_request_one(&pdev->dev, master->cs_gpios[i],
+					      GPIOF_OUT_INIT_HIGH,
+					      "ep93xx-spi");
+		if (error) {
+			dev_err(&pdev->dev, "could not request cs gpio %d\n",
+				master->cs_gpios[i]);
+			goto fail_release_master;
+		}
+	}
+
 	platform_set_drvdata(pdev, master);
 
 	espi = spi_master_get_devdata(master);
diff --git a/include/linux/platform_data/spi-ep93xx.h b/include/linux/platform_data/spi-ep93xx.h
index 9bb63ac..171a271 100644
--- a/include/linux/platform_data/spi-ep93xx.h
+++ b/include/linux/platform_data/spi-ep93xx.h
@@ -5,25 +5,14 @@ struct spi_device;
 
 /**
  * struct ep93xx_spi_info - EP93xx specific SPI descriptor
- * @num_chipselect: number of chip selects on this board, must be
- *                  at least one
+ * @chipselect: array of gpio numbers to use as chip selects
+ * @num_chipselect: ARRAY_SIZE(chipselect)
  * @use_dma: use DMA for the transfers
  */
 struct ep93xx_spi_info {
+	int	*chipselect;
 	int	num_chipselect;
 	bool	use_dma;
 };
 
-/**
- * struct ep93xx_spi_chip_ops - operation callbacks for SPI slave device
- * @setup: setup the chip select mechanism
- * @cleanup: cleanup the chip select mechanism
- * @cs_control: control the device chip select
- */
-struct ep93xx_spi_chip_ops {
-	int	(*setup)(struct spi_device *spi);
-	void	(*cleanup)(struct spi_device *spi);
-	void	(*cs_control)(struct spi_device *spi, int value);
-};
-
 #endif /* __ASM_MACH_EP93XX_SPI_H */
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
