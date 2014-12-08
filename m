From: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] ARM: sun4i: dt: Add pin muxing options for SPI
Date: Mon,  8 Dec 2014 04:14:01 -0600
Message-ID: <1418033642-29731-3-git-send-email-mr.nuke.me@gmail.com>
References: <1418033642-29731-1-git-send-email-mr.nuke.me@gmail.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418033642-29731-1-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These are based on the available SPI configurations of Cubieboard,
Olimex LIME, and PcDuino. There is no pin group for SPI3, as all the
boards seem to use those pins for EMAC.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 5e2ec2d..38d9611 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -615,6 +615,34 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			spi0_pins_a: spi0@0 {
+				allwinner,pins = "PI10", "PI11", "PI12", "PI13";
+				allwinner,function = "spi0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			spi1_pins_a: spi1@0 {
+				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
+				allwinner,function = "spi1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			spi2_pins_a: spi2@0 {
+				allwinner,pins = "PB14", "PB15", "PB16", "PB17";
+				allwinner,function = "spi2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			spi2_pins_b: spi2@1 {
+				allwinner,pins = "PC19", "PC20", "PC21", "PC22";
+				allwinner,function = "spi2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer@01c20c00 {
-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
