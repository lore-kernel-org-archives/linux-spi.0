From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 00/10] MXS SPI driver
Date: Mon, 16 Jul 2012 14:09:47 +0200
Message-ID: <1342440597-8395-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

This patchset adds SPI master support for Freescale i.MX233/i.MX28.
This is rebased on top of next-20120713. Please consider applying,
bugs shall now be squashed during the previous two review rounds.


This is a repost (rebased) of the patchset from Jul 6, 2012.

Marek Vasut (10):
  mmc: spi: Move SSP register definitions into separate file
  mmc: spi: Rename IMX2[38]_MMC to IMX2[38]_SSP
  mmc: spi: Add necessary bits into mxs-spi.h
  mmc: spi: Pull out parts shared between MMC and SPI
  mmc: spi: Pull out the SSP clock configuration function
  spi: Add SPI driver for mx233/mx28
  mmc: spi: Pull out common DMA parts from MXS MMC
  spi: Add DMA support into SPI driver
  spi: Add SSP/SPI device tree documentation
  ARM: mx28: Add SPI pinmux into imx28.dtsi

 Documentation/devicetree/bindings/spi/mxs-spi.txt |   18 +
 arch/arm/boot/dts/imx28.dtsi                      |   39 ++
 drivers/clk/mxs/Makefile                          |    2 +-
 drivers/clk/mxs/clk-ssp.c                         |   61 ++
 drivers/mmc/host/mxs-mmc.c                        |  325 ++++-------
 drivers/spi/Kconfig                               |    7 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-mxs.c                             |  626 +++++++++++++++++++++
 include/linux/spi/mxs-spi.h                       |  150 +++++
 9 files changed, 1010 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
 create mode 100644 drivers/clk/mxs/clk-ssp.c
 create mode 100644 drivers/spi/spi-mxs.c
 create mode 100644 include/linux/spi/mxs-spi.h

-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
