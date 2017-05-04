From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] spi: SPI_TI_QSPI should depend on HAS_DMA
Date: Thu,  4 May 2017 09:37:18 +0200
Message-ID: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/spi/spi-ti-qspi.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6caff35af8815cda..51bf4da6dc18e7e8 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -463,6 +463,7 @@ config SPI_OMAP24XX
 
 config SPI_TI_QSPI
 	tristate "DRA7xxx QSPI controller support"
+	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  QSPI master controller for DRA7xxx used for flash devices.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
