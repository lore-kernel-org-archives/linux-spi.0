From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: [PATCH 0/3] mtd: spi-nor: fix DMA-unsafe buffer issue between MTD and SPI
Date: Sun, 24 Dec 2017 05:36:03 +0100
Message-ID: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, radu.pirea@microchip.com,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
To: computersforpeace@gmail.com, dwmw2@infradead.org, richard@nod.at,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, broonie@kernel.org, vigneshr@ti.com,
        linux@armlinux.org.uk
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi all,

this series tries to solve a long time issue of compatibility between the
MTD and SPI sub-systems about whether we should use DMA-safe memory.

This issue is visible espcecially when using a UBI file-system on a SPI
NOR memory accessed through a SPI controller behind the m25p80 driver.

The SPI sub-system has already implemented a work-around on its side,
based on the spi_map_buf() function. However this function has its own
limitation too. Especially, even if it builds a 'struct scatterlist' from
a vmalloc'ed buffer, calling dma_map_sg() is still not safe on all
architectures. Especially, on ARM cores using either VIPT or VIVT data
caches, dma_map_sg() doesn't take the cache aliases issue into account.
Then numerous crashes were reported for such architectures.

If think it's high time to provide a reliable solution. So let's try to
work together!

The proposed solution here is based on an former series from Vignesh R and
relies on a bounce buffer.

For this series, I will need some pieces of advice on how to implement
a reliable [spi_nor_]is_dma_safe() function. The proposed implementation
in patch 1 is based on the tests performed by spi_map_buf() but I was
wondring whether it would be more cautious to consider:
DMA-safe <=> allocated by kmalloc'ed.

Actually, it's better using the bounce buffer when not needed than not
using it when we should.

Also the bounce buffer solution in spi-nor is designed so it could be
used as an helper so spi flash controller drivers other than m25p80.c
could now easily add support to DMA transfers for (Fast) Read and/or
Page Program operations.

I've implemented and tested it on a sama5d2 xplained board + Macronix
mx25l25673g SPI NOR memory reading from and writing into some UBI
file-system. I've also tested with mtd_debug to write then read back
a raw data into the SPI NOR memory, later checking the data integrity with
sha1sum.

For the atmel-quadspi.c driver, DMA memcpy() transfers are enabled only if
the "dmacap,mempcy" boolean property is set in the device-tree.
I found this name in some other device-trees already using it for a
boolean property.

Best regards,

Cyrille

Cyrille Pitchen (3):
  mtd: spi-nor: add optional DMA-safe bounce buffer for data transfer
  dt-bindings: mtd: atmel-quadspi: add an optional property
    'dmacap,memcpy'
  mtd: atmel-quadspi: add support of DMA memcpy()

 .../devicetree/bindings/mtd/atmel-quadspi.txt      |   5 +
 drivers/mtd/devices/m25p80.c                       |   4 +-
 drivers/mtd/spi-nor/atmel-quadspi.c                | 132 +++++++++++++++++++-
 drivers/mtd/spi-nor/spi-nor.c                      | 136 +++++++++++++++++++--
 include/linux/mtd/spi-nor.h                        |   8 ++
 5 files changed, 273 insertions(+), 12 deletions(-)

-- 
2.11.0
