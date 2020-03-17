From: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Subject: [PATCH 20/28] dt-bindings: phy: Convert phy-mmp3-usb to json-schema
Date: Tue, 17 Mar 2020 10:39:14 +0100
Message-ID: <20200317093922.20785-21-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
        Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>,
        Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Gregory Clement <gregory.clement-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        devicetree-u79uwXL29TZNg+MwTxZMZA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317093922.20785-1-lkundrak-NGH9Lh4a5iE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

A rather straightforward conversion of the phy-mmp3-usb binding to DT
schema format using json-schema.

Signed-off-by: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
---
 .../bindings/phy/marvell,mmp3-usb-phy.yaml    | 40 +++++++++++++++++++
 .../devicetree/bindings/phy/phy-mmp3-usb.txt  | 13 ------
 2 files changed, 40 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
new file mode 100644
index 0000000000000..1307703d9b627
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+# Copyright 2019,2020 Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/marvell,mmp3-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP3 USB PHY bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
+
+properties:
+  $nodename:
+    pattern: '^usb-phy@[a-f0-9]+$'
+
+  compatible:
+    const: marvell,mmp3-usb-phy
+
+  reg:
+    maxItems: 1
+    description: base address of the device
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+examples:
+  - |
+    usb-phy@d4207000 {
+      compatible = "marvell,mmp3-usb-phy";
+      reg = <0xd4207000 0x40>;
+      #phy-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt b/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
deleted file mode 100644
index 7183b9102f917..0000000000000
--- a/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Marvell MMP3 USB PHY
---------------------
-
-Required properties:
-- compatible: must be "marvell,mmp3-usb-phy"
-- #phy-cells: must be 0
-
-Example:
-	usb-phy: usb-phy@d4207000 {
-		compatible = "marvell,mmp3-usb-phy";
-		reg = <0xd4207000 0x40>;
-		#phy-cells = <0>;
-	};
-- 
2.25.1
