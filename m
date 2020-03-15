From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 06/36] dt-bindings: display: convert ilitek,ili9322 to DT Schema
Date: Sun, 15 Mar 2020 14:43:46 +0100
Message-ID: <20200315134416.16527-7-sam@ravnborg.org>
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

The .txt binding explains:

"
    The following optional properties only apply to
    RGB and YUV input modes and
    can be omitted for BT.656 input modes:
"

This constraint is not implmented in the DT Schema.

The original binding from the .txt file referenced
properties that is included in panel-timing.yaml.
These properties are kept here as we want as close to a 1:1
conversion as we can. If the properties should be dropped
from the binding then this is a follow-up patch.

The properties in question are:
  - pixelclk-active
  - de-active
  - hsync-active
  - vsync-active

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../bindings/display/panel/ilitek,ili9322.txt | 49 ----------
 .../display/panel/ilitek,ili9322.yaml         | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9322.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.txt b/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.txt
deleted file mode 100644
index 3d5ce6ad6ec7..000000000000
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-Ilitek ILI9322 TFT panel driver with SPI control bus
-
-This is a driver for 320x240 TFT panels, accepting a variety of input
-streams that get adapted and scaled to the panel. The panel output has
-960 TFT source driver pins and 240 TFT gate driver pins, VCOM, VCOML and
-VCOMH outputs.
-
-Required properties:
-  - compatible: "dlink,dir-685-panel", "ilitek,ili9322"
-    (full system-specific compatible is always required to look up configuration)
-  - reg: address of the panel on the SPI bus
-
-Optional properties:
-  - vcc-supply: core voltage supply, see regulator/regulator.txt
-  - iovcc-supply: voltage supply for the interface input/output signals,
-    see regulator/regulator.txt
-  - vci-supply: voltage supply for analog parts, see regulator/regulator.txt
-  - reset-gpios: a GPIO spec for the reset pin, see gpio/gpio.txt
-
-  The following optional properties only apply to RGB and YUV input modes and
-  can be omitted for BT.656 input modes:
-
-  - pixelclk-active: see display/panel/display-timing.txt
-  - de-active: see display/panel/display-timing.txt
-  - hsync-active: see display/panel/display-timing.txt
-  - vsync-active: see display/panel/display-timing.txt
-
-The panel must obey the rules for a SPI slave device as specified in
-spi/spi-bus.txt
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in
-media/video-interfaces.txt. This node should describe panel's video bus.
-
-Example:
-
-panel: display@0 {
-	compatible = "dlink,dir-685-panel", "ilitek,ili9322";
-	reg = <0>;
-	vcc-supply = <&vdisp>;
-	iovcc-supply = <&vdisp>;
-	vci-supply = <&vdisp>;
-
-	port {
-		panel_in: endpoint {
-			remote-endpoint = <&display_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
new file mode 100644
index 000000000000..9f165f12fc32
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9322.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9322 TFT panel driver with SPI control bus
+
+maintainers:
+  - Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+
+description: |
+  This is a driver for 320x240 TFT panels, accepting a variety of input
+  streams that get adapted and scaled to the panel. The panel output has
+  960 TFT source driver pins and 240 TFT gate driver pins, VCOM, VCOML and
+  VCOMH outputs.
+
+  The panel must obey the rules for a SPI slave device as specified in
+  spi/spi-bus.txt
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: ../../spi/spi-slave.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - dlink,dir-685-panel
+      
+      - const: ilitek,ili9322
+
+  reset-gpios: true
+  port: true
+
+  vcc-supply:
+    description: Core voltage supply
+
+  iovcc-supply:
+    description: Voltage supply for the interface input/output signals
+
+  vci-supply:
+    description: Voltage supply for analog parts
+
+  pixelclk-active:
+    description: |
+      Optional property, applies only to RGB and YUV input modes and
+      can be omitted for BT.656 input modes
+
+  de-active:
+    description: |
+      Optional property, applies only to RGB and YUV input modes and
+      can be omitted for BT.656 input modes
+
+  hsync-active:
+    description: |
+      Optional property, applies only to RGB and YUV input modes and
+      can be omitted for BT.656 input modes
+
+  vsync-active:
+    description: |
+      Optional property, applies only to RGB and YUV input modes and
+      can be omitted for BT.656 input modes
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: display@0 {
+            compatible = "dlink,dir-685-panel", "ilitek,ili9322";
+            reg = <0>;
+            vcc-supply = <&vdisp>;
+            iovcc-supply = <&vdisp>;
+            vci-supply = <&vdisp>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&display_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1
