From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 04/11] spi: designware: Use devm_*() functions
Date: Mon, 09 Dec 2013 19:16:44 +0900
Message-ID: <001001cef4c7$c32368b0$496a3a10$%han@samsung.com>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Jean-Hugues Deschenes' <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000801cef4c7$1b84a470$528ded50$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c |   57 +++++++++++----------------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 168c620..1107ca9 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -30,14 +30,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio;
 	struct dw_spi *dws;
-	struct resource *mem, *ioarea;
+	struct resource *mem;
 	int ret;
 
-	dwsmmio = kzalloc(sizeof(struct dw_spi_mmio), GFP_KERNEL);
-	if (!dwsmmio) {
-		ret = -ENOMEM;
-		goto err_end;
-	}
+	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
+				GFP_KERNEL);
+	if (!dwsmmio)
+		return -ENOMEM;
 
 	dws = &dwsmmio->dws;
 
@@ -45,37 +44,23 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
-		ret = -EINVAL;
-		goto err_kfree;
-	}
-
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "SPI region already claimed\n");
-		ret = -EBUSY;
-		goto err_kfree;
+		return -EINVAL;
 	}
 
-	dws->regs = ioremap_nocache(mem->start, resource_size(mem));
-	if (!dws->regs) {
-		dev_err(&pdev->dev, "SPI region already mapped\n");
-		ret = -ENOMEM;
-		goto err_release_reg;
-	}
+	mem->flags &= ~IORESOURCE_CACHEABLE;
+	dws->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dws->regs))
+		return PTR_ERR(dws->regs);
 
 	dws->irq = platform_get_irq(pdev, 0);
 	if (dws->irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		ret = dws->irq; /* -ENXIO */
-		goto err_unmap;
+		return dws->irq; /* -ENXIO */
 	}
 
-	dwsmmio->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dwsmmio->clk)) {
-		ret = PTR_ERR(dwsmmio->clk);
-		goto err_unmap;
-	}
+	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dwsmmio->clk))
+		return PTR_ERR(dwsmmio->clk);
 	clk_enable(dwsmmio->clk);
 
 	dws->parent_dev = &pdev->dev;
@@ -92,33 +77,19 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 err_clk:
 	clk_disable(dwsmmio->clk);
-	clk_put(dwsmmio->clk);
 	dwsmmio->clk = NULL;
-err_unmap:
-	iounmap(dws->regs);
-err_release_reg:
-	release_mem_region(mem->start, resource_size(mem));
-err_kfree:
-	kfree(dwsmmio);
-err_end:
 	return ret;
 }
 
 static int dw_spi_mmio_remove(struct platform_device *pdev)
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
-	struct resource *mem;
 
 	clk_disable(dwsmmio->clk);
-	clk_put(dwsmmio->clk);
 	dwsmmio->clk = NULL;
 
 	dw_spi_remove_host(&dwsmmio->dws);
-	iounmap(dwsmmio->dws.regs);
-	kfree(dwsmmio);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 	return 0;
 }
 
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
