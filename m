From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] spi: SPI_ZYNQMP_GQSPI should depend on HAS_DMA
Date: Fri, 26 Jun 2015 14:07:12 +0200
Message-ID: <1435320432-4855-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If NO_DMA=y:

    ERROR: "dma_unmap_single" [drivers/spi/spi-zynqmp-gqspi.ko] undefined!
    ERROR: "dma_mapping_error" [drivers/spi/spi-zynqmp-gqspi.ko] undefined!
    ERROR: "dma_map_single" [drivers/spi/spi-zynqmp-gqspi.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1c0b261b66fcfdcb..b787b515bd73322b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -618,7 +618,7 @@ config SPI_XTENSA_XTFPGA
 
 config SPI_ZYNQMP_GQSPI
 	tristate "Xilinx ZynqMP GQSPI controller"
-	depends on SPI_MASTER
+	depends on SPI_MASTER && HAS_DMA
 	help
 	  Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
