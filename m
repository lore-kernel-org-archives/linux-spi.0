From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH v1 04/36] dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
Date: Sun, 15 Mar 2020 14:43:44 +0100
Message-ID: <20200315134416.16527-5-sam@ravnborg.org>
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
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
---
 .../display/panel/arm,versatile-tft-panel.txt | 31 -----------
 .../panel/arm,versatile-tft-panel.yaml        | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
deleted file mode 100644
index 0601a9e34703..000000000000
--- a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-ARM Versatile TFT Panels
-
-These panels are connected to the daughterboards found on the
-ARM Versatile reference designs.
-
-This device node must appear as a child to a "syscon"-compatible
-node.
-
-Required properties:
-- compatible: should be "arm,versatile-tft-panel"
-
-Required subnodes:
-- port: see display/panel/panel-common.yaml, graph.txt
-
-
-Example:
-
-sysreg@0 {
-	compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
-	reg = <0x00000 0x1000>;
-
-	panel: display@0 {
-		compatible = "arm,versatile-tft-panel";
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&foo>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
new file mode 100644
index 000000000000..8ad7305887b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/arm,versatile-tft-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Versatile TFT Panels
+
+maintainers:
+  - Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+
+description: |
+  These panels are connected to the daughterboards found on the
+  ARM Versatile reference designs.
+
+  This device node must appear as a child to a "syscon"-compatible
+  node.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: arm,versatile-tft-panel
+
+  port: true
+
+required:
+  - compatible
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    sysreg {
+        compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
+        reg = <0x00000 0x1000>;
+
+        panel: display@0 {
+            compatible = "arm,versatile-tft-panel";
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&foo>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.20.1
