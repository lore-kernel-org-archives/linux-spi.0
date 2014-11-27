From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] ARM: sti: Provide DT nodes for SSC[0..4]
Date: Thu, 27 Nov 2014 11:43:55 +0000
Message-ID: <1417088636-11994-4-git-send-email-lee.jones@linaro.org>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417088636-11994-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Synchronous Serial Controller is used to provide SPI.

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/stih407.dtsi | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 50637f5..245aa31 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -275,5 +275,59 @@
 
 			status = "disabled";
 		};
+
+		spi@9840000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9840000 0x110>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+			pinctrl-0 = <&pinctrl_spi0_default>;
+			pinctrl-names = "default";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		spi@9841000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9841000 0x110>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi@9842000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9842000 0x110>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi@9843000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9843000 0x110>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi@9844000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9844000 0x110>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
