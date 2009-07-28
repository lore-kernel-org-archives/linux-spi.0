From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [patch 5/6] spi_s3c24xx: use dev_pm_ops
Date: Tue, 28 Jul 2009 21:51:42 +0100
Message-ID: <20090728205239.591586104@fluff.org>
References: <20090728205137.613851078@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=spi-use-pmops.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Change the spi_s3c24xx driver to use dev_pm_ops to avoid the
following warning during probe:

Platform driver 's3c2410-spi' needs updating - please use dev_pm_ops

Signed-off-by: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---

---
 drivers/spi/spi_s3c24xx.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

Index: b/drivers/spi/spi_s3c24xx.c
===================================================================
--- a/drivers/spi/spi_s3c24xx.c	2009-07-28 15:20:16.000000000 +0100
+++ b/drivers/spi/spi_s3c24xx.c	2009-07-28 15:20:22.000000000 +0100
@@ -418,9 +418,9 @@ static int __exit s3c24xx_spi_remove(str
 
 #ifdef CONFIG_PM
 
-static int s3c24xx_spi_suspend(struct platform_device *pdev, pm_message_t msg)
+static int s3c24xx_spi_suspend(struct device *dev)
 {
-	struct s3c24xx_spi *hw = platform_get_drvdata(pdev);
+	struct s3c24xx_spi *hw = platform_get_drvdata(to_platform_device(dev));
 
 	if (hw->pdata && hw->pdata->gpio_setup)
 		hw->pdata->gpio_setup(hw->pdata, 0);
@@ -429,27 +429,31 @@ static int s3c24xx_spi_suspend(struct pl
 	return 0;
 }
 
-static int s3c24xx_spi_resume(struct platform_device *pdev)
+static int s3c24xx_spi_resume(struct device *dev)
 {
-	struct s3c24xx_spi *hw = platform_get_drvdata(pdev);
+	struct s3c24xx_spi *hw = platform_get_drvdata(to_platform_device(dev));
 
 	s3c24xx_spi_initialsetup(hw);
 	return 0;
 }
 
+static struct dev_pm_ops s3c24xx_spi_pmops = {
+	.suspend	= s3c24xx_spi_suspend,
+	.resume		= s3c24xx_spi_resume,
+};
+
+#define S3C24XX_SPI_PMOPS &s3c24xx_spi_pmops
 #else
-#define s3c24xx_spi_suspend NULL
-#define s3c24xx_spi_resume  NULL
-#endif
+#define S3C24XX_SPI_PMOPS NULL
+#endif /* CONFIG_PM */
 
 MODULE_ALIAS("platform:s3c2410-spi");
 static struct platform_driver s3c24xx_spi_driver = {
 	.remove		= __exit_p(s3c24xx_spi_remove),
-	.suspend	= s3c24xx_spi_suspend,
-	.resume		= s3c24xx_spi_resume,
 	.driver		= {
 		.name	= "s3c2410-spi",
 		.owner	= THIS_MODULE,
+		.pm	= S3C24XX_SPI_PMOPS,
 	},
 };
 

-- 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
