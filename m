From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-fsl-dspi: Check clk_prepare_enable() error" to the spi tree
Date: Mon, 22 Aug 2016 18:59:44 +0100
Message-ID: <E1bbtVg-000135-Re@debutante>
References: <1471831530-8527-1-git-send-email-festevam@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471831530-8527-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-fsl-dspi: Check clk_prepare_enable() error

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1c5ea2b4de22434b9da9c33640f47458ba093dea Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Date: Sun, 21 Aug 2016 23:05:30 -0300
Subject: [PATCH] spi: spi-fsl-dspi: Check clk_prepare_enable() error

clk_prepare_enable() may fail, so we should better check its
return value and propagate it in the case of failure.

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index d57baf6c2d1e..95d8b929cd52 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
