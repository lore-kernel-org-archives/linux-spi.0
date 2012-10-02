From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] spi: s3c64xx: use clk_prepare_enable and clk_disable_unprepare
Date: Wed,  3 Oct 2012 08:30:12 +0900
Message-ID: <1349220612-2464-1-git-send-email-thomas.abraham@linaro.org>
Cc: grant.likely@secretlab.ca, broonie@opensource.wolfsonmicro.com,
	kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/spi/spi-s3c64xx.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9e55c44..9ad7109 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -516,7 +516,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	/* Disable Clock */
 	if (sdd->port_conf->clk_from_cmu) {
-		clk_disable(sdd->src_clk);
+		clk_disable_unprepare(sdd->src_clk);
 	} else {
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
 		val &= ~S3C64XX_SPI_ENCLK_ENABLE;
@@ -564,7 +564,7 @@ static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 		/* There is half-multiplier before the SPI */
 		clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
 		/* Enable Clock */
-		clk_enable(sdd->src_clk);
+		clk_prepare_enable(sdd->src_clk);
 	} else {
 		/* Configure Clock */
 		val = readl(regs + S3C64XX_SPI_CLK_CFG);
@@ -1299,7 +1299,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err3;
 	}
 
-	if (clk_enable(sdd->clk)) {
+	if (clk_prepare_enable(sdd->clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
 		ret = -EBUSY;
 		goto err4;
@@ -1314,7 +1314,7 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 		goto err5;
 	}
 
-	if (clk_enable(sdd->src_clk)) {
+	if (clk_prepare_enable(sdd->src_clk)) {
 		dev_err(&pdev->dev, "Couldn't enable clock '%s'\n", clk_name);
 		ret = -EBUSY;
 		goto err6;
@@ -1358,11 +1358,11 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 err8:
 	free_irq(irq, sdd);
 err7:
-	clk_disable(sdd->src_clk);
+	clk_disable_unprepare(sdd->src_clk);
 err6:
 	clk_put(sdd->src_clk);
 err5:
-	clk_disable(sdd->clk);
+	clk_disable_unprepare(sdd->clk);
 err4:
 	clk_put(sdd->clk);
 err3:
@@ -1390,10 +1390,10 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 
 	free_irq(platform_get_irq(pdev, 0), sdd);
 
-	clk_disable(sdd->src_clk);
+	clk_disable_unprepare(sdd->src_clk);
 	clk_put(sdd->src_clk);
 
-	clk_disable(sdd->clk);
+	clk_disable_unprepare(sdd->clk);
 	clk_put(sdd->clk);
 
 	if (!sdd->cntrlr_info->cfg_gpio && pdev->dev.of_node)
@@ -1414,8 +1414,8 @@ static int s3c64xx_spi_suspend(struct device *dev)
 	spi_master_suspend(master);
 
 	/* Disable the clock */
-	clk_disable(sdd->src_clk);
-	clk_disable(sdd->clk);
+	clk_disable_unprepare(sdd->src_clk);
+	clk_disable_unprepare(sdd->clk);
 
 	if (!sdd->cntrlr_info->cfg_gpio && dev->of_node)
 		s3c64xx_spi_dt_gpio_free(sdd);
@@ -1437,8 +1437,8 @@ static int s3c64xx_spi_resume(struct device *dev)
 		sci->cfg_gpio();
 
 	/* Enable the clock */
-	clk_enable(sdd->src_clk);
-	clk_enable(sdd->clk);
+	clk_prepare_enable(sdd->src_clk);
+	clk_prepare_enable(sdd->clk);
 
 	s3c64xx_spi_hwinit(sdd, sdd->port_id);
 
@@ -1454,8 +1454,8 @@ static int s3c64xx_spi_runtime_suspend(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
-	clk_disable(sdd->clk);
-	clk_disable(sdd->src_clk);
+	clk_disable_unprepare(sdd->clk);
+	clk_disable_unprepare(sdd->src_clk);
 
 	return 0;
 }
@@ -1465,8 +1465,8 @@ static int s3c64xx_spi_runtime_resume(struct device *dev)
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 
-	clk_enable(sdd->src_clk);
-	clk_enable(sdd->clk);
+	clk_prepare_enable(sdd->src_clk);
+	clk_prepare_enable(sdd->clk);
 
 	return 0;
 }
-- 
1.7.4.1
