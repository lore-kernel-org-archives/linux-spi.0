From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] spi/pl022: use more managed resources
Date: Wed, 26 Sep 2012 16:48:36 +0200
Message-ID: <1348670916-26267-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

This switches the PL022 SPI driver to use devm_* managed resources
for IRQ, clocks, ioremap and GPIO. Prior to this, the GPIOs would
even leak.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/spi/spi-pl022.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f8568b4..15737bc 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1,7 +1,7 @@
 /*
  * A driver for the ARM PL022 PrimeCell SSP/SPI bus master.
  *
- * Copyright (C) 2008-2009 ST-Ericsson AB
+ * Copyright (C) 2008-2012 ST-Ericsson AB
  * Copyright (C) 2006 STMicroelectronics Pvt. Ltd.
  *
  * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
@@ -2074,24 +2074,21 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	if (!platform_info) {
 		dev_err(dev, "probe: no platform data defined\n");
-		status = -ENODEV;
-		goto err_no_pdata;
+		return -ENODEV;
 	}
 
 	if (platform_info->num_chipselect) {
 		num_cs = platform_info->num_chipselect;
 	} else {
 		dev_err(dev, "probe: no chip select defined\n");
-		status = -ENODEV;
-		goto err_no_pdata;
+		return -ENODEV;
 	}
 
 	/* Allocate master with space for data */
 	master = spi_alloc_master(dev, sizeof(struct pl022));
 	if (master == NULL) {
 		dev_err(&adev->dev, "probe - cannot alloc SPI master\n");
-		status = -ENOMEM;
-		goto err_no_master;
+		return -ENOMEM;
 	}
 
 	pl022 = spi_master_get_devdata(master);
@@ -2153,7 +2150,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 			pl022->chipselects[i] = cs_gpio;
 
 			if (gpio_is_valid(cs_gpio)) {
-				if (gpio_request(cs_gpio, "ssp-pl022"))
+				if (devm_gpio_request(dev, cs_gpio, "ssp-pl022"))
 					dev_err(&adev->dev,
 						"could not request %d gpio\n",
 						cs_gpio);
@@ -2180,7 +2177,8 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_no_ioregion;
 
 	pl022->phybase = adev->res.start;
-	pl022->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
+	pl022->virtbase = devm_ioremap(dev, adev->res.start,
+				       resource_size(&adev->res));
 	if (pl022->virtbase == NULL) {
 		status = -ENOMEM;
 		goto err_no_ioremap;
@@ -2190,7 +2188,7 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	pm_runtime_resume(dev);
 
-	pl022->clk = clk_get(&adev->dev, NULL);
+	pl022->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
 		status = PTR_ERR(pl022->clk);
 		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
@@ -2218,8 +2216,8 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	       SSP_CR1(pl022->virtbase));
 	load_ssp_default_config(pl022);
 
-	status = request_irq(adev->irq[0], pl022_interrupt_handler, 0, "pl022",
-			     pl022);
+	status = devm_request_irq(dev, adev->irq[0], pl022_interrupt_handler,
+				  0, "pl022", pl022);
 	if (status < 0) {
 		dev_err(&adev->dev, "probe - cannot get IRQ (%d)\n", status);
 		goto err_no_irq;
@@ -2259,24 +2257,18 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
  err_spi_register:
 	if (platform_info->enable_dma)
 		pl022_dma_remove(pl022);
-
-	free_irq(adev->irq[0], pl022);
  err_no_irq:
 	clk_disable(pl022->clk);
  err_no_clk_en:
 	clk_unprepare(pl022->clk);
  err_clk_prep:
-	clk_put(pl022->clk);
  err_no_clk:
-	iounmap(pl022->virtbase);
  err_no_ioremap:
 	amba_release_regions(adev);
  err_no_ioregion:
  err_no_gpio:
  err_no_pinctrl:
 	spi_master_put(master);
- err_no_master:
- err_no_pdata:
 	return status;
 }
 
@@ -2298,12 +2290,9 @@ pl022_remove(struct amba_device *adev)
 	if (pl022->master_info->enable_dma)
 		pl022_dma_remove(pl022);
 
-	free_irq(adev->irq[0], pl022);
 	clk_disable(pl022->clk);
 	clk_unprepare(pl022->clk);
-	clk_put(pl022->clk);
 	pm_runtime_disable(&adev->dev);
-	iounmap(pl022->virtbase);
 	amba_release_regions(adev);
 	tasklet_disable(&pl022->pump_transfers);
 	spi_unregister_master(pl022->master);
-- 
1.7.11.3


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
