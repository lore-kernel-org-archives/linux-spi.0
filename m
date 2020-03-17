From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 24/28] dt-bindings: media: Convert marvell,mmp2-ccic to json-schema
Date: Tue, 17 Mar 2020 10:39:18 +0100
Message-ID: <20200317093922.20785-25-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kerne
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert the marvell,mmp2-ccic binding to DT schema format using
json-schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/media/marvell,mmp2-ccic.txt      |  50 ---------
 .../bindings/media/marvell,mmp2-ccic.yaml     | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
 create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml

diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
deleted file mode 100644
index 7ec2c8c8a3b98..0000000000000
--- a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Marvell MMP2 camera host interface
-
-Required properties:
- - compatible: Should be "marvell,mmp2-ccic".
- - reg: Register base and size.
- - interrupts: The interrupt number.
- - #clock-cells: Must be 0.
-
-Optional properties:
- - clocks: Reference to the input clock as specified by
-           Documentation/devicetree/bindings/clock/clock-bindings.txt.
- - clock-names: Names of the clocks used; "axi" for the AXI bus interface,
-                "func" for the peripheral clock and "phy" for the parallel
-                video bus interface.
- - clock-output-names: Optional clock source for sensors. Shall be "mclk".
-
-Required subnodes:
- - port: The parallel bus interface port with a single endpoint linked to
-         the sensor's endpoint as described in
-         Documentation/devicetree/bindings/media/video-interfaces.txt.
-
-Required endpoint properties:
- - bus-type: data bus type, <5> or <6> for Parallel or Bt.656 respectively
- - pclk-sample: pixel clock polarity
- - hsync-active: horizontal synchronization polarity (only required for
-   parallel bus)
- - vsync-active: vertical synchronization polarity (only required for
-   parallel bus)
-
-Example:
-
-	camera0: camera@d420a000 {
-		compatible = "marvell,mmp2-ccic";
-		reg = <0xd420a000 0x800>;
-		interrupts = <42>;
-		clocks = <&soc_clocks MMP2_CLK_CCIC0>;
-		clock-names = "axi";
-		#clock-cells = <0>;
-		clock-output-names = "mclk";
-
-		port {
-			camera0_0: endpoint {
-				remote-endpoint = <&ov7670_0>;
-                                bus-type = <5>;      /* Parallel */
-                                hsync-active = <1>;  /* Active high */
-                                vsync-active = <1>;  /* Active high */
-                                pclk-sample = <0>;   /* Falling */
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
new file mode 100644
index 0000000000000..890a3f9d0302f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+# Copyright 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/marvell,mmp2-ccic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP2 camera host interface bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  $nodename:
+    pattern: '^camera@[a-f0-9]+$'
+
+  compatible:
+    const: marvell,mmp2-ccic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  port:
+    type: object
+    additionalProperties: false
+
+    properties:
+       endpoint:
+         type: object
+         additionalProperties: false
+
+         # Properties described in
+         # Documentation/devicetree/bindings/media/video-interfaces.txt
+         properties:
+           remote-endpoint: true
+           hsync-active: true
+           vsync-active: true
+           pclk-sample: true
+           bus-type: true
+
+         required:
+           - remote-endpoint
+
+    required:
+      - endpoint
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+    items:
+      - description: AXI bus interface clock
+      - description: Peripheral clock
+      - description: Parallel video bus interface clock
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      - const: axi
+      - const: func
+      - const: phy
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    const: mclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - port
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2.h>
+
+    camera@d420a000 {
+      compatible = "marvell,mmp2-ccic";
+      reg = <0xd420a000 0x800>;
+      interrupts = <42>;
+      clocks = <&soc_clocks MMP2_CLK_CCIC0>;
+      clock-names = "axi";
+      #clock-cells = <0>;
+      clock-output-names = "mclk";
+
+      port {
+        camera0_0: endpoint {
+          remote-endpoint = <&ov7670_0>;
+          bus-type = <5>;      /* Parallel */
+          hsync-active = <1>;  /* Active high */
+          vsync-active = <1>;  /* Active high */
+          pclk-sample = <0>;   /* Falling */
+        };
+      };
+    };
+
+...
-- 
2.25.1
