From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH] spi/s3c64xx: Check for errors in dmaengine prepare_transfer()
Date: Thu, 18 Apr 2013 18:14:17 +0100
Message-ID: <1366305257-20942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-p8RBGIrYaKw76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Arnd Bergman <arnd-r2nGTMty4D4@public.gmane.org>
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

Don't silently ignore errors, report them.

Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 drivers/spi/spi-s3c64xx.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 6d6537d..5000586 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -421,6 +421,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	dma_filter_fn filter = sdd->cntrlr_info->filter;
 	struct device *dev = &sdd->pdev->dev;
 	dma_cap_mask_t mask;
+	int ret;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -428,11 +429,34 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	/* Acquire DMA channels */
 	sdd->rx_dma.ch = dma_request_slave_channel_compat(mask, filter,
 				(void*)sdd->rx_dma.dmach, dev, "rx");
+	if (!sdd->rx_dma.ch) {
+		dev_err(dev, "Failed to get RX DMA channel\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
 	sdd->tx_dma.ch = dma_request_slave_channel_compat(mask, filter,
 				(void*)sdd->tx_dma.dmach, dev, "tx");
-	pm_runtime_get_sync(&sdd->pdev->dev);
+	if (!sdd->tx_dma.ch) {
+		dev_err(dev, "Failed to get TX DMA channel\n");
+		ret = -EBUSY;
+		goto out_rx;
+	}
+
+	ret = pm_runtime_get_sync(&sdd->pdev->dev);
+	if (ret != 0) {
+		dev_err(dev, "Failed to enable device: %d\n", ret);
+		goto out_tx;
+	}
 
 	return 0;
+
+out_tx:
+	dma_release_channel(sdd->tx_dma.ch);
+out_rx:
+	dma_release_channel(sdd->rx_dma.ch);
+out:
+	return ret;
 }
 
 static int s3c64xx_spi_unprepare_transfer(struct spi_master *spi)
-- 
1.7.10.4


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
