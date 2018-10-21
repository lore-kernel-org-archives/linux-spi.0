From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs" to the spi tree
Date: Sun, 21 Oct 2018 13:09:15 +0200 (CEST)
Message-ID: <20181021110915.A57A6440078@finisterre.ee.mobilebroadband>
References: <20181019181233.10227-1-f.fainelli@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        jonas.gorski@gmail.com, Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019181233.10227-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 79a15f4974ce9613134648e6e1dd0eb7ca199de6 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 19 Oct 2018 11:12:32 -0700
Subject: [PATCH] spi: Allow building SPI_BCM63XX_HSSPI on ARM-based SoCs

ARM-based 63xx DSL platforms have the spi-bcm63xx-hsspi controller
present, allow using this driver there as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 71851d00f47d..f756450a8914 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -129,7 +129,7 @@ config SPI_BCM63XX
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
-	depends on BCM63XX || COMPILE_TEST
+	depends on BCM63XX || ARCH_BCM_63XX || COMPILE_TEST
 	help
 	  This enables support for the High Speed SPI controller present on
 	  newer Broadcom BCM63XX SoCs.
-- 
2.19.0
