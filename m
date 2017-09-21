From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH -next] spi: fix spi-sprd-adi build errors when COMPILE_TEST=y
Date: Thu, 21 Sep 2017 09:10:04 -0700
Message-ID: <1e21f485-7f06-0566-afd4-74f2bfc9606e@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Baolin Wang <Baolin.Wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Fix build errors when CONFIG_HWSPINLOCK=m.

This patch fixes the build errors when COMPILE_TEST=y,
but I expect that this driver also wants HWSPINLOCK_SPRD=y (or =m
when SPI_SPRD_ADI=m).

drivers/spi/spi-sprd-adi.o: In function `sprd_adi_remove':
spi-sprd-adi.c:(.text+0x13): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_probe':
spi-sprd-adi.c:(.text+0xf5): undefined reference to `of_hwspin_lock_get_id'
spi-sprd-adi.c:(.text+0x107): undefined reference to `hwspin_lock_request_specific'
spi-sprd-adi.c:(.text+0x22e): undefined reference to `hwspin_lock_free'
drivers/spi/spi-sprd-adi.o: In function `sprd_adi_transfer_one':
spi-sprd-adi.c:(.text+0x2eb): undefined reference to `__hwspin_lock_timeout'
spi-sprd-adi.c:(.text+0x349): undefined reference to `__hwspin_unlock'
spi-sprd-adi.c:(.text+0x389): undefined reference to `__hwspin_lock_timeout'
spi-sprd-adi.c:(.text+0x3ee): undefined reference to `__hwspin_unlock'

Signed-off-by: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Baolin Wang <Baolin.Wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/spi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20170921.orig/drivers/spi/Kconfig
+++ linux-next-20170921/drivers/spi/Kconfig
@@ -625,6 +625,7 @@ config SPI_SIRF
 config SPI_SPRD_ADI
 	tristate "Spreadtrum ADI controller"
 	depends on ARCH_SPRD || COMPILE_TEST
+	depends on HWSPINLOCK
 	help
 	  ADI driver based on SPI for Spreadtrum SoCs.
 


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
