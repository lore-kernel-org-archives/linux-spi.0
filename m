From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 12/12] davinci: add tnetv107x evm i2c eeprom device
Date: Thu, 14 Oct 2010 14:38:55 -0400
Message-ID: <1287081535-2864-13-git-send-email-cyril@ti.com>
References: <1287081535-2864-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287081535-2864-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The tnetv107x evm board has an I2C device connected on one of the SSP ports.
This patch adds board definitions for a GPIO based I2C master, as well as
definitions for the eeprom device on these boards.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   35 +++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 0a1e9c8..2e3d842 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -29,6 +29,9 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+#include <linux/i2c-gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -45,6 +48,8 @@
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
 #define EVM_SPI_CS_GPIO		54
+#define EVM_I2C_SDA_GPIO	(SSP_GPIO_START + 0)
+#define EVM_I2C_SCL_GPIO	(SSP_GPIO_START + 1)
 #define EVM_BACKLIGHT_GPIO	(SSP_GPIO_START + 2)
 
 static int initialize_gpio(int gpio, char *desc)
@@ -270,11 +275,6 @@ static struct ti_ssp_gpio_data ssp_gpio_data = {
 	.port_data = {
 		.ssp_dev_name = "ti-ssp",
 		.port = 0,
-		.iosel = SSP_PIN_SEL(0, SSP_OUT)	|
-			 SSP_PIN_SEL(1, SSP_OUT)	|
-			 SSP_PIN_SEL(2, SSP_OUT)	|
-			 SSP_PIN_SEL(3, SSP_OUT)	|
-			 SSP_INPUT_SEL(3),
 	},
 	.start		= SSP_GPIO_START,
 };
@@ -382,6 +382,29 @@ static struct platform_device backlight_device = {
 	.dev.platform_data = (void *)EVM_BACKLIGHT_GPIO,
 };
 
+struct i2c_gpio_platform_data i2c_data = {
+	.sda_pin	= EVM_I2C_SDA_GPIO,
+	.scl_pin	= EVM_I2C_SCL_GPIO,
+};
+
+static struct platform_device i2c_device = {
+	.name		= "i2c-gpio",
+	.id		= 0,
+	.dev.platform_data = &i2c_data,
+};
+
+static struct at24_platform_data at24_config = {
+	.byte_len	= SZ_16K / 8,
+	.page_size	= 16,
+};
+
+static struct i2c_board_info i2c_info[] __initconst =  {
+	{
+		I2C_BOARD_INFO("24c16", 0x50),
+		.platform_data	= &at24_config,
+	},
+};
+
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
@@ -393,8 +416,10 @@ static __init void tnetv107x_evm_board_init(void)
 	platform_device_register(&spi_master_device);
 	platform_device_register(&ssp_gpio_device);
 	platform_device_register(&backlight_device);
+	platform_device_register(&i2c_device);
 
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
+	i2c_register_board_info(0, i2c_info, ARRAY_SIZE(i2c_info));
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.0.4


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
