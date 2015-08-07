From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Mediatek: Document devicetree bindings for spi bus" to the spi tree
Date: Fri, 07 Aug 2015 14:36:10 +0100
Message-ID: <E1ZNhog-00059I-AV@finisterre>
References: <1438931991-17044-2-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438931991-17044-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Mediatek: Document devicetree bindings for spi bus

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

>From 0d850e7cdc69962e85abd7f7dcd2359f293f835a Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Fri, 7 Aug 2015 15:19:49 +0800
Subject: [PATCH] spi: Mediatek: Document devicetree bindings for spi bus

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
new file mode 100644
index 0000000..dcefc43
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -0,0 +1,51 @@
+Binding for MTK SPI controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt6589-spi: for mt6589 platforms
+
+- #address-cells: should be 1.
+
+- #size-cells: should be 0.
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clocks: phandles to input clocks.
+  The first should be <&topckgen CLK_TOP_SPI_SEL>.
+  The second should be one of the following.
+   -  <&clk26m>: specify parent clock 26MHZ.
+   -  <&topckgen CLK_TOP_SYSPLL3_D2>: specify parent clock 109MHZ.
+				      It's the default one.
+   -  <&topckgen CLK_TOP_SYSPLL4_D2>: specify parent clock 78MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+
+- clock-names: shall be "spi-clk" for the controller clock, and
+  "parent-clk" for the parent clock.
+
+Optional properties:
+- mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
+  controller used, this value should be 0~3, only required for MT8173.
+    0: specify GPIO69,70,71,72 for spi pins.
+    1: specify GPIO102,103,104,105 for spi pins.
+    2: specify GPIO128,129,130,131 for spi pins.
+    3: specify GPIO5,6,7,8 for spi pins.
+
+Example:
+
+- SoC Specific Portion:
+spi: spi@1100a000 {
+	compatible = "mediatek,mt8173-spi";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0 0x1100a000 0 0x1000>;
+	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&topckgen CLK_TOP_SPI_SEL>, <&topckgen CLK_TOP_SYSPLL3_D2>;
+	clock-names = "spi-clk", "parent-clk";
+	mediatek,pad-select = <0>;
+	status = "disabled";
+};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
