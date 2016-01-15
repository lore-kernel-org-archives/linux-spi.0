From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Remove CONFIG_SPI_PXA2XX_DMA" to the spi tree
Date: Fri, 15 Jan 2016 18:19:16 +0000
Message-ID: <E1aK8xw-0005ZR-Ud@debutante>
References: <1452694807-29304-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452694807-29304-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Remove CONFIG_SPI_PXA2XX_DMA

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 22a33632fb607a18148815548478265a672d5295 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Wed, 13 Jan 2016 16:20:07 +0200
Subject: [PATCH] spi: pxa2xx: Remove CONFIG_SPI_PXA2XX_DMA

After removal of legacy PXA DMA code by the commit 6356437e65c2
("spi: spi-pxa2xx: remove legacy PXA DMA bits") the
CONFIG_SPI_PXA2XX_DMA follows the CONFIG_SPI_PXA2XX and cannot be disabled
alone. Therefore remove this config symbol and dead definitions from the
spi-pxa2xx.h.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig      |  4 ----
 drivers/spi/Makefile     |  3 +--
 drivers/spi/spi-pxa2xx.h | 35 -----------------------------------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8b9c2a38d1cc..c0604aecf45f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -415,10 +415,6 @@ config SPI_PPC4xx
 	help
 	  This selects a driver for the PPC4xx SPI Controller.
 
-config SPI_PXA2XX_DMA
-	def_bool y
-	depends on SPI_PXA2XX
-
 config SPI_PXA2XX
 	tristate "PXA2xx SSP SPI master"
 	depends on (ARCH_PXA || PCI || ACPI)
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 31fb7fb2a0b6..13cee44ec94d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -61,8 +61,7 @@ obj-$(CONFIG_SPI_TI_QSPI)		+= spi-ti-qspi.o
 obj-$(CONFIG_SPI_ORION)			+= spi-orion.o
 obj-$(CONFIG_SPI_PL022)			+= spi-pl022.o
 obj-$(CONFIG_SPI_PPC4xx)		+= spi-ppc4xx.o
-spi-pxa2xx-platform-objs		:= spi-pxa2xx.o
-spi-pxa2xx-platform-$(CONFIG_SPI_PXA2XX_DMA)	+= spi-pxa2xx-dma.o
+spi-pxa2xx-platform-objs		:= spi-pxa2xx.o spi-pxa2xx-dma.o
 obj-$(CONFIG_SPI_PXA2XX)		+= spi-pxa2xx-platform.o
 obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 58efa98313aa..8e781c8b4374 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -147,20 +147,9 @@ static inline void write_SSSR_CS(struct driver_data *drv_data, u32 val)
 extern int pxa2xx_spi_flush(struct driver_data *drv_data);
 extern void *pxa2xx_spi_next_transfer(struct driver_data *drv_data);
 
-/*
- * Select the right DMA implementation.
- */
-#if defined(CONFIG_SPI_PXA2XX_DMA)
-#define SPI_PXA2XX_USE_DMA	1
 #define MAX_DMA_LEN		SZ_64K
 #define DEFAULT_DMA_CR1		(SSCR1_TSRE | SSCR1_RSRE | SSCR1_TRAIL)
-#else
-#undef SPI_PXA2XX_USE_DMA
-#define MAX_DMA_LEN		0
-#define DEFAULT_DMA_CR1		0
-#endif
 
-#ifdef SPI_PXA2XX_USE_DMA
 extern bool pxa2xx_spi_dma_is_possible(size_t len);
 extern int pxa2xx_spi_map_dma_buffers(struct driver_data *drv_data);
 extern irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data);
@@ -173,29 +162,5 @@ extern int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 						  u8 bits_per_word,
 						  u32 *burst_code,
 						  u32 *threshold);
-#else
-static inline bool pxa2xx_spi_dma_is_possible(size_t len) { return false; }
-static inline int pxa2xx_spi_map_dma_buffers(struct driver_data *drv_data)
-{
-	return 0;
-}
-#define pxa2xx_spi_dma_transfer NULL
-static inline void pxa2xx_spi_dma_prepare(struct driver_data *drv_data,
-					  u32 dma_burst) {}
-static inline void pxa2xx_spi_dma_start(struct driver_data *drv_data) {}
-static inline int pxa2xx_spi_dma_setup(struct driver_data *drv_data)
-{
-	return 0;
-}
-static inline void pxa2xx_spi_dma_release(struct driver_data *drv_data) {}
-static inline int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
-							 struct spi_device *spi,
-							 u8 bits_per_word,
-							 u32 *burst_code,
-							 u32 *threshold)
-{
-	return -ENODEV;
-}
-#endif
 
 #endif /* SPI_PXA2XX_H */
-- 
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
