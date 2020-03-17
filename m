From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 15/28] dt-bindings: arm: mrvl: Add missing compatible strings
Date: Tue, 17 Mar 2020 10:39:09 +0100
Message-ID: <20200317093922.20785-16-lkundrak@v3.sk>
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
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add compatible strings for the boards we have in tree. At the same time,
fix the MMP3 compatible string: the preferred vendor name for Marvell is
"marvell", not "mrvl", and indeed "marvell,mmp3" has been actively used,
not "mrvl,mmp3".

Fixes: 95aecb71b84e ("dt-bindings: arm: mrvl: Document MMP3 compatible string")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
index 818dfe6de5120..3235ec9e9bad1 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
@@ -28,8 +28,11 @@ properties:
         items:
           - enum:
               - mrvl,mmp2-brownstone
+              - olpc,xo-1.75
           - const: mrvl,mmp2
       - description: MMP3 based boards
         items:
-          - const: mrvl,mmp3
+          - enum:
+              - dell,wyse-ariel
+          - const: marvell,mmp3
 ...
-- 
2.25.1
