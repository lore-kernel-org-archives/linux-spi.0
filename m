From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 1/3] dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings documentation
Date: Tue, 19 Mar 2019 15:52:05 +0000
Message-ID: <1553010727-23157-2-git-send-email-gareth.williams.jx@renesas.com>
References: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The Synopsys SSI driver uses a mandatory clock that is not documented,
so detail it in the device tree bindings. Also correct the spelling of
"pins" in the "Optional Properties" section for the driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
v2:
 - Seperated spelling correction and mandatory clock documentation
  from the optional interface clock documentation commit.
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2864bc6..bcd8f96 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,10 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
+- clocks : phandle for the core clock used to generate the external SPI clock.
 
 Optional properties:
-- cs-gpios : Specifies the gpio pis to be used for chipselects.
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
@@ -25,6 +26,7 @@ Example:
 		interrupts = <0 154 4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&spi_m_clk>;
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
-- 
2.7.4
