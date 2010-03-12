From: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2 v2] overhaul davinci spi driver to fix multiple errors
Date: Fri, 12 Mar 2010 13:35:18 -0600
Message-ID: <1268422520-22642-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

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

I realize that this is a very large patch, but I hope that it's not
thrown out just because of its size.  It does solve a lot of issues that
should save a lot of people time down the road.  I would appreciate any
feedback from those who can test it out on other davinci EVMs.


Brian Niebuhr (2):
  spi: overhaul davinci spi driver to correct multiple errors
  spi: modify davinci platform data for updated driver

 arch/arm/mach-davinci/board-dm355-evm.c     |   10 +
 arch/arm/mach-davinci/board-dm355-leopard.c |   10 +
 arch/arm/mach-davinci/board-dm365-evm.c     |   10 +
 arch/arm/mach-davinci/board-dm646x-evm.c    |   12 +
 arch/arm/mach-davinci/dm355.c               |    7 -
 arch/arm/mach-davinci/dm365.c               |    7 -
 arch/arm/mach-davinci/dm646x.c              |    7 -
 arch/arm/mach-davinci/include/mach/spi.h    |   30 +-
 drivers/spi/davinci_spi.c                   |  990 +++++++++++----------------
 drivers/spi/davinci_spi.h                   |   53 +-
 10 files changed, 479 insertions(+), 657 deletions(-)
