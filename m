From: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Subject: [PATCH v3 1/2] dt-bindings: fsi: Add FSI2SPI bindings
Date: Fri,  6 Mar 2020 13:41:17 -0600
Message-ID: <20200306194118.18581-2-eajames@linux.ibm.com>
References: <20200306194118.18581-1-eajames@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org,
        andrew-zrmu5oMJ5Fs@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200306194118.18581-1-eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add documentation for the FSI2SPI CFAM engine, which provides access to
a number of SPI controllers.

Signed-off-by: Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
---
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
new file mode 100644
index 000000000000..893d81e54caa
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,fsi2spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SPI controllers
+
+maintainers:
+ - Eddie James <eajames-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
+
+description: |
+  This binding describes an FSI CFAM engine called the FSI2SPI. Therefore this
+  node will always be a child of an FSI CFAM node; see fsi.txt for details on
+  FSI slave and CFAM nodes. This FSI2SPI engine provides access to a number of
+  SPI controllers.
+
+properties:
+  compatible:
+    enum:
+      - ibm,fsi2spi
+
+  reg:
+    items:
+      - description: FSI slave address
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    fsi2spi@1c00 {
+        compatible = "ibm,fsi2spi";
+        reg = <0x1c00 0x400>;
+    };
-- 
2.24.0
