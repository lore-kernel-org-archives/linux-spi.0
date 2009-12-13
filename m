From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH v2 0/3] Add spi100k driver and arch support
Date: Sat, 12 Dec 2009 17:34:45 -0800
Message-ID: <1260668088-27555-1-git-send-email-darkstar6262@gmail.com>
Cc: Cory Maccarrone <darkstar6262@gmail.com>
To: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch set implements the spi100k driver we use in the linwizard
and wing-linux projects.  This SPI driver is used for many omap7xx
devices, particularly omap850 HTC smartphones.

The first patch is directed at the SPI subsystem mailing list primarily
for review.  The other two are directed primarily at linux-omap for
review.  All three are sent to both to preserve complete context for
all to see.

This is a resubmit of the entire patch series to account for comments
recieved on the first one.

Cory Maccarrone (3):
  [SPI] [OMAP] Add OMAP spi100k driver
  [OMAP] Add spi100k configuration to OMAP1
  [OMAP] Add OMAP 7xx pin muxes for SPI

 arch/arm/mach-omap1/clock.c               |    4 +
 arch/arm/mach-omap1/devices.c             |   34 ++
 arch/arm/mach-omap1/mux.c                 |    8 +
 arch/arm/plat-omap/include/plat/mux.h     |    8 +
 arch/arm/plat-omap/include/plat/omap7xx.h |    3 +
 drivers/spi/Kconfig                       |    6 +
 drivers/spi/Makefile                      |    1 +
 drivers/spi/omap_spi_100k.c               |  635 +++++++++++++++++++++++++++++
 8 files changed, 699 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/omap_spi_100k.c

