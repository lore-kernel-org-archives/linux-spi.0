From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: merge all identical compat to mtk_common_compat" to the spi tree
Date: Thu, 31 Dec 2015 22:18:58 +0000
Message-ID: <E1aElYg-0006Tr-5T@debutante>
References: <1451530743-8995-2-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451530743-8995-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: merge all identical compat to mtk_common_compat

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

>From 4eaf6f730355ce3725dd8c98e62696ec4c507e9b Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 31 Dec 2015 10:59:00 +0800
Subject: [PATCH] spi: mediatek: merge all identical compat to
 mtk_common_compat

This patch merge all identical compat into on mtk_common_compat
and used for all compatible soc.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 00a36dacfe2f..917c564edd4a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -95,8 +95,7 @@ struct mtk_spi {
 	const struct mtk_spi_compatible *dev_comp;
 };
 
-static const struct mtk_spi_compatible mt6589_compat;
-static const struct mtk_spi_compatible mt8135_compat;
+static const struct mtk_spi_compatible mtk_common_compat;
 static const struct mtk_spi_compatible mt8173_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
@@ -112,9 +111,15 @@ static const struct mtk_chip_config mtk_default_chip_info = {
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
-	{ .compatible = "mediatek,mt6589-spi", .data = (void *)&mt6589_compat },
-	{ .compatible = "mediatek,mt8135-spi", .data = (void *)&mt8135_compat },
-	{ .compatible = "mediatek,mt8173-spi", .data = (void *)&mt8173_compat },
+	{ .compatible = "mediatek,mt6589-spi",
+		.data = (void *)&mtk_common_compat,
+	},
+	{ .compatible = "mediatek,mt8135-spi",
+		.data = (void *)&mtk_common_compat,
+	},
+	{ .compatible = "mediatek,mt8173-spi",
+		.data = (void *)&mt8173_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
