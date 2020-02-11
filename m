From: Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 0/9] mtd: spi-nor: add xSPI Octal DTR support
Date: Tue, 11 Feb 2020 19:03:39 +0530
Message-ID: <20200211133348.15558-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

This series adds support for octal DTR flashes in the spi-nor framework,
and then adds hooks for the Cypress Semper flash which is an xSPI
compliant Octal DTR flash.

The Cadence QSPI controller driver is also updated to run in Octal DTR
mode.

Tested on TI J721e EVM with 1-bit ECC on the Cypress flash.

This series depends on [0].

[0] https://patchwork.kernel.org/patch/11355593/

Pratyush Yadav (9):
  spi: spi-mem: allow specifying whether an op is DTR or not
  spi: spi-mem: allow specifying a command's extension
  spi: cadence-quadspi: Add support for octal DTR flashes
  mtd: spi-nor: add support for DTR protocol
  mtd: spi-nor: get command opcode extension type from BFPT
  mtd: spi-nor: parse xSPI Profile 1.0 table
  mtd: spi-nor: use dummy cycle and address width info from SFDP
  mtd: spi-nor: enable octal DTR mode when possible
  mtd: spi-nor: add support for Cypress Semper flash

 drivers/mtd/spi-nor/spi-nor.c     | 595 +++++++++++++++++++++++++++---
 drivers/spi/spi-cadence-quadspi.c | 262 +++++++++++--
 drivers/spi/spi-mem.c             |  48 +++
 include/linux/mtd/spi-nor.h       |  55 ++-
 include/linux/spi/spi-mem.h       |  32 ++
 include/linux/spi/spi.h           |   2 +
 6 files changed, 890 insertions(+), 104 deletions(-)

--
2.25.0
