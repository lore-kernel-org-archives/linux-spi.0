From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: revise mtk_spi_probe() failure flow" to the spi tree
Date: Wed, 25 Nov 2015 12:11:25 +0000
Message-ID: <E1a1Yuz-0001v7-81@debutante>
References: <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447986080-31410-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: revise mtk_spi_probe() failure flow

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

>From e38da37fa8f410e61f2a6c03b3d14fec11b00259 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Wed, 25 Nov 2015 17:50:38 +0800
Subject: [PATCH] spi: mediatek: revise mtk_spi_probe() failure flow

mtk_spi_probe() calls pm_runtime_enable(), after
pm_runtime_enable() is called, it should call
pm_runtime_disable() in the failure flow.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6c1a96eb49ee..00a36dacfe2f 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -607,7 +607,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
-		goto err_disable_clk;
+		clk_disable_unprepare(mdata->spi_clk);
+		goto err_put_master;
 	}
 
 	clk_disable_unprepare(mdata->spi_clk);
@@ -617,7 +618,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
-		goto err_put_master;
+		goto err_disable_runtime_pm;
 	}
 
 	if (mdata->dev_comp->need_pad_sel) {
@@ -626,14 +627,14 @@ static int mtk_spi_probe(struct platform_device *pdev)
 				"pad_num does not match num_chipselect(%d != %d)\n",
 				mdata->pad_num, master->num_chipselect);
 			ret = -EINVAL;
-			goto err_put_master;
+			goto err_disable_runtime_pm;
 		}
 
 		if (!master->cs_gpios && master->num_chipselect > 1) {
 			dev_err(&pdev->dev,
 				"cs_gpios not specified and num_chipselect > 1\n");
 			ret = -EINVAL;
-			goto err_put_master;
+			goto err_disable_runtime_pm;
 		}
 
 		if (master->cs_gpios) {
@@ -644,7 +645,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 				if (ret) {
 					dev_err(&pdev->dev,
 						"can't get CS GPIO %i\n", i);
-					goto err_put_master;
+					goto err_disable_runtime_pm;
 				}
 			}
 		}
@@ -652,8 +653,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_disable_clk:
-	clk_disable_unprepare(mdata->spi_clk);
+err_disable_runtime_pm:
+	pm_runtime_disable(&pdev->dev);
 err_put_master:
 	spi_master_put(master);
 
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
