From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] ARM: dts: sama5d36ek: add spi pinctrl sleep state
Date: Wed, 5 Mar 2014 09:58:50 +0800
Message-ID: <1393984730-14828-3-git-send-email-wenyou.yang@atmel.com>
References: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	<plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393984730-14828-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/sama5d36ek.dts |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
index 59576c6..676d121 100644
--- a/arch/arm/boot/dts/sama5d36ek.dts
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -18,6 +18,8 @@
 	ahb {
 		apb {
 			spi0: spi@f0004000 {
+				pinctrl-names = "default", "sleep";
+				pinctrl-1 = <&pinctrl_spi0_sleep>;
 				status = "okay";
 			};
 
@@ -44,6 +46,18 @@
 			macb1: ethernet@f802c000 {
 				status = "okay";
 			};
+
+			pinctrl@fffff200 {
+				spi0 {
+					pinctrl_spi0_sleep: spi0-1 {
+						atmel,pins =
+							<AT91_PIOD 10 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW	/* PD10 GPIO Output Low */
+							 AT91_PIOD 11 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW	/* PD11 GPIO Output Low */
+							 AT91_PIOD 12 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW>;	/* PD12 GPIO Output Low */
+					};
+				};
+
+			};
 		};
 	};
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
