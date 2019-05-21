From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sun4i: Add YAML schemas" to the spi tree
Date: Tue, 21 May 2019 21:33:09 +0100 (BST)
Message-ID: <20190521203309.34FE71126D16@debutante.sirena.org.uk>
References: <b83d0e208072a4f7d017650bc10de8cbe7558a99.1558363790.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b83d0e208072a4f7d017650bc10de8cbe7558a99.1558363790.git-series.maxime.ripard@bootlin.com>
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

The patch

   spi: sun4i: Add YAML schemas

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3133f5c24305c31ef2805a7eb05fc18a664836d3 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Mon, 20 May 2019 16:50:34 +0200
Subject: [PATCH] spi: sun4i: Add YAML schemas

Switch the DT binding to a YAML schema to enable the DT validation.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml | 86 +++++++++++++++++++
 .../devicetree/bindings/spi/spi-sun4i.txt     | 23 -----
 2 files changed, 86 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
new file mode 100644
index 000000000000..c374fd4923a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/allwinner,sun4i-a10-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 SPI Controller Device Tree Bindings
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
+    const: allwinner,sun4i-a10-spi
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
+    spi1: spi@1c06000 {
+        compatible = "allwinner,sun4i-a10-spi";
+        reg = <0x01c06000 0x1000>;
+        interrupts = <11>;
+        clocks = <&ahb_gates 21>, <&spi1_clk>;
+        clock-names = "ahb", "mod";
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/spi/spi-sun4i.txt b/Documentation/devicetree/bindings/spi/spi-sun4i.txt
deleted file mode 100644
index c75d604a8290..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sun4i.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Allwinner A10 SPI controller
-
-Required properties:
-- compatible: Should be "allwinner,sun4-a10-spi".
-- reg: Should contain register location and length.
-- interrupts: Should contain interrupt.
-- clocks: phandle to the clocks feeding the SPI controller. Two are
-          needed:
-  - "ahb": the gated AHB parent clock
-  - "mod": the parent module clock
-- clock-names: Must contain the clock names described just above
-
-Example:
-
-spi1: spi@1c06000 {
-	compatible = "allwinner,sun4i-a10-spi";
-	reg = <0x01c06000 0x1000>;
-	interrupts = <11>;
-	clocks = <&ahb_gates 21>, <&spi1_clk>;
-	clock-names = "ahb", "mod";
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
-- 
2.20.1
