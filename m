From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 33/36] dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
Date: Sun, 15 Mar 2020 14:44:13 +0100
Message-ID: <20200315134416.16527-34-sam@ravnborg.org>
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
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/sharp,lq150x1lg11.txt       | 36 ------------
 .../display/panel/sharp,lq150x1lg11.yaml      | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt b/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
deleted file mode 100644
index 0f57c3143506..000000000000
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Sharp 15" LQ150X1LG11 XGA TFT LCD panel
-
-Required properties:
-- compatible: should be "sharp,lq150x1lg11"
-- power-supply: regulator to provide the VCC supply voltage (3.3 volts)
-
-Optional properties:
-- backlight: phandle of the backlight device
-- rlud-gpios: a single GPIO for the RL/UD (rotate 180 degrees) pin.
-- sellvds-gpios: a single GPIO for the SELLVDS pin.
-
-If rlud-gpios and/or sellvds-gpios are not specified, the RL/UD and/or SELLVDS
-pins are assumed to be handled appropriately by the hardware.
-
-Example:
-
-	backlight: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 100000>;                      /* VBR */
-
-		brightness-levels = <0 20 40 60 80 100>;
-		default-brightness-level = <2>;
-
-		power-supply = <&vdd_12v_reg>;               /* VDD */
-		enable-gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;  /* XSTABY */
-	};
-
-	panel {
-		compatible = "sharp,lq150x1lg11";
-
-		power-supply = <&vcc_3v3_reg>;               /* VCC */
-
-		backlight = <&backlight>;
-		rlud-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;    /* RL/UD */
-		sellvds-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>; /* SELLVDS */
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml
new file mode 100644
index 000000000000..92f2d12f4f4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq150x1lg11.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/sharp,lq150x1lg11.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp 15" LQ150X1LG11 XGA TFT LCD panel
+
+maintainers:
+  - Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: sharp,lq150x1lg11
+
+  power-supply: true
+  backlight: true
+
+  rlud-gpios:
+    maxItems: 1
+    description: |
+      GPIO for the RL/UD (rotate 180 degrees) pin.
+      If rlud-gpios and/or sellvds-gpios are not specified,
+      the RL/UD and/or SELLVDS pins are assumed to be handled
+      appropriately by the hardware.
+
+  sellvds-gpios:
+    maxItems: 1
+    description: |
+      GPIO for the SELLVDS pin.
+      If rlud-gpios and/or sellvds-gpios are not specified,
+      the RL/UD and/or SELLVDS pins are assumed to be handled
+      appropriately by the hardware.
+
+required:
+  - compatible
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    panel {
+        compatible = "sharp,lq150x1lg11";
+
+        power-supply = <&vcc_3v3_reg>;               /* VCC */
+
+        backlight = <&backlight>;
+        rlud-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;    /* RL/UD */
+        sellvds-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>; /* SELLVDS */
+    };
+
+...
-- 
2.20.1
