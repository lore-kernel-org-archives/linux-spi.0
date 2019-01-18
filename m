From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings
Date: Fri, 18 Jan 2019 13:54:15 +0800
Message-ID: <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 0000000..9b5001e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,37 @@
+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+----------------------------------------------------------
+
+Required properties:
+- compatible: should be "renesas,rcar-gen3-rpc"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain three register areas:
+	first for the base address of rpc-if registers,
+	second for the direct mapping read mode and
+	third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clock-names: should contain "rpc"
+- clocks: should contain 1 entries for the module's clock
+
+Example:
+
+	rpc: rpc@ee200000 {
+		compatible = "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x7fff>, <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "<wbuf>;
+		clocks = <&cpg CPG_MOD 917>;
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		clock-names = "rpc";
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
