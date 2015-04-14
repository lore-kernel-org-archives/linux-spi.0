From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] spi: bcm2835: Add GPIOLIB dependency
Date: Mon, 13 Apr 2015 21:24:48 -0700
Message-ID: <1428985488-3811-1-git-send-email-linux@roeck-us.net>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix:

drivers/spi/spi-bcm2835.c: In function 'chip_match_name':
drivers/spi/spi-bcm2835.c:356:21: error:
			dereferencing pointer to incomplete type
drivers/spi/spi-bcm2835.c: In function 'bcm2835_spi_setup':
drivers/spi/spi-bcm2835.c:382:2: error:
	`		implicit declaration of function 'gpiochip_find'
drivers/spi/spi-bcm2835.c:387:21: error:
			dereferencing pointer to incomplete type

by adding the now mandatory GPIOLIB dependency.

Fixes: a30a555d7435 ("spi: bcm2835: transform native-cs to gpio-cs
	on first spi_setup")
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 198f96b7fb45..a132180a9251 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -78,6 +78,7 @@ config SPI_ATMEL
 config SPI_BCM2835
 	tristate "BCM2835 SPI controller"
 	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on GPIOLIB
 	help
 	  This selects a driver for the Broadcom BCM2835 SPI master.
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
