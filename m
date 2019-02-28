From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [RFC PATCH 1/2] dt-bindings: spi: Add device tree binding documentation for Zynq QSPI controller
Date: Thu, 28 Feb 2019 12:31:53 +0530
Message-ID: <1551337313-9499-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <michal.simek@xilinx.com>, <mark.rutland@arm.com>,
        <broonie@kernel.org>, <bbrezillon@kernel.org>,
        <horms+renesas@verge.net.au>, <geert+renesas@glider.be>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds the dts binding document for Zynq SOC QSPI
controller.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
 .../devicetree/bindings/spi/spi-zynq-qspi.txt      | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
new file mode 100644
index 0000000..16b734a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-zynq-qspi.txt
@@ -0,0 +1,25 @@
+Xilinx Zynq QSPI controller Device Tree Bindings
+-------------------------------------------------------------------
+
+Required properties:
+- compatible		: Should be "xlnx,zynq-qspi-1.0".
+- reg			: Physical base address and size of QSPI registers map.
+- interrupts		: Property with a value describing the interrupt
+			  number.
+- clock-names		: List of input clock names - "ref_clk", "pclk"
+			  (See clock bindings for details).
+- clocks		: Clock phandles (see clock bindings for details).
+
+Optional properties:
+- num-cs		: Number of chip selects used.
+
+Example:
+	qspi: spi@e000d000 {
+		compatible = "xlnx,zynq-qspi-1.0";
+		reg = <0xe000d000 0x1000>;
+		interrupt-parent = <&intc>;
+		interrupts = <0 19 4>;
+		clock-names = "ref_clk", "pclk";
+		clocks = <&clkc 10>, <&clkc 43>;
+		num-cs = <1>;
+	};
-- 
2.7.4
