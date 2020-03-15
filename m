From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 10/36] dt-bindings: display: convert innolux,p097pfg to DT Schema
Date: Sun, 15 Mar 2020 14:43:50 +0100
Message-ID: <20200315134416.16527-11-sam@ravnborg.org>
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
Cc: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/innolux,p097pfg.txt         | 24 --------
 .../display/panel/innolux,p097pfg.yaml        | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
deleted file mode 100644
index d1cab3a8f0fb..000000000000
--- a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
-
-Required properties:
-- compatible: should be "innolux,p097pfg"
-- reg: DSI virtual channel of the peripheral
-- avdd-supply: phandle of the regulator that provides positive voltage
-- avee-supply: phandle of the regulator that provides negative voltage
-- enable-gpios: panel enable gpio
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-
-Example:
-
-	&mipi_dsi {
-		panel@0 {
-			compatible = "innolux,p079zca";
-			reg = <0>;
-			avdd-supply = <...>;
-			avee-supply = <...>;
-			backlight = <&backlight>;
-			enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
new file mode 100644
index 000000000000..5a5f071627fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,p097pfg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux P097PFG 9.7" 1536x2048 TFT LCD panel
+
+maintainers:
+  - Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: innolux,p097pfg
+
+  backlight: true
+  enable-gpios: true
+  reg: true
+
+  avdd-supply:
+    description: The regulator that provides positive voltage
+
+  avee-supply:
+    description: The regulator that provides negative voltage
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - avee-supply
+  - enable-gpios
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
+            compatible = "innolux,p097pfg";
+            reg = <0>;
+            avdd-supply = <&avdd>;
+            avee-supply = <&avee>;
+            backlight = <&backlight>;
+            enable-gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
-- 
2.20.1
