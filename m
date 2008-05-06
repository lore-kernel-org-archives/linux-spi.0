From: "Robert P. J. Day" <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>
Subject: [PATCH] SPI: Use "if SPI_MASTER" to remove
	numerous dependencies.
Date: Tue, 6 May 2008 04:03:02 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805060401080.1858@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


Signed-off-by: Robert P. J. Day <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>

---

  i'm guessing that a number of those "EXPERIMENTAL" dependencies
might be removable as well, no?

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fae9e8f..6d37903 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -49,25 +49,26 @@ config SPI_MASTER
 	  controller and the protocol drivers for the SPI slave chips
 	  that are connected.

+if SPI_MASTER
+
 comment "SPI Master Controller Drivers"
-	depends on SPI_MASTER

 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on (ARCH_AT91 || AVR32) && SPI_MASTER
+	depends on (ARCH_AT91 || AVR32)
 	help
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.

 config SPI_BFIN
 	tristate "SPI controller driver for ADI Blackfin5xx"
-	depends on SPI_MASTER && BLACKFIN
+	depends on BLACKFIN
 	help
 	  This is the SPI controller master driver for Blackfin 5xx processor.

 config SPI_AU1550
 	tristate "Au1550/Au12x0 SPI Controller"
-	depends on SPI_MASTER && (SOC_AU1550 || SOC_AU1200) && EXPERIMENTAL
+	depends on (SOC_AU1550 || SOC_AU1200) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  If you say yes to this option, support will be included for the
@@ -78,7 +79,7 @@ config SPI_AU1550

 config SPI_BITBANG
 	tristate "Bitbanging SPI master"
-	depends on SPI_MASTER && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  With a few GPIO pins, your system can bitbang the SPI protocol.
 	  Select this to get SPI support through I/O pins (GPIO, parallel
@@ -92,7 +93,7 @@ config SPI_BITBANG

 config SPI_BUTTERFLY
 	tristate "Parallel port adapter for AVR Butterfly (DEVELOPMENT)"
-	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
+	depends on PARPORT && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This uses a custom parallel port cable to connect to an AVR
@@ -102,14 +103,14 @@ config SPI_BUTTERFLY

 config SPI_IMX
 	tristate "Freescale iMX SPI controller"
-	depends on SPI_MASTER && ARCH_IMX && EXPERIMENTAL
+	depends on ARCH_IMX && EXPERIMENTAL
 	help
 	  This enables using the Freescale iMX SPI controller in master
 	  mode.

 config SPI_LM70_LLP
 	tristate "Parallel port adapter for LM70 eval board (DEVELOPMENT)"
-	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
+	depends on PARPORT && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This driver supports the NS LM70 LLP Evaluation Board,
@@ -118,14 +119,14 @@ config SPI_LM70_LLP

 config SPI_MPC52xx_PSC
 	tristate "Freescale MPC52xx PSC SPI controller"
-	depends on SPI_MASTER && PPC_MPC52xx && EXPERIMENTAL
+	depends on PPC_MPC52xx && EXPERIMENTAL
 	help
 	  This enables using the Freescale MPC52xx Programmable Serial
 	  Controller in master SPI mode.

 config SPI_MPC83xx
 	tristate "Freescale MPC83xx/QUICC Engine SPI controller"
-	depends on SPI_MASTER && (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
+	depends on (PPC_83xx || QUICC_ENGINE) && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This enables using the Freescale MPC83xx and QUICC Engine SPI
@@ -138,21 +139,21 @@ config SPI_MPC83xx

 config SPI_OMAP_UWIRE
 	tristate "OMAP1 MicroWire"
-	depends on SPI_MASTER && ARCH_OMAP1
+	depends on ARCH_OMAP1
 	select SPI_BITBANG
 	help
 	  This hooks up to the MicroWire controller on OMAP1 chips.

 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP24xx/OMAP34xx"
-	depends on SPI_MASTER && (ARCH_OMAP24XX || ARCH_OMAP34XX)
+	depends on ARCH_OMAP24XX || ARCH_OMAP34XX
 	help
 	  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 	  (McSPI) modules.

 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
-	depends on SPI_MASTER && ARCH_PXA && EXPERIMENTAL
+	depends on ARCH_PXA && EXPERIMENTAL
 	select PXA_SSP
 	help
 	  This enables using a PXA2xx SSP port as a SPI master controller.
@@ -161,14 +162,14 @@ config SPI_PXA2XX

 config SPI_S3C24XX
 	tristate "Samsung S3C24XX series SPI"
-	depends on SPI_MASTER && ARCH_S3C2410 && EXPERIMENTAL
+	depends on ARCH_S3C2410 && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  SPI driver for Samsung S3C24XX series ARM SoCs

 config SPI_S3C24XX_GPIO
 	tristate "Samsung S3C24XX series SPI by GPIO"
-	depends on SPI_MASTER && ARCH_S3C2410 && EXPERIMENTAL
+	depends on ARCH_S3C2410 && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  SPI driver for Samsung S3C24XX series ARM SoCs using
@@ -178,20 +179,20 @@ config SPI_S3C24XX_GPIO

 config SPI_SH_SCI
 	tristate "SuperH SCI SPI controller"
-	depends on SPI_MASTER && SUPERH
+	depends on SUPERH
 	select SPI_BITBANG
 	help
 	  SPI driver for SuperH SCI blocks.

 config SPI_TXX9
 	tristate "Toshiba TXx9 SPI controller"
-	depends on SPI_MASTER && GENERIC_GPIO && CPU_TX49XX
+	depends on GENERIC_GPIO && CPU_TX49XX
 	help
 	  SPI driver for Toshiba TXx9 MIPS SoCs

 config SPI_XILINX
 	tristate "Xilinx SPI controller"
-	depends on SPI_MASTER && XILINX_VIRTEX && EXPERIMENTAL
+	depends on XILINX_VIRTEX && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This exposes the SPI controller IP from the Xilinx EDK.
@@ -208,11 +209,10 @@ config SPI_XILINX
 # being probably the most widely used ones.
 #
 comment "SPI Protocol Masters"
-	depends on SPI_MASTER

 config SPI_AT25
 	tristate "SPI EEPROMs from most vendors"
-	depends on SPI_MASTER && SYSFS
+	depends on SYSFS
 	help
 	  Enable this driver to get read/write support to most SPI EEPROMs,
 	  after you configure the board init code to know about each eeprom
@@ -223,7 +223,7 @@ config SPI_AT25

 config SPI_SPIDEV
 	tristate "User mode SPI device driver support"
-	depends on SPI_MASTER && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  This supports user mode SPI protocol drivers.

@@ -232,7 +232,7 @@ config SPI_SPIDEV

 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
-	depends on SPI_MASTER && SYSFS
+	depends on SYSFS
 	help
 	  SPI driver for Infineon TLE62X0 series line driver chips,
 	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
@@ -243,6 +243,8 @@ config SPI_TLE62X0
 # Add new SPI protocol masters in alphabetical order above this line
 #

+endif # SPI_MASTER
+
 # (slave support would go here)

 endif # SPI


========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
