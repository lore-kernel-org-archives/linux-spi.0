From: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 2/2] ARM: ls1021a: dtsi: Update 'dspi' node compatible string
Date: Mon, 15 Jun 2015 19:49:15 +0800
Message-ID: <1434368955-13470-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

DSPI driver has been updated and supports TCF interrupt type now.
In the new driver we choose the interrupt type according the compatible
string of the device node.
This patch update the compatible string of DSPI of LS1021A in order to
use the correct interrupt type.

Signed-off-by: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index c70bb27..1b306c7 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -184,7 +184,7 @@
 		};
 
 		dspi0: dspi@2100000 {
-			compatible = "fsl,vf610-dspi";
+			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2100000 0x0 0x10000>;
@@ -197,7 +197,7 @@
 		};
 
 		dspi1: dspi@2110000 {
-			compatible = "fsl,vf610-dspi";
+			compatible = "fsl,ls1021a-v1.0-dspi";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x2110000 0x0 0x10000>;
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
