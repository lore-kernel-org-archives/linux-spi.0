From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] dt-bindings: spi: Fix the number of CS lines documented as an example
Date: Tue, 20 Aug 2019 17:20:00 +0530
Message-ID: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: broonie@kernel.org, robh+dt@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The number of CS lines is mentioned as 2 in the spi-controller binding
but however in the example, 4 cs-gpios are used. Hence fix that to
mention 4.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index a02e2fe2bfb2..732339275848 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -31,7 +31,7 @@ properties:
       If that property is used, the number of chip selects will be
       increased automatically with max(cs-gpios, hardware chip selects).
 
-      So if, for example, the controller has 2 CS lines, and the
+      So if, for example, the controller has 4 CS lines, and the
       cs-gpios looks like this
         cs-gpios = <&gpio1 0 0>, <0>, <&gpio1 1 0>, <&gpio1 2 0>;
 
-- 
2.17.1
