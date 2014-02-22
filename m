From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Kconfig: Drop default setting for SPI_IMX
Date: Sat, 22 Feb 2014 17:38:24 -0300
Message-ID: <1393101504-23302-1-git-send-email-festevam@gmail.com>
Cc: shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

SPI_IMX is selected by imx_v6_v7_defconfig/imx_v4_v5_defconfig and we don't need
to have a default setting which depends on the IMX_HAVE_PLATFORM_SPI_IMX symbol.

Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 65e420d..d9496d8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -212,7 +212,6 @@ config SPI_IMX
 	tristate "Freescale i.MX SPI controllers"
 	depends on ARCH_MXC || COMPILE_TEST
 	select SPI_BITBANG
-	default m if IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  This enables using the Freescale i.MX SPI controllers in master
 	  mode.
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
