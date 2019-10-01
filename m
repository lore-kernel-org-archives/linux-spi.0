From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_slave_probe()" to the spi tree
Date: Tue,  1 Oct 2019 12:41:05 +0100 (BST)
Message-ID: <20191001114105.EAA1C27429C0@ypsilon.sirena.org.uk>
References: <225b76ca-a367-4bef-d8ce-42c7af9242a5@web.de>
Cc: kernel-janitors@vger.kernel.org,
        Leilk Liu <leilk.liu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <225b76ca-a367-4bef-d8ce-42c7af9242a5@web.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: mediatek: Use devm_platform_ioremap_resource() in mtk_spi_slave_probe()

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

>From 6cdcb5d394413d906773f1ae2efaa86485d6d6e1 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 15:12:33 +0200
Subject: [PATCH] spi: mediatek: Use devm_platform_ioremap_resource() in
 mtk_spi_slave_probe()

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lore.kernel.org/r/225b76ca-a367-4bef-d8ce-42c7af9242a5@web.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-slave-mt27xx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index 61bc43b0fe57..44edaa360405 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -368,7 +368,6 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct mtk_spi_slave *mdata;
-	struct resource *res;
 	int irq, ret;
 
 	ctlr = spi_alloc_slave(&pdev->dev, sizeof(*mdata));
@@ -392,17 +391,8 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctlr);
 
 	init_completion(&mdata->xfer_done);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		dev_err(&pdev->dev, "failed to determine base address\n");
-		goto err_put_ctlr;
-	}
-
 	mdata->dev = &pdev->dev;
-
-	mdata->base = devm_ioremap_resource(&pdev->dev, res);
+	mdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mdata->base)) {
 		ret = PTR_ERR(mdata->base);
 		goto err_put_ctlr;
-- 
2.20.1
