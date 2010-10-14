From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 05/12] davinci: add spi devices on tnetv107x evm
Date: Thu, 14 Oct 2010 14:38:48 -0400
Message-ID: <1287081535-2864-6-git-send-email-cyril@ti.com>
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

This patch adds definitions for spi devices on the tnetv107x evm platform.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   51 +++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index c2c467b..52378bf 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -38,6 +39,7 @@
 
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
+#define EVM_SPI_CS_GPIO		54
 
 static int initialize_gpio(int gpio, char *desc)
 {
@@ -215,6 +217,52 @@ static struct tnetv107x_device_info evm_device_info __initconst = {
 	.ssp_config		= &ssp_config,
 };
 
+static void spi_select_device(int cs)
+{
+	static int gpio;
+
+	if (!gpio) {
+		int ret;
+		ret = gpio_request(EVM_SPI_CS_GPIO, "spi chipsel");
+		if (ret < 0) {
+			pr_err("cannot open spi chipsel gpio\n");
+			gpio = -ENOSYS;
+			return;
+		} else {
+			gpio = EVM_SPI_CS_GPIO;
+			gpio_direction_output(gpio, 0);
+		}
+	}
+
+	if (gpio < 0)
+		return;
+
+	return gpio_set_value(gpio, cs ? 1 : 0);
+}
+
+static struct ti_ssp_spi_data spi_master_data = {
+	.port_data = {
+		.ssp_dev_name = "ti-ssp",
+		.port = 1,
+		.iosel = SSP_PIN_SEL(0, SSP_CLOCK)	|
+			 SSP_PIN_SEL(1, SSP_DATA)	|
+			 SSP_PIN_SEL(2, SSP_CHIPSEL)	|
+			 SSP_PIN_SEL(3, SSP_IN)		|
+			 SSP_INPUT_SEL(3),
+	},
+	.num_cs		= 2,
+	.select		= spi_select_device,
+};
+
+static struct platform_device spi_master_device = {
+	.name		= "ti-ssp-spi",
+	.id		= 0,
+	.dev.platform_data = &spi_master_data,
+};
+
+static struct spi_board_info spi_info[] __initconst = {
+};
+
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
@@ -222,6 +270,9 @@ static __init void tnetv107x_evm_board_init(void)
 	davinci_cfg_reg_list(ssp_pins);
 
 	tnetv107x_devices_init(&evm_device_info);
+
+	platform_device_register(&spi_master_device);
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
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
