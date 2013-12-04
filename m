From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] spi: coldfire-qspi: Use devm_*() functions
Date: Wed, 04 Dec 2013 14:10:10 +0900
Message-ID: <002c01cef0af$1b3a4630$51aed290$%han@samsung.com>
References: <002b01cef0ae$c8261dc0$58725940$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Steven King' <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002b01cef0ae$c8261dc0$58725940$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c |   47 ++++++++++++---------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index cc5b75d..9ee81a4 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -403,38 +403,31 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		goto fail0;
 	}
 
-	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
-		dev_dbg(&pdev->dev, "request_mem_region failed\n");
-		status = -EBUSY;
+	mcfqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mcfqspi->iobase)) {
+		status = PTR_ERR(mcfqspi->iobase);
 		goto fail0;
 	}
 
-	mcfqspi->iobase = ioremap(res->start, resource_size(res));
-	if (!mcfqspi->iobase) {
-		dev_dbg(&pdev->dev, "ioremap failed\n");
-		status = -ENOMEM;
-		goto fail1;
-	}
-
 	mcfqspi->irq = platform_get_irq(pdev, 0);
 	if (mcfqspi->irq < 0) {
 		dev_dbg(&pdev->dev, "platform_get_irq failed\n");
 		status = -ENXIO;
-		goto fail2;
+		goto fail0;
 	}
 
-	status = request_irq(mcfqspi->irq, mcfqspi_irq_handler, 0,
-			     pdev->name, mcfqspi);
+	status = devm_request_irq(&pdev->dev, mcfqspi->irq, mcfqspi_irq_handler,
+				0, pdev->name, mcfqspi);
 	if (status) {
 		dev_dbg(&pdev->dev, "request_irq failed\n");
-		goto fail2;
+		goto fail0;
 	}
 
-	mcfqspi->clk = clk_get(&pdev->dev, "qspi_clk");
+	mcfqspi->clk = devm_clk_get(&pdev->dev, "qspi_clk");
 	if (IS_ERR(mcfqspi->clk)) {
 		dev_dbg(&pdev->dev, "clk_get failed\n");
 		status = PTR_ERR(mcfqspi->clk);
-		goto fail3;
+		goto fail0;
 	}
 	clk_enable(mcfqspi->clk);
 
@@ -445,7 +438,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	status = mcfqspi_cs_setup(mcfqspi);
 	if (status) {
 		dev_dbg(&pdev->dev, "error initializing cs_control\n");
-		goto fail4;
+		goto fail1;
 	}
 
 	init_waitqueue_head(&mcfqspi->waitq);
@@ -459,10 +452,10 @@ static int mcfqspi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, master);
 
-	status = spi_register_master(master);
+	status = devm_spi_register_master(&pdev->dev, master);
 	if (status) {
 		dev_dbg(&pdev->dev, "spi_register_master failed\n");
-		goto fail5;
+		goto fail2;
 	}
 	pm_runtime_enable(mcfqspi->dev);
 
@@ -470,17 +463,10 @@ static int mcfqspi_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail5:
-	mcfqspi_cs_teardown(mcfqspi);
-fail4:
-	clk_disable(mcfqspi->clk);
-	clk_put(mcfqspi->clk);
-fail3:
-	free_irq(mcfqspi->irq, mcfqspi);
 fail2:
-	iounmap(mcfqspi->iobase);
+	mcfqspi_cs_teardown(mcfqspi);
 fail1:
-	release_mem_region(res->start, resource_size(res));
+	clk_disable(mcfqspi->clk);
 fail0:
 	spi_master_put(master);
 
@@ -501,11 +487,6 @@ static int mcfqspi_remove(struct platform_device *pdev)
 
 	mcfqspi_cs_teardown(mcfqspi);
 	clk_disable(mcfqspi->clk);
-	clk_put(mcfqspi->clk);
-	free_irq(mcfqspi->irq, mcfqspi);
-	iounmap(mcfqspi->iobase);
-	release_mem_region(res->start, resource_size(res));
-	spi_unregister_master(master);
 
 	return 0;
 }
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
