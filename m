From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [RFC PATCH] spi: zynqmp: Add pm runtime support
Date: Mon, 26 Mar 2018 18:34:20 +0530
Message-ID: <1522069460-4703-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        <shubhrajyoti.datta@xilinx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds runtime pm functions.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 86 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 18aeace..26d1ac3 100644
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
@@ -135,6 +136,7 @@
 #define GQSPI_DMA_UNALIGN		0x3
 #define GQSPI_DEFAULT_NUM_CS	1	/* Default number of chip selects */
 
+#define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
 /**
@@ -356,21 +358,9 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
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
@@ -387,8 +377,6 @@ static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
-	clk_disable(xqspi->refclk);
-	clk_disable(xqspi->pclk);
 	return 0;
 }
 
@@ -959,11 +947,67 @@ static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 
 	spi_master_resume(master);
 
+	clk_disable(xqspi->refclk);
+	clk_disable(xqspi->pclk);
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
@@ -1023,9 +1067,15 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_pclk;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1063,6 +1113,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	return 0;
 
 clk_dis_all:
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
@@ -1090,6 +1142,8 @@ static int zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 	clk_disable_unprepare(xqspi->refclk);
 	clk_disable_unprepare(xqspi->pclk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	spi_unregister_master(master);
 
-- 
2.7.4
