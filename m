From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 07/36] dt-bindings: display: convert ilitek,ili9881c to DT Schema
Date: Sun, 15 Mar 2020 14:43:47 +0100
Message-ID: <20200315134416.16527-8-sam@ravnborg.org>
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
Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/ilitek,ili9881c.txt         | 20 --------
 .../display/panel/ilitek,ili9881c.yaml        | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
deleted file mode 100644
index 4a041acb4e18..000000000000
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Ilitek ILI9881c based MIPI-DSI panels
-
-Required properties:
-  - compatible: must be "ilitek,ili9881c" and one of:
-    * "bananapi,lhr050h41"
-  - reg: DSI virtual channel used by that screen
-  - power-supply: phandle to the power regulator
-  - reset-gpios: a GPIO phandle for the reset pin
-
-Optional properties:
-  - backlight: phandle to the backlight used
-
-Example:
-panel@0 {
-	compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
-	reg = <0>;
-	power-supply = <&reg_display>;
-	reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
-	backlight = <&pwm_bl>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
new file mode 100644
index 000000000000..a39332276bab
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9881c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9881c based MIPI-DSI panels
+
+maintainers:
+  - Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - bananapi,lhr050h41
+
+      - const: ilitek,ili9881c
+
+  backlight: true
+  power-supply: true
+  reg: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - power-supply
+  - reg
+  - reset-gpios
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
+            compatible = "bananapi,lhr050h41", "ilitek,ili9881c";
+            reg = <0>;
+            power-supply = <&reg_display>;
+            reset-gpios = <&r_pio 0 5 GPIO_ACTIVE_LOW>; /* PL05 */
+            backlight = <&pwm_bl>;
+        };
+    };
+
+...
-- 
2.20.1
