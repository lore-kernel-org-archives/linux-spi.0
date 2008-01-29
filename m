From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-git] spi: omap2_mcspi handles
	omap3 too
Date: Tue, 29 Jan 2008 10:36:26 -0800
Message-ID: <200801291036.27137.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>

This adds driver OMAP SPI specific changes to support OMAP 3430

Signed-off-by: Girish S G <girishsg-l0cyMroinI0@public.gmane.org>
---
There are also some related platform changes. Plus eventually this
config symbol should change (probably to OMAP_MCSPI). 

 drivers/spi/Kconfig       |    6 +++---
 drivers/spi/omap2_mcspi.c |   37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 4 deletions(-)

--- g26.orig/drivers/spi/Kconfig	2008-01-24 16:29:36.000000000 -0800
+++ g26/drivers/spi/Kconfig	2008-01-29 10:32:36.000000000 -0800
@@ -151,10 +151,10 @@ config SPI_OMAP_UWIRE
 	  This hooks up to the MicroWire controller on OMAP1 chips.
 
 config SPI_OMAP24XX
-	tristate "McSPI driver for OMAP24xx"
-	depends on SPI_MASTER && ARCH_OMAP24XX
+	tristate "McSPI driver for OMAP24xx/OMAP34xx"
+	depends on SPI_MASTER && (ARCH_OMAP24XX || ARCH_OMAP34XX)
 	help
-	  SPI master controller for OMAP24xx Multichannel SPI
+	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 	  (McSPI) modules.
 
 config SPI_PXA2XX
--- g26.orig/drivers/spi/omap2_mcspi.c	2008-01-24 15:26:32.000000000 -0800
+++ g26/drivers/spi/omap2_mcspi.c	2008-01-29 10:32:36.000000000 -0800
@@ -915,6 +915,28 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };
 
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
+static u8 __initdata spi3_rxdma_id[] = {
+	OMAP24XX_DMA_SPI3_RX0,
+	OMAP24XX_DMA_SPI3_RX1,
+};
+
+static u8 __initdata spi3_txdma_id[] = {
+	OMAP24XX_DMA_SPI3_TX0,
+	OMAP24XX_DMA_SPI3_TX1,
+};
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static u8 __initdata spi4_rxdma_id[] = {
+	OMAP34XX_DMA_SPI4_RX0,
+};
+
+static u8 __initdata spi4_txdma_id[] = {
+	OMAP34XX_DMA_SPI4_TX0,
+};
+#endif
+
 static int __init omap2_mcspi_probe(struct platform_device *pdev)
 {
 	struct spi_master	*master;
@@ -935,7 +957,20 @@ static int __init omap2_mcspi_probe(stru
 		txdma_id = spi2_txdma_id;
 		num_chipselect = 2;
 		break;
-	/* REVISIT omap2430 has a third McSPI ... */
+#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+	case 3:
+		rxdma_id = spi3_rxdma_id;
+		txdma_id = spi3_txdma_id;
+		num_chipselect = 2;
+		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP3
+	case 4:
+		rxdma_id = spi4_rxdma_id;
+		txdma_id = spi4_txdma_id;
+		num_chipselect = 1;
+		break;
+#endif
 	default:
 		return -EINVAL;
 	}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
