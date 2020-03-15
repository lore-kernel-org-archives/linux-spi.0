From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 23/36] dt-bindings: display: convert samsung,s6e8aa0 to DT Schema
Date: Sun, 15 Mar 2020 14:44:03 +0100
Message-ID: <20200315134416.16527-24-sam@ravnborg.org>
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

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/samsung,s6e8aa0.txt         | 56 -----------
 .../display/panel/samsung,s6e8aa0.yaml        | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt
deleted file mode 100644
index 9e766c5f86da..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Samsung S6E8AA0 AMOLED LCD 5.3 inch panel
-
-Required properties:
-  - compatible: "samsung,s6e8aa0"
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd3-supply: core voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin
-  - display-timings: timings for the connected panel as described by [1]
-
-Optional properties:
-  - power-on-delay: delay after turning regulators on [ms]
-  - reset-delay: delay after reset sequence [ms]
-  - init-delay: delay after initialization sequence [ms]
-  - panel-width-mm: physical panel width [mm]
-  - panel-height-mm: physical panel height [mm]
-  - flip-horizontal: boolean to flip image horizontally
-  - flip-vertical: boolean to flip image vertically
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [2]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
-[2]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-	panel {
-		compatible = "samsung,s6e8aa0";
-		reg = <0>;
-		vdd3-supply = <&vcclcd_reg>;
-		vci-supply = <&vlcd_reg>;
-		reset-gpios = <&gpy4 5 0>;
-		power-on-delay= <50>;
-		reset-delay = <100>;
-		init-delay = <100>;
-		panel-width-mm = <58>;
-		panel-height-mm = <103>;
-		flip-horizontal;
-		flip-vertical;
-
-		display-timings {
-			timing0: timing-0 {
-				clock-frequency = <57153600>;
-				hactive = <720>;
-				vactive = <1280>;
-				hfront-porch = <5>;
-				hback-porch = <5>;
-				hsync-len = <5>;
-				vfront-porch = <13>;
-				vback-porch = <1>;
-				vsync-len = <2>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
new file mode 100644
index 000000000000..67c99b0492e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,s6e8aa0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S6E8AA0 AMOLED LCD 5.3 inch panel
+
+maintainers:
+  - Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s6e8aa0
+
+  reg: true
+  reset-gpios: true
+  display-timings: true
+
+  vdd3-supply:
+    description: core voltage supply
+
+  vci-supply:
+    description: voltage supply for analog circuits
+ 
+  power-on-delay:
+    description: delay after turning regulators on [ms]
+
+  reset-delay:
+    description: delay after reset sequence [ms]
+
+  init-delay:
+    description: delay after initialization sequence [ms]
+
+  panel-width-mm:
+    description: physical panel width [mm]
+
+  panel-height-mm:
+    description: physical panel height [mm]
+
+  flip-horizontal:
+    description: boolean to flip image horizontally
+
+  flip-vertical:
+    description: boolean to flip image vertically
+
+required:
+  - compatible
+  - reg
+  - vdd3-supply 
+  - vci-supply
+  - reset-gpios
+  - display-timings
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel {
+            compatible = "samsung,s6e8aa0";
+            reg = <0>;
+            vdd3-supply = <&vcclcd_reg>;
+            vci-supply = <&vlcd_reg>;
+            reset-gpios = <&gpy4 5 0>;
+            power-on-delay= <50>;
+            reset-delay = <100>;
+            init-delay = <100>;
+            panel-width-mm = <58>;
+            panel-height-mm = <103>;
+            flip-horizontal;
+            flip-vertical;
+
+            display-timings {
+                timing0: timing-0 {
+                    clock-frequency = <57153600>;
+                    hactive = <720>;
+                    vactive = <1280>;
+                    hfront-porch = <5>;
+                    hback-porch = <5>;
+                    hsync-len = <5>;
+                    vfront-porch = <13>;
+                    vback-porch = <1>;
+                    vsync-len = <2>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1
