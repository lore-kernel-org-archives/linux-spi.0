From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 0/6] of, of_gpio, of_spi: Fix and improve of_parse_phandle_with_args, of_gpio_named_count and of_spi_register_master
Date: Thu, 27 Dec 2012 13:10:41 +0100
Message-ID: <1356610247-11491-1-git-send-email-andreas@gaisler.com>
Cc: Rob Herring <rob.herring@calxeda.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, software@gaisler.com
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series fixes a bug where of_gpio_named count relied upon a return
value that was no longer returned from of_parse_phandle_with_args and adds the
possibility for of_gpio_named_count to return error values.

In addition, for of_spi_register_master it fixes a bug, adds documentation,
adds fetching of gpio flags and initializes gpio values to be consistent with
return values from of_parse_phandle_with_args.

Tested on sparc. Build tested on x86, arm and ppc.

Andreas Larsson (6):
  of: Return -EEXIST from of_parse_phandle_with_args for holes in
    phandle list
  of: Return -ENXIO from of_parse_phandle_with_args for too large index
    and return errors from of_gpio_named_count
  of_spi: Initialize cs_gpios properly
  of_spi: Document cs_gpios and cs_gpio in kernel-doc
  of_spi: Add fetching of of_gpio flags to of_spi_register_master
  of_spi: Initialize cs_gpios and cs_gpio with -EEXIST

 Documentation/devicetree/bindings/spi/spi-bus.txt |    3 +-
 drivers/gpio/gpiolib-of.c                         |    8 +++--
 drivers/hwmon/gpio-fan.c                          |    2 +-
 drivers/of/base.c                                 |    9 +++--
 drivers/of/selftest.c                             |    2 +-
 drivers/spi/spi.c                                 |   40 ++++++++++++++++-----
 include/linux/spi/spi.h                           |   10 +++++
 7 files changed, 56 insertions(+), 18 deletions(-)
