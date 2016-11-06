From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: make architecture specific hardware depend on the associated hardware
Date: Sun,  6 Nov 2016 22:21:28 +0000
Message-ID: <20161106222128.24433-1-pbrobinson@gmail.com>
Cc: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There's not much point enabling hardware specific hardware drivers if the
actual SoC architecture platforms aren't enabled as they're not much use
with out it.

Signed-off-by: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b799547..5a25ab8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -188,6 +188,7 @@ config SPI_BUTTERFLY
 
 config SPI_CADENCE
 	tristate "Cadence SPI controller"
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || COMPILE_TEST
 	help
 	  This selects the Cadence SPI controller master driver
 	  used by Xilinx Zynq and ZynqMP.
@@ -224,7 +225,7 @@ config SPI_DW_PCI
 
 config SPI_DW_MID_DMA
 	bool "DMA support for DW SPI controller on Intel MID platform"
-	depends on SPI_DW_PCI && DW_DMAC_PCI
+	depends on X86 && SPI_DW_PCI && DW_DMAC_PCI
 
 config SPI_DW_MMIO
 	tristate "Memory-mapped io interface driver for DW SPI core"
@@ -499,6 +500,7 @@ config SPI_PXA2XX_PCI
 
 config SPI_ROCKCHIP
 	tristate "Rockchip SPI controller driver"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	help
 	  This selects a driver for Rockchip SPI controller.
 
@@ -650,7 +652,7 @@ config SPI_TEGRA20_SLINK
 
 config SPI_THUNDERX
 	tristate "Cavium ThunderX SPI controller"
-	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
+	depends on PCI && 64BIT && (ARCH_THUNDER || COMPILE_TEST)
 	help
 	  SPI host driver for the hardware found on Cavium ThunderX
 	  SOCs.
@@ -680,7 +682,7 @@ config SPI_XCOMM
 
 config SPI_XILINX
 	tristate "Xilinx SPI controller common module"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && (ARCH_ZYNQ || ARCH_ZYNQMP)
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
@@ -715,7 +717,7 @@ config SPI_XTENSA_XTFPGA
 
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
-	depends on SPI_MASTER && HAS_DMA
+	depends on SPI_MASTER && HAS_DMA && ARCH_ZYNQMP
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
