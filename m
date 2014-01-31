From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3 0/5] spi: dw: device tree and generic queue support
Date: Fri, 31 Jan 2014 12:07:43 +0200
Message-ID: <cover.1391162172.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Unfortunately, I probably have no chance access to thest this series on
hardware, I's only compile tested. So I'm sending this as RFC for code review.
If this series doesn't get merged, it may be used at least as a starting point
for someone with hardware access.

These patches add the following:

   * Device tree support for the platform driver (dw-mmio)

   * GPIO controlled chip-select implementing the generic SPI GPIO CS binding

   * Generic queue migration

Comments are welcome.

v3:
   * Reorder patches:

      - Move generic queue migration to the beginning

      - Move binding documentation before implementation

   * Add a patch removing HAVE_CLK dependency

   * Address the comments of Mark Brown:

      - Move gpio request to probe() for compatibility with deferred gpio
	probing

      - Extend spi_chip_sel() to handle chip-select deactivation

      - devm_gpio_request_one() can't be used in probe() to also set direction 
	and level, because we don't know the desired slave dependent 
	chip-select polarity yet

v2:
   * Use managed resources for GPIO allocation (Mark Brown)

   * Add device tree binding documentation (Mark Brown)

Baruch Siach (5):
  spi: dw: migrate to generic queue infrastructure
  spi: dw: document device tree binding
  spi: dw-mmio: add device tree support
  spi: dw: add support for gpio controlled chip select
  spi: dw-mmio: remove HAVE_CLK build dependecy

 Documentation/devicetree/bindings/spi/spi-dw.txt |  24 +++
 drivers/spi/Kconfig                              |   2 +-
 drivers/spi/spi-dw-mmio.c                        |  43 ++++-
 drivers/spi/spi-dw.c                             | 201 +++--------------------
 drivers/spi/spi-dw.h                             |  24 ++-
 5 files changed, 102 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
