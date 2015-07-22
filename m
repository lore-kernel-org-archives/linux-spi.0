From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [RESEND][PATCH 4/4] ARM: dts: keystone: Add ti,keystone-spi for SPI
Date: Wed, 22 Jul 2015 07:32:24 -0500
Message-ID: <1437568344-18889-5-git-send-email-fcooper@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org>,
	Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <nsekhar-l0cyMroinI0@public.gmane.org>, <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437568344-18889-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add ti,keystone-spi to the compatible field for the SPI node. This new
entry insures that the proper prescaler limit is used for keystone devices

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/keystone.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c06542b..ea2e1cd 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -136,7 +136,7 @@
 		};
 
 		spi0: spi@21000400 {
-			compatible = "ti,dm6441-spi";
+			compatible = "ti,keystone-spi", "ti,dm6441-spi";
 			reg = <0x21000400 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
@@ -147,7 +147,7 @@
 		};
 
 		spi1: spi@21000600 {
-			compatible = "ti,dm6441-spi";
+			compatible = "ti,keystone-spi", "ti,dm6441-spi";
 			reg = <0x21000600 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
@@ -158,7 +158,7 @@
 		};
 
 		spi2: spi@21000800 {
-			compatible = "ti,dm6441-spi";
+			compatible = "ti,keystone-spi", "ti,dm6441-spi";
 			reg = <0x21000800 0x200>;
 			num-cs = <4>;
 			ti,davinci-spi-intr-line = <0>;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
