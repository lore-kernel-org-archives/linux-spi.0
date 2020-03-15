From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 22/36] dt-bindings: display: convert samsung,ld9040 to DT Schema
Date: Sun, 15 Mar 2020 14:44:02 +0100
Message-ID: <20200315134416.16527-23-sam@ravnborg.org>
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
Cc: Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../bindings/display/panel/samsung,ld9040.txt |  66 ------------
 .../display/panel/samsung,ld9040.yaml         | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 66 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
deleted file mode 100644
index 354d4d1df4ff..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
-
-Required properties:
-  - compatible: "samsung,ld9040"
-  - reg: address of the panel on SPI bus
-  - vdd3-supply: core voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin
-  - display-timings: timings for the connected panel according to [1]
-
-The panel must obey rules for SPI slave device specified in document [2].
-
-Optional properties:
-  - power-on-delay: delay after turning regulators on [ms]
-  - reset-delay: delay after reset sequence [ms]
-  - panel-width-mm: physical panel width [mm]
-  - panel-height-mm: physical panel height [mm]
-
-The device node can contain one 'port' child node with one child
-'endpoint' node, according to the bindings defined in [3]. This
-node should describe panel's video bus.
-
-[1]: Documentation/devicetree/bindings/display/panel/display-timing.txt
-[2]: Documentation/devicetree/bindings/spi/spi-bus.txt
-[3]: Documentation/devicetree/bindings/media/video-interfaces.txt
-
-Example:
-
-	lcd@0 {
-		compatible = "samsung,ld9040";
-		reg = <0>;
-		vdd3-supply = <&ldo7_reg>;
-		vci-supply = <&ldo17_reg>;
-		reset-gpios = <&gpy4 5 0>;
-		spi-max-frequency = <1200000>;
-		spi-cpol;
-		spi-cpha;
-		power-on-delay = <10>;
-		reset-delay = <10>;
-		panel-width-mm = <90>;
-		panel-height-mm = <154>;
-
-		display-timings {
-			timing {
-				clock-frequency = <23492370>;
-				hactive = <480>;
-				vactive = <800>;
-				hback-porch = <16>;
-				hfront-porch = <16>;
-				vback-porch = <2>;
-				vfront-porch = <28>;
-				hsync-len = <2>;
-				vsync-len = <1>;
-				hsync-active = <0>;
-				vsync-active = <0>;
-				de-active = <0>;
-				pixelclk-active = <0>;
-			};
-		};
-
-		port {
-			lcd_ep: endpoint {
-				remote-endpoint = <&fimd_dpi_ep>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
new file mode 100644
index 000000000000..b6e7e87411e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,ld9040.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung LD9040 AMOLED LCD parallel RGB panel with SPI control bus
+
+maintainers:
+  - Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+
+allOf:
+  - $ref: ../../spi/spi-slave.yaml#
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,ld9040
+
+  display-timings: true
+  port: true
+  reg: true
+  reset-gpios: true
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
+  panel-width-mm:
+    description: physical panel width [mm]
+
+  panel-height-mm:
+    description: physical panel height [mm]
+
+required:
+  - compatible
+  - reg
+  - vdd3-supply
+  - vci-supply
+  - reset-gpios
+  - display-timings
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        lcd@0 {
+            compatible = "samsung,ld9040";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            reg = <0>;
+            vdd3-supply = <&ldo7_reg>;
+            vci-supply = <&ldo17_reg>;
+            reset-gpios = <&gpy4 5 0>;
+            spi-max-frequency = <1200000>;
+            spi-cpol;
+            spi-cpha;
+            power-on-delay = <10>;
+            reset-delay = <10>;
+            panel-width-mm = <90>;
+            panel-height-mm = <154>;
+
+            display-timings {
+                timing {
+                    clock-frequency = <23492370>;
+                    hactive = <480>;
+                    vactive = <800>;
+                    hback-porch = <16>;
+                    hfront-porch = <16>;
+                    vback-porch = <2>;
+                    vfront-porch = <28>;
+                    hsync-len = <2>;
+                    vsync-len = <1>;
+                    hsync-active = <0>;
+                    vsync-active = <0>;
+                    de-active = <0>;
+                    pixelclk-active = <0>;
+                };
+            };
+
+            port {
+                lcd_ep: endpoint {
+                    remote-endpoint = <&fimd_dpi_ep>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1
