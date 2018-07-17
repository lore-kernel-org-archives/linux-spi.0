From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 0/5] Add support for MSCC Ocelot SPI
Date: Tue, 17 Jul 2018 16:23:09 +0200
Message-ID: <20180717142314.32337-1-alexandre.belloni@bootlin.com>
Cc: Paul Burton <paul.burton@mips.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

The MSCC MIPS SoC line uses a designware IP for the SPI controller but
still requires some special handling to give control of the SPI
interface to the IP and also has a specific handling for the chip
select.

Patches 1 to 3 should go through the SPI tree while 4 and 5 should
probably got throught the MIPS tree once patch 3 has been reviewed by
the DT maintainers.

Alexandre Belloni (5):
  spi: dw: fix possible race condition
  spi: dw: allow providing own set_cs callback
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     | 10 +++
 drivers/spi/spi-dw-mmio.c                     | 86 +++++++++++++++++++
 drivers/spi/spi-dw.c                          |  6 +-
 drivers/spi/spi-dw.h                          |  1 +
 6 files changed, 116 insertions(+), 3 deletions(-)

-- 
2.18.0
