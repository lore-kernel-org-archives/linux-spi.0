From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH] spi: spi-ep93xx: simplify GPIO chip selects
Date: Wed, 15 Feb 2017 09:44:22 -0700
Message-ID: <20170215164422.5957-1-hsweeten@visionengravers.com>
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
and just pass the required GPIO line as the controller_data for
each spi_board_info entry. Then handle the gpio directly in the
driver.

Fix all the ep93xx platforms that use this driver and update the
Documentation with an in-tree example.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/spi/ep93xx_spi             | 57 ++++------------------
 arch/arm/mach-ep93xx/edb93xx.c           | 25 +---------
 arch/arm/mach-ep93xx/simone.c            | 59 ++---------------------
 arch/arm/mach-ep93xx/vision_ep9307.c     | 82 ++------------------------------
 drivers/spi/spi-ep93xx.c                 | 27 +++++------
 include/linux/platform_data/spi-ep93xx.h | 12 -----
 6 files changed, 33 insertions(+), 229 deletions(-)

diff --git a/Documentation/spi/ep93xx_spi b/Documentation/spi/ep93xx_spi
index 832ddce..611ec7d 100644
--- a/Documentation/spi/ep93xx_spi
+++ b/Documentation/spi/ep93xx_spi
@@ -4,68 +4,29 @@ Cirrus EP93xx SPI controller driver HOWTO
 ep93xx_spi driver brings SPI master support for EP93xx SPI controller.  Chip
 selects are implemented with GPIO lines.
 
-NOTE: If possible, don't use SFRMOUT (SFRM1) signal as a chip select. It will
-not work correctly (it cannot be controlled by software). Use GPIO lines
-instead.
+NOTE: Don't use SFRMOUT (SFRM1) signal as a chip select. It will not work
+correctly (it cannot be controlled by software). Use GPIO lines instead.
 
 Sample configuration
 ====================
 
-Typically driver configuration is done in platform board files (the files under
-arch/arm/mach-ep93xx/*.c). In this example we configure MMC over SPI through
-this driver on TS-7260 board. You can adapt the code to suit your needs.
-
-This example uses EGPIO9 as SD/MMC card chip select (this is wired in DIO1
-header on the board).
+In this example we configure MMC over SPI on the sim.one board. This example
+uses EGPIO1 as SD/MMC card chip select.
 
 You need to select CONFIG_MMC_SPI to use mmc_spi driver.
 
-arch/arm/mach-ep93xx/ts72xx.c:
+arch/arm/mach-ep93xx/simone.c:
 
 ...
-#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
 #include <linux/platform_data/spi-ep93xx.h>
 
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
+static struct spi_board_info simone_spi_devices[] __initdata = {
 	{
 		.modalias		= "mmc_spi",
-		.controller_data	= &ts72xx_mmc_spi_ops,
+		/* .platform_data as needed by the mmc_spi driver */
+		.controller_data	= (void*)EP93XX_GPIO_LINE_EGPIO1,
 		/*
 		 * We use 10 MHz even though the maximum is 7.4 MHz. The driver
 		 * will limit it automatically to max. frequency.
@@ -73,7 +34,7 @@ static struct spi_board_info ts72xx_spi_devices[] __initdata = {
 		.max_speed_hz		= 10 * 1000 * 1000,
 		.bus_num		= 0,
 		.chip_select		= 0,
-		.mode			= SPI_MODE_0,
+		.mode			= SPI_MODE_3,
 	},
 };
 
diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index ad92d9f..014cca3 100644
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
@@ -106,33 +105,11 @@ static struct cs4271_platform_data edb93xx_cs4271_data = {
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
+		.controller_data	= (void *)EP93XX_GPIO_LINE_EGPIO6,
 		.max_speed_hz		= 6000000,
 		.bus_num		= 0,
 		.chip_select		= 0,
diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
index 65ec16e..92ad59a 100644
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
@@ -104,12 +53,14 @@ static struct mmc_spi_platform_data simone_mmc_spi_data = {
 static struct spi_board_info simone_spi_devices[] __initdata = {
 	{
 		.modalias		= "mmc_spi",
-		.controller_data	= &simone_mmc_spi_ops,
 		.platform_data		= &simone_mmc_spi_data,
 		/*
-		 * We use 10 MHz even though the maximum is 3.7 MHz. The driver
-		 * will limit it automatically to max. frequency.
+		 * Up to v1.3, the Sim.One used SFRMOUT as SD card chip select,
+		 * but this goes low between multi-message command blocks.
+		 * From v1.4, it uses a GPIO instead. v1.3 parts will still
+		 * work, since the signal on SFRMOUT is automatic.
 		 */
+		.controller_data	= (void *)EP93XX_GPIO_LINE_EGPIO1,
 		.max_speed_hz		= 10 * 1000 * 1000,
 		.bus_num		= 0,
 		.chip_select		= 0,
diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index 5cced59..2362985 100644
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
@@ -293,7 +221,7 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	{
 		.modalias		= "cs4271",
 		.platform_data		= &vision_cs4271_data,
-		.controller_data	= &vision_cs4271_hw,
+		.controller_data	= (void *)EP93XX_GPIO_LINE_EGPIO6,
 		.max_speed_hz		= 6000000,
 		.bus_num		= 0,
 		.chip_select		= 0,
@@ -301,7 +229,7 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	}, {
 		.modalias		= "sst25l",
 		.platform_data		= &vision_spi_flash_data,
-		.controller_data	= &vision_spi_flash_hw,
+		.controller_data	= (void *)EP93XX_GPIO_LINE_EGPIO7,
 		.max_speed_hz		= 20000000,
 		.bus_num		= 0,
 		.chip_select		= 1,
@@ -309,7 +237,7 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 	}, {
 		.modalias		= "mmc_spi",
 		.platform_data		= &vision_spi_mmc_data,
-		.controller_data	= &vision_spi_mmc_hw,
+		.controller_data	= (void *)EP93XX_GPIO_LINE_G(2),
 		.max_speed_hz		= 20000000,
 		.bus_num		= 0,
 		.chip_select		= 2,
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 17a6387..2921556 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/scatterlist.h>
+#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
 #include <linux/platform_data/dma-ep93xx.h>
@@ -110,11 +111,11 @@ struct ep93xx_spi {
 /**
  * struct ep93xx_spi_chip - SPI device hardware settings
  * @spi: back pointer to the SPI device
- * @ops: private chip operations
+ * @cs_gpio: gpio used to chip select the device
  */
 struct ep93xx_spi_chip {
 	const struct spi_device		*spi;
-	struct ep93xx_spi_chip_ops	*ops;
+	unsigned int			cs_gpio;
 };
 
 /* converts bits per word to CR0.DSS value */
@@ -234,8 +235,7 @@ static void ep93xx_spi_cs_control(struct spi_device *spi, bool control)
 	struct ep93xx_spi_chip *chip = spi_get_ctldata(spi);
 	int value = (spi->mode & SPI_CS_HIGH) ? control : !control;
 
-	if (chip->ops && chip->ops->cs_control)
-		chip->ops->cs_control(spi, value);
+	gpio_set_value(chip->cs_gpio, value);
 }
 
 /**
@@ -254,6 +254,8 @@ static int ep93xx_spi_setup(struct spi_device *spi)
 
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
+		int ret;
+
 		dev_dbg(&espi->pdev->dev, "initial setup for %s\n",
 			spi->modalias);
 
@@ -262,15 +264,13 @@ static int ep93xx_spi_setup(struct spi_device *spi)
 			return -ENOMEM;
 
 		chip->spi = spi;
-		chip->ops = spi->controller_data;
-
-		if (chip->ops && chip->ops->setup) {
-			int ret = chip->ops->setup(spi);
+		chip->cs_gpio = (unsigned long)spi->controller_data;
 
-			if (ret) {
-				kfree(chip);
-				return ret;
-			}
+		ret = gpio_request_one(chip->cs_gpio, GPIOF_OUT_INIT_HIGH,
+				       spi->modalias);
+		if (ret) {
+			kfree(chip);
+			return ret;
 		}
 
 		spi_set_ctldata(spi, chip);
@@ -293,8 +293,7 @@ static void ep93xx_spi_cleanup(struct spi_device *spi)
 
 	chip = spi_get_ctldata(spi);
 	if (chip) {
-		if (chip->ops && chip->ops->cleanup)
-			chip->ops->cleanup(spi);
+		gpio_free(chip->cs_gpio);
 		spi_set_ctldata(spi, NULL);
 		kfree(chip);
 	}
diff --git a/include/linux/platform_data/spi-ep93xx.h b/include/linux/platform_data/spi-ep93xx.h
index 9bb63ac..a538eae 100644
--- a/include/linux/platform_data/spi-ep93xx.h
+++ b/include/linux/platform_data/spi-ep93xx.h
@@ -14,16 +14,4 @@ struct ep93xx_spi_info {
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
