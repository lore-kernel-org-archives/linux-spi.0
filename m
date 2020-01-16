From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3 3/3] dt-bindings: spi: sunxi: Document new compatible strings
Date: Thu, 16 Jan 2020 23:11:48 +0000
Message-ID: <20200116231148.1490-4-andre.przywara@arm.com>
References: <20200116231148.1490-1-andre.przywara@arm.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116231148.1490-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The Allwinner H6 SPI controller has advanced features over the H3
version, but remains compatible with it.
Document the usual "specific", "fallback" compatible string pair.
Also add the R40 version while at it.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 .../devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index f36c46d236d7..c8ccbc2fd1e3 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -18,9 +18,14 @@ properties:
   "#size-cells": true
 
   compatible:
-    enum:
-      - allwinner,sun6i-a31-spi
-      - allwinner,sun8i-h3-spi
+    oneOf:
+      - const: allwinner,sun6i-a31-spi
+      - const: allwinner,sun8i-h3-spi
+      - items:
+        - enum:
+          - allwinner,sun8i-r40-spi
+          - allwinner,sun50i-h6-spi
+        - const: allwinner,sun8i-h3-spi
 
   reg:
     maxItems: 1
-- 
2.14.5
