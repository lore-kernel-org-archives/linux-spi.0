From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 4/4][V3] dt-bindings: iio: imu: add bindings for ADIS16460
Date: Mon, 22 Jul 2019 15:47:47 +0300
Message-ID: <20190722124747.4792-5-alexandru.ardelean@analog.com>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>
To: <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722124747.4792-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This change adds device-tree bindings for the ADIS16460.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/imu/adi,adis16460.yaml       | 53 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
new file mode 100644
index 000000000000..0c53009ba7d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16460.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16460 and similar IMUs
+
+maintainers:
+  - Dragos Bogdan <dragos.bogdan@analog.com>
+
+description: |
+  Analog Devices ADIS16460 and similar IMUs
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16460.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16460
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "adi,adis16460";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            spi-cpol;
+            spi-cpha;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e679504c087..c44fbe8e91e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -943,6 +943,7 @@ S:	Supported
 L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
-- 
2.20.1
