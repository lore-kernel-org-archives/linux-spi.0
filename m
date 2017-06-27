From: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Subject: [PATCHv2 6/9] spi: stm32: add runtime PM support
Date: Tue, 27 Jun 2017 17:45:18 +0200
Message-ID: <1498578321-13980-7-git-send-email-amelie.delaunay@st.com>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498578321-13980-1-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch reworks suspend and resume callbacks and add runtime_suspend
and runtime_resume callbacks.

Signed-off-by: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
---
 drivers/spi/spi-stm32.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 72efc63..209afda 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -27,6 +27,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
@@ -1164,6 +1165,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	if (spi->dma_tx || spi->dma_rx)
 		master->can_dma = stm32_spi_can_dma;
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed: %d\n",
@@ -1203,6 +1207,8 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		dma_release_channel(spi->dma_tx);
 	if (spi->dma_rx)
 		dma_release_channel(spi->dma_rx);
+
+	pm_runtime_disable(&pdev->dev);
 err_clk_disable:
 	clk_disable_unprepare(spi->clk);
 err_master_put:
@@ -1225,23 +1231,42 @@ static int stm32_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(spi->clk);
 
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int stm32_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(spi->clk);
+
+	return 0;
+}
+
+static int stm32_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct stm32_spi *spi = spi_master_get_devdata(master);
+
+	return clk_prepare_enable(spi->clk);
+}
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 static int stm32_spi_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
-	struct stm32_spi *spi = spi_master_get_devdata(master);
 	int ret;
 
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(spi->clk);
-
-	return ret;
+	return pm_runtime_force_suspend(dev);
 }
 
 static int stm32_spi_resume(struct device *dev)
@@ -1250,9 +1275,10 @@ static int stm32_spi_resume(struct device *dev)
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_prepare_enable(spi->clk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
+
 	ret = spi_master_resume(master);
 	if (ret)
 		clk_disable_unprepare(spi->clk);
@@ -1261,8 +1287,11 @@ static int stm32_spi_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(stm32_spi_pm_ops,
-			 stm32_spi_suspend, stm32_spi_resume);
+static const struct dev_pm_ops stm32_spi_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_spi_suspend, stm32_spi_resume)
+	SET_RUNTIME_PM_OPS(stm32_spi_runtime_suspend,
+			   stm32_spi_runtime_resume, NULL)
+};
 
 static struct platform_driver stm32_spi_driver = {
 	.probe = stm32_spi_probe,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
