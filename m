From: Rob Herring <robh@kernel.org>
Subject: [PATCH] dt-bindings: Ensure child nodes are of type 'object'
Date: Mon, 15 Jul 2019 17:04:57 -0600
Message-ID: <20190715230457.3901-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org
To: devicetree@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Properties which are child node definitions need to have an explict
type. Otherwise, a matching (DT) property can silently match when an
error is desired. Fix this up tree-wide. Once this is fixed, the
meta-schema will enforce this on any child node definitions.

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-mtd@lists.infradead.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack. I will take this via the DT tree.

Rob

 .../devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml       | 1 +
 .../devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml      | 1 +
 Documentation/devicetree/bindings/mtd/nand-controller.yaml     | 1 +
 .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml          | 3 +++
 .../devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml       | 1 +
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml       | 1 +
 6 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml b/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
index fc2f63860cc8..be32f087c529 100644
--- a/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
+++ b/Documentation/devicetree/bindings/bus/allwinner,sun8i-a23-rsb.yaml
@@ -42,6 +42,7 @@ properties:
 
 patternProperties:
   "^.*@[0-9a-fA-F]+$":
+    type: object
     properties:
       reg:
         maxItems: 1
diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
index e5a411518be1..b5b3cf5b1ac2 100644
--- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
@@ -55,6 +55,7 @@ patternProperties:
   "^pinctrl-[0-9]+$": true
 
   "^nand@[a-f0-9]+$":
+    type: object
     properties:
       reg:
         minimum: 0
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 199ba5ac2a06..d261b7096c69 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -40,6 +40,7 @@ properties:
 
 patternProperties:
   "^nand@[a-f0-9]$":
+    type: object
     properties:
       reg:
         description:
diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index 06c4b66c3ee6..3ac5d2088e49 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -55,6 +55,7 @@ properties:
 
 patternProperties:
   '^gpio@[0-9a-f]*$':
+    type: object
     properties:
       gpio-controller: true
       '#gpio-cells':
@@ -113,8 +114,10 @@ patternProperties:
       - st,bank-name
 
   '-[0-9]*$':
+    type: object
     patternProperties:
       '^pins':
+        type: object
         description: |
           A pinctrl node should contain at least one subnode representing the
           pinctrl group available on the machine. Each subnode will list the
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index c374fd4923a6..6d1329c28170 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -50,6 +50,7 @@ properties:
 
 patternProperties:
   "^.*@[0-9a-f]+":
+    type: object
     properties:
       reg:
         items:
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index bda7a5befd8b..f36c46d236d7 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -55,6 +55,7 @@ properties:
 
 patternProperties:
   "^.*@[0-9a-f]+":
+    type: object
     properties:
       reg:
         items:
-- 
2.20.1
