From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v5 0/2] spi: driver for Cirrus EP93xx
	SPI controller
Date: Wed, 28 Apr 2010 20:51:19 +0300
Message-ID: <cover.1272476431.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
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

This series implements SPI master driver for Cirrus Logic EP93xx SPI
controllers.

This is fifth iteration of the driver.

Changes to the previous version:
	- addressed review comments
	- added priming the TX FIFO when transfer is started
	- in case of ROR interrupt we clear it
	- added documentation in Documentation/spi/ep93xx_spi which provides
	  sample code how the driver can be hooked into platform data

I tested this on TS-7260 board with at25 and mmc_spi drivers. Now that I have
Sim.One board, which is EP9307 based, I also tested with that (I hacked the
board a bit to get EGPIO9 as a chip select).

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system:
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1

Thanks,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 Documentation/spi/ep93xx_spi                    |  102 +++
 arch/arm/mach-ep93xx/clock.c                    |   13 +
 arch/arm/mach-ep93xx/core.c                     |   50 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   32 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    4 +
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        |  972 +++++++++++++++++++++++
 9 files changed, 1186 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/ep93xx_spi
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c


------------------------------------------------------------------------------
