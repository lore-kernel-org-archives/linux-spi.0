From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/3] dt-bindings: spi: spi-rockchip: add description for rk3328
Date: Wed, 22 Jan 2020 23:45:55 +0100
Message-ID: <20200122224555.6845-3-jbx6244@gmail.com>
References: <20200122224555.6845-1-jbx6244@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200122224555.6845-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The description below is already in use for rk3328.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3328-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3328 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index a797a4748..5e0fab1bc 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
             - rockchip,rk3188-spi  #for rk3188 SoCs.
             - rockchip,rk3288-spi  #for rk3288 SoCs.
             - rockchip,rk3308-spi  #for rk3308 SoCs.
+            - rockchip,rk3328-spi  #for rk3328 SoCs.
             - rockchip,rk3368-spi  #for rk3368 SoCs.
             - rockchip,rk3399-spi  #for rk3399 SoCs.
           - const: rockchip,rk3066-spi
-- 
2.11.0
