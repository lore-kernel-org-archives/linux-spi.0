From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: xtensa-xtfpga: Use devm_platform_ioremap_resource() in xtfpga_spi_probe()" to the spi tree
Date: Tue,  1 Oct 2019 12:41:05 +0100 (BST)
Message-ID: <20191001114105.AF4BB2742A30@ypsilon.sirena.org.uk>
References: <178bb78e-714f-645f-d819-5732870c4272@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
To: Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <178bb78e-714f-645f-d819-5732870c4272@web.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: xtensa-xtfpga: Use devm_platform_ioremap_resource() in xtfpga_spi_probe()

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

>From 3f049e7df22e563b04fd576bdc37e6b3e2c7a996 Mon Sep 17 00:00:00 2001
From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Sep 2019 15:35:08 +0200
Subject: [PATCH] spi: xtensa-xtfpga: Use devm_platform_ioremap_resource() in
 xtfpga_spi_probe()

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Link: https://lore.kernel.org/r/178bb78e-714f-645f-d819-5732870c4272@web.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-xtensa-xtfpga.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spi-xtensa-xtfpga.c b/drivers/spi/spi-xtensa-xtfpga.c
index 86516eb1e143..fc2b5eb7d614 100644
--- a/drivers/spi/spi-xtensa-xtfpga.c
+++ b/drivers/spi/spi-xtensa-xtfpga.c
@@ -80,7 +80,6 @@ static void xtfpga_spi_chipselect(struct spi_device *spi, int is_on)
 static int xtfpga_spi_probe(struct platform_device *pdev)
 {
 	struct xtfpga_spi *xspi;
-	struct resource *mem;
 	int ret;
 	struct spi_master *master;
 
@@ -97,14 +96,7 @@ static int xtfpga_spi_probe(struct platform_device *pdev)
 	xspi->bitbang.master = master;
 	xspi->bitbang.chipselect = xtfpga_spi_chipselect;
 	xspi->bitbang.txrx_word[SPI_MODE_0] = xtfpga_spi_txrx_word;
-
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		ret = -ENODEV;
-		goto err;
-	}
-	xspi->regs = devm_ioremap_resource(&pdev->dev, mem);
+	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(xspi->regs)) {
 		ret = PTR_ERR(xspi->regs);
 		goto err;
-- 
2.20.1
