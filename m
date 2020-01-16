From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2 1/3] arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
Date: Thu, 16 Jan 2020 00:56:52 +0000
Message-ID: <20200116005654.27672-2-andre.przywara@arm.com>
References: <20200116005654.27672-1-andre.przywara@arm.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116005654.27672-1-andre.przywara-5wv7dgnIgG8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Allwinner H6 SoC contains two SPI controllers similar to the H3/A64,
but with the added capability of 3-wire and 4-wire operation modes.
For now the driver does not support those, but the SPI registers are
fully backwards-compatible, just adding bits and registers which were
formerly reserved. So we can use the existing driver in "legacy" SPI
modes, for instance to access the SPI NOR flash soldered on the PineH64
board.
We use an H6 specific compatible string in addition to the existing H3
string, so when the driver later gains QSPI support, it should work
automatically without any DT changes.

Tested by accessing the SPI flash on a Pine H64 board (SPI0), also
connecting another SPI flash to the SPI1 header pins.

Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 55 ++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3329283e38ab..41b58ffa8596 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -338,6 +338,31 @@
 				bias-pull-up;
 			};
 
+			/omit-if-no-ref/
+			spi0_pins: spi0-pins {
+				pins = "PC0", "PC2", "PC3";
+				function = "spi0";
+			};
+
+			/* pin shared with MMC2-CMD (eMMC) */
+			/omit-if-no-ref/
+			spi0_cs_pin: spi0-cs-pin {
+				pins = "PC5";
+				function = "spi0";
+			};
+
+			/omit-if-no-ref/
+			spi1_pins: spi1-pins {
+				pins = "PH4", "PH5", "PH6";
+				function = "spi1";
+			};
+
+			/omit-if-no-ref/
+			spi1_cs_pin: spi1-cs-pin {
+				pins = "PH3";
+				function = "spi1";
+			};
+
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PH7";
 				function = "spdif";
@@ -504,6 +529,36 @@
 			#size-cells = <0>;
 		};
 
+		spi0: spi@5010000 {
+			compatible = "allwinner,sun50i-h6-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x05010000 0x1000>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@5011000 {
+			compatible = "allwinner,sun50i-h6-spi",
+				     "allwinner,sun8i-h3-spi";
+			reg = <0x05011000 0x1000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		emac: ethernet@5020000 {
 			compatible = "allwinner,sun50i-h6-emac",
 				     "allwinner,sun50i-a64-emac";
-- 
2.14.5
