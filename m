From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] spi: sirf: add reset controller dependency
Date: Wed, 18 Feb 2015 16:29:10 +0100
Message-ID: <4553005.HBquOfbqXe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The sirf spi driver only builds correctly if the reset controller
framework is available, otherwise we get an error:

drivers/spi/spi-sirf.c: In function 'spi_sirfsoc_probe':
drivers/spi/spi-sirf.c:651:2: error: implicit declaration of function 'device_reset' [-Werror=implicit-function-declaration]

The adds a dependency in Kconfig to prevent it from being selected
if the resets are not available.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Fixes:  8509c55fcb51 ("spi: sirf: reset SPI controller in init stage")

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ab8dfbef6f1b..b3ae90e4c03c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -507,6 +507,7 @@ config SPI_SH_HSPI
 config SPI_SIRF
 	tristate "CSR SiRFprimaII SPI controller"
 	depends on SIRF_DMA
+	depends on RESET_CONTROLLER
 	select SPI_BITBANG
 	help
 	  SPI driver for CSR SiRFprimaII SoCs

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
