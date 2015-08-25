From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: add PM clk_prepare_enable fail flow" to the spi tree
Date: Tue, 25 Aug 2015 18:50:08 +0100
Message-ID: <E1ZUIMK-0005OS-CM@debutante>
References: <1440387918-22191-4-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1440387918-22191-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: add PM clk_prepare_enable fail flow

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

>From 13da5a0b72ea66c74483966ff91718ae0a9c0703 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 24 Aug 2015 11:45:17 +0800
Subject: [PATCH] spi: mediatek: add PM clk_prepare_enable fail flow

This patch adds PM clk_prepare_enable fail flow.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 81b75b94145c..14112a5e63b9 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -665,8 +665,10 @@ static int mtk_spi_resume(struct device *dev)
 
 	if (!pm_runtime_suspended(dev)) {
 		ret = clk_prepare_enable(mdata->spi_clk);
-		if (ret < 0)
+		if (ret < 0) {
+			dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
 			return ret;
+		}
 	}
 
 	ret = spi_master_resume(master);
@@ -692,8 +694,15 @@ static int mtk_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(mdata->spi_clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable spi_clk (%d)\n", ret);
+		return ret;
+	}
 
-	return clk_prepare_enable(mdata->spi_clk);
+	return 0;
 }
 #endif /* CONFIG_PM */
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
