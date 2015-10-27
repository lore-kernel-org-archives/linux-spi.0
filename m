From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: mt8173 spi multiple devices support" to the spi tree
Date: Tue, 27 Oct 2015 13:50:04 +0900
Message-ID: <E1ZqwCy-00056u-U0@finisterre>
References: <1444793015-30359-5-git-send-email-leilk.liu@mediatek.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444793015-30359-5-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: mt8173 spi multiple devices support

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

>From 37457607ecaffe56718a0e423548edeb3d4a11b7 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Mon, 26 Oct 2015 16:09:44 +0800
Subject: [PATCH] spi: mediatek: mt8173 spi multiple devices support

mt8173 IC spi HW has 4 gpio group, it's possible to support
max <= 4 slave devices, even mtk spi HW is not congruent to spi core.
1. When a device do a spi_message transfer, spi HW should know
   which pad-group this device is on, and then writes pad-select
   register.
2. Mtk pad-select register just selects which MISO pin HW will
   receive data. For example, pad-select=1(select spi1 pins), HW just
   receives data from spi1 MISO, but it still send waveform to all 4
   group cs/clk/mosi. If cs pin in other groups is still spi mode,
   after spi1 is selected(by active cs pin), devices on other group
   will also be selected.

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 65 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 406695a..563954a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -20,6 +20,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/spi-mt65xx.h>
 #include <linux/pm_runtime.h>
@@ -84,7 +85,8 @@ struct mtk_spi_compatible {
 struct mtk_spi {
 	void __iomem *base;
 	u32 state;
-	u32 pad_sel;
+	int pad_num;
+	u32 *pad_sel;
 	struct clk *parent_clk, *sel_clk, *spi_clk;
 	struct spi_transfer *cur_transfer;
 	u32 xfer_len;
@@ -188,7 +190,8 @@ static int mtk_spi_prepare_message(struct spi_master *master,
 
 	/* pad select */
 	if (mdata->dev_comp->need_pad_sel)
-		writel(mdata->pad_sel, mdata->base + SPI_PAD_SEL_REG);
+		writel(mdata->pad_sel[spi->chip_select],
+		       mdata->base + SPI_PAD_SEL_REG);
 
 	return 0;
 }
@@ -407,6 +410,9 @@ static int mtk_spi_setup(struct spi_device *spi)
 	if (!spi->controller_data)
 		spi->controller_data = (void *)&mtk_default_chip_info;
 
+	if (mdata->dev_comp->need_pad_sel)
+		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+
 	return 0;
 }
 
@@ -481,7 +487,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
 	struct resource *res;
-	int irq, ret;
+	int i, irq, ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
 	if (!master) {
@@ -512,21 +518,34 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		master->flags = SPI_MASTER_MUST_TX;
 
 	if (mdata->dev_comp->need_pad_sel) {
-		ret = of_property_read_u32(pdev->dev.of_node,
-					   "mediatek,pad-select",
-					   &mdata->pad_sel);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to read pad select: %d\n",
-				ret);
+		mdata->pad_num = of_property_count_u32_elems(
+			pdev->dev.of_node,
+			"mediatek,pad-select");
+		if (mdata->pad_num < 0) {
+			dev_err(&pdev->dev,
+				"No 'mediatek,pad-select' property\n");
+			ret = -EINVAL;
 			goto err_put_master;
 		}
 
-		if (mdata->pad_sel > MT8173_SPI_MAX_PAD_SEL) {
-			dev_err(&pdev->dev, "wrong pad-select: %u\n",
-				mdata->pad_sel);
-			ret = -EINVAL;
+		mdata->pad_sel = devm_kmalloc_array(&pdev->dev, mdata->pad_num,
+						    sizeof(u32), GFP_KERNEL);
+		if (!mdata->pad_sel) {
+			ret = -ENOMEM;
 			goto err_put_master;
 		}
+
+		for (i = 0; i < mdata->pad_num; i++) {
+			of_property_read_u32_index(pdev->dev.of_node,
+						   "mediatek,pad-select",
+						   i, &mdata->pad_sel[i]);
+			if (mdata->pad_sel[i] > MT8173_SPI_MAX_PAD_SEL) {
+				dev_err(&pdev->dev, "wrong pad-sel[%d]: %u\n",
+					i, mdata->pad_sel[i]);
+				ret = -EINVAL;
+				goto err_put_master;
+			}
+		}
 	}
 
 	platform_set_drvdata(pdev, master);
@@ -604,6 +623,26 @@ static int mtk_spi_probe(struct platform_device *pdev)
 		goto err_put_master;
 	}
 
+	if (mdata->dev_comp->need_pad_sel) {
+		if (mdata->pad_num != master->num_chipselect) {
+			dev_err(&pdev->dev,
+				"pad_num does not match num_chipselect(%d != %d)\n",
+				mdata->pad_num, master->num_chipselect);
+			ret = -EINVAL;
+			goto err_put_master;
+		}
+
+		for (i = 0; i < master->num_chipselect; i++) {
+			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
+						dev_name(&pdev->dev));
+			if (ret) {
+				dev_err(&pdev->dev,
+					"can't get CS GPIO %i\n", i);
+				goto err_put_master;
+			}
+		}
+	}
+
 	return 0;
 
 err_disable_clk:
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
