From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH] spi: kconfig: When possible, compile drivers with COMPILE_TEST
Date: Wed, 14 Oct 2015 18:41:50 +0100
Message-ID: <1444844510-13035-1-git-send-email-luisbg@osg.samsung.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	javier@osg.samsung.com,
	Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

These drivers only have runtime but no build time dependencies, so they can
be built for testing purposes if the Kconfig COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that drivers are
not affected by changes that could cause build regressions.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/spi/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 26b8605..585d0cb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -128,7 +128,7 @@ config SPI_AU1550
 
 config SPI_BCM53XX
 	tristate "Broadcom BCM53xx SPI controller"
-	depends on ARCH_BCM_5301X
+	depends on ARCH_BCM_5301X || COMPILE_TEST
 	depends on BCMA_POSSIBLE
 	select BCMA
 	help
@@ -192,7 +192,7 @@ config SPI_COLDFIRE_QSPI
 
 config SPI_DAVINCI
 	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
-	depends on ARCH_DAVINCI || ARCH_KEYSTONE
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.
@@ -209,7 +209,7 @@ config SPI_DLN2
 
 config SPI_EFM32
 	tristate "EFM32 SPI controller"
-	depends on OF && ARM && (ARCH_EFM32 || COMPILE_TEST)
+	depends on OF && (ARM && ARCH_EFM32) || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  Driver for the spi controller found on Energy Micro's EFM32 SoCs.
@@ -370,7 +370,7 @@ config SPI_OMAP_UWIRE
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
 	depends on HAS_DMA
-	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH
+	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH || COMPILE_TEST
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
@@ -488,7 +488,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
+	depends on (PLAT_SAMSUNG || ARCH_EXYNOS) || COMPILE_TEST
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
@@ -533,7 +533,7 @@ config SPI_SIRF
 
 config SPI_ST_SSC4
 	tristate "STMicroelectronics SPI SSC-based driver"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	help
 	  STMicroelectronics SoCs support for SPI. If you say yes to
 	  this option, support will be included for the SSC driven SPI.
-- 
2.5.1
