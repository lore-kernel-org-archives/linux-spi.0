From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: bcm2835: Remove duplicate depend on GPIOLIB in Kconfig
Date: Sat, 13 Feb 2016 23:46:10 +0800
Message-ID: <1455378370.20150.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d71abc7..533fe2da0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -95,7 +95,6 @@ config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on GPIOLIB
 	depends on ARCH_BCM2835 || COMPILE_TEST
-	depends on GPIOLIB
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI master.
 
-- 
2.1.4



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
