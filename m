From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 0/5] Add support for MSCC Ocelot SPI
Date: Fri, 27 Jul 2018 21:53:53 +0200
Message-ID: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
Cc: Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
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

Changes in v3:
 - Added a patch to export dw_spi_set_cs

Changes in v2:
 - Removed already applied patches
 - separated DT binding changes from the driver patch

Alexandre Belloni (5):
  spi: dw: export dw_spi_set_cs
  dt-bindings: spi: snps,dw-apb-ssi: document Microsemi integration
  spi: dw-mmio: add MSCC Ocelot support
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../bindings/spi/snps,dw-apb-ssi.txt          |  5 +-
 arch/mips/boot/dts/mscc/ocelot.dtsi           | 11 +++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts     | 10 +++
 drivers/spi/spi-dw-mmio.c                     | 90 +++++++++++++++++++
 drivers/spi/spi-dw.c                          |  3 +-
 drivers/spi/spi-dw.h                          |  1 +
 6 files changed, 117 insertions(+), 3 deletions(-)

-- 
2.18.0
