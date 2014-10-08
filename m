From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv2] arm: dts: socfpga: Add SPI nodes to SOCFPGA DT.
Date: Wed, 8 Oct 2014 14:27:08 -0500
Message-ID: <1412796428-3255-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	<mark.rutland-5wv7dgnIgG8@public.gmane.org>, <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Add 2 SPI nodes to SOCFPGA device tree.

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
v2: Remove extra files. Move SPIDEV into board specific file.
---
 arch/arm/boot/dts/socfpga.dtsi          |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 4d77ad6..d81bc2d3 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -628,6 +628,30 @@
 			clock-names = "biu", "ciu";
 		};
 
+		spi0: spi@fff00000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xfff00000 0x1000>;
+			interrupts = <0 154 4>;
+			num-cs = <4>;
+			bus-num = <0>;
+			clocks = <&spi_m_clk>;
+			status = "disabled";
+		};
+
+		spi1: spi@fff01000 {
+			compatible = "snps,dw-apb-ssi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xfff01000 0x1000>;
+			interrupts = <0 156 4>;
+			num-cs = <4>;
+			bus-num = <1>;
+			clocks = <&spi_m_clk>;
+			status = "disabled";
+		};
+
 		/* Local timer */
 		timer@fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index bf51182..85c6b5c 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -48,5 +48,15 @@
 		sysmgr@ffd08000 {
 			cpu1-start-addr = <0xffd080c4>;
 		};
+
+		spi0: spi@fff00000 {
+			status = "okay";
+
+			spidev@0 {
+				compatible = "spidev";
+				reg = <0>;	/* chip select */
+				spi-max-frequency = <100000000>;
+			};
+		};
 	};
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
