From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: remove unnecessary bit clearing in mx51_ecspi_config" to the spi tree
Date: Fri, 26 Feb 2016 11:47:58 +0900
Message-ID: <E1aZ8Ri-0006ZN-Li@finisterre>
References: <1455715739-25161-10-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455715739-25161-10-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: remove unnecessary bit clearing in mx51_ecspi_config

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

>From c34de7168cd201ab757b11bfc7899953948d7753 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Wed, 24 Feb 2016 09:20:30 +0100
Subject: [PATCH] spi: imx: remove unnecessary bit clearing in
 mx51_ecspi_config

This reverts patch 1476253cef (spi: imx: fix ecspi mode setup)
The patch tried to fix something by clearing bits in the cfg variable,
but cfg is initialized to zero on function entry. There are no bits to
clear.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 15b23f0b83e8..287ec0cb6992 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -366,20 +366,13 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
-	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
 	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
-	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
 	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
-	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
 	/* CTRL register always go first to bring out controller from reset */
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
