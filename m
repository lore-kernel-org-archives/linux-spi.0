From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_probe()" to the spi tree
Date: Tue,  1 Oct 2019 12:41:06 +0100 (BST)
Message-ID: <20191001114106.2FA1C2742A10@ypsilon.sirena.org.uk>
References: <478e0df1-e800-8cf1-f9b3-d72f8e26aa0b@web.de>
Cc: kernel-janitors@vger.kernel.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <478e0df1-e800-8cf1-f9b3-d72f8e26aa0b@web.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_probe()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From 5dd381e71994ab554f711afe89b5a6157bdcd19d Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 14:45:40 +0200
Subject: [PATCH] spi: mediatek: Use devm_platform_ioremap_resource() in
 mtk_spi_probe()

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lore.kernel.org/r/478e0df1-e800-8cf1-f9b3-d72f8e26aa0b@web.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mt65xx.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 6888a4dcff6d..25fe149a8d9a 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -619,7 +619,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct mtk_spi *mdata;
 	const struct of_device_id *of_id;
-	struct resource *res;
 	int i, irq, ret, addr_bits;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*mdata));
@@ -682,15 +681,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err_put_master;
-	}
-
-	mdata->base = devm_ioremap_resource(&pdev->dev, res);
+	mdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base)) {
 		ret = PTR_ERR(mdata->base);
 		goto err_put_master;
-- 
2.20.1
