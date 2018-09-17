From: masonccyang@mxic.com.tw
Subject: [PATCH 2/2] dt-binding: spi: Document Macronix controller bindings
Date: Mon, 17 Sep 2018 15:16:19 +0800
Message-ID: <1537168579-31593-3-git-send-email-masonccyang@mxic.com.tw>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
To: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Document the bindings used by the Macronix controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 Documentation/devicetree/bindings/spi/spi-mxic.txt | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mxic.txt b/Documentation/devicetree/bindings/spi/spi-mxic.txt
new file mode 100644
index 0000000..529f2da
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mxic.txt
@@ -0,0 +1,34 @@
+Macronix SPI controller Device Tree Bindings
+--------------------------------------------
+
+Required properties:
+- compatible: should be "mxicy,mx25f0a-spi"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area
+- reg-names: should contain "regs" and "dirmap"
+- interrupts: interrupt line connected to the SPI controller
+- clock-names: should contain "ps_clk", "send_clk" and "send_dly_clk"
+- clocks: should contain 3 entries for the "ps_clk", "send_clk" and
+	  "send_dly_clk" clocks
+
+Example:
+
+	spi@43c30000 {
+		compatible = "mxicy,mx25f0a-spi";
+		reg = <0x43c30000 0x10000>, <0xa0000000 0x20000000>;
+		reg-names = "regs", "dirmap";
+		clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 18>;
+		clock-names = "send_clk", "send_dly_clk", "ps_clk";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <25000000>;
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+		};
+	};
-- 
1.9.1
