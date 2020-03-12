From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
Date: Thu, 12 Mar 2020 19:31:26 +0800
Message-ID: <20200312113129.8198-5-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds compatible string "snps,dwc-ssi-1.01a" to the above DT
binding document, to provide support for DesignWare DWC_ssi IP [1].

Current driver supports DW_apb_ssi IP [2].

References:
[1] https://www.synopsys.com/dw/ipdir.php?c=dwc_ssi
[2] https://www.synopsys.com/dw/ipdir.php?c=DW_apb_ssi

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 57a789f5d9f3..36371654ea95 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -23,6 +23,8 @@ properties:
           - const: amazon,alpine-dw-apb-ssi
       - items:
           - const: snps,dw-apb-ssi
+      - items:
+          - const: snps,dwc-ssi-1.01a
 
   reg:
     minItems: 1
-- 
2.17.1
