From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 1/4] spi: dw: use managed resources
Date: Thu, 26 Dec 2013 09:00:12 +0200
Message-ID: <406b0c452cfa4e58b8d4c565beb861da30ebead7.1388040447.git.baruch@tkos.co.il>
References: <cover.1388040447.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Migrate mmio code and core driver to managed resources to reduce boilerplate
error handling code. Also, handle clk_enable() failure while at it.

This commit doesn't migrate the PCI specific code to managed resources, because
I can't test that code.

Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 63 ++++++++++++++++-------------------------------
 drivers/spi/spi-dw-pci.c  |  2 +-
 drivers/spi/spi-dw.c      | 18 ++++----------
 drivers/spi/spi-dw.h      |  2 +-
 4 files changed, 28 insertions(+), 57 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 168c620..a85ff37 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -33,11 +33,10 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct resource *mem, *ioarea;
 	int ret;
 
-	dwsmmio = kzalloc(sizeof(struct dw_spi_mmio), GFP_KERNEL);
-	if (!dwsmmio) {
-		ret = -ENOMEM;
-		goto err_end;
-	}
+	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
+			GFP_KERNEL);
+	if (!dwsmmio)
+		return -ENOMEM;
 
 	dws = &dwsmmio->dws;
 
@@ -45,80 +44,60 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
-		ret = -EINVAL;
-		goto err_kfree;
+		return -EINVAL;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
+	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
+			resource_size(mem), pdev->name);
 	if (!ioarea) {
 		dev_err(&pdev->dev, "SPI region already claimed\n");
-		ret = -EBUSY;
-		goto err_kfree;
+		return -EBUSY;
 	}
 
-	dws->regs = ioremap_nocache(mem->start, resource_size(mem));
+	dws->regs = devm_ioremap_nocache(&pdev->dev, mem->start,
+			resource_size(mem));
 	if (!dws->regs) {
 		dev_err(&pdev->dev, "SPI region already mapped\n");
-		ret = -ENOMEM;
-		goto err_release_reg;
+		return -ENOMEM;
 	}
 
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
-	clk_enable(dwsmmio->clk);
+	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dwsmmio->clk))
+		return PTR_ERR(dwsmmio->clk);
+	ret = clk_enable(dwsmmio->clk);
+	if (ret)
+		return ret;
 
 	dws->parent_dev = &pdev->dev;
 	dws->bus_num = 0;
 	dws->num_cs = 4;
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
-	ret = dw_spi_add_host(dws);
+	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
-		goto err_clk;
+		goto out;
 
 	platform_set_drvdata(pdev, dwsmmio);
 	return 0;
 
-err_clk:
+out:
 	clk_disable(dwsmmio->clk);
-	clk_put(dwsmmio->clk);
-	dwsmmio->clk = NULL;
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
-	dwsmmio->clk = NULL;
-
 	dw_spi_remove_host(&dwsmmio->dws);
-	iounmap(dwsmmio->dws.regs);
-	kfree(dwsmmio);
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 	return 0;
 }
 
diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 66fa995..1c00597 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -86,7 +86,7 @@ static int spi_pci_probe(struct pci_dev *pdev,
 			goto err_unmap;
 	}
 
-	ret = dw_spi_add_host(dws);
+	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto err_unmap;
 
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b897c4ad..e37dfc1 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -776,7 +776,7 @@ static void spi_hw_init(struct dw_spi *dws)
 	}
 }
 
-int dw_spi_add_host(struct dw_spi *dws)
+int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_master *master;
 	int ret;
@@ -784,10 +784,8 @@ int dw_spi_add_host(struct dw_spi *dws)
 	BUG_ON(dws == NULL);
 
 	master = spi_alloc_master(dws->parent_dev, 0);
-	if (!master) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!master)
+		return -ENOMEM;
 
 	dws->master = master;
 	dws->type = SSI_MOTO_SPI;
@@ -797,7 +795,7 @@ int dw_spi_add_host(struct dw_spi *dws)
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d",
 			dws->bus_num);
 
-	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
+	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
 			dws->name, dws);
 	if (ret < 0) {
 		dev_err(&master->dev, "can not get IRQ\n");
@@ -836,7 +834,7 @@ int dw_spi_add_host(struct dw_spi *dws)
 	}
 
 	spi_master_set_devdata(master, dws);
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
 		goto err_queue_alloc;
@@ -851,10 +849,8 @@ err_queue_alloc:
 		dws->dma_ops->dma_exit(dws);
 err_diable_hw:
 	spi_enable_chip(dws, 0);
-	free_irq(dws->irq, dws);
 err_free_master:
 	spi_master_put(master);
-exit:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_spi_add_host);
@@ -878,10 +874,6 @@ void dw_spi_remove_host(struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	/* Disable clk */
 	spi_set_clk(dws, 0);
-	free_irq(dws->irq, dws);
-
-	/* Disconnect from the SPI framework */
-	spi_unregister_master(dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 9c57c07..1ccfc18 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -231,7 +231,7 @@ struct dw_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
-extern int dw_spi_add_host(struct dw_spi *dws);
+extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
-- 
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
