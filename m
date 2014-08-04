From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: [PATCH v3 7/8] ARM: sun5i: dt: enable DMA on SPI
Date: Mon,  4 Aug 2014 17:10:01 -0300
Message-ID: <1407183002-29420-8-git-send-email-emilio@elopez.com.ar>
References: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407183002-29420-1-git-send-email-emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

All of our SPI controllers support DMA transfers, so let's add the
properties here so they can be used when it's best to do so.

Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---

Changes from v2:
 * Collect tag from Chen-Yu

 arch/arm/boot/dts/sun5i-a10s.dtsi | 6 ++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5=
i-a10s.dtsi
index 8b5a27c..2ee786a 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -314,6 +314,8 @@
 			interrupts =3D <10>;
 			clocks =3D <&ahb_gates 20>, <&spi0_clk>;
 			clock-names =3D "ahb", "mod";
+			dmas =3D <&dma 1 27>, <&dma 1 26>;
+			dma-names =3D "rx", "tx";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -325,6 +327,8 @@
 			interrupts =3D <11>;
 			clocks =3D <&ahb_gates 21>, <&spi1_clk>;
 			clock-names =3D "ahb", "mod";
+			dmas =3D <&dma 1 9>, <&dma 1 8>;
+			dma-names =3D "rx", "tx";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -411,6 +415,8 @@
 			interrupts =3D <12>;
 			clocks =3D <&ahb_gates 22>, <&spi2_clk>;
 			clock-names =3D "ahb", "mod";
+			dmas =3D <&dma 1 29>, <&dma 1 28>;
+			dma-names =3D "rx", "tx";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i=
-a13.dtsi
index 139f4ac..6e0823b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -312,6 +312,8 @@
 			interrupts =3D <10>;
 			clocks =3D <&ahb_gates 20>, <&spi0_clk>;
 			clock-names =3D "ahb", "mod";
+			dmas =3D <&dma 1 27>, <&dma 1 26>;
+			dma-names =3D "rx", "tx";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -323,6 +325,8 @@
 			interrupts =3D <11>;
 			clocks =3D <&ahb_gates 21>, <&spi1_clk>;
 			clock-names =3D "ahb", "mod";
+			dmas =3D <&dma 1 9>, <&dma 1 8>;
+			dma-names =3D "rx", "tx";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
@@ -384,6 +388,8 @@
 			interrupts =3D <12>;
 			clocks =3D <&ahb_gates 22>, <&spi2_clk>;
 			clock-names =3D "ahb", "mod";
+			dmas =3D <&dma 1 29>, <&dma 1 28>;
+			dma-names =3D "rx", "tx";
 			status =3D "disabled";
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
--=20
2.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
