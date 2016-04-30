From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Drop unnecessary dependencies on relaxed I/O accessors
Date: Sat, 30 Apr 2016 15:01:08 +0800
Message-ID: <1461999668.6497.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The relaxed I/O accessors are available on all architectures now.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2a357f6..8259bf7 100644
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
@@ -481,7 +480,6 @@ config SPI_PXA2XX_PCI
 
 config SPI_ROCKCHIP
 	tristate "Rockchip SPI controller driver"
-	depends on ARM || ARM64 || AVR32 || HEXAGON || MIPS || SUPERH
 	help
 	  This selects a driver for Rockchip SPI controller.
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
