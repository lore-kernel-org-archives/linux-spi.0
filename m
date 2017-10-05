From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spreadtrum adi: add hwspinlock dependency" to the spi tree
Date: Thu, 05 Oct 2017 21:59:27 +0100
Message-ID: <E1e0DEt-0007Am-0T@debutante>
References: <20171005203949.3227075-1-arnd@arndb.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171005203949.3227075-1-arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spreadtrum adi: add hwspinlock dependency

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

>From e83f374247c310bc558c8626fbfcc03f22f9bf02 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Date: Thu, 5 Oct 2017 22:39:37 +0200
Subject: [PATCH] spi: spreadtrum adi: add hwspinlock dependency

With CONFIG_HWSPINLOCK=m, the new driver fails to link as a built-in driver:

drivers/spi/spi-sprd-adi.o: In function `sprd_adi_remove':
spi-sprd-adi.c:(.text+0x18): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_probe':
spi-sprd-adi.c:(.text+0xfc): undefined reference to `of_hwspin_lock_get_id'
spi-sprd-adi.c:(.text+0x108): undefined reference to `hwspin_lock_request_specific'
spi-sprd-adi.c:(.text+0x268): undefined reference to `hwspin_lock_free'

This adds a hard Kconfig dependency on HWSPINLOCK for the !COMPILE_TEST
case, and allows compile-testing with HWSPINLOCK completely disabled,
which will then rely on the existing stub API.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0c38a5bfcd74..2c96f744352b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -629,6 +629,7 @@ config SPI_SIRF
 config SPI_SPRD_ADI
 	tristate "Spreadtrum ADI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HWSPINLOCK || (COMPILE_TEST && !HWSPINLOCK)
 	help
 	  ADI driver based on SPI for Spreadtrum SoCs.
 
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
