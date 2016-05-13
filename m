From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32-sqi: Fix linker error, undefined reference to `bad_dma_ops'." to the spi tree
Date: Fri, 13 May 2016 13:38:17 +0100
Message-ID: <E1b1CMD-00007G-PH@finisterre>
References: <1463128973-29831-1-git-send-email-purna.mandal@microchip.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463128973-29831-1-git-send-email-purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32-sqi: Fix linker error, undefined reference to `bad_dma_ops'.

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

>From 21825ff11d683fa2fc0f5668cc2ec0a0652ee64b Mon Sep 17 00:00:00 2001
From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Date: Fri, 13 May 2016 14:12:53 +0530
Subject: [PATCH] spi: pic32-sqi: Fix linker error, undefined reference to
 `bad_dma_ops'.

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
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 281ed5da4832..0f507552ed3e 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
