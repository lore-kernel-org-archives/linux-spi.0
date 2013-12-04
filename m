From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] spi: spi-atmel: Use devm_*() functions
Date: Wed, 04 Dec 2013 14:07:51 +0900
Message-ID: <002b01cef0ae$c8261dc0$58725940$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Nicolas Ferre' <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-atmel.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 273db0b..57fa738 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1510,7 +1510,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	clk = clk_get(&pdev->dev, "spi_clk");
+	clk = devm_clk_get(&pdev->dev, "spi_clk");
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -1570,14 +1570,14 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "Atmel SPI Controller using PIO only\n");
 
 	if (as->use_pdc) {
-		ret = request_irq(irq, atmel_spi_pdc_interrupt, 0,
-					dev_name(&pdev->dev), master);
+		ret = devm_request_irq(&pdev->dev, irq, atmel_spi_pdc_interrupt,
+					0, dev_name(&pdev->dev), master);
 	} else {
 		tasklet_init(&as->tasklet, atmel_spi_tasklet_func,
 					(unsigned long)master);
 
-		ret = request_irq(irq, atmel_spi_pio_interrupt, 0,
-					dev_name(&pdev->dev), master);
+		ret = devm_request_irq(&pdev->dev, irq, atmel_spi_pio_interrupt,
+					0, dev_name(&pdev->dev), master);
 	}
 	if (ret)
 		goto out_unmap_regs;
@@ -1603,7 +1603,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "Atmel SPI Controller at 0x%08lx (irq %d)\n",
 			(unsigned long)regs->start, irq);
 
-	ret = spi_register_master(master);
+	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret)
 		goto out_free_dma;
 
@@ -1617,7 +1617,6 @@ out_free_dma:
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	clk_disable_unprepare(clk);
 out_free_irq:
-	free_irq(irq, master);
 out_unmap_regs:
 out_free_buffer:
 	if (!as->use_pdc)
@@ -1625,7 +1624,6 @@ out_free_buffer:
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 out_free:
-	clk_put(clk);
 	spi_master_put(master);
 	return ret;
 }
@@ -1668,10 +1666,6 @@ static int atmel_spi_remove(struct platform_device *pdev)
 			as->buffer_dma);
 
 	clk_disable_unprepare(as->clk);
-	clk_put(as->clk);
-	free_irq(as->irq, master);
-
-	spi_unregister_master(master);
 
 	return 0;
 }
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
