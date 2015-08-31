From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: fix spi clock usage error" to the spi tree
Date: Mon, 31 Aug 2015 15:28:33 +0100
Message-ID: <E1ZWQ4X-0000LA-E0@finisterre>
References: <1441027138-16458-3-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441027138-16458-3-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: fix spi clock usage error

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

>From adcbcfea15d62fab5ba40ac28f9d2a590cc5e5e8 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 31 Aug 2015 21:18:57 +0800
Subject: [PATCH] spi: mediatek: fix spi clock usage error

spi clock manages flow:
  CLK_TOP_SYSPLL3_D2 ---> CLK_TOP_SPI_SEL ---> CLK_PERI_SPI0
     (source clock)           (clock mux)       (clock gate)
spi driver should choose source clock by clock mux, then enable
clock gate.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index b609b1c..6fbb5e5 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -85,7 +85,7 @@ struct mtk_spi {
 	void __iomem *base;
 	u32 state;
 	u32 pad_sel;
-	struct clk *spi_clk, *parent_clk;
+	struct clk *parent_clk, *sel_clk, *spi_clk;
 	struct spi_transfer *cur_transfer;
 	u32 xfer_len;
 	struct scatterlist *tx_sgl, *rx_sgl;
@@ -576,17 +576,24 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi-clk");
-	if (IS_ERR(mdata->spi_clk)) {
+	mdata->parent_clk = devm_clk_get(&pdev->dev, "parent-clk");
+	if (IS_ERR(mdata->parent_clk)) {
+		ret = PTR_ERR(mdata->parent_clk);
+		dev_err(&pdev->dev, "failed to get parent-clk: %d\n", ret);
+		goto err_put_master;
+	}
+
+	mdata->sel_clk = devm_clk_get(&pdev->dev, "sel-clk");
+	if (IS_ERR(mdata->sel_clk)) {
 		ret = PTR_ERR(mdata->spi_clk);
-		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to get sel-clk: %d\n", ret);
 		goto err_put_master;
 	}
 
-	mdata->parent_clk = devm_clk_get(&pdev->dev, "parent-clk");
-	if (IS_ERR(mdata->parent_clk)) {
+	mdata->spi_clk = devm_clk_get(&pdev->dev, "spi-clk");
+	if (IS_ERR(mdata->spi_clk)) {
 		ret = PTR_ERR(mdata->parent_clk);
-		dev_err(&pdev->dev, "failed to get parent-clk: %d\n", ret);
+		dev_err(&pdev->dev, "failed to get spi-clk: %d\n", ret);
 		goto err_put_master;
 	}
 
@@ -596,7 +603,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
-	ret = clk_set_parent(mdata->spi_clk, mdata->parent_clk);
+	ret = clk_set_parent(mdata->sel_clk, mdata->parent_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
 		goto err_disable_clk;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
