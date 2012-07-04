From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH 1/2] spi/s3c64xx: Convert to devm_request_and_ioremap()
Date: Wed,  4 Jul 2012 17:11:55 +0100
Message-ID: <1341418316-26190-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Saves some error handling and a small amount of code.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c |   25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index f4e2341..b7aeb5d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1028,19 +1028,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
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
-	if (sdd->regs == NULL) {
-		dev_err(&pdev->dev, "Unable to remap IO\n");
-		ret = -ENXIO;
-		goto err1;
-	}
+	sdd->regs = devm_request_and_ioremap(&pdev->dev, mem_res);
 
 	if (sci->cfg_gpio == NULL || sci->cfg_gpio(pdev)) {
 		dev_err(&pdev->dev, "Unable to config gpio\n");
@@ -1124,10 +1112,6 @@ err4:
 	clk_put(sdd->clk);
 err3:
 err2:
-	iounmap((void *) sdd->regs);
-err1:
-	release_mem_region(mem_res->start, resource_size(mem_res));
-err0:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
 
@@ -1138,7 +1122,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 {
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
-	struct resource	*mem_res;
 
 	pm_runtime_disable(&pdev->dev);
 
@@ -1154,12 +1137,6 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
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


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
