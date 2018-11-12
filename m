From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] spi: npcm: add NPCM Peripheral SPI driver
Date: Mon, 12 Nov 2018 18:42:30 +0200
Message-ID: <20181112164232.435629-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch set adds Peripheral SPI (PSPI) support for the
Nuvoton NPCM Baseboard Management Controller (BMC).

The NPCM PSPI operates in master mode.

The NPCM750/730/715/710 supports up to two PSPI devices.

The NPCM PSPI driver tested on NPCM750 evaluation board.

Tomer Maimon (2):
  dt-binding: spi: add NPCM PSPI controller documentation
  spi: npcm: add NPCM PSPI controller driver

 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  |  35 ++
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-npcm-pspi.c                        | 480 +++++++++++++++++++++
 4 files changed, 523 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
 create mode 100644 drivers/spi/spi-npcm-pspi.c

-- 
2.14.1
