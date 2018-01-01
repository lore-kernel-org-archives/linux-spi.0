From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/5] Rewrite GPIO SPI to use descriptors
Date: Mon,  1 Jan 2018 14:37:44 +0100
Message-ID: <20180101133749.29567-1-linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Just as it says, this rewrites the GPIO bit-banged SPI driver to
just use GPIO descriptors and pushes the configuration of the GPIO
lines down into devices trees and board files.

As there is a patch to the GPIO core, I can provide a tag to
be pulled from the GPIO tree so I can pull the first patch
into the GPIO devel branch for next as well.

There is a testing branch based on v4.15-rc1 already if people
just want to pull it in and test it from there:

https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=gpio-descriptors-spi

Please test it if you can.

Linus Walleij (5):
  gpio: of: Support SPI nonstandard GPIO properties
  spi: spi-gpio: Rewrite to use GPIO descriptors
  spi: spi-gpio: Augment device tree bindings
  spi: spi-gpio: Make optional chipselect handling more explicit
  spi: spi-gpio: Delete references to non-GENERIC_BITBANG

 Documentation/devicetree/bindings/spi/spi-gpio.txt |  24 +-
 arch/arm/mach-pxa/cm-x300.c                        |  21 +-
 arch/arm/mach-pxa/raumfeld.c                       |  26 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |  55 ++--
 arch/arm/mach-s3c24xx/mach-qt2410.c                |  26 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |  22 +-
 arch/mips/alchemy/devboards/db1000.c               |  24 +-
 arch/mips/jz4740/board-qi_lb60.c                   |  26 +-
 drivers/gpio/gpiolib-of.c                          |  36 +++
 drivers/misc/eeprom/digsy_mtc_eeprom.c             |  29 +-
 drivers/spi/spi-gpio.c                             | 293 ++++++---------------
 include/linux/spi/spi_gpio.h                       |  49 +---
 12 files changed, 311 insertions(+), 320 deletions(-)

-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
