From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 5/7] spi: cadence: Runtime pm adaptation
Date: Tue, 5 Apr 2016 23:37:52 +0530
Message-ID: <1459879674-13012-5-git-send-email-shubhraj@xilinx.com>
References: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
	Shubhrajyoti Datta <shubhraj@xilinx.com>
To: <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459879674-13012-1-git-send-email-shubhraj@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently the clocks are enabled at probe and disabled
at remove. This patch moves the clock enable to the
start of transaction and disables at the end.

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/spi/spi-cadence.c |   70 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 8a6fee9..3b94063 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -19,6 +19,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
 
 /* Name of this driver */
@@ -37,6 +38,7 @@
 #define CDNS_SPI_SICR	0x24 /* Slave Idle Count Register, RW */
 #define CDNS_SPI_THLD	0x28 /* Transmit FIFO Watermark Register,RW */
 
+#define SPI_AUTOSUSPEND_TIMEOUT		3000
 /*
  * SPI Configuration Register bit Masks
  *
@@ -509,6 +511,11 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_apb;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_set_active(&pdev->dev);
+
 	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &num_cs);
 	if (ret < 0)
 		master->num_chipselect = CDNS_SPI_DEFAULT_NUM_CS;
@@ -523,6 +530,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	/* SPI controller initializations */
 	cdns_spi_init_hw(xspi);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		ret = -ENXIO;
@@ -543,6 +553,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	master->transfer_one = cdns_transfer_one;
 	master->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
 	master->set_cs = cdns_spi_chipselect;
+	master->auto_runtime_pm = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 
 	/* Set to default valid value */
@@ -560,6 +571,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	return ret;
 
 clk_dis_all:
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xspi->ref_clk);
 clk_dis_apb:
 	clk_disable_unprepare(xspi->pclk);
@@ -587,6 +600,8 @@ static int cdns_spi_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(xspi->ref_clk);
 	clk_disable_unprepare(xspi->pclk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	spi_unregister_master(master);
 
@@ -649,8 +664,59 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(cdns_spi_dev_pm_ops, cdns_spi_suspend,
-			 cdns_spi_resume);
+/**
+ * cdns_spi_runtime_resume - Runtime resume method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function enables the clocks
+ *
+ * Return:	0 on success and error value on error
+ */
+static int cnds_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(xspi->pclk);
+	if (ret) {
+		dev_err(dev, "Cannot enable APB clock.\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(xspi->ref_clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable device clock.\n");
+		clk_disable(xspi->pclk);
+		return ret;
+	}
+	return 0;
+}
+
+/**
+ * cdns_spi_runtime_suspend - Runtime suspend method for the SPI driver
+ * @dev:	Address of the platform_device structure
+ *
+ * This function disables the clocks
+ *
+ * Return:	Always 0
+ */
+static int cnds_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct cdns_spi *xspi = spi_master_get_devdata(master);
+
+	clk_disable_unprepare(xspi->ref_clk);
+	clk_disable_unprepare(xspi->pclk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops cdns_spi_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(cnds_runtime_suspend,
+			   cnds_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(cdns_spi_suspend, cdns_spi_resume)
+};
 
 static const struct of_device_id cdns_spi_of_match[] = {
 	{ .compatible = "xlnx,zynq-spi-r1p6" },
-- 
1.7.1
