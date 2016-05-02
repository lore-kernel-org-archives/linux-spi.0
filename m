From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Drop unnecessary dependencies on relaxed I/O accessors" to the spi tree
Date: Mon, 02 May 2016 16:47:18 +0100
Message-ID: <E1axG46-0005PO-7R@debutante>
References: <1461999668.6497.2.camel@ingics.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461999668.6497.2.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Drop unnecessary dependencies on relaxed I/O accessors

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

>From 46cb41534a1a1d1f75aae5eab0dd8c06a9461e6b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Date: Sat, 30 Apr 2016 15:01:08 +0800
Subject: [PATCH] spi: Drop unnecessary dependencies on relaxed I/O accessors

The relaxed I/O accessors are available on all architectures now.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9d8c84bb1544..28147c8031c6 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -410,7 +410,6 @@ config SPI_OMAP_UWIRE
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
 	depends on HAS_DMA
-	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
@@ -469,7 +468,6 @@ config SPI_PXA2XX_PCI
 
 config SPI_ROCKCHIP
 	tristate "Rockchip SPI controller driver"
-	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH
 	help
 	  This selects a driver for Rockchip SPI controller.
 
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
