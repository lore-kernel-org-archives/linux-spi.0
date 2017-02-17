From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: ti-qspi: revise ti_qspi_probe() failure flow" to the spi tree
Date: Fri, 17 Feb 2017 13:22:30 +0000
Message-ID: <E1ceiUY-00040s-5s@debutante>
References: <20170216203335.27182-1-prahlad.eee@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216203335.27182-1-prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: ti-qspi: revise ti_qspi_probe() failure flow

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

>From cce59c225920309e03c2ea350ed6a0e233e33963 Mon Sep 17 00:00:00 2001
From: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Fri, 17 Feb 2017 02:03:35 +0530
Subject: [PATCH] spi: ti-qspi: revise ti_qspi_probe() failure flow

call spi_master_put() in case of failures after spi_alloc_master().
call pm_runtime_disable() in case of failures after pm_runtime_enable().

Signed-off-by: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ti-qspi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ec6fb09e2e17..e784d0f64dc1 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -652,7 +652,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (r == NULL) {
 			dev_err(&pdev->dev, "missing platform data\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto free_master;
 		}
 	}
 
@@ -669,7 +670,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return irq;
+		ret = irq;
+		goto free_master;
 	}
 
 	mutex_init(&qspi->list_lock);
@@ -685,15 +687,17 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		qspi->ctrl_base =
 		syscon_regmap_lookup_by_phandle(np,
 						"syscon-chipselects");
-		if (IS_ERR(qspi->ctrl_base))
-			return PTR_ERR(qspi->ctrl_base);
+		if (IS_ERR(qspi->ctrl_base)) {
+			ret = PTR_ERR(qspi->ctrl_base);
+			goto free_master;
+		}
 		ret = of_property_read_u32_index(np,
 						 "syscon-chipselects",
 						 1, &qspi->ctrl_reg);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"couldn't get ctrl_mod reg index\n");
-			return ret;
+			goto free_master;
 		}
 	}
 
@@ -742,6 +746,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (!ret)
 		return 0;
 
+	pm_runtime_disable(&pdev->dev);
 free_master:
 	spi_master_put(master);
 	return ret;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
