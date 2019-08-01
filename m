From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 2/3] arm64: dts: ls1088a: Add the DSPI controller node
Date: Thu,  1 Aug 2019 16:31:04 +0800
Message-ID: <20190801083105.30102-2-chuanhua.han@nxp.com>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801083105.30102-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds the DSPI controller node for ls1088a boards.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index dacd8cf..fe8f1bd 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -252,6 +252,19 @@
 			#thermal-sensor-cells = <1>;
 		};
 
+		dspi: spi@2100000 {
+			compatible = "fsl,ls1088a-dspi",
+						"fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 1>;
+			spi-num-chipselects = <6>;
+			status = "disabled";
+		};
+
 		duart0: serial@21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-- 
2.9.5
