From: Rob Herring <robh@kernel.org>
Subject: [PATCH] spi: dt-bindings: Convert spi-gpio binding to json-schema
Date: Tue, 21 May 2019 16:23:25 -0500
Message-ID: <20190521212325.16639-2-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert the spi-gpio binding to DT schema format.

Cc: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-gpio.txt      | 43 -----------
 .../devicetree/bindings/spi/spi-gpio.yaml     | 72 +++++++++++++++++++
 2 files changed, 72 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
deleted file mode 100644
index 52db562f17a4..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-gpio.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-SPI-GPIO devicetree bindings
-
-This represents a group of 3-n GPIO lines used for bit-banged SPI on dedicated
-GPIO lines.
-
-Required properties:
-
- - compatible: should be set to "spi-gpio"
- - #address-cells: should be set to <0x1>
- - ranges
- - sck-gpios: GPIO spec for the SCK line to use
- - miso-gpios: GPIO spec for the MISO line to use
- - mosi-gpios: GPIO spec for the MOSI line to use
- - cs-gpios: GPIOs to use for chipselect lines.
-             Not needed if num-chipselects = <0>.
- - num-chipselects: Number of chipselect lines. Should be <0> if a single device
-                    with no chip select is connected.
-
-Deprecated bindings:
-
-These legacy GPIO line bindings can alternatively be used to define the
-GPIO lines used, they should not be used in new device trees.
-
- - gpio-sck: GPIO spec for the SCK line to use
- - gpio-miso: GPIO spec for the MISO line to use
- - gpio-mosi: GPIO spec for the MOSI line to use
-
-Example:
-
-	spi {
-		compatible = "spi-gpio";
-		#address-cells = <0x1>;
-		ranges;
-
-		sck-gpios = <&gpio 95 0>;
-		miso-gpios = <&gpio 98 0>;
-		mosi-gpios = <&gpio 97 0>;
-		cs-gpios = <&gpio 125 0>;
-		num-chipselects = <1>;
-
-		/* clients */
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.yaml b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
new file mode 100644
index 000000000000..55c4f1705f07
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SPI-GPIO devicetree bindings
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+description:
+  This represents a group of 3-n GPIO lines used for bit-banged SPI on
+  dedicated GPIO lines.
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: spi-gpio
+
+  sck-gpios:
+    description: GPIO spec for the SCK line to use
+    maxItems: 1
+
+  miso-gpios:
+    description: GPIO spec for the MISO line to use
+    maxItems: 1
+
+  mosi-gpios:
+    description: GPIO spec for the MOSI line to use
+    maxItems: 1
+
+  cs-gpios:
+    description: GPIOs to use for chipselect lines.
+      Not needed if num-chipselects = <0>.
+    minItems: 1
+    maxItems: 1024
+
+  num-chipselects:
+    description: Number of chipselect lines. Should be <0> if a single device
+      with no chip select is connected.
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+
+  # Deprecated properties
+  gpio-sck: false
+  gpio-miso: false
+  gpio-mosi: false
+
+required:
+  - compatible
+  - num-chipselects
+  - sck-gpios
+
+examples:
+  - |
+    spi {
+      compatible = "spi-gpio";
+      #address-cells = <0x1>;
+      #size-cells = <0x0>;
+
+      sck-gpios = <&gpio 95 0>;
+      miso-gpios = <&gpio 98 0>;
+      mosi-gpios = <&gpio 97 0>;
+      cs-gpios = <&gpio 125 0>;
+      num-chipselects = <1>;
+
+      /* clients */
+    };
+
+...
-- 
2.20.1
