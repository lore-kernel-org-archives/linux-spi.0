From: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH V2 3/7] dt-bindings: imx-ocotp: Add i.MX8MP compatible
Date: Mon, 13 Jan 2020 13:33:18 +0800
Message-ID: <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
Cc: Linux-imx-3arQi8VN3Tc@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        rjones-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org, marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org,
        sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org, aisheng.dong-3arQi8VN3Tc@public.gmane.org,
        richard.hu-Ynyd8CyeeRDSUeElwK9/Pw@public.gmane.org, angus-HsWYs6tNinE@public.gmane.org, cosmin.stoica-3arQi8VN3Tc@public.gmane.org,
        l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org,
        leonard.crestez-3arQi8VN3Tc@public.gmane.org, daniel.baluta-3arQi8VN3Tc@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1578893602-14395-1-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add compatible and description for i.MX8MP.

Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
---
New patch
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 904dadf..6e346d5 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -2,7 +2,7 @@ Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
 i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM and i.MX8MN SoCs.
+i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -17,6 +17,7 @@ Required properties:
 	"fsl,imx8mq-ocotp" (i.MX8MQ),
 	"fsl,imx8mm-ocotp" (i.MX8MM),
 	"fsl,imx8mn-ocotp" (i.MX8MN),
+	"fsl,imx8mp-ocotp" (i.MX8MP),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.7.4
