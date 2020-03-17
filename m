From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 16/28] dt-bindings: Add "mrvl", a legacy vendor prefix for Marvell
Date: Tue, 17 Mar 2020 10:39:10 +0100
Message-ID: <20200317093922.20785-17-lkundrak@v3.sk>
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
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

While the preferred vendor prefix is "marvell", "mrvl" is used by many
older bindings already. Add it, while also marking it deprecated.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 23ca95bee2985..1653de506db1a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -645,6 +645,9 @@ patternProperties:
     description: Monolithic Power Systems Inc.
   "^mqmaker,.*":
     description: mqmaker Inc.
+  "^mrvl,.*":
+    description: Marvell Technology Group Ltd.
+    deprecated: true
   "^mscc,.*":
     description: Microsemi Corporation
   "^msi,.*":
-- 
2.25.1
