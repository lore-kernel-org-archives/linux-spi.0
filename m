From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH 22/28] dt-bindings: i2c: Convert i2c-pxa to json-schema
Date: Tue, 17 Mar 2020 10:39:16 +0100
Message-ID: <20200317093922.20785-23-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
        Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
        Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        devicetree-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317093922.20785-1-lkundrak-NGH9Lh4a5iE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A conversion of the i2c-pxa binding to DT schema format using json-schema.

This also cleans ups some errors in the binding: The compatible string
description suggested that "mmp" in "mrvl,mmp-twsi" is to be substituted
with a processor model, which wouldn't be a right thing to do and indeed
nobody seems to have been doing that. There also was "Recommended
properties" section that included optional as well as mandatory
properties. Missing mandatory properties were added to the example.

Signed-off-by: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-pxa.txt       | 31 --------
 .../devicetree/bindings/i2c/i2c-pxa.yaml      | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml

diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt b/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
deleted file mode 100644
index c30783c0eca03..0000000000000
--- a/Documentation/devicetree/bindings/i2c/i2c-pxa.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-* Marvell MMP I2C controller
-
-Required properties :
-
- - reg : Offset and length of the register set for the device
- - compatible : should be "mrvl,mmp-twsi" where mmp is the name of a
-   compatible processor, e.g. pxa168, pxa910, mmp2, mmp3.
-   For the pxa2xx/pxa3xx, an additional node "mrvl,pxa-i2c" is required
-   as shown in the example below.
-   For the Armada 3700, the compatible should be "marvell,armada-3700-i2c".
-
-Recommended properties :
-
- - interrupts : the interrupt number
- - mrvl,i2c-polling : Disable interrupt of i2c controller. Polling
-   status register of i2c controller instead.
- - mrvl,i2c-fast-mode : Enable fast mode of i2c controller.
-
-Examples:
-	twsi1: i2c@d4011000 {
-		compatible = "mrvl,mmp-twsi";
-		reg = <0xd4011000 0x1000>;
-		interrupts = <7>;
-		mrvl,i2c-fast-mode;
-	};
-	
-	twsi2: i2c@d4025000 {
-		compatible = "mrvl,mmp-twsi";
-		reg = <0xd4025000 0x1000>;
-		interrupts = <58>;
-	};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml b/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
new file mode 100644
index 0000000000000..c04fb81927208
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
@@ -0,0 +1,71 @@
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/i2c-pxa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP I2C controller bindings
+
+maintainers:
+  - devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+  - if:
+      not:
+        required:
+          - mrvl,i2c-polling
+    then:
+        required:
+          - interrupts
+
+properties:
+  compatible:
+    enum:
+      - mrvl,mmp-twsi
+      - mrvl,pxa-i2c
+      - marvell,armada-3700-i2c
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+
+  resets:
+    minItems: 1
+
+  mrvl,i2c-polling:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Disable interrupt of i2c controller. Polling status register of i2c
+      controller instead.
+
+  mrvl,i2c-fast-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable fast mode of i2c controller.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/marvell,mmp2.h>
+    i2c@d4011000 {
+        compatible = "mrvl,mmp-twsi";
+        reg = <0xd4011000 0x1000>;
+        interrupts = <7>;
+        clocks = <&soc_clocks MMP2_CLK_TWSI1>;
+        mrvl,i2c-fast-mode;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
+
+...
-- 
2.25.1
