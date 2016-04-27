From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Update DT binding documentation" to the spi tree
Date: Wed, 27 Apr 2016 17:35:29 +0100
Message-ID: <E1avSQz-0004dl-En@debutante>
References: <1461744756-31481-3-git-send-email-yao.yuan@freescale.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yao.yuan-3arQi8VN3Tc@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org,
	scott.wood-3arQi8VN3Tc@public.gmane.org
To: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461744756-31481-3-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Update DT binding documentation

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

>From c145344763192042135ef6172b779baaf4a16c1e Mon Sep 17 00:00:00 2001
From: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Date: Wed, 27 Apr 2016 16:12:36 +0800
Subject: [PATCH] spi: spi-fsl-dspi: Update DT binding documentation

DSPI driver support the register on the controller with big endian
mode R/W. But not use the regmap API.
So update the binding documentation for "big-endian".

Signed-off-by: Yuan Yao <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index fa77f874e321..d2969d2ceb4b 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -13,8 +13,7 @@ Required properties:
 
 Optional property:
 - big-endian: If present the dspi device's registers are implemented
-  in big endian mode, otherwise in native mode(same with CPU), for more
-  detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
+  in big endian mode.
 
 Optional SPI slave node properties:
 - fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
-- 
2.8.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
