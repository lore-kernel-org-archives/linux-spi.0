From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 10/12] [v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
Date: Wed,  6 Aug 2014 14:59:07 +0200
Message-ID: <1407329949-5695-11-git-send-email-geert+renesas@glider.be>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add register sets used for access by the DMA engine, and DMA properties to
the MSIOF nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
This depends on "[PATCH v2 8/8] ARM: shmobile: r8a7791: Add DMAC devices
to DT" of series "[PATCH v2 0/8] R-Car Gen2 DMA Controller driver".

v3:
  - Update DMA specifiers to match the renesas,rcar-dmac bindings,
v2:
  - Add register sets for DMA,
  - Reorder: TX first, RX second.
---
 arch/arm/boot/dts/r8a7791.dtsi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8186c9f4a18a..152c75ce8534 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1054,9 +1054,11 @@
 
 	msiof0: spi@e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1064,9 +1066,11 @@
 
 	msiof1: spi@e6e10000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
+		dmas = <&dmac0 0x55>, <&dmac0 0x56>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1074,9 +1078,11 @@
 
 	msiof2: spi@e6e00000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
+		dmas = <&dmac0 0x41>, <&dmac0 0x42>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
