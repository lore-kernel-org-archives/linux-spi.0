From: Rob Herring <robh@kernel.org>
Subject: [PATCH] spi: dt-bindings: spi-controller: remove unnecessary 'maxItems: 1' from reg
Date: Tue,  9 Jul 2019 13:26:31 -0600
Message-ID: <20190709192631.16394-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Mixing array constraints like 'maxItems' and string or integer value
constraints like 'minimum' don't make sense. Also, with only value
constraints, it is implied we have a single value. So lets remove
'maxItems: 1'.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 876c0623f322..a02e2fe2bfb2 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -73,7 +73,6 @@ patternProperties:
           Compatible of the SPI device.
 
       reg:
-        maxItems: 1
         minimum: 0
         maximum: 256
         description:
-- 
2.20.1
