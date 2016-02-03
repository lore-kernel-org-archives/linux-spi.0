From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Fix sorting in Kconfig" to the spi tree
Date: Wed, 03 Feb 2016 18:12:04 +0000
Message-ID: <E1aR1uO-0006Nt-O1@debutante>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Fix sorting in Kconfig

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e32bb8709fce66ff7f392a33d7689402d3e2ba2e Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Tue, 2 Feb 2016 11:27:42 +0000
Subject: [PATCH] spi: Fix sorting in Kconfig

Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 64 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 77064160dd76..7caf18cb3e5e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -75,6 +75,14 @@ config SPI_ATMEL
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
 
+config SPI_AU1550
+	tristate "Au1550/Au1200/Au1300 SPI Controller"
+	depends on MIPS_ALCHEMY
+	select SPI_BITBANG
+	help
+	  If you say yes to this option, support will be included for the
+	  PSC SPI controller found on Au1550, Au1200 and Au1300 series.
+
 config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on GPIOLIB
@@ -118,14 +126,6 @@ config SPI_BFIN_SPORT
 	help
 	  Enable support for a SPI bus via the Blackfin SPORT peripheral.
 
-config SPI_AU1550
-	tristate "Au1550/Au1200/Au1300 SPI Controller"
-	depends on MIPS_ALCHEMY
-	select SPI_BITBANG
-	help
-	  If you say yes to this option, support will be included for the
-	  PSC SPI controller found on Au1550, Au1200 and Au1300 series.
-
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
 	depends on ARCH_BCM_5301X
@@ -197,6 +197,23 @@ config SPI_DAVINCI
 	help
 	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.
 
+config SPI_DESIGNWARE
+	tristate "DesignWare SPI controller core support"
+	help
+	  general driver for SPI controller core from DesignWare
+
+config SPI_DW_PCI
+	tristate "PCI interface driver for DW SPI core"
+	depends on SPI_DESIGNWARE && PCI
+
+config SPI_DW_MID_DMA
+	bool "DMA support for DW SPI controller on Intel MID platform"
+	depends on SPI_DW_PCI && DW_DMAC_PCI
+
+config SPI_DW_MMIO
+	tristate "Memory-mapped io interface driver for DW SPI core"
+	depends on SPI_DESIGNWARE
+
 config SPI_DLN2
        tristate "Diolan DLN-2 USB SPI adapter"
        depends on MFD_DLN2
@@ -346,6 +363,13 @@ config SPI_MT65XX
 	  say Y or M here.If you are not sure, say N.
 	  SPI drivers for Mediatek MT65XX and MT81XX series ARM SoCs.
 
+config SPI_NUC900
+	tristate "Nuvoton NUC900 series SPI"
+	depends on ARCH_W90X900
+	select SPI_BITBANG
+	help
+	  SPI driver for Nuvoton NUC900 series ARM SoCs
+
 config SPI_OC_TINY
 	tristate "OpenCores tiny SPI"
 	depends on GPIOLIB || COMPILE_TEST
@@ -647,34 +671,10 @@ config SPI_ZYNQMP_GQSPI
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 
-config SPI_NUC900
-	tristate "Nuvoton NUC900 series SPI"
-	depends on ARCH_W90X900
-	select SPI_BITBANG
-	help
-	  SPI driver for Nuvoton NUC900 series ARM SoCs
-
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
 
-config SPI_DESIGNWARE
-	tristate "DesignWare SPI controller core support"
-	help
-	  general driver for SPI controller core from DesignWare
-
-config SPI_DW_PCI
-	tristate "PCI interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE && PCI
-
-config SPI_DW_MID_DMA
-	bool "DMA support for DW SPI controller on Intel MID platform"
-	depends on SPI_DW_PCI && DW_DMAC_PCI
-
-config SPI_DW_MMIO
-	tristate "Memory-mapped io interface driver for DW SPI core"
-	depends on SPI_DESIGNWARE
-
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
