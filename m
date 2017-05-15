From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: SPI_TI_QSPI should depend on HAS_DMA" to the spi tree
Date: Mon, 15 May 2017 17:04:42 +0900
Message-ID: <E1dAAzj-0002fa-01@finisterre>
References: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493883438-19462-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: SPI_TI_QSPI should depend on HAS_DMA

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

>From 967d6941f49f1ddd5764d3a09423a63841b9394c Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 May 2017 09:37:18 +0200
Subject: [PATCH] spi: SPI_TI_QSPI should depend on HAS_DMA

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/spi/spi-ti-qspi.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1761c9004fc1..097883362036 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -457,6 +457,7 @@ config SPI_OMAP24XX
 
 config SPI_TI_QSPI
 	tristate "DRA7xxx QSPI controller support"
+	depends on HAS_DMA
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  QSPI master controller for DRA7xxx used for flash devices.
-- 
2.11.0
