From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 3/3] spi:  McSPI support for OMAP4
Date: Thu, 27 Aug 2009 20:23:01 -0700
Message-ID: <200908272023.01950.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>

This patch adds McSPI support for OMAP4430 SDP platform. All the base addresses
are changed between OMAP1/2/3 and OMAP4.  The fields of the resource structures
are filled at runtime to have McSPI support on OMAP4.

Signed-off-by: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 arch/arm/mach-omap2/devices.c |   29 +++++++++++++++++++++++------
 drivers/spi/omap2_mcspi.c     |   10 ++++++----
 2 files changed, 29 insertions(+), 10 deletions(-)

--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -257,6 +257,11 @@ static inline void omap_init_sti(void) {
 #define OMAP2_MCSPI3_BASE		0x480b8000
 #define OMAP2_MCSPI4_BASE		0x480ba000
 
+#define OMAP4_MCSPI1_BASE		0x48098100
+#define OMAP4_MCSPI2_BASE		0x4809a100
+#define OMAP4_MCSPI3_BASE		0x480b8100
+#define OMAP4_MCSPI4_BASE		0x480ba100
+
 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
 };
@@ -301,7 +306,8 @@ static struct platform_device omap2_mcsp
 	},
 };
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
 };
@@ -325,7 +331,7 @@ static struct platform_device omap2_mcsp
 };
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi4_config = {
 	.num_cs		= 1,
 };
@@ -351,14 +357,25 @@ static struct platform_device omap2_mcsp
 
 static void omap_init_mcspi(void)
 {
+	if (cpu_is_omap44xx()) {
+		omap2_mcspi1_resources[0].start	= OMAP4_MCSPI1_BASE;
+		omap2_mcspi1_resources[0].end	= OMAP4_MCSPI1_BASE + 0xff;
+		omap2_mcspi2_resources[0].start	= OMAP4_MCSPI2_BASE;
+		omap2_mcspi2_resources[0].end	= OMAP4_MCSPI2_BASE + 0xff;
+		omap2_mcspi3_resources[0].start	= OMAP4_MCSPI3_BASE;
+		omap2_mcspi3_resources[0].end	= OMAP4_MCSPI3_BASE + 0xff;
+		omap2_mcspi4_resources[0].start	= OMAP4_MCSPI4_BASE;
+		omap2_mcspi4_resources[0].end	= OMAP4_MCSPI4_BASE + 0xff;
+	}
 	platform_device_register(&omap2_mcspi1);
 	platform_device_register(&omap2_mcspi2);
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
-	if (cpu_is_omap2430() || cpu_is_omap343x())
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap2430() || cpu_is_omap343x() || cpu_is_omap44xx())
 		platform_device_register(&omap2_mcspi3);
 #endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_omap343x())
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+	if (cpu_is_omap343x() || cpu_is_omap44xx())
 		platform_device_register(&omap2_mcspi4);
 #endif
 }
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1014,7 +1014,8 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX) \
+	|| defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
 	OMAP24XX_DMA_SPI3_RX1,
@@ -1026,7 +1027,7 @@ static u8 __initdata spi3_txdma_id[] = {
 };
 #endif
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi4_rxdma_id[] = {
 	OMAP34XX_DMA_SPI4_RX0,
 };
@@ -1056,14 +1057,15 @@ static int __init omap2_mcspi_probe(stru
 		txdma_id = spi2_txdma_id;
 		num_chipselect = 2;
 		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
+	|| defined(CONFIG_ARCH_OMAP4)
 	case 3:
 		rxdma_id = spi3_rxdma_id;
 		txdma_id = spi3_txdma_id;
 		num_chipselect = 2;
 		break;
 #endif
-#ifdef CONFIG_ARCH_OMAP3
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 	case 4:
 		rxdma_id = spi4_rxdma_id;
 		txdma_id = spi4_txdma_id;


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
