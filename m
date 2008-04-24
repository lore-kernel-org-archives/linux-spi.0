From: "Robert P. J. Day" <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>
Subject: [PATCH] SPI: Use "menuconfig" to shorten the
	SPI Kconfig file.
Date: Thu, 24 Apr 2008 15:29:22 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0804241527300.26406@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


A number of dependencies can be removed simply by adding a couple
"menuconfig" structures.

Signed-off-by: Robert P. J. Day <rpjday-L09J2beyid0N/H6P543EQg@public.gmane.org>

---

  also, a lot of that Kconfig file is marked EXPERIMENTAL.  is that
still true?

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d810789..fa580d5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -5,11 +5,9 @@
 # nobody's needed a slave side API yet.  The master-role API is not
 # fully appropriate there, so it'd need some thought to do well.
 #
-menu "SPI support"
-	depends on HAS_IOMEM
-
-config SPI
+menuconfig SPI
 	bool "SPI support"
+	depends on HAS_IOMEM
 	help
 	  The "Serial Peripheral Interface" is a low level synchronous
 	  protocol.  Chips that support SPI can have data transfer rates
@@ -28,9 +26,11 @@ config SPI
 	  (half duplex), SSP, SSI, and PSP.  This driver framework should
 	  work with most such devices and controllers.

+if SPI
+
 config SPI_DEBUG
 	boolean "Debug support for SPI drivers"
-	depends on SPI && DEBUG_KERNEL
+	depends on DEBUG_KERNEL
 	help
 	  Say "yes" to enable debug messaging (like dev_dbg and pr_debug),
 	  sysfs, and debugfs support in SPI controller and protocol drivers.
@@ -39,35 +39,35 @@ config SPI_DEBUG
 # MASTER side ... talking to discrete SPI slave chips including microcontrollers
 #

-config SPI_MASTER
+menuconfig SPI_MASTER
 #	boolean "SPI Master Support"
-	boolean
-	default SPI
+	def_bool SPI
 	help
 	  If your system has an master-capable SPI controller (which
 	  provides the clock and chipselect), you can enable that
 	  controller and the protocol drivers for the SPI slave chips
 	  that are connected.

+if SPI_MASTER
+
 comment "SPI Master Controller Drivers"
-	depends on SPI_MASTER

 config SPI_ATMEL
 	tristate "Atmel SPI Controller"
-	depends on (ARCH_AT91 || AVR32) && SPI_MASTER
+	depends on ARCH_AT91 || AVR32
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
@@ -78,7 +78,7 @@ config SPI_AU1550

 config SPI_BITBANG
 	tristate "Bitbanging SPI master"
-	depends on SPI_MASTER && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  With a few GPIO pins, your system can bitbang the SPI protocol.
 	  Select this to get SPI support through I/O pins (GPIO, parallel
@@ -92,7 +92,7 @@ config SPI_BITBANG

 config SPI_BUTTERFLY
 	tristate "Parallel port adapter for AVR Butterfly (DEVELOPMENT)"
-	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
+	depends on PARPORT && EXPERIMENTAL
 	select SPI_BITBANG
 	help
 	  This uses a custom parallel port cable to connect to an AVR
@@ -102,14 +102,14 @@ config SPI_BUTTERFLY

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
@@ -118,14 +118,14 @@ config SPI_LM70_LLP

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
@@ -138,21 +138,21 @@ config SPI_MPC83xx

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
@@ -161,14 +161,14 @@ config SPI_PXA2XX

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
@@ -178,20 +178,20 @@ config SPI_S3C24XX_GPIO

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
@@ -208,11 +208,10 @@ config SPI_XILINX
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
@@ -223,7 +222,7 @@ config SPI_AT25

 config SPI_SPIDEV
 	tristate "User mode SPI device driver support"
-	depends on SPI_MASTER && EXPERIMENTAL
+	depends on EXPERIMENTAL
 	help
 	  This supports user mode SPI protocol drivers.

@@ -232,18 +231,19 @@ config SPI_SPIDEV

 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
-	depends on SPI_MASTER && SYSFS
+	depends on SYSFS
 	help
 	  SPI driver for Infineon TLE62X0 series line driver chips,
 	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
 	  sysfs interface, with each line presented as a kind of GPIO
 	  exposing both switch control and diagnostic feedback.

+endif # SPI_MASTER
+
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #

 # (slave support would go here)

-endmenu # "SPI support"
-
+endif # SPI
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
