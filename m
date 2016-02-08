From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Allow compile test of bcm2835aux if !GPIOLIB" to the spi tree
Date: Mon, 08 Feb 2016 18:01:47 +0000
Message-ID: <E1aSq8B-0002tQ-Gq@debutante>
References: <1454854349-20780-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454854349-20780-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Allow compile test of bcm2835aux if !GPIOLIB

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

>From 0697ae80fe3ccaf7d443fa5522fa7eeea34c19bb Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Date: Sun, 7 Feb 2016 15:12:29 +0100
Subject: [PATCH] spi: Allow compile test of bcm2835aux if !GPIOLIB

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency of SPI_BCM2835AUX on GPIOLIB if COMPILE_TEST is
enabled.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 77064160dd76..4e08d42a9fa1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -90,8 +90,7 @@ config SPI_BCM2835
 
 config SPI_BCM2835AUX
 	tristate "BCM2835 SPI auxiliary controller"
-	depends on ARCH_BCM2835 || COMPILE_TEST
-	depends on GPIOLIB
+	depends on (ARCH_BCM2835 && GPIOLIB) || COMPILE_TEST
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI aux master.
 
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
