From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH resend 1/5] spi: bcm2835: Add GPIOLIB dependency
Date: Mon,  4 May 2015 15:30:45 -0700
Message-ID: <1430778649-28126-2-git-send-email-linux@roeck-us.net>
References: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
Cc: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Yes, I know, this patch is in -next. Please see this e-mail as gentle reminder
to consider pushing it (or one of the other patches fixing the same problem)
into mainline. 

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
