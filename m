From: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/atmel: improve the system suspend/resume functions implementation
Date: Tue, 21 Oct 2014 11:43:34 +0800
Message-ID: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

To make it cleaner, the system suspend/resume directly call
the runtime suspend/resume functions
and remove the wapper of CONFIG_PM_RUNTIME, CONFIG_PM_SLEEP.

Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-atmel.c |   61 ++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 3f50014..6ed1893 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1451,11 +1451,30 @@ static int atmel_spi_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-#ifdef CONFIG_PM_SLEEP
+static int atmel_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(as->clk);
+	pinctrl_pm_select_sleep_state(dev);
+
+	return 0;
+}
+
+static int atmel_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct atmel_spi *as = spi_master_get_devdata(master);
+
+	pinctrl_pm_select_default_state(dev);
+
+	return clk_prepare_enable(as->clk);
+}
+
 static int atmel_spi_suspend(struct device *dev)
 {
-	struct spi_master	*master = dev_get_drvdata(dev);
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_master *master = dev_get_drvdata(dev);
 	int ret;
 
 	/* Stop the queue running */
@@ -1465,23 +1484,19 @@ static int atmel_spi_suspend(struct device *dev)
 		return ret;
 	}
 
-	if (!pm_runtime_suspended(dev)) {
-		clk_disable_unprepare(as->clk);
-		pinctrl_pm_select_sleep_state(dev);
-	}
+	if (!pm_runtime_suspended(dev))
+		atmel_spi_runtime_suspend(dev);
 
 	return 0;
 }
 
 static int atmel_spi_resume(struct device *dev)
 {
-	struct spi_master	*master = dev_get_drvdata(dev);
-	struct atmel_spi	*as = spi_master_get_devdata(master);
+	struct spi_master *master = dev_get_drvdata(dev);
 	int ret;
 
 	if (!pm_runtime_suspended(dev)) {
-		pinctrl_pm_select_default_state(dev);
-		ret = clk_prepare_enable(as->clk);
+		ret = atmel_spi_runtime_resume(dev);
 		if (ret)
 			return ret;
 	}
@@ -1493,30 +1508,6 @@ static int atmel_spi_resume(struct device *dev)
 
 	return ret;
 }
-#endif
-
-#ifdef CONFIG_PM_RUNTIME
-static int atmel_spi_runtime_suspend(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct atmel_spi *as = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(as->clk);
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-
-static int atmel_spi_runtime_resume(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct atmel_spi *as = spi_master_get_devdata(master);
-
-	pinctrl_pm_select_default_state(dev);
-
-	return clk_prepare_enable(as->clk);
-}
-#endif
 
 static const struct dev_pm_ops atmel_spi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
