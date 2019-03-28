From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH 4/7] dt-bindings: mfd: Document Macronix MX25F0A controller bindings
Date: Thu, 28 Mar 2019 18:18:35 +0800
Message-ID: <1553768318-23149-5-git-send-email-masonccyang@mxic.com.tw>
References: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, zhengxunli@mxic.com.tw,
        Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, dwmw2@infradead.org, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmal.com, paul.burton@mips.com, stefan@agner.ch,
        christophe.kerello@st.com, liang.yang@amlogic.com,
        geert@linux-m68k.org, devicetree@vger.kernel.org,
        marcel.ziswiler@toradex.com, linux-mtd@lists.infradead.org,
        richard@nod.at, miquel.raynal@bootlin.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553768318-23149-1-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document the bindings used by the Macronix MX25F0A MFD controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/mfd/mxic-mx25f0a.txt       | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt

diff --git a/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
new file mode 100644
index 0000000..53b4839
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mxic-mx25f0a.txt
@@ -0,0 +1,66 @@
+Macronix MX25F0A Multi-Function Device Tree Bindings
+----------------------------------------------------
+
+MX25F0A is a MultiFunction Device with SPI and raw NAND, which
+supports either spi host controller or raw nand controller.
+
+Required properties:
+- compatible: should be "mxic,mx25f0a-mfd"
+- #address-cells: should be 1
+- #size-cells: should be 0
+- reg: should contain 2 entries, one for the registers and one for the direct
+       mapping area in SPI mode.
+- reg-names: should contain "regs" and "dirmap"
+- interrupts: interrupt line connected to this MFD controller
+
+Required nodes:
+ - spi :
+	Node for configuring the SPI controller driver.
+	Required properties:
+		- compatible = "mxicy,mx25f0a-spi";
+		- clock-names: should contain "ps_clk", "send_clk" and
+			       "send_dly_clk"
+		- clocks: should contain 3 entries for the "ps_clk", "send_clk"
+			  and "send_dly_clk" clocks
+
+- nand :
+	Node for configuring the raw nand controller driver.
+	Required properties:
+		- compatible = "mxicy,mx25f0a-nand-ctlr";
+		- nand-ecc-mode = "soft";
+		- nand-ecc-algo = "bch";
+
+Example:
+
+	mxic: mx25f0a-mfd@43c30000 {
+		compatible = "mxic,mx25f0a-mfd";
+		reg = <0x43c30000 0x10000>, <0xa0000000 0x4000000>;
+		reg-names = "regs", "dirmap";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* either spi or nand */
+		spi {
+			compatible = "mxicy,mx25f0a-spi";
+			clocks = <&clkwizard 0>, <&clkwizard 1>, <&clkc 15>;
+			clock-names = "send_clk", "send_dly_clk", "ps_clk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			flash@0 {
+				compatible = "jedec,spi-nor";
+				reg = <0>;
+				spi-max-frequency = <25000000>;
+				spi-tx-bus-width = <4>;
+				spi-rx-bus-width = <4>;
+			};
+		};
+
+		nand {
+			compatible = "mxicy,mx25f0a-nand-ctlr";
+			nand-ecc-mode = "soft";
+			nand-ecc-algo = "bch";
+			nand-ecc-step-size = <512>;
+			nand-ecc-strength = <8>;
+		};
+	};
-- 
1.9.1
