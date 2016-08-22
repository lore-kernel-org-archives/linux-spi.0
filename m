From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-dspi: Check clk_prepare_enable() error
Date: Sun, 21 Aug 2016 23:05:30 -0300
Message-ID: <1471831530-8527-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

clk_prepare_enable() may fail, so we should better check its
return value and propagate it in the case of failure.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d57baf6..95d8b92 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -624,10 +624,13 @@ static int dspi_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct fsl_dspi *dspi = spi_master_get_devdata(master);
+	int ret;
 
 	pinctrl_pm_select_default_state(dev);
 
-	clk_prepare_enable(dspi->clk);
+	ret = clk_prepare_enable(dspi->clk);
+	if (ret)
+		return ret;
 	spi_master_resume(master);
 
 	return 0;
@@ -726,7 +729,9 @@ static int dspi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unable to get clock\n");
 		goto out_master_put;
 	}
-	clk_prepare_enable(dspi->clk);
+	ret = clk_prepare_enable(dspi->clk);
+	if (ret)
+		goto out_master_put;
 
 	master->max_speed_hz =
 		clk_get_rate(dspi->clk) / dspi->devtype_data->max_clock_factor;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
