From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "- filename      : spi-Add-DSPI-support-for-layerscape-family.patch
Date: Fri, 30 Oct 2015 10:43:38 +0900
Message-ID: <E1ZryjC-0000CO-8H@finisterre>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

- name          : spi: Add DSPI support for layerscape family" to the spi tree
In-Reply-To:  <1446025319-44125-1-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

The patch

   - filename      : spi-Add-DSPI-support-for-layerscape-family.patch
- name          : spi: Add DSPI support for layerscape family

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

>From 5a60adafb95263d63dfaaf7168680c4b7e50b370 Mon Sep 17 00:00:00 2001
From: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Date: Wed, 28 Oct 2015 17:41:59 +0800
Subject: [PATCH] spi: Add DSPI support for layerscape family

LS1043a and LS2080A in the Layerscape family also support DSPI, make
DSPI selectable for these hardwares.

Signed-off-by: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4887f31..bb41bd5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -304,7 +304,7 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
-	depends on SOC_VF610 || SOC_LS1021A || COMPILE_TEST
+	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
 	  mode. VF610 platform uses the controller.
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
