From: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: [PATCH] SPI: spi-orion: add runtime PM support
Date: Sat, 21 Jun 2014 11:32:28 +0100
Message-ID: <E1WyIay-0008KP-Mm@rmk-PC.arm.linux.org.uk>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add trivial runtime PM support.  This will only be of benefit on SoCs
where the clock to the SPI interface can be shut down.

Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
---
Patch generated against v3.15

 drivers/spi/spi-orion.c | 71 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 24844984ef36..0c229f9fec9c 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
@@ -23,6 +24,9 @@
 
 #define DRIVER_NAME			"orion_spi"
 
+/* Runtime PM autosuspend timeout: PM is fairly light on this driver */
+#define SPI_AUTOSUSPEND_TIMEOUT		200
+
 #define ORION_NUM_CHIPSELECTS		1 /* only one slave is supported*/
 #define ORION_SPI_WAIT_RDY_MAX_LOOP	2000 /* in usec */
 
@@ -277,6 +281,18 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	return xfer->len - count;
 }
 
+static int orion_spi_prepare_transfer(struct spi_master *master)
+{
+	int ret = pm_runtime_get_sync(master->dev.parent);
+	return ret < 0 ? ret : 0;
+}
+
+static int orion_spi_unprepare_transfer(struct spi_master *master)
+{
+	pm_runtime_mark_last_busy(master->dev.parent);
+	pm_runtime_put_autosuspend(master->dev.parent);
+	return 0;
+}
 
 static int orion_spi_transfer_one_message(struct spi_master *master,
 					   struct spi_message *m)
@@ -367,6 +383,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	/* we support only mode 0, and no options */
 	master->mode_bits = SPI_CPHA | SPI_CPOL;
 
+	master->prepare_transfer_hardware = orion_spi_prepare_transfer;
+	master->unprepare_transfer_hardware = orion_spi_unprepare_transfer;
 	master->transfer_one_message = orion_spi_transfer_one_message;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
@@ -397,16 +415,26 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out_rel_clk;
 	}
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_enable(&pdev->dev);
+
 	if (orion_spi_reset(spi) < 0)
-		goto out_rel_clk;
+		goto out_rel_pm;
+
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
-	status = devm_spi_register_master(&pdev->dev, master);
+	status = spi_register_master(master);
 	if (status < 0)
-		goto out_rel_clk;
+		goto out_rel_pm;
 
 	return status;
 
+out_rel_pm:
+	pm_runtime_disable(&pdev->dev);
 out_rel_clk:
 	clk_disable_unprepare(spi->clk);
 out:
@@ -417,19 +445,45 @@ static int orion_spi_probe(struct platform_device *pdev)
 
 static int orion_spi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master;
-	struct orion_spi *spi;
-
-	master = platform_get_drvdata(pdev);
-	spi = spi_master_get_devdata(master);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct orion_spi *spi = spi_master_get_devdata(master);
 
+	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->clk);
 
+	spi_unregister_master(master);
+	pm_runtime_disable(&pdev->dev);
+
 	return 0;
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
+#ifdef CONFIG_PM_RUNTIME
+static int orion_spi_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct orion_spi *spi = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(spi->clk);
+	return 0;
+}
+
+static int orion_spi_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct orion_spi *spi = spi_master_get_devdata(master);
+
+	return clk_prepare_enable(spi->clk);
+}
+#endif
+
+static const struct dev_pm_ops orion_spi_pm_ops = {
+	SET_RUNTIME_PM_OPS(orion_spi_runtime_suspend,
+			   orion_spi_runtime_resume,
+			   NULL)
+};
+
 static const struct of_device_id orion_spi_of_match_table[] = {
 	{ .compatible = "marvell,orion-spi", },
 	{}
@@ -440,6 +494,7 @@ static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.pm	= &orion_spi_pm_ops,
 		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
 	.probe		= orion_spi_probe,
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
