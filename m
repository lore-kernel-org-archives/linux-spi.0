From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] spi/s3c64xx: Convert to dev_pm_ops
Date: Mon,  5 Dec 2011 16:50:12 +0000
Message-ID: <1323103813-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Kukjin Kim <kgene.kim@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In preparation for the addition of runtime PM ops.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 9b16406..fef1c90 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1226,9 +1226,9 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
+static int s3c64xx_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	unsigned long flags;
 
@@ -1248,9 +1248,10 @@ static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int s3c64xx_spi_resume(struct platform_device *pdev)
+static int s3c64xx_spi_resume(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	struct s3c64xx_spi_info *sci = sdd->cntrlr_info;
 	unsigned long flags;
@@ -1269,19 +1270,19 @@ static int s3c64xx_spi_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define s3c64xx_spi_suspend	NULL
-#define s3c64xx_spi_resume	NULL
 #endif /* CONFIG_PM */
 
+static struct dev_pm_ops s3c64xx_spi_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(s3c64xx_spi_suspend, s3c64xx_spi_resume)
+};
+
 static struct platform_driver s3c64xx_spi_driver = {
 	.driver = {
 		.name	= "s3c64xx-spi",
 		.owner = THIS_MODULE,
+		.pm = &s3c64xx_spi_pm,
 	},
 	.remove = s3c64xx_spi_remove,
-	.suspend = s3c64xx_spi_suspend,
-	.resume = s3c64xx_spi_resume,
 };
 MODULE_ALIAS("platform:s3c64xx-spi");
 
-- 
1.7.7.3
