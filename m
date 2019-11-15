From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 0/4] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Date: Fri, 15 Nov 2019 16:58:04 +0800
Message-ID: <1573808288-19365-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, vigneshr@ti.com,
        bbrezillon@kernel.org, tudor.ambarus@microchip.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

This is repost of patchset from Boris Brezillon's
[RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].

Background from cover letter for RFC[1].

The trend has been around Octal NOR Flash lately and the latest mainline
already supports 1-1-8 and 1-8-8 modes.

Boris opened a discussion on how we should support stateful modes (X-X-X
and XD-XD-XD, where X is the bus width and D means Double Transfer Rate).

JESD216C has defined specification for Octal 8-8-8 and 8D-8D-8D.
It defined command and command extension in
JEDEC Basic Flash Parameter Table(18th DWORD) as well as how to
enable 8-8-8/8D-8D-8D mode sequences (Write CFG Reg 2).

The first set of patches is according to JESD216C adding Double Transfer
Rate(DTR) fields, extension command and command bytes number to the
spi_mem_op struct.

The second set of patches define the relevant macrons and enum in spi-nor
layer for Octal 8-8-8 and 8D-8D-8D mode operation.

The last set of patches in the series are modifying spi_nor_fixups hook to
tweak flash parameters for spi_nor_read/pp_setting() and then in a
chip-specific way to enter 8-8-8 or 8D-8D-8D modes on a Macronix chip.

Also patched spi-mxic driver for testing on Macronix's Zynq PicoZed board
with Macronix's SPI controller (spi-mxic.c) and mx25uw51245g Octal flash.

[1] https://patchwork.ozlabs.org/cover/982926/

thnaks for your time and review.
best regards,
Mason


Mason Yang (4):
  spi: spi-mem: Add support for Octal 8D-8D-8D mode
  mtd: spi-nor: Add support for Octal 8D-8D-8D mode
  mtd: spi-nor: Add Octal 8D-8D-8D mode support for Macronix
    mx25uw51245g
  spi: mxic: Add support for Octal 8D-8D-8D mode

 drivers/mtd/spi-nor/spi-nor.c | 273 +++++++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi-mem.c         |   8 +-
 drivers/spi/spi-mxic.c        |  98 ++++++++++-----
 include/linux/mtd/spi-nor.h   |  61 +++++++++-
 include/linux/spi/spi-mem.h   |  13 ++
 5 files changed, 410 insertions(+), 43 deletions(-)

-- 
1.9.1
