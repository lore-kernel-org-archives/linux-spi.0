From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 11/11] davinci: add tnetv107x evm i2c eeprom device
Date: Mon, 17 Jan 2011 14:15:25 -0500
Message-ID: <1295291725-32509-12-git-send-email-cyril@ti.com>
References: <1295291725-32509-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: c-park-l0cyMroinI0@public.gmane.org, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1295291725-32509-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
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
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   30 +++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index ac62de2..869af15 100644
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
@@ -44,6 +47,8 @@
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
 #define EVM_SPI_CS_GPIO		54
+#define EVM_I2C_SDA_GPIO	(SSP_GPIO_START + 0)
+#define EVM_I2C_SCL_GPIO	(SSP_GPIO_START + 1)
 #define EVM_BACKLIGHT_GPIO	(SSP_GPIO_START + 2)
 
 static int initialize_gpio(int gpio, char *desc)
@@ -360,6 +365,29 @@ static struct platform_device backlight_device = {
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
@@ -369,11 +397,13 @@ static __init void tnetv107x_evm_board_init(void)
 	tnetv107x_devices_init(&evm_device_info);
 
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
+	i2c_register_board_info(0, i2c_info, ARRAY_SIZE(i2c_info));
 }
 
 static int __init tnetv107x_evm_late_init(void)
 {
 	platform_device_register(&backlight_device);
+	platform_device_register(&i2c_device);
 	return 0;
 }
 late_initcall(tnetv107x_evm_late_init);
-- 
1.7.1


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
