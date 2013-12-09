From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 01/11] spi: davinci: Use devm_*() functions
Date: Mon, 09 Dec 2013 19:12:03 +0900
Message-ID: <000801cef4c7$1b84a470$528ded50$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Santosh Shilimkar' <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	'Matt Porter' <mporter-l0cyMroinI0@public.gmane.org>,
	"'Manjunathappa, Prakash'" <prakash.pm-l0cyMroinI0@public.gmane.org>,
	'Sekhar Nori' <nsekhar-l0cyMroinI0@public.gmane.org>,
	'Murali Karicheri' <m-karicheri2-l0cyMroinI0@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use devm_*() functions to make cleanup paths simpler.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-davinci.c |   41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index d3f6386..79d40c8 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -853,7 +853,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct davinci_spi *dspi;
 	struct davinci_spi_platform_data *pdata;
-	struct resource *r, *mem;
+	struct resource *r;
 	resource_size_t dma_rx_chan = SPI_NO_RESOURCE;
 	resource_size_t	dma_tx_chan = SPI_NO_RESOURCE;
 	int i = 0, ret = 0;
@@ -894,39 +894,33 @@ static int davinci_spi_probe(struct platform_device *pdev)
 
 	dspi->pbase = r->start;
 
-	mem = request_mem_region(r->start, resource_size(r), pdev->name);
-	if (mem == NULL) {
-		ret = -EBUSY;
+	dspi->base = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(dspi->base)) {
+		ret = PTR_ERR(dspi->base);
 		goto free_master;
 	}
 
-	dspi->base = ioremap(r->start, resource_size(r));
-	if (dspi->base == NULL) {
-		ret = -ENOMEM;
-		goto release_region;
-	}
-
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq <= 0) {
 		ret = -EINVAL;
-		goto unmap_io;
+		goto free_master;
 	}
 
-	ret = request_threaded_irq(dspi->irq, davinci_spi_irq, dummy_thread_fn,
-				 0, dev_name(&pdev->dev), dspi);
+	ret = devm_request_threaded_irq(&pdev->dev, dspi->irq, davinci_spi_irq,
+				dummy_thread_fn, 0, dev_name(&pdev->dev), dspi);
 	if (ret)
-		goto unmap_io;
+		goto free_master;
 
 	dspi->bitbang.master = master;
 	if (dspi->bitbang.master == NULL) {
 		ret = -ENODEV;
-		goto irq_free;
+		goto free_master;
 	}
 
-	dspi->clk = clk_get(&pdev->dev, NULL);
+	dspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dspi->clk)) {
 		ret = -ENODEV;
-		goto irq_free;
+		goto free_master;
 	}
 	clk_prepare_enable(dspi->clk);
 
@@ -1015,13 +1009,6 @@ free_dma:
 	dma_release_channel(dspi->dma_tx);
 free_clk:
 	clk_disable_unprepare(dspi->clk);
-	clk_put(dspi->clk);
-irq_free:
-	free_irq(dspi->irq, dspi);
-unmap_io:
-	iounmap(dspi->base);
-release_region:
-	release_mem_region(dspi->pbase, resource_size(r));
 free_master:
 	spi_master_put(master);
 err:
@@ -1041,7 +1028,6 @@ static int davinci_spi_remove(struct platform_device *pdev)
 {
 	struct davinci_spi *dspi;
 	struct spi_master *master;
-	struct resource *r;
 
 	master = platform_get_drvdata(pdev);
 	dspi = spi_master_get_devdata(master);
@@ -1049,11 +1035,6 @@ static int davinci_spi_remove(struct platform_device *pdev)
 	spi_bitbang_stop(&dspi->bitbang);
 
 	clk_disable_unprepare(dspi->clk);
-	clk_put(dspi->clk);
-	free_irq(dspi->irq, dspi);
-	iounmap(dspi->base);
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(dspi->pbase, resource_size(r));
 	spi_master_put(master);
 
 	return 0;
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
