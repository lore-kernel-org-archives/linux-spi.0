From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v7 0/2] spi: driver for Cirrus EP93xx
	SPI controller
Date: Thu,  6 May 2010 07:47:03 +0300
Message-ID: <cover.1273120206.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org,
	mika.westerberg-X3B1VOXEql0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
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

Changes to previous (v6) version:
	- only cosmetic non-functional changes (removed unnecessary comments and
	  few inlines) based on review comments by H Hartley Sweeten

Tested on TS-7260 (ep9302) and Sim.One (ep9307) boards with mmc_spi and at25
drivers.

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system (and in linux-next)
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1
So 2/2 should probably go in via Russell's tree.

Regards,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 Documentation/spi/ep93xx_spi                    |   95 +++
 arch/arm/mach-ep93xx/clock.c                    |   13 +
 arch/arm/mach-ep93xx/core.c                     |   52 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   27 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    4 +
 drivers/spi/Kconfig                             |   10 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        |  938 +++++++++++++++++++++++
 9 files changed, 1141 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/ep93xx_spi
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c


------------------------------------------------------------------------------
