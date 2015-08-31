From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/3] spi: mediatek: fix spi clock usage error
Date: Mon, 31 Aug 2015 21:18:57 +0800
Message-ID: <1441027138-16458-3-git-send-email-leilk.liu@mediatek.com>
References: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441027138-16458-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi clock manages flow:
  CLK_TOP_SYSPLL3_D2 ---> CLK_TOP_SPI_SEL ---> CLK_PERI_SPI0
     (source clock)           (clock mux)       (clock gate)
spi driver should choose source clock by clock mux, then enable
clock gate.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3a177d0..5ecd644 100644
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
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
