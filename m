From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Use ARCH_SHMOBILE instead of SUPERH" to the spi tree
Date: Thu, 01 Sep 2016 21:35:49 +0100
Message-ID: <E1bfYiD-00033v-36@debutante>
References: <1472636225-27091-1-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1472636225-27091-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Use ARCH_SHMOBILE instead of SUPERH

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

>From 6ffc84dd1590a7af837a23c8d2c405eaa0a7faef Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 31 Aug 2016 11:37:05 +0200
Subject: [PATCH] spi: sh-msiof: Use ARCH_SHMOBILE instead of SUPERH

"spi_sh_msiof" is used on sh7723 and sh7724 only. As all of the above
select ARCH_SHMOBILE, restrict its driver dependencies from SUPERH to
ARCH_SHMOBILE.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6fb8d4b7786..056e3bada65f 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -549,7 +549,7 @@ config SPI_SC18IS602
 config SPI_SH_MSIOF
 	tristate "SuperH MSIOF SPI controller"
 	depends on HAVE_CLK && HAS_DMA
-	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
 	help
 	  SPI driver for SuperH and SH Mobile MSIOF blocks.
 
-- 
2.8.1

