From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [RFC PATCH 0/5] spi: moving to struct gpio_desc
Date: Thu, 25 May 2017 16:30:38 +1200
Message-ID: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Cc: linux@armlinux.org.uk,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, andy.shevchenko@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rmallon@gmail.com, shawnguo@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is my attempt to move spi over to using struct gpio_desc. I've
stopped at converting struct spi_master to gather some feedback.

ep93xx wasn't as hard as I'd expected so I'm pretty happy with those
changes. imx on the other hand has an annoying habit of conflating the GPIO
and native chip-select so I'm pretty sure that's broken.

I've compile tested ep93xx_defconfig and multi_v5_defconfig.

Looking ahead to converting struct spi_device there are a number of drivers
that re-use cs_gpio to reference the native chip-select so that still poses
issues I don't have a plan to solve. Happily most of the changes are deleting
code that requests the GPIO since that's now taken care of in core.

Chris Packham (5):
  spi: use gpio_desc instead of numeric gpio
  ARM: ep93xx: add gpiod_lookup_table for spi chip-selects
  ARM: imx: add gpiod_lookup_table for spi chip-selects
  spi: core: convert spi_master to use gpio_desc
  ARM: ep93xx: remove chipselect from ep93xx_spi_info

 arch/arm/mach-ep93xx/edb93xx.c           | 15 +++++++++++----
 arch/arm/mach-ep93xx/simone.c            | 14 ++++++++++----
 arch/arm/mach-ep93xx/vision_ep9307.c     | 20 ++++++++++++++------
 arch/arm/mach-imx/mach-mx27_3ds.c        | 21 +++++++++++++++++++++
 arch/arm/mach-imx/mach-pca100.c          | 13 +++++++++++++
 drivers/spi/spi-ep93xx.c                 | 18 ++++++++----------
 drivers/spi/spi-imx.c                    | 25 +++++++++----------------
 drivers/spi/spi-mt65xx.c                 | 13 -------------
 drivers/spi/spi.c                        | 29 +++++++++++++++++++++--------
 include/linux/platform_data/spi-ep93xx.h |  4 +---
 include/linux/spi/spi.h                  |  2 +-
 11 files changed, 109 insertions(+), 65 deletions(-)

-- 
2.13.0
