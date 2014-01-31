From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 4/5] ARM: sun6i: dt: Add SPI controllers to
 the A31 DTSI
Date: Fri, 31 Jan 2014 11:55:51 +0100
Message-ID: <1391165752-1819-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBR4EV2LQKGQEGEX7U3Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1391165752-1819-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

The A31 has 4 SPI controllers. Add them in the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 0eea325..57af66f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -340,6 +340,46 @@
 			status = "disabled";
 		};
 
+		spi0: spi@01c68000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <0 65 4>;
+			clocks = <&ahb1_gates 20>, <&spi0_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 20>;
+			status = "disabled";
+		};
+
+		spi1: spi@01c69000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c69000 0x1000>;
+			interrupts = <0 66 4>;
+			clocks = <&ahb1_gates 21>, <&spi1_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 21>;
+			status = "disabled";
+		};
+
+		spi2: spi@01c6a000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c6a000 0x1000>;
+			interrupts = <0 67 4>;
+			clocks = <&ahb1_gates 22>, <&spi2_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 22>;
+			status = "disabled";
+		};
+
+		spi3: spi@01c6b000 {
+			compatible = "allwinner,sun6i-a31-spi";
+			reg = <0x01c6b000 0x1000>;
+			interrupts = <0 68 4>;
+			clocks = <&ahb1_gates 23>, <&spi3_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 23>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
1.8.4.2
