From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: mediatek: single device does not require cs_gpios" to the spi tree
Date: Mon, 16 Nov 2015 17:51:59 +0000
Message-ID: <E1ZyNwd-0006sN-H7@debutante>
References: <1447042491-1199-1-git-send-email-drinkcat@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447042491-1199-1-git-send-email-drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: mediatek: single device does not require cs_gpios

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

>From 98c8dccf2b2771fb622d449b2ec1604fc5d260e5 Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Date: Mon, 9 Nov 2015 12:14:51 +0800
Subject: [PATCH] spi: mediatek: single device does not require cs_gpios

When only one device is present, it is not necessary to specify
cs_gpios, as the CS line can be controlled by the hardware
module.

Without this patch, older device tree bindings used before
37457607 "spi: mediatek: mt8173 spi multiple devices support"
would cause a panic on boot. This fixes the crash, and
re-introduces backward compatibility.

Signed-off-by: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Acked-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mt65xx.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 563954a61424..7840067062a8 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -410,7 +410,7 @@ static int mtk_spi_setup(struct spi_device *spi)
 	if (!spi->controller_data)
 		spi->controller_data = (void *)&mtk_default_chip_info;
 
-	if (mdata->dev_comp->need_pad_sel)
+	if (mdata->dev_comp->need_pad_sel && gpio_is_valid(spi->cs_gpio))
 		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
 
 	return 0;
@@ -632,13 +632,23 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			goto err_put_master;
 		}
 
-		for (i = 0; i < master->num_chipselect; i++) {
-			ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-						dev_name(&pdev->dev));
-			if (ret) {
-				dev_err(&pdev->dev,
-					"can't get CS GPIO %i\n", i);
-				goto err_put_master;
+		if (!master->cs_gpios && master->num_chipselect > 1) {
+			dev_err(&pdev->dev,
+				"cs_gpios not specified and num_chipselect > 1\n");
+			ret = -EINVAL;
+			goto err_put_master;
+		}
+
+		if (master->cs_gpios) {
+			for (i = 0; i < master->num_chipselect; i++) {
+				ret = devm_gpio_request(&pdev->dev,
+							master->cs_gpios[i],
+							dev_name(&pdev->dev));
+				if (ret) {
+					dev_err(&pdev->dev,
+						"can't get CS GPIO %i\n", i);
+					goto err_put_master;
+				}
 			}
 		}
 	}
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
