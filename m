From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 2/2] dt-binding: spi: Document Renesas R-Car RPC controller bindings
Date: Mon, 19 Nov 2018 18:01:30 +0800
Message-ID: <1542621690-10229-3-git-send-email-masonccyang@mxic.com.tw>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document the bindings used by the Renesas R-Car D3 RPC controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 0000000..8286cc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,33 @@
+Renesas R-Car D3 RPC controller Device Tree Bindings
+----------------------------------------------------
+
+Required properties:
+- compatible: should be "renesas,rpc-r8a77995"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area
+- reg-names: should contain "rpc_regs" and "dirmap"
+- interrupts: interrupt line connected to the RPC SPI controller
+- clock-names: should contain "clk_rpc"
+- clocks: should contain 1 entries for the CPG Module 917 clocks
+
+Example:
+
+	rpc: spi@ee200000 {
+		compatible = "renesas,rpc-r8a77995";
+		reg = <0 0xee200000 0 0x8100>, <0 0x08000000 0 0x4000000>;
+		reg-names = "rpc_regs", "dirmap";
+		clocks = <&cpg CPG_MOD 917>;
+		clock-names = "clk_rpc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
-- 
1.9.1
