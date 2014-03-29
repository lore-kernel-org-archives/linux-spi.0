From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: Convert to use devm_kcalloc
Date: Sat, 29 Mar 2014 21:37:44 +0800
Message-ID: <1396100264.10175.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This saves a few unwind code and return proper error if devm_kcalloc fails.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2941c5b..4dc77df 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1379,12 +1379,13 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&mcspi->ctx.cs);
 
-	mcspi->dma_channels = kcalloc(master->num_chipselect,
-			sizeof(struct omap2_mcspi_dma),
-			GFP_KERNEL);
-
-	if (mcspi->dma_channels == NULL)
+	mcspi->dma_channels = devm_kcalloc(&pdev->dev, master->num_chipselect,
+					   sizeof(struct omap2_mcspi_dma),
+					   GFP_KERNEL);
+	if (mcspi->dma_channels == NULL) {
+		status = -ENOMEM;
 		goto free_master;
+	}
 
 	for (i = 0; i < master->num_chipselect; i++) {
 		char *dma_rx_ch_name = mcspi->dma_channels[i].dma_rx_ch_name;
@@ -1426,7 +1427,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	if (status < 0)
-		goto dma_chnl_free;
+		goto free_master;
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
@@ -1444,8 +1445,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
-dma_chnl_free:
-	kfree(mcspi->dma_channels);
 free_master:
 	spi_master_put(master);
 	return status;
@@ -1453,19 +1452,12 @@ free_master:
 
 static int omap2_mcspi_remove(struct platform_device *pdev)
 {
-	struct spi_master	*master;
-	struct omap2_mcspi	*mcspi;
-	struct omap2_mcspi_dma	*dma_channels;
-
-	master = platform_get_drvdata(pdev);
-	mcspi = spi_master_get_devdata(master);
-	dma_channels = mcspi->dma_channels;
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	kfree(dma_channels);
-
 	return 0;
 }
 
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
