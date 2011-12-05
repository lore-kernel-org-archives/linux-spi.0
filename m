From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] spi/s3c64xx: Implement runtime PM support
Date: Mon,  5 Dec 2011 21:01:03 +0000
Message-ID: <1323118863-19890-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1323118863-19890-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	patches@opensource.wolfsonmicro.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1323118863-19890-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Enable and disable the clocks to the SPI controller using runtime PM. This
serves the dual purpose of reducing power consumption a little and letting
the core know when the device is idle.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d0c70f2..b899af66 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -25,6 +25,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
 #include <mach/dma.h>
@@ -782,6 +783,8 @@ static void s3c64xx_spi_work(struct work_struct *work)
 	while (!acquire_dma(sdd))
 		msleep(10);
 
+	pm_runtime_get_sync(&sdd->pdev->dev);
+
 	spin_lock_irqsave(&sdd->lock, flags);
 
 	while (!list_empty(&sdd->queue)
@@ -810,6 +813,8 @@ static void s3c64xx_spi_work(struct work_struct *work)
 	/* Free DMA channels */
 	sdd->ops->release(sdd->rx_dma.ch, &s3c64xx_spi_dma_client);
 	sdd->ops->release(sdd->tx_dma.ch, &s3c64xx_spi_dma_client);
+
+	pm_runtime_put(&sdd->pdev->dev);
 }
 
 static int s3c64xx_spi_transfer(struct spi_device *spi,
@@ -892,6 +897,8 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		goto setup_exit;
 	}
 
+	pm_runtime_get_sync(&sdd->pdev->dev);
+
 	/* Check if we can provide the requested rate */
 	if (!sci->clk_from_cmu) {
 		u32 psr, speed;
@@ -924,6 +931,8 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 			err = -EINVAL;
 	}
 
+	pm_runtime_put(&sdd->pdev->dev);
+
 setup_exit:
 
 	/* setup() returns with device de-selected */
@@ -1159,6 +1168,8 @@ static int __init s3c64xx_spi_probe(struct platform_device *pdev)
 					mem_res->end, mem_res->start,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 
 err9:
@@ -1192,6 +1203,8 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 	struct resource	*mem_res;
 	unsigned long flags;
 
+	pm_runtime_disable(&pdev->dev);
+
 	spin_lock_irqsave(&sdd->lock, flags);
 	sdd->state |= SUSPND;
 	spin_unlock_irqrestore(&sdd->lock, flags);
@@ -1272,8 +1285,34 @@ static int s3c64xx_spi_resume(struct device *dev)
 }
 #endif /* CONFIG_PM */
 
+#ifdef CONFIG_PM_RUNTIME
+static int s3c64xx_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+
+	clk_disable(sdd->clk);
+	clk_disable(sdd->src_clk);
+
+	return 0;
+}
+
+static int s3c64xx_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
+
+	clk_enable(sdd->src_clk);
+	clk_enable(sdd->clk);
+
+	return 0;
+}
+#endif /* CONFIG_PM_RUNTIME */
+
 static const struct dev_pm_ops s3c64xx_spi_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(s3c64xx_spi_suspend, s3c64xx_spi_resume)
+	SET_RUNTIME_PM_OPS(s3c64xx_spi_runtime_suspend,
+			   s3c64xx_spi_runtime_resume, NULL)
 };
 
 static struct platform_driver s3c64xx_spi_driver = {
-- 
1.7.7.3
