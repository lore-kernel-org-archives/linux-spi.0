From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 4/7] ARM: dt: sun5i: Add A10s SPI controller nodes
Date: Sat, 22 Feb 2014 22:35:56 +0100
Message-ID: <1393104959-12831-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBNFSUSMAKGQEVTS2WJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393104959-12831-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

The A10s has 3 SPI controllers compatible with the one found in the A10. Add
them in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index df90a29..b2cb5dc 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -300,6 +300,28 @@
 		#size-cells = <1>;
 		ranges;
 
+		spi0: spi@01c05000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c05000 0x1000>;
+			interrupts = <10>;
+			clocks = <&ahb_gates 20>, <&spi0_clk>;
+			clock-names = "ahb", "mod";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@01c06000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c06000 0x1000>;
+			interrupts = <11>;
+			clocks = <&ahb_gates 21>, <&spi1_clk>;
+			clock-names = "ahb", "mod";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		emac: ethernet@01c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
@@ -316,6 +338,17 @@
 			#size-cells = <0>;
 		};
 
+		spi2: spi@01c17000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c17000 0x1000>;
+			interrupts = <12>;
+			clocks = <&ahb_gates 22>, <&spi2_clk>;
+			clock-names = "ahb", "mod";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		intc: interrupt-controller@01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
-- 
1.9.0
