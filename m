From: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Subject: [PATCH] ARM: mvebu: use improved armada spi device tree compatible name
Date: Mon,  8 Sep 2014 13:30:29 +1000
Message-ID: <1410147029-30067-1-git-send-email-gerg@uclinux.org>
Cc: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>

Switch the Armada SoC SPI port device tree binding to use the new improved
armada-370-spi compatible name. This allows for a wider range of baud rates
to be used.

Signed-off-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Tested-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Reviewed-by: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 23227e0..83286ec 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -110,7 +110,7 @@
 			};
 
 			spi0: spi@10600 {
-				compatible = "marvell,orion-spi";
+				compatible = "marvell,armada-370-spi", "marvell,orion-spi";
 				reg = <0x10600 0x28>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -121,7 +121,7 @@
 			};
 
 			spi1: spi@10680 {
-				compatible = "marvell,orion-spi";
+				compatible = "marvell,armada-370-spi", "marvell,orion-spi";
 				reg = <0x10680 0x28>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
