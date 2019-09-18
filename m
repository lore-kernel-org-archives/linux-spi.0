From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 0/4] spi: dw: Add basic runtime PM support
Date: Wed, 18 Sep 2019 09:04:32 +0100
Message-ID: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

v2:
 - Note that pclk should be renamed when using a clock domain in the
   bindings documentation.
 - Set spi_controller.auto_runtime_pm instead of using
   pm_runtime_get_sync.
 - Added pm_runtime_disable calls to dw_spi_remove_host and the error
   condition of dw_spi_add_host.

Gareth Williams (1):
  dt-bindings: snps,dw-apb-ssi: Add optional clock domain information

Phil Edworthy (3):
  dt: spi: Add Renesas RZ/N1 binding documentation
  spi: dw: Add basic runtime PM support
  spi: dw: Add compatible string for Renesas RZ/N1 SPI Controller

 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt | 11 +++++++++++
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt  |  3 ++-
 drivers/spi/spi-dw-mmio.c                                  |  1 +
 drivers/spi/spi-dw.c                                       |  8 ++++++++
 4 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzn1-spi.txt

-- 
2.7.4
