From: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 2/2] Add dt-bindings for Cadence XSPI controller
Date: Tue, 28 Jan 2020 13:43:04 +0100
Message-ID: <20200128124313.12837-1-konrad@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add dt-bindings documentation for Cadence XSPI controller to support
SPI based flash memories.

Signed-off-by: Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
---
Changes between initial version and v2:
  - renamed yaml file
  - added missing include

 .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 +++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 000000000000..e8c43957fd90
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Cadence
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence XSPI Controller
+
+maintainers:
+  - Konrad Kociolek <konrad-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>
+
+description: |
+  The XSPI controller allows SPI protocol communication in
+  single, dual, quad or octal wire transmission modes for
+  read/write access to slaves such as SPI-NOR flash.
+
+properties:
+  compatible:
+    const: cdns,xspi-nor-fpga
+
+  reg:
+    maxItems: 3
+    description: |
+      Contains three entries, each of which is a tuple consisting of a
+      physical address and length. The first entry is the address and
+      length of the controller register set. The second entry is the
+      address and length of the Slave DMA data port. The third entry is
+      the address and length of auxiliary registers.
+
+  interrupts:
+    maxItems: 1
+
+  cdns,dqs-last-data-drop:
+    type: boolean
+    description: |
+      This parameter should be set when the Flash Device being used
+      issues data on negative edge of Flash clock and returns them with
+      DQS and the PHY is configured to sample data in DQS mode.
+      If this param is set the controller internally requests this redundant
+      data at the end of the transfer cleaning up the PHY FIFO.
+
+  cdns,phy-data-select-oe-start:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the starting point of the DQ pad output enable window.
+      Lower numbers pull the rising edge earlier in time and larger
+      numbers cause the rising edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-data-select-oe-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the ending point of the DQ pad output enable window.
+      Lower numbers pull the falling edge earlier in time and larger
+      numbers cause the falling edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-dqs-select-oe-start:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the starting point of the DQS pad output enable window.
+      Lower numbers pull the rising edge earlier in time and larger
+      numbers cause the rising edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-dqs-select-oe-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the ending point of the DQS pad output enable window.
+      Lower numbers pull the falling edge earlier in time and larger
+      numbers cause the falling edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-gate-cfg-close:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Normally the gate is closing then all bits of dfi_cebar are high
+      or when dfi_rd_pre_post_amble and rebar_dfi are high. This parameter
+      allows to extend the closing of the DQS gate. Recommended zero.
+
+  cdns,phy-gate-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Coarse adjust of gate open time. This value is the number of cycles
+      to delay the dfi_rddata_en signal prior to opening the gate in
+      full cycle increments. Decreasing this value pulls the gate earlier
+      in time. This field should be programmed such that the gate signal
+      lands in the valid DQS gate window.
+
+  cdns,phy-rd-del-select:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Defines the read data delay. Holds the number of cycles to delay
+      the dfi_rddata_en signal prior to enabling the read FIFO.
+      After this delay, the read pointers begin incrementing the read FIFO.
+
+  cdns,phy-clk-wr-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Controls the clk_wr delay line which adjusts the write DQ bit
+      timing in 1/256th steps of the clock period in normal DLL
+      locked mode. In bypass mode this field directly programs
+      the number of delay elements.
+
+  cdns,phy-use-lpbk-dqs:
+    type: boolean
+    description: |
+      This parameter chooses lpbk_dqs to capture data for reads.
+      Instead memory DQS will be used.
+
+  cdns,phy-use-ext-lpbk-dqs:
+    type: boolean
+    description: |
+      This parameter chooses external lpbk_dqs for data capture
+      (lpbk_dqs connected to the lpbk_dqs_IO pad). When not used
+      mem_rebar_pad is used for data read capture.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - cdns,phy-data-select-oe-start
+  - cdns,phy-data-select-oe-end
+  - cdns,phy-dqs-select-oe-start
+  - cdns,phy-dqs-select-oe-end
+  - cdns,phy-gate-cfg-close
+  - cdns,phy-gate-cfg
+  - cdns,phy-rd-del-select
+  - cdns,phy-clk-wr-delay
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    xspi: spi@a0010000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "cdns,xspi-nor-fpga";
+        reg = <0x0 0xa0010000 0x0 0x10000>,
+              <0x0 0xb0000000 0x0 0x10000>,
+              <0x0 0xa0020000 0x0 0x10000>;
+        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+        cdns,dqs-last-data-drop;
+        cdns,phy-data-select-oe-start = <0>;
+        cdns,phy-data-select-oe-end = <4>;
+        cdns,phy-dqs-select-oe-start = <0>;
+        cdns,phy-dqs-select-oe-end = <1>;
+        cdns,phy-gate-cfg-close = <3>;
+        cdns,phy-gate-cfg = <0>;
+        cdns,phy-rd-del-select = <5>;
+        cdns,phy-clk-wr-delay = <64>;
+        cdns,phy-use-lpbk-dqs;
+        cdns,phy-use-ext-lpbk-dqs;
+        mt35xu512@0 {
+            compatible = "spi-nor", "micron,mt35xu512";
+            spi-max-frequency = <75000000>;
+            reg = <0>;
+        };
+        mt35xu512@1 {
+            compatible = "spi-nor", "micron,mt35xu512";
+            spi-max-frequency = <75000000>;
+            reg = <1>;
+        };
+    };
-- 
2.15.0
