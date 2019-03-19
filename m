From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 2/3] dt-bindings: snps,dw-apb-ssi: Add optional clock bindings documentation
Date: Tue, 19 Mar 2019 15:52:06 +0000
Message-ID: <1553010727-23157-3-git-send-email-gareth.williams.jx@renesas.com>
References: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add documentation to the Synopsys SPI dt-bindings to support an
optional interface clock that may be used for register access.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
v2: Created this separate patch to detail the optional interface clock
    property. This includes the clocks section on working with the two
    clocks and the clock-names line for pclk.
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bcd8f96..f54c8c3 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -8,9 +8,15 @@ Required properties:
 - interrupts : One interrupt, used by the controller.
 - #address-cells : <1>, as required by generic SPI binding.
 - #size-cells : <0>, also as required by generic SPI binding.
-- clocks : phandle for the core clock used to generate the external SPI clock.
+- clocks : phandles for the clocks, see the description of clock-names below.
+   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
+   is optional. If a single clock is specified but no clock-name, it is the
+   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
 
 Optional properties:
+- clock-names : Contains the names of the clocks:
+    "ssi_clk", for the core clock used to generate the external SPI clock.
+    "pclk", the interface clock, required for register access.
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
 - reg-io-width : The I/O register width (in bytes) implemented by this
-- 
2.7.4
