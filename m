From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 00/10 V3] MXS SPI driver
Date: Fri,  3 Aug 2012 17:26:05 +0200
Message-ID: <1344007575-11448-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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

This patchset adds SPI master support for Freescale i.MX233/i.MX28.
This is rebased on top of next-20120713. Please consider applying,
bugs shall now be squashed during the previous two review rounds.

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
 drivers/clk/mxs/clk-ssp.c                         |   62 ++
 drivers/mmc/host/mxs-mmc.c                        |  325 ++++-------
 drivers/spi/Kconfig                               |    7 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-mxs.c                             |  631 +++++++++++++++++++++
 include/linux/spi/mxs-spi.h                       |  150 +++++
 9 files changed, 1016 insertions(+), 219 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mxs-spi.txt
 create mode 100644 drivers/clk/mxs/clk-ssp.c
 create mode 100644 drivers/spi/spi-mxs.c
 create mode 100644 include/linux/spi/mxs-spi.h

Cc: Attila Kinali <attila-HB9FjVmMKa7tRgLqZ5aouw@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
-- 
1.7.10.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
