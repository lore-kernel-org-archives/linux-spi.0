From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] spi: Document Octal mode as valid SPI bus width
Date: Thu, 2 Jan 2020 15:51:18 +0530
Message-ID: <20200102102118.23318-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI core supports Octal SPI controllers which have 8 IO lines.
Therefore document 8 as a valid option for spi-tx{rx}-bus-width

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 732339275848..1e0ca6ccf64b 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -111,7 +111,7 @@ patternProperties:
       spi-rx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MISO.
@@ -123,7 +123,7 @@ patternProperties:
       spi-tx-bus-width:
         allOf:
           - $ref: /schemas/types.yaml#/definitions/uint32
-          - enum: [ 1, 2, 4 ]
+          - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
           Bus width to the SPI bus used for MOSI.
-- 
2.24.1
