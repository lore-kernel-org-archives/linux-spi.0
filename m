From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/2] spi: sh-msiof: SPI_SH_MSIOF should depend on HAS_DMA
Date: Wed,  9 Jul 2014 23:27:08 +0200
Message-ID: <1404941228-9922-2-git-send-email-geert+renesas@glider.be>
References: <1404941228-9922-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404941228-9922-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If NO_DMA=y:

    drivers/built-in.o: In function `sh_msiof_release_dma':
    spi-sh-msiof.c:(.text+0x23cbfe): undefined reference to `dma_unmap_single'
    drivers/built-in.o: In function `sh_msiof_request_dma':
    spi-sh-msiof.c:(.text+0x23cd5e): undefined reference to `dma_map_single'
    spi-sh-msiof.c:(.text+0x23cd70): undefined reference to `dma_mapping_error'
    spi-sh-msiof.c:(.text+0x23cdca): undefined reference to `dma_unmap_single'
    drivers/built-in.o: In function `sh_msiof_dma_once':
    spi-sh-msiof.c:(.text+0x23d450): undefined reference to `dma_sync_single_for_cpu'
    spi-sh-msiof.c:(.text+0x23d5ea): undefined reference to `dma_sync_single_for_cpu'

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d46b4b9e73b2..ab70bca8c7e1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -446,7 +446,7 @@ config SPI_SC18IS602
 
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
-	depends on HAVE_CLK
+	depends on HAVE_CLK && HAS_DMA
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
