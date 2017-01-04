From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v4 0/2] mtd: spi-nor: add a stateless method to support memory size above 128Mib
Date: Wed, 4 Jan 2017 13:20:53 +0100
Message-ID: <cover.1483528931.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace@gmail.com>,
        <boris.brezillon@free-electrons.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
To: <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi all,

this series of patches is based on the git://github.com/spi-nor/linux.git
tree. It has been extracted from the SFDP series and is resent as
a standalone series.

This series fixes compatibility issue between Linux and many bootloaders
when using SPI flash with size greater than 128Mib.

Indeed, before this series, Linux used to make the SPI flash memory enter
its 4-byte address mode when its size is greater than 128Mib: The very
same Fast Read 1-1-z op code is used, for instance Fast Read 1-1-4 (6Bh)
but once in 4-byte address mode, the SPI flash memory now expects a 4-byte
address following the op code instead of a 3-byte address.
This solution is statefull: it changes the internal state of the memory.

Hence, when the CPU is reset but not the memory, many bootloaders are not
aware of this internal state change at the memory side, don't know how to
handle this and still send one Fast Read op code followed by a 3-byte
address. So the bootloader fails to read data from the SPI flash memory.

ChangeLog:

v3 -> v4:
- replace "++i" by "i++" in a "for" loop.
- add a new "size" parameter to spi_nor_convert_opcode() and use the
  ARRAY_SIZE() macro instead of a null sentinel at the end the table array.

v2 -> v3:
- no change on patch 1.
- rebase patch 2 on the spi-nor tree: SPI_NOR_4B_OPCODES is changed from
  BIT(10) to BIT(11), otherwise patch could be applied on linux-next.
- remove helper macro such as ENTRY_3TO4()
- split the 3to4 opcode table into 3 different tables for read, program
  and erase op codes.

v1 -> v2:
- collect Acked-by for patch 1.
- replace the dichotomic search by a simple for() loop for better clarity
  purpose in patch 2.

Cyrille Pitchen (2):
  mtd: spi-nor: rename SPINOR_OP_* macros of the 4-byte address op codes
  mtd: spi-nor: add a stateless method to support memory size above
    128Mib

 drivers/mtd/devices/serial_flash_cmds.h |   7 ---
 drivers/mtd/devices/st_spi_fsm.c        |  28 ++++-----
 drivers/mtd/spi-nor/spi-nor.c           | 101 +++++++++++++++++++++++++-------
 drivers/spi/spi-bcm-qspi.c              |   6 +-
 include/linux/mtd/spi-nor.h             |  22 +++++--
 5 files changed, 113 insertions(+), 51 deletions(-)

-- 
2.7.4
