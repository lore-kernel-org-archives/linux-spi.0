From: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP compatible string
Date: Mon, 13 Jan 2020 13:33:17 +0800
Message-ID: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
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
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1578893602-14395-1-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add compatible string for imx8mp

Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
---
New patch
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 2fb466c..c93643f 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -21,6 +21,7 @@ Required properties:
 	       "fsl,imx8mq-usdhc"
 	       "fsl,imx8mm-usdhc"
 	       "fsl,imx8mn-usdhc"
+	       "fsl,imx8mp-usdhc"
 	       "fsl,imx8qxp-usdhc"
 
 Optional properties:
-- 
2.7.4
