From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/3] spi: spi-gpio: Rewrite to use GPIO descriptors
Date: Mon, 12 Feb 2018 13:45:30 +0100
Message-ID: <20180212124532.25776-2-linus.walleij@linaro.org>
References: <20180212124532.25776-1-linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Harald Welte <laforge@openmoko.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Anatolij Gustschin <agust@denx.de>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180212124532.25776-1-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This converts the bit-banged GPIO SPI driver to looking up and
using GPIO descriptors to get a handle on GPIO lines for SCK,
MOSI, MISO and all CS lines.

All existing board files are converted in one go to keep it all
consistent. With these conversions I rarely find any interrim
steps that makes any sense.

Device tree probing and GPIO handling should work like before
also after this patch.

For board files, we stop using controller data to pass the GPIO
line for chip select, instead we pass this as a GPIO descriptor
lookup like everything else.

In some s3c24xx machines the names of the SPI devices were set to
"spi-gpio" rather than "spi_gpio" which can never have worked, I
fixed it working (I guess) as part of this patch set. Sometimes
I wonder how this code got upstream in the first place, it
obviously is not tested.

mach-s3c64xx/mach-smartq.c has the same problem and additionally
defines the *same* GPIO line for MOSI and MISO which is not going
to be accepted by gpiolib. As the lines were number 1,2,2 I assumed
it was a typo and use lines 1,2,3. A comment gives awat that line 0
is chip select though no actual SPI device is provided for the LCD
supposed to be on this bit-banged SPI bus. I left it intact instead
of just deleting the bus though.

Kill off board file code that try to initialize the SPI lines
to the same values that they will later be set by the spi_gpio
driver anyways. Given the huge number of weird things in these
board files I do not think this code is very tested or put in
with much afterthought anyways.

In order to assert that we do not get performance regressions on
this crucial bing-banged driver, a ran a script like this dumping the
Ilitek ILI9322 regmap 10000 times (it has no caching obviously) on
an otherwise idle system in two iterations before and after the
patches:

 #!/bin/sh
 for run in `seq 10000`
 do
     cat /debug/regmap/spi0.0/registers > /dev/null
 done

Before the patch:

time test.sh
real    3m 41.03s
user    0m 29.41s
sys     3m 7.22s

time test.sh
real    3m 44.24s
user    0m 32.31s
sys     3m 7.60s

After the patch:

time test.sh
real    3m 41.32s
user    0m 28.92s
sys     3m 8.08s

time test.sh
real    3m 39.92s
user    0m 30.20s
sys     3m 5.56s

So any performance differences seems to be in the error margin.

Cc: Ralf Baechle <ralf@linux-mips.org> # Request ACK
Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com> # S3C stuff
Cc: Kukjin Kim <kgene.kim@samsung.com> # S3C stuff
Cc: Ben Dooks <ben-linux@fluff.org> # S3C Jive
Cc: Harald Welte <laforge@openmoko.org> # S3C qt2410
Cc: Manuel Lauss <manuel.lauss@gmail.com> # MIPS db1000
Cc: Paul Cercueil <paul@crapouillou.net> # JZ4740
Cc: Anatolij Gustschin <agust@denx.de> # EEPROM hack
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Allocate the array of CS gpio descriptors dynamically.
- Request the proper GPIO names in the machine descriptor
  tables.
- Squash in patch to make CS GPIO handling more explicit.
- Collected Olof's ACK for ARM SoC.

MIPS maintainers: please ACK this so it can be merged
into the SPI tree.
---
 arch/arm/mach-pxa/cm-x300.c            |  21 ++-
 arch/arm/mach-pxa/raumfeld.c           |  26 +++-
 arch/arm/mach-s3c24xx/mach-jive.c      |  55 ++++---
 arch/arm/mach-s3c24xx/mach-qt2410.c    |  26 +++-
 arch/arm/mach-s3c64xx/mach-smartq.c    |  22 ++-
 arch/mips/alchemy/devboards/db1000.c   |  24 ++-
 arch/mips/jz4740/board-qi_lb60.c       |  26 +++-
 drivers/misc/eeprom/digsy_mtc_eeprom.c |  29 +++-
 drivers/spi/spi-gpio.c                 | 270 +++++++++++----------------------
 include/linux/spi/spi_gpio.h           |  49 +-----
 10 files changed, 262 insertions(+), 286 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index c487401b6fdb..69d7f48a4183 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -23,6 +23,7 @@
 #include <linux/clk.h>
 
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/dm9000.h>
 #include <linux/leds.h>
 #include <linux/platform_data/rtc-v3020.h>
@@ -343,9 +344,6 @@ static inline void cm_x300_init_bl(void) {}
 #define LCD_SPI_BUS_NUM	(1)
 
 static struct spi_gpio_platform_data cm_x300_spi_gpio_pdata = {
-	.sck		= GPIO_LCD_SCL,
-	.mosi		= GPIO_LCD_DIN,
-	.miso		= GPIO_LCD_DOUT,
 	.num_chipselect	= 1,
 };
 
@@ -357,6 +355,21 @@ static struct platform_device cm_x300_spi_gpio = {
 	},
 };
 
+static struct gpiod_lookup_table cm_x300_spi_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_SCL,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DIN,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_DOUT,
+			    "miso", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-pxa", GPIO_LCD_CS,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct tdo24m_platform_data cm_x300_tdo24m_pdata = {
 	.model = TDO35S,
 };
@@ -367,7 +380,6 @@ static struct spi_board_info cm_x300_spi_devices[] __initdata = {
 		.max_speed_hz		= 1000000,
 		.bus_num		= LCD_SPI_BUS_NUM,
 		.chip_select		= 0,
-		.controller_data	= (void *) GPIO_LCD_CS,
 		.platform_data		= &cm_x300_tdo24m_pdata,
 	},
 };
@@ -376,6 +388,7 @@ static void __init cm_x300_init_spi(void)
 {
 	spi_register_board_info(cm_x300_spi_devices,
 				ARRAY_SIZE(cm_x300_spi_devices));
+	gpiod_add_lookup_table(&cm_x300_spi_gpiod_table);
 	platform_device_register(&cm_x300_spi_gpio);
 }
 #else
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 4d5d05cf87d6..e7ac7dcb95e9 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -646,9 +646,6 @@ static void __init raumfeld_lcd_init(void)
  */
 
 static struct spi_gpio_platform_data raumfeld_spi_platform_data = {
-	.sck		= GPIO_SPI_CLK,
-	.mosi		= GPIO_SPI_MOSI,
-	.miso		= GPIO_SPI_MISO,
 	.num_chipselect	= 3,
 };
 
@@ -660,6 +657,25 @@ static struct platform_device raumfeld_spi_device = {
 	}
 };
 
+static struct gpiod_lookup_table raumfeld_spi_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("gpio-0", GPIO_SPI_CLK,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0", GPIO_SPI_MOSI,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio-0", GPIO_SPI_MISO,
+			    "miso", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-0", GPIO_SPDIF_CS,
+				"cs", 0, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-0", GPIO_ACCEL_CS,
+				"cs", 1, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-0", GPIO_MCLK_DAC_CS,
+				"cs", 2, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct lis3lv02d_platform_data lis3_pdata = {
 	.click_flags 	= LIS3_CLICK_SINGLE_X |
 			  LIS3_CLICK_SINGLE_Y |
@@ -680,7 +696,6 @@ static struct lis3lv02d_platform_data lis3_pdata = {
 	.max_speed_hz	= 10000,		\
 	.bus_num	= 0,			\
 	.chip_select	= 0,			\
-	.controller_data = (void *) GPIO_SPDIF_CS,	\
 }
 
 #define SPI_LIS3	\
@@ -689,7 +704,6 @@ static struct lis3lv02d_platform_data lis3_pdata = {
 	.max_speed_hz	= 1000000,		\
 	.bus_num	= 0,			\
 	.chip_select	= 1,			\
-	.controller_data = (void *) GPIO_ACCEL_CS,	\
 	.platform_data	= &lis3_pdata,		\
 	.irq		= PXA_GPIO_TO_IRQ(GPIO_ACCEL_IRQ),	\
 }
@@ -700,7 +714,6 @@ static struct lis3lv02d_platform_data lis3_pdata = {
 	.max_speed_hz	= 1000000,		\
 	.bus_num	= 0,			\
 	.chip_select	= 2,			\
-	.controller_data = (void *) GPIO_MCLK_DAC_CS,	\
 }
 
 static struct spi_board_info connector_spi_devices[] __initdata = {
@@ -1066,6 +1079,7 @@ static void __init raumfeld_common_init(void)
 	else
 		gpio_direction_output(GPIO_SHUTDOWN_SUPPLY, 0);
 
+	gpiod_add_lookup_table(&raumfeld_spi_gpiod_table);
 	platform_add_devices(ARRAY_AND_SIZE(raumfeld_common_devices));
 	i2c_register_board_info(1, &raumfeld_pwri2c_board_info, 1);
 }
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index a3ddbbbd6d92..59589a4a0d4b 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -12,6 +12,7 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/syscore_ops.h>
 #include <linux/serial_core.h>
 #include <linux/serial_s3c.h>
@@ -388,32 +389,53 @@ static struct ili9320_platdata jive_lcm_config = {
 /* LCD SPI support */
 
 static struct spi_gpio_platform_data jive_lcd_spi = {
-	.sck		= S3C2410_GPG(8),
-	.mosi		= S3C2410_GPB(8),
-	.miso		= SPI_GPIO_NO_MISO,
+	.num_chipselect	= 1,
 };
 
 static struct platform_device jive_device_lcdspi = {
-	.name		= "spi-gpio",
+	.name		= "spi_gpio",
 	.id		= 1,
 	.dev.platform_data = &jive_lcd_spi,
 };
 
+static struct gpiod_lookup_table jive_lcdspi_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("GPIOG", 8,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOB", 8,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOB", 7,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
 
 /* WM8750 audio code SPI definition */
 
 static struct spi_gpio_platform_data jive_wm8750_spi = {
-	.sck		= S3C2410_GPB(4),
-	.mosi		= S3C2410_GPB(9),
-	.miso		= SPI_GPIO_NO_MISO,
+	.num_chipselect	= 1,
 };
 
 static struct platform_device jive_device_wm8750 = {
-	.name		= "spi-gpio",
+	.name		= "spi_gpio",
 	.id		= 2,
 	.dev.platform_data = &jive_wm8750_spi,
 };
 
+static struct gpiod_lookup_table jive_wm8750_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("GPIOB", 4,
+			    "gpio-sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOB", 9,
+			    "gpio-mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOH", 10,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* JIVE SPI devices. */
 
 static struct spi_board_info __initdata jive_spi_devs[] = {
@@ -424,14 +446,12 @@ static struct spi_board_info __initdata jive_spi_devs[] = {
 		.mode		= SPI_MODE_3,	/* CPOL=1, CPHA=1 */
 		.max_speed_hz	= 100000,
 		.platform_data	= &jive_lcm_config,
-		.controller_data = (void *)S3C2410_GPB(7),
 	}, {
 		.modalias	= "WM8750",
 		.bus_num	= 2,
 		.chip_select	= 0,
 		.mode		= SPI_MODE_0,	/* CPOL=0, CPHA=0 */
 		.max_speed_hz	= 100000,
-		.controller_data = (void *)S3C2410_GPH(10),
 	},
 };
 
@@ -619,25 +639,12 @@ static void __init jive_machine_init(void)
 	/** TODO - check that this is after the cmdline option! */
 	s3c_nand_set_platdata(&jive_nand_info);
 
-	/* initialise the spi */
-
 	gpio_request(S3C2410_GPG(13), "lcm reset");
 	gpio_direction_output(S3C2410_GPG(13), 0);
 
-	gpio_request(S3C2410_GPB(7), "jive spi");
-	gpio_direction_output(S3C2410_GPB(7), 1);
-
 	gpio_request_one(S3C2410_GPB(6), GPIOF_OUT_INIT_LOW, NULL);
 	gpio_free(S3C2410_GPB(6));
 
-	gpio_request_one(S3C2410_GPG(8), GPIOF_OUT_INIT_HIGH, NULL);
-	gpio_free(S3C2410_GPG(8));
-
-	/* initialise the WM8750 spi */
-
-	gpio_request(S3C2410_GPH(10), "jive wm8750 spi");
-	gpio_direction_output(S3C2410_GPH(10), 1);
-
 	/* Turn off suspend on both USB ports, and switch the
 	 * selectable USB port to USB device mode. */
 
@@ -655,6 +662,8 @@ static void __init jive_machine_init(void)
 
 	pm_power_off = jive_power_off;
 
+	gpiod_add_lookup_table(&jive_lcdspi_gpiod_table);
+	gpiod_add_lookup_table(&jive_wm8750_gpiod_table);
 	platform_add_devices(jive_devices, ARRAY_SIZE(jive_devices));
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 9c8373b8d9c3..5d48e5b6e738 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -11,6 +11,7 @@
 #include <linux/timer.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -194,17 +195,30 @@ static struct platform_device qt2410_led = {
 /* SPI */
 
 static struct spi_gpio_platform_data spi_gpio_cfg = {
-	.sck		= S3C2410_GPG(7),
-	.mosi		= S3C2410_GPG(6),
-	.miso		= S3C2410_GPG(5),
+	.num_chipselect	= 1,
 };
 
 static struct platform_device qt2410_spi = {
-	.name		= "spi-gpio",
+	.name		= "spi_gpio",
 	.id		= 1,
 	.dev.platform_data = &spi_gpio_cfg,
 };
 
+static struct gpiod_lookup_table qt2410_spi_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("GPIOG", 7,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOG", 6,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOG", 5,
+			    "miso", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOB", 5,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /* Board devices */
 
 static struct platform_device *qt2410_devices[] __initdata = {
@@ -323,9 +337,7 @@ static void __init qt2410_machine_init(void)
 	s3c24xx_udc_set_platdata(&qt2410_udc_cfg);
 	s3c_i2c0_set_platdata(NULL);
 
-	WARN_ON(gpio_request(S3C2410_GPB(5), "spi cs"));
-	gpio_direction_output(S3C2410_GPB(5), 1);
-
+	gpiod_add_lookup_table(&qt2410_spi_gpiod_table);
 	platform_add_devices(qt2410_devices, ARRAY_SIZE(qt2410_devices));
 	s3c_pm_init();
 }
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 5655fe968b1f..951208f168e7 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -206,17 +206,30 @@ static int __init smartq_lcd_setup_gpio(void)
 
 /* GPM0 -> CS */
 static struct spi_gpio_platform_data smartq_lcd_control = {
-	.sck			= S3C64XX_GPM(1),
-	.mosi			= S3C64XX_GPM(2),
-	.miso			= S3C64XX_GPM(2),
+	.num_chipselect	= 1,
 };
 
 static struct platform_device smartq_lcd_control_device = {
-	.name			= "spi-gpio",
+	.name			= "spi_gpio",
 	.id			= 1,
 	.dev.platform_data	= &smartq_lcd_control,
 };
 
+static struct gpiod_lookup_table smartq_lcd_control_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("GPIOM", 1,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOM", 2,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOM", 3,
+			    "miso", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOM", 0,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void smartq_lcd_power_set(struct plat_lcd_data *pd, unsigned int power)
 {
 	gpio_direction_output(S3C64XX_GPM(3), power);
@@ -404,6 +417,7 @@ void __init smartq_machine_init(void)
 	WARN_ON(smartq_wifi_init());
 
 	pwm_add_table(smartq_pwm_lookup, ARRAY_SIZE(smartq_pwm_lookup));
+	gpiod_add_lookup_table(&smartq_lcd_control_gpiod_table);
 	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
 
 	gpiod_add_lookup_table(&smartq_audio_gpios);
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 433c4b9a9f0a..13e3c84859fe 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/leds.h>
@@ -447,9 +448,6 @@ static struct ads7846_platform_data db1100_touch_pd = {
 };
 
 static struct spi_gpio_platform_data db1100_spictl_pd = {
-	.sck		= 209,
-	.mosi		= 208,
-	.miso		= 207,
 	.num_chipselect = 1,
 };
 
@@ -462,7 +460,6 @@ static struct spi_board_info db1100_spi_info[] __initdata = {
 		.mode		 = 0,
 		.irq		 = AU1100_GPIO21_INT,
 		.platform_data	 = &db1100_touch_pd,
-		.controller_data = (void *)210, /* for spi_gpio: CS# GPIO210 */
 	},
 };
 
@@ -474,6 +471,24 @@ static struct platform_device db1100_spi_dev = {
 	},
 };
 
+/*
+ * Alchemy GPIO 2 has its base at 200 so the GPIO lines
+ * 207 thru 210 are GPIOs at offset 7 thru 10 at this chip.
+ */
+static struct gpiod_lookup_table db1100_spi_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("alchemy-gpio2", 9,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("alchemy-gpio2", 8,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("alchemy-gpio2", 7,
+			    "miso", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("alchemy-gpio2", 10,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
 
 static struct platform_device *db1x00_devs[] = {
 	&db1x00_codec_dev,
@@ -541,6 +556,7 @@ int __init db1000_dev_setup(void)
 			clk_put(p);
 
 		platform_add_devices(db1100_devs, ARRAY_SIZE(db1100_devs));
+		gpiod_add_lookup_table(&db1100_spi_gpiod_table);
 		platform_device_register(&db1100_spi_dev);
 	} else if (board == BCSR_WHOAMI_DB1000) {
 		c0 = AU1000_GPIO2_INT;
diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 6d7f97552200..60f0767507c6 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -313,25 +313,34 @@ static struct jz4740_fb_platform_data qi_lb60_fb_pdata = {
 	.pixclk_falling_edge = 1,
 };
 
-struct spi_gpio_platform_data spigpio_platform_data = {
-	.sck = JZ_GPIO_PORTC(23),
-	.mosi = JZ_GPIO_PORTC(22),
-	.miso = -1,
+struct spi_gpio_platform_data qi_lb60_spigpio_platform_data = {
 	.num_chipselect = 1,
 };
 
-static struct platform_device spigpio_device = {
+static struct platform_device qi_lb60_spigpio_device = {
 	.name = "spi_gpio",
 	.id   = 1,
 	.dev = {
-		.platform_data = &spigpio_platform_data,
+		.platform_data = &qi_lb60_spigpio_platform_data,
+	},
+};
+
+static struct gpiod_lookup_table qi_lb60_spigpio_gpio_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("GPIOC", 23,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOC", 22,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("GPIOC", 21,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
 	},
 };
 
 static struct spi_board_info qi_lb60_spi_board_info[] = {
 	{
 		.modalias = "ili8960",
-		.controller_data = (void *)JZ_GPIO_PORTC(21),
 		.chip_select = 0,
 		.bus_num = 1,
 		.max_speed_hz = 30 * 1000,
@@ -435,7 +444,7 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_mmc_device,
 	&jz4740_nand_device,
 	&qi_lb60_keypad,
-	&spigpio_device,
+	&qi_lb60_spigpio_device,
 	&jz4740_framebuffer_device,
 	&jz4740_pcm_device,
 	&jz4740_i2s_device,
@@ -489,6 +498,7 @@ static int __init qi_lb60_init_platform_devices(void)
 
 	gpiod_add_lookup_table(&qi_lb60_audio_gpio_table);
 	gpiod_add_lookup_table(&qi_lb60_nand_gpio_table);
+	gpiod_add_lookup_table(&qi_lb60_spigpio_gpio_table);
 
 	spi_register_board_info(qi_lb60_spi_board_info,
 				ARRAY_SIZE(qi_lb60_spi_board_info));
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index 66d9e1baeae5..fbde2516c04f 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -7,9 +7,18 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * FIXME: this driver is used on a device-tree probed platform: it
+ * should be defined as a bit-banged SPI device and probed from the device
+ * tree and not like this with static grabbing of a few numbered GPIO
+ * lines at random.
+ *
+ * Add proper SPI and EEPROM in arch/powerpc/boot/dts/digsy_mtc.dts
+ * and delete this driver.
  */
 
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
@@ -42,9 +51,6 @@ struct eeprom_93xx46_platform_data digsy_mtc_eeprom_data = {
 };
 
 static struct spi_gpio_platform_data eeprom_spi_gpio_data = {
-	.sck		= GPIO_EEPROM_CLK,
-	.mosi		= GPIO_EEPROM_DI,
-	.miso		= GPIO_EEPROM_DO,
 	.num_chipselect	= 1,
 };
 
@@ -56,6 +62,21 @@ static struct platform_device digsy_mtc_eeprom = {
 	},
 };
 
+static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
+	.dev_id         = "spi_gpio",
+	.table          = {
+		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CLK,
+			    "sck", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_DI,
+			    "mosi", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_DO,
+			    "miso", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CS,
+			    "cs", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct spi_board_info digsy_mtc_eeprom_info[] __initdata = {
 	{
 		.modalias		= "93xx46",
@@ -63,7 +84,6 @@ static struct spi_board_info digsy_mtc_eeprom_info[] __initdata = {
 		.bus_num		= EE_SPI_BUS_NUM,
 		.chip_select		= 0,
 		.mode			= SPI_MODE_0,
-		.controller_data	= (void *)GPIO_EEPROM_CS,
 		.platform_data		= &digsy_mtc_eeprom_data,
 	},
 };
@@ -78,6 +98,7 @@ static int __init digsy_mtc_eeprom_devices_init(void)
 		pr_err("can't request gpio %d\n", GPIO_EEPROM_OE);
 		return ret;
 	}
+	gpiod_add_lookup_table(&eeprom_spi_gpiod_table);
 	spi_register_board_info(digsy_mtc_eeprom_info,
 				ARRAY_SIZE(digsy_mtc_eeprom_info));
 	return platform_device_register(&digsy_mtc_eeprom);
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1c34c9314c8a..b85a93cad44a 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -2,6 +2,7 @@
  * SPI master driver using generic bitbanged GPIO
  *
  * Copyright (C) 2006,2008 David Brownell
+ * Copyright (C) 2017 Linus Walleij
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -16,10 +17,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -44,7 +44,11 @@ struct spi_gpio {
 	struct spi_bitbang		bitbang;
 	struct spi_gpio_platform_data	pdata;
 	struct platform_device		*pdev;
-	unsigned long			cs_gpios[0];
+	struct gpio_desc		*sck;
+	struct gpio_desc		*miso;
+	struct gpio_desc		*mosi;
+	struct gpio_desc		**cs_gpios;
+	bool				has_cs;
 };
 
 /*----------------------------------------------------------------------*/
@@ -77,13 +81,6 @@ struct spi_gpio {
 
 #define GENERIC_BITBANG	/* vs tight inlines */
 
-/* all functions referencing these symbols must define pdata */
-#define SPI_MISO_GPIO	((pdata)->miso)
-#define SPI_MOSI_GPIO	((pdata)->mosi)
-#define SPI_SCK_GPIO	((pdata)->sck)
-
-#define SPI_N_CHIPSEL	((pdata)->num_chipselect)
-
 #endif
 
 /*----------------------------------------------------------------------*/
@@ -105,25 +102,27 @@ spi_to_pdata(const struct spi_device *spi)
 	return &spi_to_spi_gpio(spi)->pdata;
 }
 
-/* this is #defined to avoid unused-variable warnings when inlining */
-#define pdata		spi_to_pdata(spi)
-
+/* These helpers are in turn called by the bitbang inlines */
 static inline void setsck(const struct spi_device *spi, int is_on)
 {
-	gpio_set_value_cansleep(SPI_SCK_GPIO, is_on);
+	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
+
+	gpiod_set_value_cansleep(spi_gpio->sck, is_on);
 }
 
 static inline void setmosi(const struct spi_device *spi, int is_on)
 {
-	gpio_set_value_cansleep(SPI_MOSI_GPIO, is_on);
+	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
+
+	gpiod_set_value_cansleep(spi_gpio->mosi, is_on);
 }
 
 static inline int getmiso(const struct spi_device *spi)
 {
-	return !!gpio_get_value_cansleep(SPI_MISO_GPIO);
-}
+	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
 
-#undef pdata
+	return !!gpiod_get_value_cansleep(spi_gpio->miso);
+}
 
 /*
  * NOTE:  this clocks "as fast as we can".  It "should" be a function of the
@@ -216,123 +215,89 @@ static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
 static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 {
 	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
-	unsigned long cs = spi_gpio->cs_gpios[spi->chip_select];
 
-	/* set initial clock polarity */
+	/* set initial clock line level */
 	if (is_active)
-		setsck(spi, spi->mode & SPI_CPOL);
+		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
+
+	/* Drive chip select line, if we have one */
+	if (spi_gpio->has_cs) {
+		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
-	if (cs != SPI_GPIO_NO_CHIPSELECT) {
-		/* SPI is normally active-low */
-		gpio_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
+		/* SPI chip selects are normally active-low */
+		gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
 	}
 }
 
 static int spi_gpio_setup(struct spi_device *spi)
 {
-	unsigned long		cs;
+	struct gpio_desc	*cs;
 	int			status = 0;
 	struct spi_gpio		*spi_gpio = spi_to_spi_gpio(spi);
-	struct device_node	*np = spi->master->dev.of_node;
-
-	if (np) {
-		/*
-		 * In DT environments, the CS GPIOs have already been
-		 * initialized from the "cs-gpios" property of the node.
-		 */
-		cs = spi_gpio->cs_gpios[spi->chip_select];
-	} else {
-		/*
-		 * ... otherwise, take it from spi->controller_data
-		 */
-		cs = (uintptr_t) spi->controller_data;
-	}
 
-	if (!spi->controller_state) {
-		if (cs != SPI_GPIO_NO_CHIPSELECT) {
-			status = gpio_request(cs, dev_name(&spi->dev));
-			if (status)
-				return status;
-			status = gpio_direction_output(cs,
-					!(spi->mode & SPI_CS_HIGH));
-		}
-	}
-	if (!status) {
-		/* in case it was initialized from static board data */
-		spi_gpio->cs_gpios[spi->chip_select] = cs;
+	/*
+	 * The CS GPIOs have already been
+	 * initialized from the descriptor lookup.
+	 */
+	cs = spi_gpio->cs_gpios[spi->chip_select];
+	if (!spi->controller_state && cs)
+		status = gpiod_direction_output(cs,
+						!(spi->mode & SPI_CS_HIGH));
+
+	if (!status)
 		status = spi_bitbang_setup(spi);
-	}
 
-	if (status) {
-		if (!spi->controller_state && cs != SPI_GPIO_NO_CHIPSELECT)
-			gpio_free(cs);
-	}
 	return status;
 }
 
 static void spi_gpio_cleanup(struct spi_device *spi)
 {
-	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
-	unsigned long cs = spi_gpio->cs_gpios[spi->chip_select];
-
-	if (cs != SPI_GPIO_NO_CHIPSELECT)
-		gpio_free(cs);
 	spi_bitbang_cleanup(spi);
 }
 
-static int spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
-{
-	int value;
-
-	value = gpio_request(pin, label);
-	if (value == 0) {
-		if (is_in)
-			value = gpio_direction_input(pin);
-		else
-			value = gpio_direction_output(pin, 0);
-	}
-	return value;
-}
-
-static int spi_gpio_request(struct spi_gpio_platform_data *pdata,
-			    const char *label, u16 *res_flags)
+/*
+ * It can be convenient to use this driver with pins that have alternate
+ * functions associated with a "native" SPI controller if a driver for that
+ * controller is not available, or is missing important functionality.
+ *
+ * On platforms which can do so, configure MISO with a weak pullup unless
+ * there's an external pullup on that signal.  That saves power by avoiding
+ * floating signals.  (A weak pulldown would save power too, but many
+ * drivers expect to see all-ones data as the no slave "response".)
+ */
+static int spi_gpio_request(struct device *dev,
+			    struct spi_gpio *spi_gpio,
+			    unsigned int num_chipselects,
+			    u16 *mflags)
 {
-	int value;
-
-	/* NOTE:  SPI_*_GPIO symbols may reference "pdata" */
+	int i;
 
-	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI) {
-		value = spi_gpio_alloc(SPI_MOSI_GPIO, label, false);
-		if (value)
-			goto done;
-	} else {
+	spi_gpio->mosi = devm_gpiod_get_optional(dev, "mosi", GPIOD_OUT_LOW);
+	if (IS_ERR(spi_gpio->mosi))
+		return PTR_ERR(spi_gpio->mosi);
+	if (!spi_gpio->mosi)
 		/* HW configuration without MOSI pin */
-		*res_flags |= SPI_MASTER_NO_TX;
-	}
+		*mflags |= SPI_MASTER_NO_TX;
 
-	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO) {
-		value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
-		if (value)
-			goto free_mosi;
-	} else {
+	spi_gpio->miso = devm_gpiod_get_optional(dev, "miso", GPIOD_IN);
+	if (IS_ERR(spi_gpio->miso))
+		return PTR_ERR(spi_gpio->miso);
+	if (!spi_gpio->miso)
 		/* HW configuration without MISO pin */
-		*res_flags |= SPI_MASTER_NO_RX;
-	}
+		*mflags |= SPI_MASTER_NO_RX;
 
-	value = spi_gpio_alloc(SPI_SCK_GPIO, label, false);
-	if (value)
-		goto free_miso;
+	spi_gpio->sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_LOW);
+	if (IS_ERR(spi_gpio->mosi))
+		return PTR_ERR(spi_gpio->mosi);
 
-	goto done;
+	for (i = 0; i < num_chipselects; i++) {
+		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs",
+							     i, GPIOD_OUT_HIGH);
+		if (IS_ERR(spi_gpio->cs_gpios[i]))
+			return PTR_ERR(spi_gpio->cs_gpios[i]);
+	}
 
-free_miso:
-	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
-		gpio_free(SPI_MISO_GPIO);
-free_mosi:
-	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
-		gpio_free(SPI_MOSI_GPIO);
-done:
-	return value;
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -358,26 +323,6 @@ static int spi_gpio_probe_dt(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = of_get_named_gpio(np, "gpio-sck", 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "gpio-sck property not found\n");
-		goto error_free;
-	}
-	pdata->sck = ret;
-
-	ret = of_get_named_gpio(np, "gpio-miso", 0);
-	if (ret < 0) {
-		dev_info(&pdev->dev, "gpio-miso property not found, switching to no-rx mode\n");
-		pdata->miso = SPI_GPIO_NO_MISO;
-	} else
-		pdata->miso = ret;
-
-	ret = of_get_named_gpio(np, "gpio-mosi", 0);
-	if (ret < 0) {
-		dev_info(&pdev->dev, "gpio-mosi property not found, switching to no-tx mode\n");
-		pdata->mosi = SPI_GPIO_NO_MOSI;
-	} else
-		pdata->mosi = ret;
 
 	ret = of_property_read_u32(np, "num-chipselects", &tmp);
 	if (ret < 0) {
@@ -409,7 +354,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio_platform_data	*pdata;
 	u16 master_flags = 0;
 	bool use_of = 0;
-	int num_devices;
 
 	status = spi_gpio_probe_dt(pdev);
 	if (status < 0)
@@ -423,59 +367,41 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 #endif
 
-	if (use_of && !SPI_N_CHIPSEL)
-		num_devices = 1;
-	else
-		num_devices = SPI_N_CHIPSEL;
-
-	status = spi_gpio_request(pdata, dev_name(&pdev->dev), &master_flags);
-	if (status < 0)
-		return status;
+	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio));
+	if (!master)
+		return -ENOMEM;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio) +
-					(sizeof(unsigned long) * num_devices));
-	if (!master) {
-		status = -ENOMEM;
-		goto gpio_free;
-	}
 	spi_gpio = spi_master_get_devdata(master);
+
+	spi_gpio->cs_gpios = devm_kzalloc(&pdev->dev,
+				pdata->num_chipselect * sizeof(*spi_gpio->cs_gpios),
+				GFP_KERNEL);
+	if (!spi_gpio->cs_gpios)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, spi_gpio);
 
+	/* Determine if we have chip selects connected */
+	spi_gpio->has_cs = !!pdata->num_chipselect;
+
 	spi_gpio->pdev = pdev;
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
+	status = spi_gpio_request(&pdev->dev, spi_gpio,
+				  pdata->num_chipselect, &master_flags);
+	if (status)
+		return status;
+
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
-	master->num_chipselect = num_devices;
+	/* The master needs to think there is a chipselect even if not connected */
+	master->num_chipselect = spi_gpio->has_cs ? pdata->num_chipselect : 1;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
 #ifdef CONFIG_OF
 	master->dev.of_node = pdev->dev.of_node;
-
-	if (use_of) {
-		int i;
-		struct device_node *np = pdev->dev.of_node;
-
-		/*
-		 * In DT environments, take the CS GPIO from the "cs-gpios"
-		 * property of the node.
-		 */
-
-		if (!SPI_N_CHIPSEL)
-			spi_gpio->cs_gpios[0] = SPI_GPIO_NO_CHIPSELECT;
-		else
-			for (i = 0; i < SPI_N_CHIPSEL; i++) {
-				status = of_get_named_gpio(np, "cs-gpios", i);
-				if (status < 0) {
-					dev_err(&pdev->dev,
-						"invalid cs-gpios property\n");
-					goto gpio_free;
-				}
-				spi_gpio->cs_gpios[i] = status;
-			}
-	}
 #endif
 
 	spi_gpio->bitbang.master = master;
@@ -496,15 +422,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	spi_gpio->bitbang.flags = SPI_CS_HIGH;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
-	if (status < 0) {
-gpio_free:
-		if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
-			gpio_free(SPI_MISO_GPIO);
-		if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
-			gpio_free(SPI_MOSI_GPIO);
-		gpio_free(SPI_SCK_GPIO);
+	if (status)
 		spi_master_put(master);
-	}
 
 	return status;
 }
@@ -520,11 +439,6 @@ static int spi_gpio_remove(struct platform_device *pdev)
 	/* stop() unregisters child devices too */
 	spi_bitbang_stop(&spi_gpio->bitbang);
 
-	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
-		gpio_free(SPI_MISO_GPIO);
-	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
-		gpio_free(SPI_MOSI_GPIO);
-	gpio_free(SPI_SCK_GPIO);
 	spi_master_put(spi_gpio->bitbang.master);
 
 	return 0;
diff --git a/include/linux/spi/spi_gpio.h b/include/linux/spi/spi_gpio.h
index e7bd89a59cd1..9e7e83d8645b 100644
--- a/include/linux/spi/spi_gpio.h
+++ b/include/linux/spi/spi_gpio.h
@@ -8,64 +8,17 @@
  *   - id the same as the SPI bus number it implements
  *   - dev.platform data pointing to a struct spi_gpio_platform_data
  *
- * Or, see the driver code for information about speedups that are
- * possible on platforms that support inlined access for GPIOs (no
- * spi_gpio_platform_data is used).
- *
- * Use spi_board_info with these busses in the usual way, being sure
- * that the controller_data being the GPIO used for each device's
- * chipselect:
- *
- *	static struct spi_board_info ... [] = {
- *	...
- *		// this slave uses GPIO 42 for its chipselect
- *		.controller_data = (void *) 42,
- *	...
- *		// this one uses GPIO 86 for its chipselect
- *		.controller_data = (void *) 86,
- *	...
- *	};
- *
- * If chipselect is not used (there's only one device on the bus), assign
- * SPI_GPIO_NO_CHIPSELECT to the controller_data:
- *		.controller_data = (void *) SPI_GPIO_NO_CHIPSELECT;
- *
- * If the MISO or MOSI pin is not available then it should be set to
- * SPI_GPIO_NO_MISO or SPI_GPIO_NO_MOSI.
+ * Use spi_board_info with these busses in the usual way.
  *
  * If the bitbanged bus is later switched to a "native" controller,
  * that platform_device and controller_data should be removed.
  */
 
-#define SPI_GPIO_NO_CHIPSELECT		((unsigned long)-1l)
-#define SPI_GPIO_NO_MISO		((unsigned long)-1l)
-#define SPI_GPIO_NO_MOSI		((unsigned long)-1l)
-
 /**
  * struct spi_gpio_platform_data - parameter for bitbanged SPI master
- * @sck: number of the GPIO used for clock output
- * @mosi: number of the GPIO used for Master Output, Slave In (MOSI) data
- * @miso: number of the GPIO used for Master Input, Slave Output (MISO) data
  * @num_chipselect: how many slaves to allow
- *
- * All GPIO signals used with the SPI bus managed through this driver
- * (chipselects, MOSI, MISO, SCK) must be configured as GPIOs, instead
- * of some alternate function.
- *
- * It can be convenient to use this driver with pins that have alternate
- * functions associated with a "native" SPI controller if a driver for that
- * controller is not available, or is missing important functionality.
- *
- * On platforms which can do so, configure MISO with a weak pullup unless
- * there's an external pullup on that signal.  That saves power by avoiding
- * floating signals.  (A weak pulldown would save power too, but many
- * drivers expect to see all-ones data as the no slave "response".)
  */
 struct spi_gpio_platform_data {
-	unsigned	sck;
-	unsigned long	mosi;
-	unsigned long	miso;
-
 	u16		num_chipselect;
 };
 
-- 
2.14.3

