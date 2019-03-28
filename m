From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 0/7] Add Macronix MX25F0A MFD driver and NAND function
Date: Thu, 28 Mar 2019 18:18:31 +0800
Message-ID: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

These patches support
1. Add Macronix MX25F0A MFD driver for SPI and raw NAND controller.
2. Add direct mapping read mode for SPI host controller.
3. Macronix NAND device read retry and randomizer function.
4. Macronix NAND device block protection function.

thanks for your review.

best regards,
Mason


Mason Yang (7):
  mfd: Add Macronix MX25F0A MFD controller driver
  mtd: rawnand: Add Macronix MX25F0A NAND controller driver
  spi: Patch Macronix MX25F0A SPI controller driver
  dt-bindings: mfd: Document Macronix MX25F0A controller bindings
  spi: Add direct mapping mode for Macronix SPI controller
  mtd: rawnand: Add Macronix NAND read retry and randomizer support
  mtd: rawnand: Add Macronix NAND block protection driver

 .../devicetree/bindings/mfd/mxic-mx25f0a.txt       |  66 +++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/mxic-mx25f0a.c                         |  90 ++++++
 drivers/mtd/nand/raw/Kconfig                       |   6 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/mxic_nand.c                   | 306 +++++++++++++++++++++
 drivers/mtd/nand/raw/nand_macronix.c               | 216 +++++++++++++++
 drivers/spi/spi-mxic.c                             | 288 +++++++------------
 include/linux/mfd/mxic-mx25f0a.h                   | 176 ++++++++++++
 10 files changed, 974 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
 create mode 100644 drivers/mfd/mxic-mx25f0a.c
 create mode 100644 drivers/mtd/nand/raw/mxic_nand.c
 create mode 100644 include/linux/mfd/mxic-mx25f0a.h

-- 
1.9.1
