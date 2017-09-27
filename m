From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2] spi: mxs: implement runtime pm
Date: Wed, 27 Sep 2017 17:39:22 +0200
Message-ID: <20170927153922.15321-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a straight forward addition of runtime and system sleep pm operations
that handle clk and pinctrl (for runtime pm) and spi_master_{suspend,resume}
(for system sleep).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since v1 (Message-Id: 20170426201028.19217-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org):

 - Make use of auto_runtime_pm
 - drop a stray dev_info()

 drivers/spi/spi-mxs.c | 120 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 110 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 5b0e9a3e83f6..3d216b950b41 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -44,6 +44,7 @@
 #include <linux/completion.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/stmp_device.h>
 #include <linux/spi/spi.h>
@@ -442,6 +443,85 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 	return status;
 }
 
+static int mxs_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mxs_spi *spi = spi_master_get_devdata(master);
+	struct mxs_ssp *ssp = &spi->ssp;
+	int ret;
+
+	clk_disable_unprepare(ssp->clk);
+
+	ret = pinctrl_pm_select_idle_state(dev);
+	if (ret) {
+		int ret2 = clk_prepare_enable(ssp->clk);
+
+		if (ret2)
+			dev_warn(dev, "Failed to reenable clock after failing pinctrl request (pinctrl: %d, clk: %d)\n",
+				 ret, ret2);
+	}
+
+	return ret;
+}
+
+static int mxs_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct mxs_spi *spi = spi_master_get_devdata(master);
+	struct mxs_ssp *ssp = &spi->ssp;
+	int ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ssp->clk);
+	if (ret)
+		pinctrl_pm_select_idle_state(dev);
+
+	return ret;
+}
+
+static int __maybe_unused mxs_spi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	ret = spi_master_suspend(master);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		return mxs_spi_runtime_suspend(dev);
+	else
+		return 0;
+}
+
+static int __maybe_unused mxs_spi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	int ret;
+
+	if (!pm_runtime_suspended(dev))
+		ret = mxs_spi_runtime_resume(dev);
+	else
+		ret = 0;
+	if (ret)
+		return ret;
+
+	ret = spi_master_resume(master);
+	if (ret < 0 && !pm_runtime_suspended(dev))
+		mxs_spi_runtime_suspend(dev);
+
+	return ret;
+}
+
+static const struct dev_pm_ops mxs_spi_pm = {
+	SET_RUNTIME_PM_OPS(mxs_spi_runtime_suspend,
+			   mxs_spi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(mxs_spi_suspend, mxs_spi_resume)
+};
+
 static const struct of_device_id mxs_spi_dt_ids[] = {
 	{ .compatible = "fsl,imx23-spi", .data = (void *) IMX23_SSP, },
 	{ .compatible = "fsl,imx28-spi", .data = (void *) IMX28_SSP, },
@@ -493,12 +573,15 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, master);
+
 	master->transfer_one_message = mxs_spi_transfer_one;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 	master->num_chipselect = 3;
 	master->dev.of_node = np;
 	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->auto_runtime_pm = true;
 
 	spi = spi_master_get_devdata(master);
 	ssp = &spi->ssp;
@@ -521,28 +604,41 @@ static int mxs_spi_probe(struct platform_device *pdev)
 		goto out_master_free;
 	}
 
-	ret = clk_prepare_enable(ssp->clk);
-	if (ret)
-		goto out_dma_release;
+	pm_runtime_enable(ssp->dev);
+	if (!pm_runtime_enabled(ssp->dev)) {
+		ret = mxs_spi_runtime_resume(ssp->dev);
+		if (ret < 0) {
+			dev_err(ssp->dev, "runtime resume failed\n");
+			goto out_dma_release;
+		}
+	}
+
+	ret = pm_runtime_get_sync(ssp->dev);
+	if (ret < 0) {
+		dev_err(ssp->dev, "runtime_get_sync failed\n");
+		goto out_pm_runtime_disable;
+	}
 
 	clk_set_rate(ssp->clk, clk_freq);
 
 	ret = stmp_reset_block(ssp->base);
 	if (ret)
-		goto out_disable_clk;
-
-	platform_set_drvdata(pdev, master);
+		goto out_pm_runtime_put;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register SPI master, %d\n", ret);
-		goto out_disable_clk;
+		goto out_pm_runtime_put;
 	}
 
+	pm_runtime_put(ssp->dev);
+
 	return 0;
 
-out_disable_clk:
-	clk_disable_unprepare(ssp->clk);
+out_pm_runtime_put:
+	pm_runtime_put(ssp->dev);
+out_pm_runtime_disable:
+	pm_runtime_disable(ssp->dev);
 out_dma_release:
 	dma_release_channel(ssp->dmach);
 out_master_free:
@@ -560,7 +656,10 @@ static int mxs_spi_remove(struct platform_device *pdev)
 	spi = spi_master_get_devdata(master);
 	ssp = &spi->ssp;
 
-	clk_disable_unprepare(ssp->clk);
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mxs_spi_runtime_suspend(&pdev->dev);
+
 	dma_release_channel(ssp->dmach);
 
 	return 0;
@@ -572,6 +671,7 @@ static struct platform_driver mxs_spi_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.of_match_table = mxs_spi_dt_ids,
+		.pm = &mxs_spi_pm,
 	},
 };
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
