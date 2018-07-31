From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Date: Tue, 31 Jul 2018 16:38:52 +0200
Message-ID: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
Cc: James Hogan <jhogan@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Paul Burton <paul.burton@mips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello,

This series only contains the DT documentation and the corresponding DT addition
since it has been rebased on spi-next.

Alexandre Belloni (3):
  spi: dw: document Microsemi integration
  mips: dts: mscc: Add spi on Ocelot
  mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123

 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
 arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
 arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.18.0
