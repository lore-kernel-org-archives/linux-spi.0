From: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/12] davinci: add tnetv107x evm ti-ssp gpio device
Date: Thu, 14 Oct 2010 14:38:52 -0400
Message-ID: <1287081535-2864-10-git-send-email-cyril@ti.com>
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

This patch adds definitions to hook up one of the ti-ssp ports to the SSP GPIO
driver.

Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index 2f13544..7b4f86e 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -40,6 +40,8 @@
 #include <mach/ti_ssp.h>
 #include <mach/tnetv107x.h>
 
+#define SSP_GPIO_START		128
+
 #define EVM_MMC_WP_GPIO		21
 #define EVM_MMC_CD_GPIO		24
 #define EVM_SPI_CS_GPIO		54
@@ -263,6 +265,25 @@ static struct platform_device spi_master_device = {
 	.dev.platform_data = &spi_master_data,
 };
 
+static struct ti_ssp_gpio_data ssp_gpio_data = {
+	.port_data = {
+		.ssp_dev_name = "ti-ssp",
+		.port = 0,
+		.iosel = SSP_PIN_SEL(0, SSP_OUT)	|
+			 SSP_PIN_SEL(1, SSP_OUT)	|
+			 SSP_PIN_SEL(2, SSP_OUT)	|
+			 SSP_PIN_SEL(3, SSP_OUT)	|
+			 SSP_INPUT_SEL(3),
+	},
+	.start		= SSP_GPIO_START,
+};
+
+static struct platform_device ssp_gpio_device = {
+	.name		= "ti-ssp-gpio",
+	.id		= 0,
+	.dev.platform_data = &ssp_gpio_data,
+};
+
 static struct regulator_consumer_supply usb_consumers[] = {
 	REGULATOR_SUPPLY("vbus", "musb_hdrc.1"),
 };
@@ -363,6 +384,8 @@ static __init void tnetv107x_evm_board_init(void)
 	tnetv107x_devices_init(&evm_device_info);
 
 	platform_device_register(&spi_master_device);
+	platform_device_register(&ssp_gpio_device);
+
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 }
 
-- 
1.7.0.4


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
