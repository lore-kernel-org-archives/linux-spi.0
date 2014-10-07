From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCH 2/2] arm: dts: socfpga: Add SPI nodes & update copyright.
Date: Tue, 7 Oct 2014 14:48:17 -0500
Message-ID: <1412711297-31857-3-git-send-email-tthayer@opensource.altera.com>
References: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412711297-31857-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Add 2 SPI nodes to SOCFPGA device tree. Update copyright.
Update spi-dw.txt with bus-num as an optional property.

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
 arch/arm/boot/dts/socfpga.dtsi                   |   52 ++++++++++++++++++----
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
index 7b63ed6..f1d54e6 100644
--- a/Documentation/devicetree/bindings/spi/spi-dw.txt
+++ b/Documentation/devicetree/bindings/spi/spi-dw.txt
@@ -11,6 +11,7 @@ Required properties:
 
 Optional properties:
 - cs-gpios: see spi-bus.txt
+- bus-num: see spi-bus.txt
 
 Example:
 
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 4d77ad6..42855bc 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -1,15 +1,14 @@
 /*
- *  Copyright (C) 2012 Altera <www.altera.com>
+ * Copyright Altera Corporation (C) 2012-2014. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
+ * it under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
  *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
@@ -628,6 +627,43 @@
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
+			clocks = <&per_base_clk>;
+
+			spidev@0 {
+				compatible = "spidev";
+				reg = <0>;	/* chip select */
+				spi-max-frequency = <100000000>;
+				enable-dma = <1>;
+			};
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
+			clocks = <&per_base_clk>;
+			status = "disabled";
+
+			spidev@0 {
+				compatible = "spidev";
+				reg = <0>;
+				spi-max-frequency = <100000000>;
+				enable-dma = <1>;
+			};
+		};
+
 		/* Local timer */
 		timer@fffec600 {
 			compatible = "arm,cortex-a9-twd-timer";
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
