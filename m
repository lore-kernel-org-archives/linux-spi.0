From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [RFT][PATCH 1/2] spi: s3c24xx: Add missing
 spi_master_{resume,suspend} calls to PM callbacks
Date: Wed, 05 Mar 2014 15:17:23 +0800
Message-ID: <1394003843.18343.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is required since commit 2025172e3280 "spi/bitbang: Use core message pump".
spi-bitbang now uses core message pump, so it needs to call spi_master_suspend/
spi_master_resume to start/stop the queue while suspend/resume.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-s3c24xx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index a275445..bed2338 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -633,6 +633,11 @@ static int s3c24xx_spi_remove(struct platform_device *dev)
 static int s3c24xx_spi_suspend(struct device *dev)
 {
 	struct s3c24xx_spi *hw = dev_get_drvdata(dev);
+	int ret;
+
+	ret = spi_master_suspend(hw->master);
+	if (ret)
+		return ret;
 
 	if (hw->pdata && hw->pdata->gpio_setup)
 		hw->pdata->gpio_setup(hw->pdata, 0);
@@ -646,7 +651,7 @@ static int s3c24xx_spi_resume(struct device *dev)
 	struct s3c24xx_spi *hw = dev_get_drvdata(dev);
 
 	s3c24xx_spi_initialsetup(hw);
-	return 0;
+	return spi_master_resume(hw->master);
 }
 
 static const struct dev_pm_ops s3c24xx_spi_pmops = {
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
