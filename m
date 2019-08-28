From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 0/2] spi: add NPCM FIU controller driver
Date: Wed, 28 Aug 2019 17:25:11 +0300
Message-ID: <20190828142513.228556-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        vigneshr@ti.com, bbrezillon@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch set adds Flash Interface Unit(FIU) SPI 
master support for the Nuvoton NPCM Baseboard 
Management Controller (BMC).

The FIU supports single, dual or quad communication interface.

the FIU controller can operate in following modes:
- User Mode Access(UMA): provides flash access by using an
  indirect address/data mechanism.
- direct rd/wr mode: maps the flash memory into the core
  address space.
- SPI-X mode: used for an expansion bus to an ASIC or CPLD.

The NPCM750/730/715/710 supports up to three FIU devices:
- FIU0 supports two chip select.
- FIU3 supports four chip select.
- FIUX supports two chip select.

The NPCM FIU driver tested on NPCM750 evaluation board. 

The FIU controller driver using direct map API SPI-MEM
interface and tested with the latest m25p80 driver patch
https://www.spinics.net/lists/linux-mtd/msg07358.html

According a conversion about direct SPI-MEM API
https://www.spinics.net/lists/linux-mtd/msg08225.html

The m25p80 driver will merge to the spi-nor driver we
need to make sure the m25p80 direct SPI-MEM will merge
as well.

The FIU controller driver tested with the latest spi-nor driver patch
https://www.spinics.net/lists/linux-mtd/msg08472.html

Addressed comments from:
 - Mark Brown: https://www.spinics.net/lists/linux-spi/msg18166.html
 - Boris Brezillon: https://www.spinics.net/lists/linux-spi/msg18176.html 
 - Rob Herring: https://www.spinics.net/lists/linux-spi/msg18289.html
  
Changes since version 2:
 - Remove unnecessary dev_info probe print.
 - Support address SPI memory operation. 
 - Limit address size support.
 - Add vendor prefix to spi-mode property dt-binding documentation.

Changes since version 1:
 - Support spi-mem no data transferred option (SPI_MEM_NO_DATA)

Tomer Maimon (2):
  dt-binding: spi: add NPCM FIU controller
  spi: npcm-fiu: add NPCM FIU controller driver

 .../bindings/spi/nuvoton,npcm-fiu.txt         |  47 ++
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-npcm-fiu.c                    | 771 ++++++++++++++++++
 4 files changed, 829 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-fiu.txt
 create mode 100644 drivers/spi/spi-npcm-fiu.c

-- 
2.18.0
