From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
Date: Mon,  9 Mar 2020 16:56:23 +0200
Message-ID: <20200309145624.10026-6-olteanv@gmail.com>
References: <20200309145624.10026-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org,
        andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
        mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael-QKn5cuLxLXY@public.gmane.org, peng.ma-3arQi8VN3Tc@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200309145624.10026-1-olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

LS1028A has a functional connection to the eDMA module. Even if the
spi-fsl-dspi.c driver is not using DMA for LS1028A now, define the slots
in the DMAMUX for connecting the eDMA channels to the 3 DSPI
controllers.

Signed-off-by: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 515e0a1b934f..18155273a46e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -298,6 +298,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 62>, <&edma0 0 60>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
 			little-endian;
 			status = "disabled";
@@ -311,6 +313,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 58>, <&edma0 0 56>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <4>;
 			little-endian;
 			status = "disabled";
@@ -324,6 +328,8 @@
 			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&clockgen 4 1>;
+			dmas = <&edma0 0 54>, <&edma0 0 2>;
+			dma-names = "tx", "rx";
 			spi-num-chipselects = <3>;
 			little-endian;
 			status = "disabled";
-- 
2.17.1
