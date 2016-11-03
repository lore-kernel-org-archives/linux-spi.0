From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sun6i: Add binding for Allwinner H3 SPI controller" to the spi tree
Date: Thu, 03 Nov 2016 09:42:56 -0600
Message-ID: <E1c2KAK-0000CV-Ad@finisterre>
References: <20161019140234.13518-2-woogyom.kim@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-spi@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019140234.13518-2-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sun6i: Add binding for Allwinner H3 SPI controller

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

>From 8ea7ce9cc6dec26db22a97f00523a4bfd3a97d72 Mon Sep 17 00:00:00 2001
From: Milo Kim <woogyom.kim@gmail.com>
Date: Fri, 28 Oct 2016 15:54:11 +0900
Subject: [PATCH] spi: sun6i: Add binding for Allwinner H3 SPI controller

H3 SPI has same architecture as A31 except FIFO capacity.
To configure the buffer size separately, compatible property should be
different. Optional DMA specifiers and example are added.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-sun6i.txt          | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
index 21de73db6a05..2ec99b86b622 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
@@ -1,7 +1,7 @@
-Allwinner A31 SPI controller
+Allwinner A31/H3 SPI controller
 
 Required properties:
-- compatible: Should be "allwinner,sun6i-a31-spi".
+- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
 - reg: Should contain register location and length.
 - interrupts: Should contain interrupt.
 - clocks: phandle to the clocks feeding the SPI controller. Two are
@@ -12,6 +12,11 @@ Required properties:
 - resets: phandle to the reset controller asserting this device in
           reset
 
+Optional properties:
+- dmas: DMA specifiers for rx and tx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request names should include "rx" and "tx" if present.
+
 Example:
 
 spi1: spi@01c69000 {
@@ -22,3 +27,19 @@ spi1: spi@01c69000 {
 	clock-names = "ahb", "mod";
 	resets = <&ahb1_rst 21>;
 };
+
+spi0: spi@01c68000 {
+	compatible = "allwinner,sun8i-h3-spi";
+	reg = <0x01c68000 0x1000>;
+	interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+	clock-names = "ahb", "mod";
+	dmas = <&dma 23>, <&dma 23>;
+	dma-names = "rx", "tx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi0_pins>;
+	resets = <&ccu RST_BUS_SPI0>;
+	status = "disabled";
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
2.10.1
