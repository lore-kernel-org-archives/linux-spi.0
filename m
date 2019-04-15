From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v10 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF controller bindings
Date: Mon, 15 Apr 2019 15:37:14 +0800
Message-ID: <1555313834-15107-4-git-send-email-masonccyang@mxic.com.tw>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
new file mode 100644
index 0000000..bfb3d29
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
@@ -0,0 +1,37 @@
+Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
+-------------------------------------------------------------
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77995-rpc"	(R-Car D3)
+- reg: should contain 2 entries, one for the base address of rpc-if registers,
+	and one for the direct mapping area
+- reg-names: should contain "regs", and "dirmap"
+- clocks: should contain 1 entries for the module's clock
+- clock-names: should contain "rpc"
+- #address-cells: should be 1
+- #size-cells: should be 0
+
+Example:
+
+	rpc: rpc-if@ee200000 {
+		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>;
+		reg-names = "regs", "dirmap";
+		clocks = <&cpg CPG_MOD 917>;
+		clock-names = "rpc";
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
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
