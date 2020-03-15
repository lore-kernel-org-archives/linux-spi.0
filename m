From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 13/36] dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
Date: Sun, 15 Mar 2020 14:43:53 +0100
Message-ID: <20200315134416.16527-14-sam@ravnborg.org>
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
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200315134416.16527-1-sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../panel/kingdisplay,kd035g6-54nt.txt        | 42 -------------
 .../panel/kingdisplay,kd035g6-54nt.yaml       | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
deleted file mode 100644
index fa9596082e44..000000000000
--- a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
-
-Required properties:
-- compatible: should be "kingdisplay,kd035g6-54nt"
-- power-supply: See panel-common.txt
-- reset-gpios: See panel-common.txt
-
-Optional properties:
-- backlight: see panel-common.txt
-
-The generic bindings for the SPI slaves documented in [1] also apply.
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [2]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/spi/spi-bus.txt
-[2]: Documentation/devicetree/bindings/graph.txt
-
-Example:
-
-&spi {
-	panel@0 {
-		compatible = "kingdisplay,kd035g6-54nt";
-		reg = <0>;
-
-		spi-max-frequency = <3125000>;
-		spi-3wire;
-		spi-cs-high;
-
-		reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
-
-		backlight = <&backlight>;
-		power-supply = <&ldo6>;
-
-		port {
-			panel_input: endpoint {
-				remote-endpoint = <&panel_output>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
new file mode 100644
index 000000000000..31fc63294a9f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/kingdisplay,kd035g6-54nt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: King Display KD035G6-54NT 3.5" (320x240 pixels) 24-bit TFT LCD panel
+
+maintainers:
+  - Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
+
+allOf:
+  - $ref: ../../spi/spi-slave.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: kingdisplay,kd035g6-54nt
+
+  backlight: true
+  port: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - power-supply
+  - reset-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "kingdisplay,kd035g6-54nt";
+            reg = <0>;
+
+            spi-max-frequency = <3125000>;
+            spi-3wire;
+            spi-cs-high;
+
+            reset-gpios = <&gpe 2 GPIO_ACTIVE_LOW>;
+
+            backlight = <&backlight>;
+            power-supply = <&ldo6>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&panel_output>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1
