From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 1/3] spi: dw: use managed resources
Date: Mon, 30 Dec 2013 20:30:44 +0200
Message-ID: <9fca9e7e34cd6bd0ec14d28952d422014d94763b.1388427564.git.baruch@tkos.co.il>
References: <cover.1388427564.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1388427564.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Migrate mmio code and core driver to managed resources to reduce boilerplate
error handling code. Also, handle clk_enable() failure while at it, and drop
unused dw_spi iolen field.

Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
v2:
    Convert also the PCI code

    Drop the iolen and parent_dev fields
---
 drivers/spi/spi-dw-mmio.c | 70 ++++++++++++++---------------------------------
 drivers/spi/spi-dw-pci.c  | 40 +++++++--------------------
 drivers/spi/spi-dw.c      | 20 ++++----------
 drivers/spi/spi-dw.h      |  4 +--
 4 files changed, 37 insertions(+), 97 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 168c620..569adf8 100644
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
+			GFP_KERNEL);
+	if (!dwsmmio)
+		return -ENOMEM;
 
 	dws = &dwsmmio->dws;
 
@@ -45,80 +44,51 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
-		ret = -EINVAL;
-		goto err_kfree;
+		return -EINVAL;
 	}
 
-	ioarea = request_mem_region(mem->start, resource_size(mem),
-			pdev->name);
-	if (!ioarea) {
-		dev_err(&pdev->dev, "SPI region already claimed\n");
-		ret = -EBUSY;
-		goto err_kfree;
-	}
-
-	dws->regs = ioremap_nocache(mem->start, resource_size(mem));
-	if (!dws->regs) {
-		dev_err(&pdev->dev, "SPI region already mapped\n");
-		ret = -ENOMEM;
-		goto err_release_reg;
+	dws->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dws->regs)) {
+		dev_err(&pdev->dev, "SPI region map failed\n");
+		return PTR_ERR(dws->regs);
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
 
-	dws->parent_dev = &pdev->dev;
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
index 66fa995..760dc00 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -43,35 +43,24 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	dev_info(&pdev->dev, "found PCI SPI controller(ID: %04x:%04x)\n",
 		pdev->vendor, pdev->device);
 
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
 
-	dwpci = kzalloc(sizeof(struct dw_spi_pci), GFP_KERNEL);
-	if (!dwpci) {
-		ret = -ENOMEM;
-		goto err_disable;
-	}
+	dwpci = devm_kzalloc(&pdev-dev, sizeof(struct dw_spi_pci), GFP_KERNEL);
+	if (!dwpci)
+		return -ENOMEM;
 
 	dwpci->pdev = pdev;
 	dws = &dwpci->dws;
 
 	/* Get basic io resource and map it */
 	dws->paddr = pci_resource_start(pdev, pci_bar);
-	dws->iolen = pci_resource_len(pdev, pci_bar);
 
-	ret = pci_request_region(pdev, pci_bar, dev_name(&pdev->dev));
+	ret = pcim_iomap_regions(pdev, 1, dev_name(&pdev->dev));
 	if (ret)
-		goto err_kfree;
-
-	dws->regs = ioremap_nocache((unsigned long)dws->paddr,
-				pci_resource_len(pdev, pci_bar));
-	if (!dws->regs) {
-		ret = -ENOMEM;
-		goto err_release_reg;
-	}
+		return ret;
 
-	dws->parent_dev = &pdev->dev;
 	dws->bus_num = 0;
 	dws->num_cs = 4;
 	dws->irq = pdev->irq;
@@ -83,26 +72,17 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	if (pdev->device == 0x0800) {
 		ret = dw_spi_mid_init(dws);
 		if (ret)
-			goto err_unmap;
+			return ret;
 	}
 
-	ret = dw_spi_add_host(dws);
+	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
-		goto err_unmap;
+		return ret;
 
 	/* PCI hook and SPI hook use the same drv data */
 	pci_set_drvdata(pdev, dwpci);
-	return 0;
 
-err_unmap:
-	iounmap(dws->regs);
-err_release_reg:
-	pci_release_region(pdev, pci_bar);
-err_kfree:
-	kfree(dwpci);
-err_disable:
-	pci_disable_device(pdev);
-	return ret;
+	return 0;
 }
 
 static void spi_pci_remove(struct pci_dev *pdev)
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index abf4fd5..48ec161 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -775,18 +775,16 @@ static void spi_hw_init(struct dw_spi *dws)
 	}
 }
 
-int dw_spi_add_host(struct dw_spi *dws)
+int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 {
 	struct spi_master *master;
 	int ret;
 
 	BUG_ON(dws == NULL);
 
-	master = spi_alloc_master(dws->parent_dev, 0);
-	if (!master) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	master = spi_alloc_master(dev, 0);
+	if (!master)
+		return -ENOMEM;
 
 	dws->master = master;
 	dws->type = SSI_MOTO_SPI;
@@ -796,7 +794,7 @@ int dw_spi_add_host(struct dw_spi *dws)
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d",
 			dws->bus_num);
 
-	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
+	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
 			dws->name, dws);
 	if (ret < 0) {
 		dev_err(&master->dev, "can not get IRQ\n");
@@ -835,7 +833,7 @@ int dw_spi_add_host(struct dw_spi *dws)
 	}
 
 	spi_master_set_devdata(master, dws);
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
 		goto err_queue_alloc;
@@ -850,10 +848,8 @@ err_queue_alloc:
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
@@ -877,10 +873,6 @@ void dw_spi_remove_host(struct dw_spi *dws)
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
index 5a5cd02..587643d 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -92,13 +92,11 @@ struct dw_spi_dma_ops {
 struct dw_spi {
 	struct spi_master	*master;
 	struct spi_device	*cur_dev;
-	struct device		*parent_dev;
 	enum dw_ssi_type	type;
 	char			name[16];
 
 	void __iomem		*regs;
 	unsigned long		paddr;
-	u32			iolen;
 	int			irq;
 	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
@@ -230,7 +228,7 @@ struct dw_spi_chip {
 	void (*cs_control)(u32 command);
 };
 
-extern int dw_spi_add_host(struct dw_spi *dws);
+extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
 extern void dw_spi_remove_host(struct dw_spi *dws);
 extern int dw_spi_suspend_host(struct dw_spi *dws);
 extern int dw_spi_resume_host(struct dw_spi *dws);
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
