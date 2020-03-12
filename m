From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
Date: Thu, 12 Mar 2020 19:31:28 +0800
Message-ID: <20200312113129.8198-7-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Document Intel Keem Bay SPI controller DT bindings.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 36371654ea95..8d3b6ee36266 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -25,6 +25,8 @@ properties:
           - const: snps,dw-apb-ssi
       - items:
           - const: snps,dwc-ssi-1.01a
+      - items:
+          - const: intel,keembay-ssi
 
   reg:
     minItems: 1
-- 
2.17.1
