From: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv2] spi: zynqmp: Add runtime support
Date: Fri, 3 Mar 2017 10:41:24 +0530
Message-ID: <1488517884-31977-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
        <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add PM runtime support for the zynqmp qspi driver.
spi core has the runtime support register to the spi core auto runtime pm.
Also removes the clock enable and disable as the spi core will
now do it for us.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
---
v2:
Update the commit message.

 drivers/spi/spi-zynqmp-gqspi.c | 90 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 0b3ba7a..980877a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
@@ -156,6 +157,7 @@
 #define GQSPI_FREQ_150MHZ	150000000
 #define IOU_TAPDLY_BYPASS_MASK	0x7
 
+#define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
@@ -424,21 +426,9 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
 static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
 {
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
-	int ret;
-
-	ret = clk_enable(xqspi->refclk);
-	if (ret)
-		return ret;
-
-	ret = clk_enable(xqspi->pclk);
-	if (ret)
-		goto clk_err;
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
 	return 0;
-clk_err:
-	clk_disable(xqspi->refclk);
-	return ret;
 }
 
 /**
@@ -455,8 +445,6 @@ static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
-	clk_disable(xqspi->refclk);
-	clk_disable(xqspi->pclk);
 	return 0;
 }
 
@@ -1054,11 +1042,14 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spi_master *master = platform_get_drvdata(pdev);
+	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 
 	spi_master_suspend(master);
 
 	zynqmp_unprepare_transfer_hardware(master);
 
+	clk_disable(xqspi->refclk);
+	clk_disable(xqspi->pclk);
 	return 0;
 }
 
@@ -1097,8 +1088,62 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(zynqmp_qspi_dev_pm_ops, zynqmp_qspi_suspend,
-			 zynqmp_qspi_resume);
+/**
+ * zynqmp_runtime_suspend - Runtime suspend method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function disables the clocks
+ *
+ * Return:	Always 0
+ */
+static int __maybe_unused zynqmp_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+
+	clk_disable(xqspi->refclk);
+	clk_disable(xqspi->pclk);
+
+	return 0;
+}
+
+/**
+ * zynqmp_runtime_resume - Runtime resume method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function enables the clocks
+ *
+ * Return:	0 on success and error value on error
+ */
+static int __maybe_unused zynqmp_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_enable(xqspi->pclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable APB clock.\n");
+		return ret;
+	}
+
+	ret = clk_enable(xqspi->refclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable device clock.\n");
+		clk_disable(xqspi->pclk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops zynqmp_qspi_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(zynqmp_runtime_suspend,
+			   zynqmp_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(zynqmp_qspi_suspend, zynqmp_qspi_resume)
+};
 
 /**
  * zynqmp_qspi_probe:	Probe method for the QSPI driver
@@ -1161,12 +1206,20 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	if (of_property_read_bool(pdev->dev.of_node, "has-io-mode"))
 		xqspi->io_mode = true;
 
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1210,6 +1263,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	xqspi->speed_hz = master->max_speed_hz;
+	master->auto_runtime_pm = true;
 
 	if (master->dev.parent == NULL)
 		master->dev.parent = &master->dev;
@@ -1223,6 +1277,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1250,6 +1306,8 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	spi_unregister_master(master);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
