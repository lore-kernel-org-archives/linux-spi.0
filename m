From: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH V3 1/4] dt-bindings: spi: imx: Add i.MX8MM/i.MX8MN/i.MX8MP compatible
Date: Tue, 11 Feb 2020 20:48:24 +0800
Message-ID: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
Cc: Linux-imx-3arQi8VN3Tc@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org,
        rjones-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org, sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org,
        aisheng.dong-3arQi8VN3Tc@public.gmane.org, gary.bisson-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org,
        angus-HsWYs6tNinE@public.gmane.org, pramod.kumar_1-3arQi8VN3Tc@public.gmane.org, rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org,
        cosmin.stoica-3arQi8VN3Tc@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        leonard.crestez-3arQi8VN3Tc@public.gmane.org, daniel.baluta-3arQi8VN3Tc@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add compatible for imx8mm/imx8mn/imx8mp.

Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
Changes since V2:
	- fix typo in commit message, compatbile -> compatible.
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 2d32641..33bc58f 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,7 +10,10 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
-  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
+  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
+  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
+  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
+  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
 - reg : Offset and length of the register set for the device
 - interrupts : Should contain CSPI/eCSPI interrupt
 - clocks : Clock specifiers for both ipg and per clocks.
-- 
2.7.4
