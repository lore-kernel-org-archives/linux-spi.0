From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: remove needless pair of writel()/readl()" to the spi tree
Date: Sat, 21 Nov 2015 14:03:29 +0000
Message-ID: <E1a08lF-0001Hm-RN@finisterre>
References: <1447986080-31410-3-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447986080-31410-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: remove needless pair of writel()/readl()

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

>From 4c3dbd35d4369ddb0f0e26dd329a6aab870703e2 Mon Sep 17 00:00:00 2001
From: "leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Fri, 20 Nov 2015 10:21:18 +0800
Subject: [PATCH] spi: mediatek: remove needless pair of writel()/readl()

It's not need to re-read and re-write SPI_CMD_REG, so remove it.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 563954a..2b3fcb8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -154,9 +154,6 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 		reg_val |= SPI_CMD_CPOL;
 	else
 		reg_val &= ~SPI_CMD_CPOL;
-	writel(reg_val, mdata->base + SPI_CMD_REG);
-
-	reg_val = readl(mdata->base + SPI_CMD_REG);
 
 	/* set the mlsbx and mlsbtx */
 	if (chip_config->tx_mlsb)
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
