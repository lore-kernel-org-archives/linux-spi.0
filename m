From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v3 0/2] spi: driver for Cirrus EP93xx
	SPI controller
Date: Tue, 13 Apr 2010 17:10:12 +0300
Message-ID: <cover.1271156934.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
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

Hello,

This is third revision of the driver. Thanks to Martin Guy who tested and
reviewed the code.

Changes since v2:
	- corrected spi clock rate calculation
	- interrupt handling is now more efficient
	- driver now supports polling mode as well, this can be selected with
	  'transfer_method' module parameter.
	- controller is disabled in probe function
	- some cosmetic changes

I have been testing this on my TS-7260 board (ep9302 based) with mmc_spi and
at25 drivers.

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system:
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1

Thanks,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 arch/arm/mach-ep93xx/clock.c                    |   14 +
 arch/arm/mach-ep93xx/core.c                     |   42 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   34 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    2 +
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        | 1113 +++++++++++++++++++++++
 8 files changed, 1218 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
