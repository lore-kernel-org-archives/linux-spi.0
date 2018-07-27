From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 0/4] Add support for MSCC Ocelot SPI
Date: Fri, 27 Jul 2018 14:05:31 +0200
Message-ID: <20180727120535.16504-1-alexandre.belloni@bootlin.com>
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

Changes in v2:
 - Removed already applied patches
 - separated DT binding changes from the driver patch

Alexandre Belloni (4):
  dt-bindings: spi: snps,dw-apb-ssi: document Microsemi integration
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 arch/mips/boot/dts/mscc/ocelot.dtsi       | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts | 10 +++
 drivers/spi/spi-dw-mmio.c                 | 91 +++++++++++++++++++++++
 3 files changed, 112 insertions(+)

-- 
2.18.0
