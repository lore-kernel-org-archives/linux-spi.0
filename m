From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] ARM: sti: Provide DT nodes for SBC SSC[0..2]
Date: Thu, 27 Nov 2014 11:43:56 +0000
Message-ID: <1417088636-11994-5-git-send-email-lee.jones@linaro.org>
References: <1417088636-11994-1-git-send-email-lee.jones@linaro.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417088636-11994-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The Synchronous Serial Controller is used to provide SPI.

These are the ports which are located on the Stand-By Controller (SBC).

Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/stih407.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 245aa31..cff106d 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -329,5 +329,36 @@
 
 			status = "disabled";
 		};
+
+		/* SBC SSC */
+		spi@9540000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9540000 0x110>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_sysin>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi@9541000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9541000 0x110>;
+			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_sysin>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
+
+		spi@9542000 {
+			compatible = "st,comms-ssc-spi";
+			reg = <0x9542000 0x110>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk_sysin>;
+			clock-names = "ssc";
+
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
