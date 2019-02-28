From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 1/2] dt: snps,dw-apb-ssi: Add clock bindings documentation
Date: Thu, 28 Feb 2019 13:25:41 +0000
Message-ID: <1551360342-23981-2-git-send-email-gareth.williams.jx@renesas.com>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

The driver requires a clock property, so detail it in the docs.
Fix a typo, 'pis' to 'pins'.
Add documentation for a separate, optional, interface clock.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2864bc6..7971193 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,16 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
+- clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ssi_clk" clock is required. The phandle for the "pclk"
+   clock is optional. If a single clock is specified but no clock-name, it is
+   the "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
 
 Optional properties:
-- cs-gpios : Specifies the gpio pis to be used for chipselects.
+- clock-names : Contains the names of the clocks:
+    "ssi_clk", for the core clock used to generate the external SPI clock.
+    "pclk", the interface clock, required for register access.
+- cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
   device.  Supported values are 2 or 4 (the default).
@@ -25,6 +32,7 @@ Example:
 		interrupts = <0 154 4>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		clocks = <&spi_m_clk>;
 		num-cs = <2>;
 		cs-gpios = <&gpio0 13 0>,
 			   <&gpio0 14 0>;
-- 
2.7.4
