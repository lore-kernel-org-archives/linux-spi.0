From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: spreadtrum adi: add hwspinlock dependency
Date: Thu,  5 Oct 2017 14:11:17 +0200
Message-ID: <20171005121129.531046-1-arnd@arndb.de>
Cc: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>,
        Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

With CONFIG_HWSPINLOCK=m, the new driver fails to link as a built-in driver:

drivers/spi/spi-sprd-adi.o: In function `sprd_adi_remove':
spi-sprd-adi.c:(.text+0x18): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_probe':
spi-sprd-adi.c:(.text+0xfc): undefined reference to `of_hwspin_lock_get_id'
spi-sprd-adi.c:(.text+0x108): undefined reference to `hwspin_lock_request_specific'
spi-sprd-adi.c:(.text+0x268): undefined reference to `hwspin_lock_free'

This adds a hard Kconfig dependency on HWSPINLOCK, which is the
simplest solution since we don't care about building for the case
without HWSPINLOCK.

Fixes: 7e2903cb91df ("spi: Add ADI driver for Spreadtrum platform")
Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2d9601e3a6ae..e2bd86826d44 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -625,6 +625,7 @@ config SPI_SIRF
 config SPI_SPRD_ADI
 	tristate "Spreadtrum ADI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HWSPINLOCK
 	help
 	  ADI driver based on SPI for Spreadtrum SoCs.
 
-- 
2.9.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
