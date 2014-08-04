From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Subject: [PATCH v3 4/8] ARM: sun5i: dt: Add nodes to represent the DMA controllers
Date: Mon,  4 Aug 2014 17:09:58 -0300
Message-ID: <1407183002-29420-5-git-send-email-emilio@elopez.com.ar>
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

The A10S and A13 SoCs have sun4i-compatible DMA controllers. Let's add
the corresponding nodes to represent them on the device tree.

Signed-off-by: Emilio L=C3=B3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Reviewed-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---

Changes from v2:
 * Fix whitespace
 * Collect tag from Chen-Yu

Note that I have only tested on A10S, if anyone with an A13 device coul=
d
test as well, that would be great! I don't expect any issues however.

 arch/arm/boot/dts/sun5i-a10s.dtsi | 8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5=
i-a10s.dtsi
index b64f705..8b5a27c 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -300,6 +300,14 @@
 		#size-cells =3D <1>;
 		ranges;
=20
+		dma: dma-controller@01c02000 {
+			compatible =3D "allwinner,sun4i-a10-dma";
+			reg =3D <0x01c02000 0x1000>;
+			interrupts =3D <27>;
+			clocks =3D <&ahb_gates 6>;
+			#dma-cells =3D <2>;
+		};
+
 		spi0: spi@01c05000 {
 			compatible =3D "allwinner,sun4i-a10-spi";
 			reg =3D <0x01c05000 0x1000>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i=
-a13.dtsi
index 3b2a94c..139f4ac 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -298,6 +298,14 @@
 		#size-cells =3D <1>;
 		ranges;
=20
+		dma: dma-controller@01c02000 {
+			compatible =3D "allwinner,sun4i-a10-dma";
+			reg =3D <0x01c02000 0x1000>;
+			interrupts =3D <27>;
+			clocks =3D <&ahb_gates 6>;
+			#dma-cells =3D <2>;
+		};
+
 		spi0: spi@01c05000 {
 			compatible =3D "allwinner,sun4i-a10-spi";
 			reg =3D <0x01c05000 0x1000>;
--=20
2.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
