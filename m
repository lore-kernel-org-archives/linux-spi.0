From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: fix spi cs polarity error" to the spi tree
Date: Mon, 07 Sep 2015 20:17:25 +0100
Message-ID: <E1ZZ1uv-0005If-BS@debutante>
References: <1441625877-583-1-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441625877-583-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: fix spi cs polarity error

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

>From 6583d2032d57df9f1c00c753ca58e1a822901bf0 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 7 Sep 2015 19:37:57 +0800
Subject: [PATCH] spi: mediatek: fix spi cs polarity error

Mediatek spi HW can't set cs inactive(keep cs high) directly.
Instead, it supplies pause mode to do it indirectly. If driver
unsets SPI_CMD_PAUSE_MODE in CMD_REG, it also needs to reset
internal state machine to let cs inactive at once.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 5f6315c47920..b6073bbff8d9 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -173,22 +173,6 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
 }
 
-static int mtk_spi_prepare_hardware(struct spi_master *master)
-{
-	struct spi_transfer *trans;
-	struct mtk_spi *mdata = spi_master_get_devdata(master);
-	struct spi_message *msg = master->cur_msg;
-
-	trans = list_first_entry(&msg->transfers, struct spi_transfer,
-				 transfer_list);
-	if (!trans->cs_change) {
-		mdata->state = MTK_SPI_IDLE;
-		mtk_spi_reset(mdata);
-	}
-
-	return 0;
-}
-
 static int mtk_spi_prepare_message(struct spi_master *master,
 				   struct spi_message *msg)
 {
@@ -228,11 +212,15 @@ static void mtk_spi_set_cs(struct spi_device *spi, bool enable)
 	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
 
 	reg_val = readl(mdata->base + SPI_CMD_REG);
-	if (!enable)
+	if (!enable) {
 		reg_val |= SPI_CMD_PAUSE_EN;
-	else
+		writel(reg_val, mdata->base + SPI_CMD_REG);
+	} else {
 		reg_val &= ~SPI_CMD_PAUSE_EN;
-	writel(reg_val, mdata->base + SPI_CMD_REG);
+		writel(reg_val, mdata->base + SPI_CMD_REG);
+		mdata->state = MTK_SPI_IDLE;
+		mtk_spi_reset(mdata);
+	}
 }
 
 static void mtk_spi_prepare_transfer(struct spi_master *master,
@@ -509,7 +497,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 
 	master->set_cs = mtk_spi_set_cs;
-	master->prepare_transfer_hardware = mtk_spi_prepare_hardware;
 	master->prepare_message = mtk_spi_prepare_message;
 	master->transfer_one = mtk_spi_transfer_one;
 	master->can_dma = mtk_spi_can_dma;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
