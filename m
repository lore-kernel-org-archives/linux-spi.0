From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: s3c64xx: Allow driver to build if COMPILE_TEST is enabled" to the spi tree
Date: Wed, 09 Nov 2016 15:00:23 +0000
Message-ID: <E1c4UMR-0002n6-UR@finisterre>
References: <1478551612-5110-1-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478551612-5110-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: s3c64xx: Allow driver to build if COMPILE_TEST is enabled

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

>From b099b1319d581243402d8dc56b4237d9928d00ca Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Mon, 7 Nov 2016 17:46:52 -0300
Subject: [PATCH] spi: s3c64xx: Allow driver to build if COMPILE_TEST is
 enabled

The driver only has runtime but no build time dependency with PLAT_SAMSUNG
|| ARCH_EXYNOS so it can be built for testing purposes if the COMPILE_TEST
option is enabled.

This is useful to have more build coverage and make sure that the driver
is not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b7995474148c..68910915ca49 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -553,7 +553,7 @@ config SPI_S3C24XX_FIQ
 
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
-	depends on (PLAT_SAMSUNG || ARCH_EXYNOS)
+	depends on (PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST)
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
 
-- 
2.10.2
