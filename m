From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/7] dt-bindings: spi: dw-apb-ssi: Convert bindings to json-schema
Date: Thu, 12 Mar 2020 19:31:25 +0800
Message-ID: <20200312113129.8198-4-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert the Synopsis DesignWare dw-apb-ssi binding to DT schema format
using json-schema.

Suggested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 .../bindings/spi/snps,dw-apb-ssi.txt          |  41 -------
 .../bindings/spi/snps,dw-apb-ssi.yaml         | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
deleted file mode 100644
index 3ed08ee9feba..000000000000
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
-
-Required properties:
-- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi"
-- reg : The register base for the controller. For "mscc,<soc>-spi", a second
-  register set is required (named ICPU_CFG:SPI_MST)
-- interrupts : One interrupt, used by the controller.
-- #address-cells : <1>, as required by generic SPI binding.
-- #size-cells : <0>, also as required by generic SPI binding.
-- clocks : phandles for the clocks, see the description of clock-names below.
-   The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
-   is optional. If a single clock is specified but no clock-name, it is the
-   "ssi_clk" clock. If both clocks are listed, the "ssi_clk" must be first.
-
-Optional properties:
-- clock-names : Contains the names of the clocks:
-    "ssi_clk", for the core clock used to generate the external SPI clock.
-    "pclk", the interface clock, required for register access. If a clock domain
-     used to enable this clock then it should be named "pclk_clkdomain".
-- cs-gpios : Specifies the gpio pins to be used for chipselects.
-- num-cs : The number of chipselects. If omitted, this will default to 4.
-- reg-io-width : The I/O register width (in bytes) implemented by this
-  device.  Supported values are 2 or 4 (the default).
-
-Child nodes as per the generic SPI binding.
-
-Example:
-
-	spi@fff00000 {
-		compatible = "snps,dw-apb-ssi";
-		reg = <0xfff00000 0x1000>;
-		interrupts = <0 154 4>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clocks = <&spi_m_clk>;
-		num-cs = <2>;
-		cs-gpios = <&gpio0 13 0>,
-			   <&gpio0 14 0>;
-	};
-
diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
new file mode 100644
index 000000000000..57a789f5d9f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface
+
+maintainers:
+  - Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mscc,ocelot-spi
+              - mscc,jaguar2-spi
+      - items:
+          - const: amazon,alpine-dw-apb-ssi
+      - items:
+          - const: snps,dw-apb-ssi
+
+  reg:
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - description: The register base for the controller.
+      - items:
+          - description: The register base for the controller.
+          - description: For "mscc,<soc>-spi", a second register set is
+                         required (named ICPU_CFG:SPI_MST)
+
+  interrupts:
+    maxItems: 1
+    description: One interrupt, used by the controller.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    description: |
+      phandles for the clocks, see the description of clock-names below.
+      The phandle for the "ssi_clk" is required. The phandle for the "pclk"
+      clock is optional. If a single clock is specified but no clock-name,
+      it is the "ssi_clk" clock. If both clocks are listed, the "ssi_clk"
+      must be first.
+
+  clock-names:
+    items:
+      - const: ssi_clk
+      - const: pclk
+    description: |
+      Contains the names of the clocks.
+      "ssi_clk", for the core clock used to generate the external SPI clock.
+      "pclk", the interface clock, required for register access.
+      If a clock domain used to enable this clock then it should be
+      named "pclk_clkdomain".
+
+  cs-gpios:
+    description: Specifies the gpio pins to be used for chipselects.
+
+  num-cs:
+    default: 4
+    description: The number of chipselects. If omitted, this will default to 4.
+
+  reg-io-width:
+    default: 4
+    description: |
+      The I/O register width (in bytes) implemented by this device.
+      Supported values are 2 or 4 (the default).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#address-cells'
+  - '#size-cells'
+  - clocks
+
+examples:
+  - |
+    spi@fff00000 {
+          compatible = "snps,dw-apb-ssi";
+          reg = <0xfff00000 0x1000>;
+          interrupts = <0 154 4>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+          clocks = <&spi_m_clk>;
+          num-cs = <2>;
+          cs-gpios = <&gpio0 13 0>,
+                     <&gpio0 14 0>;
+    };
-- 
2.17.1
