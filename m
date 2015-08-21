From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "dt: snps,dw-apb-ssi: Document new I/O data register width property" to the spi tree
Date: Fri, 21 Aug 2015 10:26:03 -0700
Message-ID: <E1ZSq4p-0005W0-Ax@finisterre>
References: <1439929313-4948-2-git-send-email-michael@smart-africa.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439929313-4948-2-git-send-email-michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   dt: snps,dw-apb-ssi: Document new I/O data register width property

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

>From 4b226fbde68b8bfb66452067523a677b8e6492fa Mon Sep 17 00:00:00 2001
From: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Date: Tue, 18 Aug 2015 22:21:52 +0200
Subject: [PATCH] dt: snps,dw-apb-ssi: Document new I/O data register width
 property

This change documents a new property for the snps,dw-apb-ssi device,
allowing an implementer to specify either four byte or two bytes
access to the SPI controller data register.

This supports a change that unbreaks this driver on picoXcell
platforms.

Signed-off-by: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index bd99193..204b311 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
 - cs-gpios : Specifies the gpio pis to be used for chipselects.
 - num-cs : The number of chipselects. If omitted, this will default to 4.
+- reg-io-width : The I/O register width (in bytes) implemented by this
+  device.  Supported values are 2 or 4 (the default).
 
 Child nodes as per the generic SPI binding.
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
