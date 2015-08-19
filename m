From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: remove redundant clock in prepare_hardware/unprepare_hardware" to the spi tree
Date: Wed, 19 Aug 2015 10:27:35 -0700
Message-ID: <E1ZS79D-0001xh-7v@finisterre>
References: <1439955478-2733-3-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439955478-2733-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: remove redundant clock in prepare_hardware/unprepare_hardware

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

>From c5e5cd28d7c5a18d6da6575957dd0c5243ac3e7b Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Wed, 19 Aug 2015 11:37:57 +0800
Subject: [PATCH] spi: mediatek: remove redundant clock in
 prepare_hardware/unprepare_hardware

clock in prepare_hardware/unprepare_hardware is redundant
with pm_runtime, so remove them.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 62baaad..546d70c 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -186,13 +186,6 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 	struct spi_transfer *trans;
 	struct mtk_spi *mdata = spi_master_get_devdata(master);
 	struct spi_message *msg = master->cur_msg;
-	int ret;
-
-	ret = clk_prepare_enable(mdata->spi_clk);
-	if (ret < 0) {
-		dev_err(&master->dev, "failed to enable clock (%d)\n", ret);
-		return ret;
-	}
 
 	trans = list_first_entry(&msg->transfers, struct spi_transfer,
 				 transfer_list);
@@ -201,15 +194,6 @@ static int mtk_spi_prepare_hardware(struct spi_master *master)
 		mtk_spi_reset(mdata);
 	}
 
-	return ret;
-}
-
-static int mtk_spi_unprepare_hardware(struct spi_master *master)
-{
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(mdata->spi_clk);
-
 	return 0;
 }
 
@@ -541,7 +525,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	master->set_cs = mtk_spi_set_cs;
 	master->prepare_transfer_hardware = mtk_spi_prepare_hardware;
-	master->unprepare_transfer_hardware = mtk_spi_unprepare_hardware;
 	master->prepare_message = mtk_spi_prepare_message;
 	master->transfer_one = mtk_spi_transfer_one;
 	master->can_dma = mtk_spi_can_dma;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
