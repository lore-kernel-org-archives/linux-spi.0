From: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 1/3] dt-bindings: spi: convert rockchip spi bindings to yaml
Date: Wed,  4 Mar 2020 19:42:01 +0100
Message-ID: <20200304184203.9548-1-jbx6244@gmail.com>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Current dts files with 'spi' nodes are manually verified.
In order to automate this process spi-rockchip.txt
has to be converted to yaml. In the new setup
spi-rockchip.yaml will inherit properties from
spi-controller.yaml.

Add document to MAINTAINERS.

Also rk3188.dtsi, rk3288.dtsi, rk3368.dtsi and rk3399.dtsi
use an extra fallback string, so change this in the documentation.

Changed:
"rockchip,rk3188-spi", "rockchip,rk3066-spi"
"rockchip,rk3288-spi", "rockchip,rk3066-spi"
"rockchip,rk3368-spi", "rockchip,rk3066-spi"
"rockchip,rk3399-spi", "rockchip,rk3066-spi"

Signed-off-by: Johan Jonker <jbx6244-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes v3:
  fix compile for latest linux-next
  remove some comments

Changes v2:
  include suggestions by robh
---
 .../devicetree/bindings/spi/spi-rockchip.txt       |  58 ------------
 .../devicetree/bindings/spi/spi-rockchip.yaml      | 105 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 106 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rockchip.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
deleted file mode 100644
index a0edac12d..000000000
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Rockchip SPI Controller
-
-The Rockchip SPI controller is used to interface with various devices such as flash
-and display controllers using the SPI communication interface.
-
-Required Properties:
-
-- compatible: should be one of the following.
-    "rockchip,rv1108-spi" for rv1108 SoCs.
-    "rockchip,px30-spi", "rockchip,rk3066-spi" for px30 SoCs.
-    "rockchip,rk3036-spi" for rk3036 SoCS.
-    "rockchip,rk3066-spi" for rk3066 SoCs.
-    "rockchip,rk3188-spi" for rk3188 SoCs.
-    "rockchip,rk3228-spi" for rk3228 SoCS.
-    "rockchip,rk3288-spi" for rk3288 SoCs.
-    "rockchip,rk3368-spi" for rk3368 SoCs.
-    "rockchip,rk3399-spi" for rk3399 SoCs.
-- reg: physical base address of the controller and length of memory mapped
-       region.
-- interrupts: The interrupt number to the cpu. The interrupt specifier format
-              depends on the interrupt controller.
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Shall be "spiclk" for the transfer-clock, and "apb_pclk" for
-			   the peripheral clock.
-- #address-cells: should be 1.
-- #size-cells: should be 0.
-
-Optional Properties:
-
-- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
-		Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request names should include "tx" and "rx" if present.
-- rx-sample-delay-ns: nanoseconds to delay after the SCLK edge before sampling
-		Rx data (may need to be fine tuned for high capacitance lines).
-		No delay (0) by default.
-- pinctrl-names: Names for the pin configuration(s); may be "default" or
-		"sleep", where the "sleep" configuration may describe the state
-		the pins should be in during system suspend. See also
-		pinctrl/pinctrl-bindings.txt.
-
-
-Example:
-
-	spi0: spi@ff110000 {
-		compatible = "rockchip,rk3066-spi";
-		reg = <0xff110000 0x1000>;
-		dmas = <&pdma1 11>, <&pdma1 12>;
-		dma-names = "tx", "rx";
-		rx-sample-delay-ns = <10>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
-		clock-names = "spiclk", "apb_pclk";
-		pinctrl-0 = <&spi1_pins>;
-		pinctrl-1 = <&spi1_sleep>;
-		pinctrl-names = "default", "sleep";
-	};
diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
new file mode 100644
index 000000000..bd1450c12
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/spi-rockchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip SPI Controller
+
+description:
+  The Rockchip SPI controller is used to interface with various devices such
+  as flash and display controllers using the SPI communication interface.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+maintainers:
+  - Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
+
+# Everything else is described in the common file
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk3036-spi
+      - const: rockchip,rk3066-spi
+      - const: rockchip,rk3228-spi
+      - const: rockchip,rv1108-spi
+      - items:
+          - enum:
+            - rockchip,px30-spi
+            - rockchip,rk3188-spi
+            - rockchip,rk3288-spi
+            - rockchip,rk3368-spi
+            - rockchip,rk3399-spi
+          - const: rockchip,rk3066-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: transfer-clock
+      - description: peripheral clock
+
+  clock-names:
+    items:
+      - const: spiclk
+      - const: apb_pclk
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  rx-sample-delay-ns:
+    default: 0
+    description:
+      Nano seconds to delay after the SCLK edge before sampling Rx data
+      (may need to be fine tuned for high capacitance lines).
+      If not specified 0 will be used.
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+    description:
+      Names for the pin configuration(s); may be "default" or "sleep",
+      where the "sleep" configuration may describe the state
+      the pins should be in during system suspend.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3188-cru-common.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0: spi@ff110000 {
+      compatible = "rockchip,rk3066-spi";
+      reg = <0xff110000 0x1000>;
+      interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
+      clock-names = "spiclk", "apb_pclk";
+      dmas = <&pdma1 11>, <&pdma1 12>;
+      dma-names = "tx", "rx";
+      pinctrl-0 = <&spi1_pins>;
+      pinctrl-1 = <&spi1_sleep>;
+      pinctrl-names = "default", "sleep";
+      rx-sample-delay-ns = <10>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3bd372323..42c21184d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2281,6 +2281,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
 F:	Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
 F:	arch/arm/boot/dts/rk3*
 F:	arch/arm/boot/dts/rv1108*
 F:	arch/arm/mach-rockchip/
-- 
2.11.0
