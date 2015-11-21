From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: update document devicetree bindings to fix syntax error" to the spi tree
Date: Sat, 21 Nov 2015 14:03:36 +0000
Message-ID: <E1a08lM-0001Ii-TP@finisterre>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447986080-31410-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: update document devicetree bindings to fix syntax error

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

>From fbdb5d78ce7085966eb958ce8e003b1f8c2aaad4 Mon Sep 17 00:00:00 2001
From: "leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Fri, 20 Nov 2015 10:21:16 +0800
Subject: [PATCH] spi: mediatek: update document devicetree bindings to fix
 syntax error

This patch updates document devicetree bindings
to fix syntax error.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index ce363c923f..fba8334 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -32,7 +32,7 @@ Optional properties:
 -cs-gpios: see spi-bus.txt, only required for MT8173.
 
 - mediatek,pad-select: specify which pins group(ck/mi/mo/cs) spi
-  controller used. This is a array, the element value should be 0~3,
+  controller used. This is an array, the element value should be 0~3,
   only required for MT8173.
     0: specify GPIO69,70,71,72 for spi pins.
     1: specify GPIO102,103,104,105 for spi pins.
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
