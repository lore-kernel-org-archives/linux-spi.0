From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 36/36] dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema
Date: Sun, 15 Mar 2020 14:44:16 +0100
Message-ID: <20200315134416.16527-37-sam@ravnborg.org>
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
Cc: Stefan Mavrodiev <stefan-kyXcfZUBQGPQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/olimex,lcd-olinuxino.txt    | 42 -----------
 .../display/panel/olimex,lcd-olinuxino.yaml   | 70 +++++++++++++++++++
 2 files changed, 70 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
deleted file mode 100644
index a89f9c830a85..000000000000
--- a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
-
-This device can be used as bridge between a host controller and LCD panels.
-Currently supported LCDs are:
-  - LCD-OLinuXino-4.3TS
-  - LCD-OLinuXino-5
-  - LCD-OLinuXino-7
-  - LCD-OLinuXino-10
-
-The panel itself contains:
-  - AT24C16C EEPROM holding panel identification and timing requirements
-  - AR1021 resistive touch screen controller (optional)
-  - FT5x6 capacitive touch screnn controller (optional)
-  - GT911/GT928 capacitive touch screen controller (optional)
-
-The above chips share same I2C bus. The EEPROM is factory preprogrammed with
-device information (id, serial, etc.) and timing requirements.
-
-Touchscreen bingings can be found in these files:
-  - input/touchscreen/goodix.txt
-  - input/touchscreen/edt-ft5x06.txt
-  - input/touchscreen/ar1021.txt
-
-Required properties:
-  - compatible: should be "olimex,lcd-olinuxino"
-  - reg: address of the configuration EEPROM, should be <0x50>
-  - power-supply: phandle of the regulator that provides the supply voltage
-
-Optional properties:
-  - enable-gpios: GPIO pin to enable or disable the panel
-  - backlight: phandle of the backlight device attacked to the panel
-
-Example:
-&i2c2 {
-	panel@50 {
-		compatible = "olimex,lcd-olinuxino";
-		reg = <0x50>;
-		power-supply = <&reg_vcc5v0>;
-		enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
-		backlight = <&backlight>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
new file mode 100644
index 000000000000..22d664abd552
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/olimex,lcd-olinuxino.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
+
+maintainers:
+  - Stefan Mavrodiev <stefan-kyXcfZUBQGPQT0dZR+AlfA@public.gmane.org>
+
+description: |
+  This device can be used as bridge between a host controller and LCD panels.
+  Currently supported LCDs are:
+    - LCD-OLinuXino-4.3TS
+    - LCD-OLinuXino-5
+    - LCD-OLinuXino-7
+    - LCD-OLinuXino-10
+
+  The panel itself contains:
+    - AT24C16C EEPROM holding panel identification and timing requirements
+    - AR1021 resistive touch screen controller (optional)
+    - FT5x6 capacitive touch screnn controller (optional)
+    - GT911/GT928 capacitive touch screen controller (optional)
+
+  The above chips share same I2C bus. The EEPROM is factory preprogrammed with
+  device information (id, serial, etc.) and timing requirements.
+
+  Touchscreen bingings can be found in these files:
+    - input/touchscreen/goodix.yaml
+    - input/touchscreen/edt-ft5x06.txt
+    - input/touchscreen/ar1021.txt
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: olimex,lcd-olinuxino
+
+  backlight: true
+  enable-gpios: true
+  power-supply: true
+  reg: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c2 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@50 {
+            compatible = "olimex,lcd-olinuxino";
+            reg = <0x50>;
+            power-supply = <&reg_vcc5v0>;
+            enable-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;
+            backlight = <&backlight>;
+        };
+    };
+
+...
-- 
2.20.1
