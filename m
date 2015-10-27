From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: Update document devicetree bindings to support multiple devices" to the spi tree
Date: Tue, 27 Oct 2015 13:50:14 +0900
Message-ID: <E1ZqwD8-00058M-Hr@finisterre>
References: <1445846985-26229-2-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445846985-26229-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: Update document devicetree bindings to support multiple devices

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

>From eca3a1ee8dd7ec5819bd77d598044eb6ecdf4495 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 26 Oct 2015 16:09:41 +0800
Subject: [PATCH] spi: mediatek: Update document devicetree bindings to support
 multiple devices

This patch updates document devicetree bindings
to support multiple devices.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 6160ffb..ce363c923f 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -29,8 +29,11 @@ Required properties:
   muxes clock, and "spi-clk" for the clock gate.
 
 Optional properties:
+-cs-gpios: see spi-bus.txt, only required for MT8173.
+
 - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
-  controller used, this value should be 0~3, only required for MT8173.
+  controller used. This is a array, the element value should be 0~3,
+  only required for MT8173.
     0: specify GPIO69,70,71,72 for spi pins.
     1: specify GPIO102,103,104,105 for spi pins.
     2: specify GPIO128,129,130,131 for spi pins.
@@ -49,7 +52,7 @@ spi: spi@1100a000 {
 		 <&topckgen CLK_TOP_SPI_SEL>,
 		 <&pericfg CLK_PERI_SPI0>;
 	clock-names = "parent-clk", "sel-clk", "spi-clk";
-
-	mediatek,pad-select = <0>;
+	cs-gpios = <&pio 105 GPIO_ACTIVE_LOW>, <&pio 72 GPIO_ACTIVE_LOW>;
+	mediatek,pad-select = <1>, <0>;
 	status = "disabled";
 };
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
