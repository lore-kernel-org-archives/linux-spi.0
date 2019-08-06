From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v17 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings
Date: Tue,  6 Aug 2019 10:54:21 +0800
Message-ID: <1565060061-11588-3-git-send-email-masonccyang@mxic.com.tw>
References: <1565060061-11588-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        Mason Yang <masonccyang@mxic.com.tw>, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565060061-11588-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 0000000..d4344c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,45 @@
+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77980-rpc"	(R-Car V3H)
+		"renesas,r8a77995-rpc"	(R-Car D3)
+- reg: should contain three register areas:
+       first for the base address of RPC-IF registers,
+       second for the direct mapping read mode and
+       third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clocks: should contain the clock phandle/specifier pair for the module clock.
+- clock-names: should contain "rpc"
+- power-domains: should contain the power domain phandle/secifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1
+- #size-cells: should be 0
+- flash: should be represented by a subnode of the RPC-IF node,
+	 its "compatible" property contains "jedec,spi-nor" if SPI is used.
+
+Example:
+
+	rpc: spi@ee200000 {
+		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
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
+			spi-tx-bus-width = <4>;
+			spi-rx-bus-width = <4>;
+		};
+	};
-- 
1.9.1
