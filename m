From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] spi/s3c64xx: Convert to devm_request_and_ioremap()
Date: Thu,  5 Jul 2012 13:33:13 +0100
Message-ID: <1341491593-6781-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Saves some error handling and a small amount of code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-s3c64xx.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f4e2341..f62c13e 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1028,14 +1028,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
-	if (request_mem_region(mem_res->start,
-			resource_size(mem_res), pdev->name) == NULL) {
-		dev_err(&pdev->dev, "Req mem region failed\n");
-		ret = -ENXIO;
-		goto err0;
-	}
-
-	sdd->regs = ioremap(mem_res->start, resource_size(mem_res));
+	sdd->regs = devm_request_and_ioremap(&pdev->dev, mem_res);
 	if (sdd->regs == NULL) {
 		dev_err(&pdev->dev, "Unable to remap IO\n");
 		ret = -ENXIO;
@@ -1124,10 +1117,7 @@ err4:
 	clk_put(sdd->clk);
 err3:
 err2:
-	iounmap((void *) sdd->regs);
 err1:
-	release_mem_region(mem_res->start, resource_size(mem_res));
-err0:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
 
@@ -1138,7 +1128,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct resource	*mem_res;
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -1154,12 +1143,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	clk_disable(sdd->clk);
 	clk_put(sdd->clk);
 
-	iounmap((void *) sdd->regs);
-
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem_res != NULL)
-		release_mem_region(mem_res->start, resource_size(mem_res));
-
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
 
-- 
1.7.10
