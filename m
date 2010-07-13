From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 2/2] ARM: PL022 SSP platform data for
	the Versatile
Date: Wed, 14 Jul 2010 00:44:27 +0200
Message-ID: <1279061067-20573-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This adds platform data for the PL022 to the ARM Versatile reference
design, and adds the necessary clock definition.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 arch/arm/mach-versatile/core.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3dff864..f3a0e07 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -28,6 +28,7 @@
 #include <linux/amba/clcd.h>
 #include <linux/amba/pl061.h>
 #include <linux/amba/mmci.h>
+#include <linux/amba/pl022.h>
 #include <linux/io.h>
 #include <linux/gfp.h>
 
@@ -425,6 +426,9 @@ static struct clk_lookup lookups[] = {
 	}, {	/* MMC1 */
 		.dev_id		= "fpga:0b",
 		.clk		= &ref24_clk,
+	}, {	/* SSP */
+		.dev_id		= "dev:f4",
+		.clk		= &ref24_clk,
 	}, {	/* CLCD */
 		.dev_id		= "dev:20",
 		.clk		= &osc4_clk,
@@ -703,6 +707,12 @@ static struct pl061_platform_data gpio1_plat_data = {
 	.irq_base	= IRQ_GPIO1_START,
 };
 
+static struct pl022_ssp_controller ssp0_plat_data = {
+	.bus_id = 0,
+	.enable_dma = 0,
+	.num_chipselect = 1,
+};
+
 #define AACI_IRQ	{ IRQ_AACI, NO_IRQ }
 #define AACI_DMA	{ 0x80, 0x81 }
 #define MMCI0_IRQ	{ IRQ_MMCI0A,IRQ_SIC_MMCI0B }
@@ -772,7 +782,7 @@ AMBA_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
 AMBA_DEVICE(uart0, "dev:f1",  UART0,    NULL);
 AMBA_DEVICE(uart1, "dev:f2",  UART1,    NULL);
 AMBA_DEVICE(uart2, "dev:f3",  UART2,    NULL);
-AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      NULL);
+AMBA_DEVICE(ssp0,  "dev:f4",  SSP,      &ssp0_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&dmac_device,
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
