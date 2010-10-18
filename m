From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 02/12] davinci: add tnetv107x ssp platform device
Date: Mon, 18 Oct 2010 15:25:12 -0400
Message-ID: <1287429922-18870-3-git-send-email-cyril@ti.com>
References: <1287429922-18870-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gra
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287429922-18870-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds an SSP platform device definition for the tnetv107x soc family.
The clock lookup entry has also been updated to match.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/devices-tnetv107x.c      |   25 ++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
 arch/arm/mach-davinci/tnetv107x.c              |    2 +-
 3 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index c9a86d8..2c7aa5f 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -35,6 +35,7 @@
 #define TNETV107X_SDIO0_BASE			0x08088700
 #define TNETV107X_SDIO1_BASE			0x08088800
 #define TNETV107X_KEYPAD_BASE			0x08088a00
+#define TNETV107X_SSP_BASE			0x08088c00
 #define TNETV107X_ASYNC_EMIF_CNTRL_BASE		0x08200000
 #define TNETV107X_ASYNC_EMIF_DATA_CE0_BASE	0x30000000
 #define TNETV107X_ASYNC_EMIF_DATA_CE1_BASE	0x40000000
@@ -342,6 +343,25 @@ static struct platform_device tsc_device = {
 	.resource	= tsc_resources,
 };
 
+static struct resource ssp_resources[] = {
+	{
+		.start	= TNETV107X_SSP_BASE,
+		.end	= TNETV107X_SSP_BASE + 0x1ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_TNETV107X_SSP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ssp_device = {
+	.name		= "ti-ssp",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(ssp_resources),
+	.resource	= ssp_resources,
+};
+
 void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 {
 	int i;
@@ -367,4 +387,9 @@ void __init tnetv107x_devices_init(struct tnetv107x_device_info *info)
 		keypad_device.dev.platform_data = info->keypad_config;
 		platform_device_register(&keypad_device);
 	}
+
+	if (info->ssp_config) {
+		ssp_device.dev.platform_data = info->ssp_config;
+		platform_device_register(&ssp_device);
+	}
 }
diff --git a/arch/arm/mach-davinci/include/mach/tnetv107x.h b/arch/arm/mach-davinci/include/mach/tnetv107x.h
index 5a681d8..c1df563 100644
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@ -38,12 +38,14 @@
 #include <mach/mmc.h>
 #include <mach/nand.h>
 #include <mach/serial.h>
+#include <mach/ti_ssp.h>
 
 struct tnetv107x_device_info {
 	struct davinci_uart_config	*serial_config;
 	struct davinci_mmc_config	*mmc_config[2];  /* 2 controllers */
 	struct davinci_nand_pdata	*nand_config[4]; /* 4 chipsels */
 	struct matrix_keypad_platform_data *keypad_config;
+	struct ti_ssp_data		*ssp_config;
 };
 
 extern struct platform_device tnetv107x_wdt_device;
diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index daeae06..fcf30e7 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -277,7 +277,7 @@ static struct clk_lookup clks[] = {
 	CLK(NULL,		"timer1",		&clk_timer1),
 	CLK("tnetv107x_wdt.0",	NULL,			&clk_wdt_arm),
 	CLK(NULL,		"clk_wdt_dsp",		&clk_wdt_dsp),
-	CLK("ti-ssp.0",		NULL,			&clk_ssp),
+	CLK("ti-ssp",		NULL,			&clk_ssp),
 	CLK(NULL,		"clk_tdm0",		&clk_tdm0),
 	CLK(NULL,		"clk_vlynq",		&clk_vlynq),
 	CLK(NULL,		"clk_mcdma",		&clk_mcdma),
-- 
1.7.0.4


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
