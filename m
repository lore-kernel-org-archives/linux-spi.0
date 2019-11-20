From: Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2] dt-bindings: spi: Convert stm32 QSPI bindings to
 json-schema
Date: Wed, 20 Nov 2019 20:44:44 +0100
Message-ID: <20191120194444.10540-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <alexandre.torgue@st.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Convert the STM32 QSPI binding to DT schema format using json-schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
changes in version 2:
- fix subject
- remove useless minItems and maxItems
 .../devicetree/bindings/spi/spi-stm32-qspi.txt     | 47 ------------
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     | 83 ++++++++++++++++++++++
 2 files changed, 83 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt b/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
deleted file mode 100644
index bfc038b9478d..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-stm32-qspi.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* STMicroelectronics Quad Serial Peripheral Interface(QSPI)
-
-Required properties:
-- compatible: should be "st,stm32f469-qspi"
-- reg: the first contains the register location and length.
-       the second contains the memory mapping address and length
-- reg-names: should contain the reg names "qspi" "qspi_mm"
-- interrupts: should contain the interrupt for the device
-- clocks: the phandle of the clock needed by the QSPI controller
-- A pinctrl must be defined to set pins in mode of operation for QSPI transfer
-
-Optional properties:
-- resets: must contain the phandle to the reset controller.
-
-A spi flash (NOR/NAND) must be a child of spi node and could have some
-properties. Also see jedec,spi-nor.txt.
-
-Required properties:
-- reg: chip-Select number (QSPI controller may connect 2 flashes)
-- spi-max-frequency: max frequency of spi bus
-
-Optional properties:
-- spi-rx-bus-width: see ./spi-bus.txt for the description
-- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
-Documentation/devicetree/bindings/dma/dma.txt.
-- dma-names: DMA request names should include "tx" and "rx" if present.
-
-Example:
-
-qspi: spi@a0001000 {
-	compatible = "st,stm32f469-qspi";
-	reg = <0xa0001000 0x1000>, <0x90000000 0x10000000>;
-	reg-names = "qspi", "qspi_mm";
-	interrupts = <91>;
-	resets = <&rcc STM32F4_AHB3_RESET(QSPI)>;
-	clocks = <&rcc 0 STM32F4_AHB3_CLOCK(QSPI)>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi0>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-rx-bus-width = <4>;
-		spi-max-frequency = <108000000>;
-		...
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
new file mode 100644
index 000000000000..3665a5fe6b7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/st,stm32-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32 Quad Serial Peripheral Interface (QSPI) bindings
+
+maintainers:
+  - Christophe Kerello <christophe.kerello@st.com>
+  - Patrice Chotard <patrice.chotard@st.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: st,stm32f469-qspi
+
+  reg:
+    items:
+      - description: registers
+      - description: memory mapping
+
+  reg-names:
+    items:
+     - const: qspi
+     - const: qspi_mm
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    items:
+      - description: tx DMA channel
+      - description: rx DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+    #include <dt-bindings/reset/stm32mp1-resets.h>
+    spi@58003000 {
+      compatible = "st,stm32f469-qspi";
+      reg = <0x58003000 0x1000>, <0x70000000 0x10000000>;
+      reg-names = "qspi", "qspi_mm";
+      interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+      dmas = <&mdma1 22 0x10 0x100002 0x0 0x0>,
+             <&mdma1 22 0x10 0x100008 0x0 0x0>;
+      dma-names = "tx", "rx";
+      clocks = <&rcc QSPI_K>;
+      resets = <&rcc QSPI_R>;
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        reg = <0>;
+        spi-rx-bus-width = <4>;
+        spi-max-frequency = <108000000>;
+      };
+    };
+
+...
-- 
2.15.0
