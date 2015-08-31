From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Mediatek: Document devicetree bindings update for spi bus" to the spi tree
Date: Mon, 31 Aug 2015 15:28:31 +0100
Message-ID: <E1ZWQ4V-0000KI-0w@finisterre>
References: <1441027138-16458-4-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441027138-16458-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Mediatek: Document devicetree bindings update for spi bus

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3d4fe182003bcde778e29e84c14c0c4bb70a452e Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 31 Aug 2015 21:18:58 +0800
Subject: [PATCH] spi: Mediatek: Document devicetree bindings update for spi
 bus

This patch updates spi bindings, fixs clock usage description.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index dcefc43..6160ffb 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -15,17 +15,18 @@ Required properties:
 - interrupts: Should contain spi interrupt
 
 - clocks: phandles to input clocks.
-  The first should be <&topckgen CLK_TOP_SPI_SEL>.
-  The second should be one of the following.
+  The first should be one of the following. It's PLL.
    -  <&clk26m>: specify parent clock 26MHZ.
    -  <&topckgen CLK_TOP_SYSPLL3_D2>: specify parent clock 109MHZ.
 				      It's the default one.
    -  <&topckgen CLK_TOP_SYSPLL4_D2>: specify parent clock 78MHZ.
    -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
    -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+  The second should be <&topckgen CLK_TOP_SPI_SEL>. It's clock mux.
+  The third is <&pericfg CLK_PERI_SPI0>. It's clock gate.
 
-- clock-names: shall be "spi-clk" for the controller clock, and
-  "parent-clk" for the parent clock.
+- clock-names: shall be "parent-clk" for the parent clock, "sel-clk" for the
+  muxes clock, and "spi-clk" for the clock gate.
 
 Optional properties:
 - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
@@ -44,8 +45,11 @@ spi: spi@1100a000 {
 	#size-cells = <0>;
 	reg = <0 0x1100a000 0 0x1000>;
 	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
-	clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
-	clock-names = "spi-clk", "parent-clk";
+	clocks = <&topckgen CLK_TOP_SYSPLL3_D2>,
+		 <&topckgen CLK_TOP_SPI_SEL>,
+		 <&pericfg CLK_PERI_SPI0>;
+	clock-names = "parent-clk", "sel-clk", "spi-clk";
+
 	mediatek,pad-select = <0>;
 	status = "disabled";
 };
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
