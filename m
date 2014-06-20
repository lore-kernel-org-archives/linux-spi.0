From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC 2/2] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
Date: Fri, 20 Jun 2014 12:20:38 +0200
Message-ID: <1403259638-13774-3-git-send-email-geert+renesas@glider.be>
References: <1403259638-13774-1-git-send-email-geert+renesas@glider.be>
Cc: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403259638-13774-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add register sets used for access by the DMA engine, and DMA properties to
the MSIOF nodes.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
The format of the DMA specifiers depends on the DT bindings for SHDMA,
which are still under development.

This patch has been sent before as part of the series "[PATCH/RFC 0/7] ARM:
shmobile: r8a7791: Add preliminary DMA support". Changes:
  - Add register sets for DMA,
  - Reorder: TX first, RX second.

 arch/arm/boot/dts/r8a7791.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 98fdd88462e2..1f8a4605e1e3 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1005,9 +1005,12 @@
 
 	msiof0: spi@e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+		dmas = <&dma0 R8A7791_DMA_MSIOF0_TX CHCR_TX_32BIT>,
+		       <&dma0 R8A7791_DMA_MSIOF0_RX CHCR_RX_32BIT>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1015,9 +1018,12 @@
 
 	msiof1: spi@e6e10000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
+		dmas = <&dma0 R8A7791_DMA_MSIOF1_TX CHCR_TX_32BIT>,
+		       <&dma0 R8A7791_DMA_MSIOF1_RX CHCR_RX_32BIT>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -1025,9 +1031,12 @@
 
 	msiof2: spi@e6e00000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
+		dmas = <&dma0 R8A7791_DMA_MSIOF2_TX CHCR_TX_32BIT>,
+		       <&dma0 R8A7791_DMA_MSIOF2_RX CHCR_RX_32BIT>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
