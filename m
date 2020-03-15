From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 27/36] dt-bindings: display: convert sitronix,st7701 to DT Schema
Date: Sun, 15 Mar 2020 14:44:07 +0100
Message-ID: <20200315134416.16527-28-sam@ravnborg.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Brian Masney <masneyb-1iNe0GrtECGEi8DpZVb4nw@public.gmane.org>,
        Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Guido Gunther <agx-wGvLLbajjwFAfugRpC6u6w@public.gmane.org>, Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>,
        Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>,
        Jerry Han <hanxu5-dyavHbARFqWrZjcNGxgArdPArS5jOdiE2SarAXORi/o@public.gmane.org>,
        Jonathan Bakker <xc-racer2-kt+e9JA1QaI@public.gmane.org>,
        Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
        Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marco Franchi <marco.franchi-3arQi8VN3Tc@public.gmane.org>,
        Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <maxime.ripard@bootl
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200315134416.16527-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The old binding documented that a number of properties is
required only for a specific panel.
The binding supports only one panel so they are now
unconditionally required.

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/sitronix,st7701.txt         | 30 --------
 .../display/panel/sitronix,st7701.yaml        | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
deleted file mode 100644
index ccd17597f1f6..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Sitronix ST7701 based LCD panels
-
-ST7701 designed for small and medium sizes of TFT LCD display, is
-capable of supporting up to 480RGBX864 in resolution. It provides
-several system interfaces like MIPI/RGB/SPI.
-
-Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
-inbuilt ST7701 chip.
-
-Required properties:
-- compatible: must be "sitronix,st7701" and one of
-  * "techstar,ts8550b"
-- reset-gpios: a GPIO phandle for the reset pin
-
-Required properties for techstar,ts8550b:
-- reg: DSI virtual channel used by that screen
-- VCC-supply: analog regulator for MIPI circuit
-- IOVCC-supply: I/O system regulator
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "techstar,ts8550b", "sitronix,st7701";
-	reg = <0>;
-	VCC-supply = <&reg_dldo2>;
-	IOVCC-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
new file mode 100644
index 000000000000..d5811a8f615e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sitronix,st7701.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sitronix ST7701 based LCD panels
+
+maintainers:
+  - Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
+
+description: |
+  ST7701 is designed for small and medium sizes of TFT LCD display, is
+  capable of supporting up to 480RGBX864 in resolution. It provides
+  several system interfaces like MIPI/RGB/SPI.
+
+  Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
+  inbuilt ST7701 chip.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # Techstar TS8550B
+        - techstar,ts8550b
+      - const: sitronix,st7701
+
+  reg: true
+  reset-gpios: true
+  backlight: true
+
+  VCC-supply:
+    description: analog regulator for MIPI circuit
+
+  IOVCC-supply:
+    description: I/O system regulator
+
+required:
+  - compatible
+  - reset-gpios
+  - reg
+  - VCC-supply
+  - IOVCC-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "techstar,ts8550b", "sitronix,st7701";
+            reg = <0>;
+            VCC-supply = <&reg_dldo2>;
+            IOVCC-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.20.1
