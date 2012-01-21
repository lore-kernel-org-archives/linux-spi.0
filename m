From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] spi/s3c64xx: Convert to dev_pm_ops
Date: Sat, 21 Jan 2012 13:24:24 +0000
Message-ID: <1327152265-10789-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
 <1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1327152265-10789-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In preparation for the addition of runtime PM ops.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/spi/spi-s3c64xx.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index d56066b..56dbdf1 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1231,9 +1231,9 @@ static int s3c64xx_spi_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
+static int s3c64xx_spi_suspend(struct device *dev)
 {
-	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
+	struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
 	struct s3c64xx_spi_driver_data *sdd = spi_master_get_devdata(master);
 	unsigned long flags;
 
@@ -1253,9 +1253,10 @@ static int s3c64xx_spi_suspend(struct platform_device *pdev, pm_message_t state)
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
@@ -1274,19 +1275,19 @@ static int s3c64xx_spi_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define s3c64xx_spi_suspend	NULL
-#define s3c64xx_spi_resume	NULL
 #endif /* CONFIG_PM */
 
+static const struct dev_pm_ops s3c64xx_spi_pm = {
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
