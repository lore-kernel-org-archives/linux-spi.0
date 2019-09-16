From: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 1/2] dt-bindings: spi: Add support for cadence-qspi IP Intel LGM SoC
Date: Mon, 16 Sep 2019 15:38:42 +0800
Message-ID: <20190916073843.39618-2-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

On Intel Lightening Mountain(LGM) SoCs QSPI controller support
to QSPI-NAND flash. This introduces to device tree binding
documentation for Cadence-QSPI controller and spi-nand flash.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 .../devicetree/bindings/spi/cadence,qspi-nand.yaml | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml

diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
new file mode 100644
index 000000000000..9aae4c1459cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cadence,qspi-nand.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence QSPI Flash Controller on Intel's SoC
+
+maintainers:
+  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+description: |
+  The Cadence QSPI is a controller optimized for communication with SPI
+  FLASH memories, without DMA support on Intel's SoC.
+
+properties:
+  compatible:
+    const: cadence,lgm-qspi
+
+  reg:
+    maxItems: 1
+
+  fifo-depth:
+    maxItems: 1
+
+  fifo-width:
+    maxItems: 1
+
+  qspi-phyaddr:
+    maxItems: 1
+
+  qspi-phymask:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clocks-names:
+    maxItems: 2
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - fifo-depth
+  - fifo-width
+  - qspi-phyaddr
+  - qspi-phymask
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+examples:
+  - |
+    qspi@ec000000 {
+          compatible = "cadence,qspi-nand";
+          reg = <0xec000000 0x100>;
+          fifo-depth = <128>;
+          fifo-width = <4>;
+          qspi-phyaddr = <0xf4000000>;
+          qspi-phymask = <0xffffffff>;
+          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
+          clock-names = "freq", "qspi";
+          resets = <&rcu0 0x10 1>;
+          reset-names = "qspi";
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          flash: flash@1 {
+              compatible = "spi-nand";
+              reg = <1>;
+              spi-max-frequency = <10000000>;
+          };
+    };
+
-- 
2.11.0
