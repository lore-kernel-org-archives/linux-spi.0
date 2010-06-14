From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] davinci: spi: replace existing SPI
	driver
Date: Mon, 14 Jun 2010 10:54:58 -0500
Message-ID: <1276530901-4413-1-git-send-email-bniebuhr@efjohnson.com>
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

NOTE

This patch requires the EDMA patch at:

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-March/018022.html

which has since been reverted out of the davinci kernel.


INTRODUCTION

I have been working on a custom OMAP-L138 board that has multiple spi
devices (seven) on one controller.  These devices have a wide range of
transfer parameters (speed, phase, polarity, internal and gpio chip
selects).  During my testing I found multiple errors in the davinci spi
driver as a result of this complex setup.  The primary issues were:

1. There is a race condition due to the SPIBUF read busy-waits for slow
        devices
2. I found some DMA transfer length errors under some conditions
3. The chip select code caused extra byte transfers (with no chip
        select active) due to writes to SPIDAT1
4. Several issues prevented using multiple SPI devices, especially
        the DMA code, as disucussed previously on the davinci list.

The fixes to these problems were not simple.  I ended up making fairly
large changes to the driver, and those changes are contained in these
patches.  The full list of changes follows.

CHANGE LIST

1. davinci_spi_chipelect() now performs both activation and deactivation
        of chip selects.  This lets spi_bitbang fully control chip
        select activation, as intended by the SPI API.
2. Chip select activation does not cause extra writes to the SPI bus
3. Chip select activation does not use SPIDEF for control.  This change
        will also allow for implementation of inverted (active high)
        chip selects in the future.
4. Added back gpio chip select capability from the old driver
5. Fixed prescale calculation for non-integer fractions of spi clock
6. Allow specification of SPI transfer parameters on a per-device
        (instead of per-controller) basis
7. Allow specification of polled, interrupt-based, or DMA operation on
        a per-device basis
8. Allow DMA with when more than one device is connected
9. Combined pio and dma txrx_bufs functions into one since they share
        large parts of their functionality, and to simplify item (8).
10. Use only SPIFMT0 to allow more than 4 devices

TESTING

I have tested the driver using a custom SPI stress test on my
OMAP-L138-based board with three devices connected.  I have tested
configurations with all three devices polled, all three interrupt-based,
all three DMA, and a mixture.

I have compiled with the davinci_all_defconfig, but I don't have EVMs
for the other davinci platforms to test with.

SUMMARY

This patch solves a lot of issues that should save a lot of people time
down the road.  Since I posted the original patch I have had at least 5
people contact me personally to get help applying the patch because SPI
was broken on their boards.  I have heard back from at least 2 that the
original patch worked for them.  

I appreciate any testing and feedback that others can provide.

Brian Niebuhr (3):
  davinci: spi: remove old Davinci SPI driver
  davinci: spi: add replacement SPI driver
  davinci: spi: modify platform data for updated SPI driver

 arch/arm/mach-davinci/board-dm355-evm.c     |   10 +
 arch/arm/mach-davinci/board-dm355-leopard.c |   10 +
 arch/arm/mach-davinci/board-dm365-evm.c     |   10 +
 arch/arm/mach-davinci/dm355.c               |    6 -
 arch/arm/mach-davinci/dm365.c               |    6 -
 arch/arm/mach-davinci/include/mach/spi.h    |   41 +-
 drivers/spi/davinci_spi.c                   | 1196 ++++++++++-----------------
 drivers/spi/davinci_spi.h                   |  186 +++++
 8 files changed, 681 insertions(+), 784 deletions(-)
 create mode 100644 drivers/spi/davinci_spi.h


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
