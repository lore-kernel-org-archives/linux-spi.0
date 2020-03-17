From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 13/28] dt-bindings: serial: move Marvell compatible string to 8250 binding doc
Date: Tue, 17 Mar 2020 10:39:07 +0100
Message-ID: <20200317093922.20785-14-lkundrak@v3.sk>
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

These ports are compatible with NS8250 and handled by the same driver.
Get rid of the extra document that fails to document the properties that
are actually supported.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
 Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 55700f20f6ee8..a543702859e2f 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -26,6 +26,8 @@ Required properties:
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
 	- "nuvoton,npcm750-uart"
+	- "mrvl,mmp-uart"
+	- "mrvl,pxa-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
diff --git a/Documentation/devicetree/bindings/serial/mrvl-serial.txt b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
deleted file mode 100644
index d744340de887c..0000000000000
--- a/Documentation/devicetree/bindings/serial/mrvl-serial.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-PXA UART controller
-
-Required properties:
-- compatible : should be "mrvl,mmp-uart" or "mrvl,pxa-uart".
-- 
2.25.1
