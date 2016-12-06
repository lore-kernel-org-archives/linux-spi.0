From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] mtd: spi-nor: add a stateless method to support memory size above 128Mib
Date: Tue, 6 Dec 2016 17:52:30 +0100
Message-ID: <cover.1481041702.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, <richard-/L3Ra7n9ekc@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

this series of patches is based on next-20161206 and can also be applied
to the git://github.com/spi-nor/linux.git tree.
It has been extracted from the SFDP series and is resent as a standalone
series.

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

Cyrille Pitchen (2):
  mtd: spi-nor: rename SPINOR_OP_* macros of the 4-byte address op codes
  mtd: spi-nor: add a stateless method to support memory size above
    128Mib

 drivers/mtd/devices/serial_flash_cmds.h |   7 --
 drivers/mtd/devices/st_spi_fsm.c        |  28 ++++----
 drivers/mtd/spi-nor/spi-nor.c           | 114 ++++++++++++++++++++++++++------
 drivers/spi/spi-bcm-qspi.c              |   6 +-
 include/linux/mtd/spi-nor.h             |  22 ++++--
 5 files changed, 126 insertions(+), 51 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
