From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] spi: s3c64xx: Use devm_clk_get() and devm_request_irq()
Date: Wed, 09 Jan 2013 09:50:04 +0900
Message-ID: <002801cdee03$432149a0$c963dce0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Grant Likely' <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The devm_ functions allocate memory that is released when a driver
detaches. This patch uses devm_clk_get() and devm_request_irq()
for these functions. These make the code smaller and a bit simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c |   41 +++++++++++++++--------------------------
 1 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index ad93231..a81679a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1280,7 +1280,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	if (sdd->regs == NULL) {
 		dev_err(&pdev->dev, "Unable to remap IO\n");
 		ret = -ENXIO;
-		goto err1;
+		goto err0;
 	}
 
 	if (!sci->cfg_gpio && pdev->dev.of_node) {
@@ -1289,36 +1289,36 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	} else if (sci->cfg_gpio == NULL || sci->cfg_gpio()) {
 		dev_err(&pdev->dev, "Unable to config gpio\n");
 		ret = -EBUSY;
-		goto err2;
+		goto err0;
 	}
 
 	/* Setup clocks */
-	sdd->clk = clk_get(&pdev->dev, "spi");
+	sdd->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(sdd->clk)) {
 		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
 		ret = PTR_ERR(sdd->clk);
-		goto err3;
+		goto err1;
 	}
 
 	if (clk_prepare_enable(sdd->clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
 		ret = -EBUSY;
-		goto err4;
+		goto err1;
 	}
 
 	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
-	sdd->src_clk = clk_get(&pdev->dev, clk_name);
+	sdd->src_clk = devm_clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(sdd->src_clk)) {
 		dev_err(&pdev->dev,
 			"Unable to acquire clock '%s'\n", clk_name);
 		ret = PTR_ERR(sdd->src_clk);
-		goto err5;
+		goto err2;
 	}
 
 	if (clk_prepare_enable(sdd->src_clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
 		ret = -EBUSY;
-		goto err6;
+		goto err2;
 	}
 
 	/* Setup Deufult Mode */
@@ -1328,11 +1328,12 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	init_completion(&sdd->xfer_completion);
 	INIT_LIST_HEAD(&sdd->queue);
 
-	ret = request_irq(irq, s3c64xx_spi_irq, 0, "spi-s3c64xx", sdd);
+	ret = devm_request_irq(&pdev->dev, irq, s3c64xx_spi_irq, 0,
+				"spi-s3c64xx", sdd);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request IRQ %d: %d\n",
 			irq, ret);
-		goto err7;
+		goto err3;
 	}
 
 	writel(S3C64XX_SPI_INT_RX_OVERRUN_EN | S3C64XX_SPI_INT_RX_UNDERRUN_EN |
@@ -1342,7 +1343,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 	if (spi_register_master(master)) {
 		dev_err(&pdev->dev, "cannot register SPI master\n");
 		ret = -EBUSY;
-		goto err8;
+		goto err3;
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d "
@@ -1356,21 +1357,13 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-err8:
-	free_irq(irq, sdd);
-err7:
+err3:
 	clk_disable_unprepare(sdd->src_clk);
-err6:
-	clk_put(sdd->src_clk);
-err5:
+err2:
 	clk_disable_unprepare(sdd->clk);
-err4:
-	clk_put(sdd->clk);
-err3:
+err1:
 	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
 		s3c64xx_spi_dt_gpio_free(sdd);
-err2:
-err1:
 err0:
 	platform_set_drvdata(pdev, NULL);
 	spi_master_put(master);
@@ -1389,13 +1382,9 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
-	free_irq(platform_get_irq(pdev, 0), sdd);
-
 	clk_disable_unprepare(sdd->src_clk);
-	clk_put(sdd->src_clk);
 
 	clk_disable_unprepare(sdd->clk);
-	clk_put(sdd->clk);
 
 	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
 		s3c64xx_spi_dt_gpio_free(sdd);
-- 
1.7.2.5



------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
