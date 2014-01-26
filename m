From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 0/5] spi: dw: device tree and generic queue support
Date: Sun, 26 Jan 2014 10:14:31 +0200
Message-ID: <cover.1390723880.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
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

v2:
   * Use managed resources for GPIO allocation (Mark Brown)

   * Add device tree binding documentation (Mark Brown)

Baruch Siach (5):
  spi: dw-mmio: allow multiple instances
  spi: dw-mmio: add device tree support
  spi: dw: add support for gpio controlled chip select
  spi: dw: document device tree binding
  spi: dw: migrate to generic queue infrastructure

 Documentation/devicetree/bindings/spi/spi-dw.txt |  24 +++
 drivers/spi/spi-dw-mmio.c                        |  19 ++-
 drivers/spi/spi-dw.c                             | 209 ++++-------------------
 drivers/spi/spi-dw.h                             |  14 +-
 4 files changed, 81 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
