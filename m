From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] spi: SPI_FSL_DSPI should depend on HAS_DMA
Date: Wed, 14 Dec 2016 13:28:05 +0100
Message-ID: <1481718485-6966-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Brown <broonie@kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/spi/spi-fsl-dspi.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cb6c7def29b26f15..f5c7915a23bc2417 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -378,6 +378,7 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
+	depends on HAS_DMA
 	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
-- 
1.9.1
