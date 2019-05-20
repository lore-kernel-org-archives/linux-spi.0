From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 3/4] dt-bindings: spi: sun6i: Add YAML schemas
Date: Mon, 20 May 2019 16:50:35 +0200
Message-ID: <682af95d93f4065ee7ab6a5d6f226c848f6a7da8.1558363790.git-series.maxime.ripard@bootlin.com>
References: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f53ee257855c6499fd783dc8665558f7670312f6.1558363790.git-series.maxime.ripard@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

---

Changes from v1:
  - Fix the slave device regex
---
 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/spi/spi-sun6i.txt                |  44 +------------------------------
 2 files changed, 106 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
new file mode 100644
index 000000000000..bda7a5befd8b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/allwinner,sun6i-a31-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 SPI Controller Device Tree Bindings
+
+allOf:
+  - $ref: "spi-controller.yaml"
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+properties:
+  "#address-cells": true
+  "#size-cells": true
+
+  compatible:
+    enum:
+      - allwinner,sun6i-a31-spi
+      - allwinner,sun8i-h3-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus Clock
+      - description: Module Clock
+
+  clock-names:
+    items:
+      - const: ahb
+      - const: mod
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: RX DMA Channel
+      - description: TX DMA Channel
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
+  num-cs: true
+
+patternProperties:
+  "^.*@[0-9a-f]+":
+    properties:
+      reg:
+        items:
+          minimum: 0
+          maximum: 4
+
+      spi-rx-bus-width:
+        const: 1
+
+      spi-tx-bus-width:
+        const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi1: spi@1c69000 {
+        compatible = "allwinner,sun6i-a31-spi";
+        reg = <0x01c69000 0x1000>;
+        interrupts = <0 66 4>;
+        clocks = <&ahb1_gates 21>, <&spi1_clk>;
+        clock-names = "ahb", "mod";
+        resets = <&ahb1_rst 21>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+  - |
+    spi0: spi@1c68000 {
+        compatible = "allwinner,sun8i-h3-spi";
+        reg = <0x01c68000 0x1000>;
+        interrupts = <0 65 4>;
+        clocks = <&ccu 30>, <&ccu 82>;
+        clock-names = "ahb", "mod";
+        dmas = <&dma 23>, <&dma 23>;
+        dma-names = "rx", "tx";
+        resets = <&ccu 15>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
deleted file mode 100644
index 435a8e0731ac..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-Allwinner A31/H3 SPI controller
-
-Required properties:
-- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
-- reg: Should contain register location and length.
-- interrupts: Should contain interrupt.
-- clocks: phandle to the clocks feeding the SPI controller. Two are
-          needed:
-  - "ahb": the gated AHB parent clock
-  - "mod": the parent module clock
-- clock-names: Must contain the clock names described just above
-- resets: phandle to the reset controller asserting this device in
-          reset
-
-Optional properties:
-- dmas: DMA specifiers for rx and tx dma. See the DMA client binding,
-	Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request names should include "rx" and "tx" if present.
-
-Example:
-
-spi1: spi@1c69000 {
-	compatible = "allwinner,sun6i-a31-spi";
-	reg = <0x01c69000 0x1000>;
-	interrupts = <0 66 4>;
-	clocks = <&ahb1_gates 21>, <&spi1_clk>;
-	clock-names = "ahb", "mod";
-	resets = <&ahb1_rst 21>;
-};
-
-spi0: spi@1c68000 {
-	compatible = "allwinner,sun8i-h3-spi";
-	reg = <0x01c68000 0x1000>;
-	interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
-	clock-names = "ahb", "mod";
-	dmas = <&dma 23>, <&dma 23>;
-	dma-names = "rx", "tx";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins>;
-	resets = <&ccu RST_BUS_SPI0>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
-- 
git-series 0.9.1
