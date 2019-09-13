From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 0/3] spi: dw: Add basic runtime PM support
Date: Fri, 13 Sep 2019 13:11:57 +0100
Message-ID: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The Renesas RZ/N1 SPI Controller is based on the Synopsys DW SSI. This
series enables power mode in the driver so the clock domain will enable
the bus clock, adds the compatible string and updates the associated bindings
documentation.

Phil Edworthy (3):
  dt: spi: Add Renesas RZ/N1 binding documentation
  spi: dw: Add basic runtime PM support
  spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
 drivers/spi/spi-dw-mmio.c                                  |  1 +
 drivers/spi/spi-dw.c                                       |  4 ++++
 3 files changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

-- 
2.7.4
