From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 32/36] dt-bindings: display: convert sharp,ls037v7dw01 to DT Schema
Date: Sun, 15 Mar 2020 14:44:12 +0100
Message-ID: <20200315134416.16527-33-sam@ravnborg.org>
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
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/sharp,ls037v7dw01.txt       | 43 ------------
 .../display/panel/sharp,ls037v7dw01.yaml      | 66 +++++++++++++++++++
 2 files changed, 66 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt b/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
deleted file mode 100644
index 0cc8981e9d49..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-SHARP LS037V7DW01 TFT-LCD panel
-===================================
-
-Required properties:
-- compatible: "sharp,ls037v7dw01"
-
-Optional properties:
-- label: a symbolic name for the panel
-- enable-gpios: a GPIO spec for the optional enable pin.
-  This pin is the INI pin as specified in the LS037V7DW01.pdf file.
-- reset-gpios: a GPIO spec for the optional reset pin.
-  This pin is the RESB pin as specified in the LS037V7DW01.pdf file.
-- mode-gpios: a GPIO
-  ordered MO, LR, and UD as specified in the LS037V7DW01.pdf file.
-
-Required nodes:
-- Video port for DPI input
-
-This panel can have zero to five GPIOs to configure to change configuration
-between QVGA and VGA mode and the scan direction. As these pins can be also
-configured with external pulls, all the GPIOs are considered optional with holes
-in the array.
-
-Example
--------
-
-Example when connected to a omap2+ based device:
-
-lcd0: display {
-	compatible = "sharp,ls037v7dw01";
-	power-supply = <&lcd_3v3>;
-	enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */
-	reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB */
-	mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
-		      &gpio1 2 GPIO_ACTIVE_HIGH		/* gpio2, lcd LR */
-		      &gpio1 3 GPIO_ACTIVE_HIGH>;	/* gpio3, lcd UD */
-
-	port {
-		lcd_in: endpoint {
-			remote-endpoint = <&dpi_out>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml
new file mode 100644
index 000000000000..56bd510ae398
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,ls037v7dw01.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,ls037v7dw01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SHARP LS037V7DW01 TFT-LCD panel
+
+description: |
+  This panel can have zero to five GPIOs to configure to change configuration
+  between QVGA and VGA mode and the scan direction. As these pins can be also
+  configured with external pulls, all the GPIOs are considered optional with holes
+  in the array.
+
+maintainers:
+  - Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sharp,ls037v7dw01
+
+  label: true
+  enable-gpios: true
+  reset-gpios: true
+  port: true
+  power-supply: true
+
+  mode-gpios:
+    description: |
+      GPIO ordered MO, LR, and UD as specified in LS037V7DW01.pdf
+      This panel can have zero to five GPIOs to configure to
+      change configuration between QVGA and VGA mode and the
+      scan direction. As these pins can be also configured
+      with external pulls, all the GPIOs are considered
+      optional with holes in the array.
+
+required:
+  - compatible
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    lcd0: display {
+        compatible = "sharp,ls037v7dw01";
+        power-supply = <&lcd_3v3>;
+        enable-gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;    /* gpio152, lcd INI */
+        reset-gpios = <&gpio5 27 GPIO_ACTIVE_HIGH>;     /* gpio155, lcd RESB */
+        mode-gpios = <&gpio5 26 GPIO_ACTIVE_HIGH        /* gpio154, lcd MO */
+                      &gpio1 2 GPIO_ACTIVE_HIGH         /* gpio2, lcd LR */
+                      &gpio1 3 GPIO_ACTIVE_HIGH>;       /* gpio3, lcd UD */
+
+        port {
+            lcd_in: endpoint {
+                remote-endpoint = <&dpi_out>;
+            };
+        };
+    };
+
+...
-- 
2.20.1
