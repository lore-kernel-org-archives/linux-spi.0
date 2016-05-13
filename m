From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: [PATCH] spi: pic32-sqi: Fix linker error, undefined reference to `bad_dma_ops'.
Date: Fri, 13 May 2016 14:12:53 +0530
Message-ID: <1463128973-29831-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <kbuild-all-JC7UmRfGjtg@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Even if DMA support is disabled code using DMA mapping APIs compiles fine,
but fails in linking.
-------
drivers/built-in.o: In function `ring_desc_ring_free':
spi-pic32-sqi.c:(.text+0x2cfbe0): undefined reference to `bad_dma_ops'
spi-pic32-sqi.c:(.text+0x2cfbe4): undefined reference to `bad_dma_ops'
drivers/built-in.o: In function `pic32_sqi_probe':
spi-pic32-sqi.c:(.text+0x2cfe48): undefined reference to `bad_dma_ops'
spi-pic32-sqi.c:(.text+0x2cfeb0): undefined reference to `bad_dma_ops'
spi-pic32-sqi.c:(.text+0x2cff38): undefined reference to `bad_dma_ops'
--------
Correct dependency by adding 'depends on HAS_DMA' in Kconfig.

Signed-off-by: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>

---

 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 281ed5d..0f50755 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -445,6 +445,7 @@ config SPI_PIC32
 config SPI_PIC32_SQI
 	tristate "Microchip PIC32 Quad SPI driver"
 	depends on MACH_PIC32 || COMPILE_TEST
+	depends on HAS_DMA
 	help
 	  SPI driver for PIC32 Quad SPI controller.
 
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
