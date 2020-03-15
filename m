From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 20/36] dt-bindings: display: convert samsung AMOLED to DT Schema
Date: Sun, 15 Mar 2020 14:44:00 +0100
Message-ID: <20200315134416.16527-21-sam@ravnborg.org>
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

For samsung there was two AMOLED panels with the same
description.
Collect them in one binding file.

Signed-off-by: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Cc: Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../panel/samsung,amoled-mipi-dsi.yaml        | 65 +++++++++++++++++++
 .../display/panel/samsung,s6e3ha2.txt         | 31 ---------
 .../display/panel/samsung,s6e63j0x03.txt      | 24 -------
 3 files changed, 65 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
 delete mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
new file mode 100644
index 000000000000..96bdde9298e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,amoled-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMOLED MIPI-DSI panels
+
+maintainers:
+  - Hoegeun Kwon <hoegeun.kwon-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    enum:
+        # Samsung S6E63J0X03 1.63" 320x320 AMOLED panel
+      - samsung,s6e63j0x03
+        # Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
+      - samsung,s6e3ha2
+        # Samsung S6E3HF2 5.65" 1600x2560 AMOLED panel
+      - samsung,s6e3hf2
+
+  reg: true
+  reset-gpios: true
+  enable-gpios: true
+  te-gpios: true
+
+  vdd3-supply:
+    description: I/O voltage supply
+
+  vci-supply:
+    description: voltage supply for analog circuits
+
+required:
+  - compatible
+  - reg
+  - vdd3-supply
+  - vci-supply
+  - reset-gpios
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
+            compatible = "samsung,s6e3ha2";
+            reg = <0>;
+            vdd3-supply = <&ldo27_reg>;
+            vci-supply = <&ldo28_reg>;
+            reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
+            te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
deleted file mode 100644
index 4acea25c244b..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e3ha2.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Samsung S6E3HA2 5.7" 1440x2560 AMOLED panel
-Samsung S6E3HF2 5.65" 1600x2560 AMOLED panel
-
-Required properties:
-  - compatible: should be one of:
-    "samsung,s6e3ha2",
-    "samsung,s6e3hf2".
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd3-supply: I/O voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin (active low)
-  - enable-gpios: a GPIO spec for the panel enable pin (active high)
-
-Optional properties:
-  - te-gpios: a GPIO spec for the tearing effect synchronization signal
-    gpio pin (active high)
-
-Example:
-&dsi {
-	...
-
-	panel@0 {
-		compatible = "samsung,s6e3ha2";
-		reg = <0>;
-		vdd3-supply = <&ldo27_reg>;
-		vci-supply = <&ldo28_reg>;
-		reset-gpios = <&gpg0 0 GPIO_ACTIVE_LOW>;
-		enable-gpios = <&gpf1 5 GPIO_ACTIVE_HIGH>;
-		te-gpios = <&gpf1 3 GPIO_ACTIVE_HIGH>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt b/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
deleted file mode 100644
index 3f1a8392af7f..000000000000
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e63j0x03.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Samsung S6E63J0X03 1.63" 320x320 AMOLED panel (interface: MIPI-DSI command mode)
-
-Required properties:
-  - compatible: "samsung,s6e63j0x03"
-  - reg: the virtual channel number of a DSI peripheral
-  - vdd3-supply: I/O voltage supply
-  - vci-supply: voltage supply for analog circuits
-  - reset-gpios: a GPIO spec for the reset pin (active low)
-  - te-gpios: a GPIO spec for the tearing effect synchronization signal
-    gpio pin (active high)
-
-Example:
-&dsi {
-	...
-
-	panel@0 {
-		compatible = "samsung,s6e63j0x03";
-		reg = <0>;
-		vdd3-supply = <&ldo16_reg>;
-		vci-supply = <&ldo20_reg>;
-		reset-gpios = <&gpe0 1 GPIO_ACTIVE_LOW>;
-		te-gpios = <&gpx0 6 GPIO_ACTIVE_HIGH>;
-	};
-};
-- 
2.20.1
