From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v3 2/5] dt-bindings: spi: snps,dw-apb-ssi: document Microsemi integration
Date: Fri, 27 Jul 2018 21:53:55 +0200
Message-ID: <20180727195358.23336-3-alexandre.belloni@bootlin.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
Cc: Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
To: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727195358.23336-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The integration of the Designware SPI controller on Microsemi SoCs requires
an extra register set to be able to give the IP control of the SPI
interface.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 204b311e0400..d97b9fc4c1cb 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,8 +1,9 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
-- compatible : "snps,dw-apb-ssi"
-- reg : The register base for the controller.
+- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi"
+- reg : The register base for the controller. For "mscc,<soc>-spi", a second
+  register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- 
2.18.0
