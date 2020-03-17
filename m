From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 12/28] spi: dt-bindings: spi-controller: Slaves have no address cells
Date: Tue, 17 Mar 2020 10:39:06 +0100
Message-ID: <20200317093922.20785-13-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kerne
To: Rob Herring <robh+dt@kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI controllers in slave mode have a single child node that has no
address. Enforce #address-cells of zero instead of one.

Fixes: 0a1b929356830 ("spi: Add YAML schemas for the generic SPI options")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/spi/spi-controller.yaml          | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index d8e5509a70816..30d774cf6cc95 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -15,16 +15,27 @@ description: |
   controller may be described for use in SPI master mode or in SPI slave mode,
   but not for both at the same time.
 
+allOf:
+  - if:
+      required:
+        - spi-slave
+    then:
+      properties:
+        "#address-cells":
+          const: 0
+        "#size-cells":
+          const: 0
+    else:
+      properties:
+        "#address-cells":
+          const: 1
+        "#size-cells":
+          const: 0
+
 properties:
   $nodename:
     pattern: "^spi(@.*|-[0-9a-f])*$"
 
-  "#address-cells":
-    const: 1
-
-  "#size-cells":
-    const: 0
-
   cs-gpios:
     description: |
       GPIOs used as chip selects.
-- 
2.25.1
