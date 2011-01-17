From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v8 07/11] davinci: add spi devices on tnetv107x evm
Date: Mon, 17 Jan 2011 14:15:21 -0500
Message-ID: <1295291725-32509-8-git-send-email-cyril@ti.com>
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

This patch adds definitions for spi devices on the tnetv107x evm platform.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   43 +++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index ef526b1..1a656e8 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/spi/spi.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -37,6 +38,7 @@
 
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
+#define EVM_SPI_CS_GPIO		54
 
 static int initialize_gpio(int gpio, char *desc)
 {
@@ -202,9 +204,45 @@ static struct matrix_keypad_platform_data keypad_config = {
 	.no_autorepeat	= 0,
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
+	.num_cs	= 2,
+	.select	= spi_select_device,
+	.iosel	= SSP_PIN_SEL(0, SSP_CLOCK)	| SSP_PIN_SEL(1, SSP_DATA) |
+		  SSP_PIN_SEL(2, SSP_CHIPSEL)	| SSP_PIN_SEL(3, SSP_IN)   |
+		  SSP_INPUT_SEL(3),
+};
+
 static struct ti_ssp_data ssp_config = {
 	.out_clock	= 250 * 1000,
 	.dev_data	= {
+		[1] = {
+			.dev_name = "ti-ssp-spi",
+			.pdata = &spi_master_data,
+			.pdata_size = sizeof(spi_master_data),
+		},
 	},
 };
 
@@ -216,6 +254,9 @@ static struct tnetv107x_device_info evm_device_info __initconst = {
 	.ssp_config		= &ssp_config,
 };
 
+static struct spi_board_info spi_info[] __initconst = {
+};
+
 static __init void tnetv107x_evm_board_init(void)
 {
 	davinci_cfg_reg_list(sdio1_pins);
@@ -223,6 +264,8 @@ static __init void tnetv107x_evm_board_init(void)
 	davinci_cfg_reg_list(ssp_pins);
 
 	tnetv107x_devices_init(&evm_device_info);
+
+	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.1


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
