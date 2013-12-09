From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/11] spi: s3c24xx: Use devm_*() functions
Date: Mon, 09 Dec 2013 19:19:13 +0900
Message-ID: <001201cef4c8$1b78a110$5269e330$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c24xx.c |   67 ++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 53 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 0dc32a1..ebf80bb 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -78,7 +78,6 @@ struct s3c24xx_spi {
 	unsigned char		*rx;
 
 	struct clk		*clk;
-	struct resource		*ioarea;
 	struct spi_master	*master;
 	struct spi_device	*curdev;
 	struct device		*dev;
@@ -517,8 +516,7 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	master = spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
 	if (master == NULL) {
 		dev_err(&pdev->dev, "No memory for spi_master\n");
-		err = -ENOMEM;
-		goto err_nomem;
+		return -ENOMEM;
 	}
 
 	hw = spi_master_get_devdata(master);
@@ -567,43 +565,34 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	if (res == NULL) {
 		dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
 		err = -ENOENT;
-		goto err_no_iores;
-	}
-
-	hw->ioarea = request_mem_region(res->start, resource_size(res),
-					pdev->name);
-
-	if (hw->ioarea == NULL) {
-		dev_err(&pdev->dev, "Cannot reserve region\n");
-		err = -ENXIO;
-		goto err_no_iores;
+		goto err_no_pdata;
 	}
 
-	hw->regs = ioremap(res->start, resource_size(res));
-	if (hw->regs == NULL) {
-		dev_err(&pdev->dev, "Cannot map IO\n");
-		err = -ENXIO;
-		goto err_no_iomap;
+	hw->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->regs)) {
+		err = PTR_ERR(hw->regs);
+		goto err_no_pdata;
 	}
 
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
 		dev_err(&pdev->dev, "No IRQ specified\n");
 		err = -ENOENT;
-		goto err_no_irq;
+		goto err_no_pdata;
 	}
 
-	err = request_irq(hw->irq, s3c24xx_spi_irq, 0, pdev->name, hw);
+	err = devm_request_irq(&pdev->dev, hw->irq, s3c24xx_spi_irq, 0,
+				pdev->name, hw);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot claim IRQ\n");
-		goto err_no_irq;
+		goto err_no_pdata;
 	}
 
-	hw->clk = clk_get(&pdev->dev, "spi");
+	hw->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(hw->clk)) {
 		dev_err(&pdev->dev, "No clock for device\n");
 		err = PTR_ERR(hw->clk);
-		goto err_no_clk;
+		goto err_no_pdata;
 	}
 
 	/* setup any gpio we can */
@@ -615,7 +604,8 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 			goto err_register;
 		}
 
-		err = gpio_request(pdata->pin_cs, dev_name(&pdev->dev));
+		err = devm_gpio_request(&pdev->dev, pdata->pin_cs,
+					dev_name(&pdev->dev));
 		if (err) {
 			dev_err(&pdev->dev, "Failed to get gpio for cs\n");
 			goto err_register;
@@ -639,27 +629,10 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	return 0;
 
  err_register:
-	if (hw->set_cs == s3c24xx_spi_gpiocs)
-		gpio_free(pdata->pin_cs);
-
 	clk_disable(hw->clk);
-	clk_put(hw->clk);
 
- err_no_clk:
-	free_irq(hw->irq, hw);
-
- err_no_irq:
-	iounmap(hw->regs);
-
- err_no_iomap:
-	release_resource(hw->ioarea);
-	kfree(hw->ioarea);
-
- err_no_iores:
  err_no_pdata:
 	spi_master_put(hw->master);
-
- err_nomem:
 	return err;
 }
 
@@ -668,19 +641,7 @@ static int s3c24xx_spi_remove(struct platform_device *dev)
 	struct s3c24xx_spi *hw = platform_get_drvdata(dev);
 
 	spi_bitbang_stop(&hw->bitbang);
-
 	clk_disable(hw->clk);
-	clk_put(hw->clk);
-
-	free_irq(hw->irq, hw);
-	iounmap(hw->regs);
-
-	if (hw->set_cs == s3c24xx_spi_gpiocs)
-		gpio_free(hw->pdata->pin_cs);
-
-	release_resource(hw->ioarea);
-	kfree(hw->ioarea);
-
 	spi_master_put(hw->master);
 	return 0;
 }
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
