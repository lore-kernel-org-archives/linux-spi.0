From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 0/9 v3] MIPS: BCM63XX: add support for SPI
Date: Tue, 31 Jan 2012 15:10:39 +0100
Message-ID: <1328019048-5892-1-git-send-email-florian@openwrt.org>
Cc: linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
To: ralf@linux-mips.org
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

This patch set depend on the serie "MIPS: BCM63XX: misc cleanup" and
adds support for the SPI controller found in BCM63xx SoCs.

Grant, it probably makes sense to get this merged via the MIPS tree
since it mostly depends on it.

Florian Fainelli (9):
  MIPS: BCM63XX: add IRQ_SPI and CPU specific SPI IRQ values
  MIPS: BCM63XX: define BCM6358 SPI base address
  MIPS: BCM63XX: add BCM6368 SPI clock mask
  MIPS: BCM63XX: define SPI register sizes.
  MIPS: BCM63XX: remove SPI2 register
  MIPS: BCM63XX: define internal registers offsets of the SPI
    controller
  MIPS: BCM63XX: add stub to register the SPI platform driver
  MIPS: BCM63XX: make board setup code register the spi platform device
  spi: add Broadcom BCM63xx SPI controller driver

 arch/mips/bcm63xx/Makefile                         |    3 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |    3 +
 arch/mips/bcm63xx/clk.c                            |    6 +-
 arch/mips/bcm63xx/dev-spi.c                        |  119 +++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |   23 +-
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 ++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  119 +++++
 drivers/spi/Kconfig                                |    6 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-bcm63xx.c                          |  486 ++++++++++++++++++++
 10 files changed, 842 insertions(+), 13 deletions(-)
 create mode 100644 arch/mips/bcm63xx/dev-spi.c
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
 create mode 100644 drivers/spi/spi-bcm63xx.c

-- 
1.7.5.4
