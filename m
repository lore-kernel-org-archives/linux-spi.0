From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/5] add support for bcm63xx HSSPI controller
Date: Sat, 30 Nov 2013 12:42:01 +0100
Message-ID: <1385811726-6746-1-git-send-email-jogo@openwrt.org>
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch set adds support for the high speed SPI controller found in
newer BCM63XX SoCs.

Patches 1 to 4 add the required platform data to bcm63xx, while Patch 5
adds the actual driver.

Since all the driver needs are the register block offset, an interrupt 
and a clock with a rate, it does not need any extra platform data.
Therefore there is no compile time dependency, and patches 1 to 4, and
patch 5 can go through different trees (these patches are based on
spi/for-next).

While the controller itself has the same limitations as the old SPI
controller, that is automatic deactivation of the CS line after flushing
its hardware buffer.
But in contrast to the old one it supports CS polarity configuration,
which allows us to work around it and manually control the CS lines.
In addition to that it also supports dual mode (both read and write) and
3-wire, but both of them are not supported by the driver yet.

This driver was run tested on BCM63281, BCM63283 and BCM6361, and build
tested for x86 to ensure COMPILE_TEST works.

Jonas Gorski (5):
  MIPS: BCM63XX: expose the HSSPI clock
  MIPS: BCM63XX: setup the HSSPI clock rate
  MIPS: BCM63XX: add HSSPI IRQ and register offsets
  MIPS: BCM63XX: add HSSPI platform device and register it
  spi: add bcm63xx HSSPI driver

 arch/mips/bcm63xx/Makefile                         |   4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   3 +
 arch/mips/bcm63xx/clk.c                            |  42 ++
 arch/mips/bcm63xx/dev-hsspi.c                      |  47 ++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |  18 +
 .../include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h   |   8 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-bcm63xx-hsspi.c                    | 484 +++++++++++++++++++++
 9 files changed, 612 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-hsspi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_hsspi.h
 create mode 100644 drivers/spi/spi-bcm63xx-hsspi.c

-- 
1.8.4.rc3
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
