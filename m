From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] dt-binding: spi: add bindings for spi-ar934x
Date: Thu,  6 Feb 2020 16:38:22 +0800
Message-ID: <20200206083822.204534-3-gch981213@gmail.com>
References: <20200206083822.204534-1-gch981213@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200206083822.204534-1-gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add binding documentation for SPI controller in Qualcomm Atheros
AR934x/QCA95xx SoCs.

Signed-off-by: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
new file mode 100644
index 000000000000..8f0c520a571c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qca,ar934x-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros AR934x/QCA95xx SoC SPI controller
+
+maintainers:
+  - Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: qca,ar934x-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    spi: spi@1f000000 {
+        compatible = "qca,ar934x-spi";
+        reg = <0x1f000000 0x1c>;
+        clocks = <&pll ATH79_CLK_AHB>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.24.1
