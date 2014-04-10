From: Harini Katakam <harinik@xilinx.com>
Subject: [PATCH v3 2/2] devicetree: Add devicetree bindings documentation for Cadence SPI
Date: Thu, 10 Apr 2014 17:43:50 +0530
Message-ID: <1397132030-2440-2-git-send-email-harinik@xilinx.com>
References: <1397132030-2440-1-git-send-email-harinik@xilinx.com>
Cc: michals@xilinx.com, Harini Katakam <harinik@xilinx.com>
To: broonie@kernel.org, grant.likely@linaro.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397132030-2440-1-git-send-email-harinik@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add spi-cadence bindings documentation.

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---

v3 changes:
- Remove /bits/ 16 from num-cs property in example.
- Add is-decoded-cs optional property and add to description of num-cs.

v2 changes:
- Separate patch for bindings.
- Add xilinx compatible string; Make compatible string first in the node.
- Use property name num-cs. Make this property optional.

---
 .../devicetree/bindings/spi/spi-cadence.txt        |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-cadence.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.txt b/Documentation/devicetree/bindings/spi/spi-cadence.txt
new file mode 100644
index 0000000..94f0914
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.txt
@@ -0,0 +1,31 @@
+Cadence SPI controller Device Tree Bindings
+-------------------------------------------
+
+Required properties:
+- compatible		: Should be "cdns,spi-r1p6" or "xlnx,zynq-spi-r1p6".
+- reg			: Physical base address and size of SPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- interrupt-parent	: Must be core interrupt controller
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+			  If a decoder is used, this will be the number of
+			  chip selects after the decoder.
+- is-decoded-cs		: Flag to indicate whether decoder is used or not.
+
+Example:
+
+	spi@e0007000 {
+		compatible = "xlnx,zynq-spi-r1p6";
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clkc 26>, <&clkc 35>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 49 4>;
+		num-cs = <4>;
+		is-decoded-cs = <0>;
+		reg = <0xe0007000 0x1000>;
+	} ;
-- 
1.7.9.5
