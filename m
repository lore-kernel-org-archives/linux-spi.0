From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/3] Convert GPIO SPI to use descriptors only
Date: Mon, 12 Feb 2018 13:45:29 +0100
Message-ID: <20180212124532.25776-1-linus.walleij@linaro.org>
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series now has all prerequisite changes in gpiolib
merged upstream so the conversion should be smooth.

The boardfile patches have been under review forever now,
so the maintainers either think it's OK or do not care.

I have confirmed clean build on a plethora of platforms
using the zeroday build system.

I think we can safely queue this for v4.17.

Linus Walleij (3):
  spi: spi-gpio: Rewrite to use GPIO descriptors
  spi: spi-gpio: Delete references to non-GENERIC_BITBANG
  spi: spi-gpio: Augment device tree bindings

 Documentation/devicetree/bindings/spi/spi-gpio.txt |  24 +-
 arch/arm/mach-pxa/cm-x300.c                        |  21 +-
 arch/arm/mach-pxa/raumfeld.c                       |  26 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |  55 ++--
 arch/arm/mach-s3c24xx/mach-qt2410.c                |  26 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |  22 +-
 arch/mips/alchemy/devboards/db1000.c               |  24 +-
 arch/mips/jz4740/board-qi_lb60.c                   |  26 +-
 drivers/misc/eeprom/digsy_mtc_eeprom.c             |  29 +-
 drivers/spi/spi-gpio.c                             | 298 +++++++--------------
 include/linux/spi/spi_gpio.h                       |  49 +---
 11 files changed, 280 insertions(+), 320 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
