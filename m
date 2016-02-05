From: qiujiang <qiujiang@huawei.com>
Subject: [RFC PATCH] SPI/ACPI: DesignWare: Add ACPI support for Designware SPI driver
Date: Fri, 5 Feb 2016 15:11:20 +0800
Message-ID: <1454656280-130658-1-git-send-email-qiujiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<haifeng.wei@huawei.com>, <charles.chenxin@huawei.com>,
	qiujiang <qiujiang@huawei.com>
To: <broonie@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch added ACPI support for DesignWare SPI mmio driver. It
was based the corresponding DT driver and compatible for this two
way. This patch has been tested on Hisilicon D02 board. It relies
on the GPIO patchset.

Signed-off-by: qiujiang <qiujiang@huawei.com>
---
 drivers/spi/spi-dw-mmio.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index a6d7029..de542f0 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -8,6 +8,7 @@
  * version 2, as published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -36,7 +37,9 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct dw_spi *dws;
 	struct resource *mem;
 	int ret;
-	int num_cs;
+	int num_cs, i;
+	struct gpio_desc *gpiod;
+	char propname[32];
 
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			GFP_KERNEL);
@@ -84,8 +87,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	dws->num_cs = num_cs;
 
 	if (pdev->dev.of_node) {
-		int i;
-
 		for (i = 0; i < dws->num_cs; i++) {
 			int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
 					"cs-gpios", i);
@@ -104,6 +105,18 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (ACPI_COMPANION(&pdev->dev)) {
+		for (i = 0; i < dws->num_cs; i++) {
+			snprintf(propname, sizeof(propname), "cs%d", i);
+			gpiod = devm_gpiod_get(&pdev->dev,
+				propname, GPIOD_ASIS);
+			if (IS_ERR(gpiod)) {
+				dev_err(&pdev->dev, "Get gpio desc failed!\n");
+				return PTR_ERR(gpiod);
+			}
+		}
+	}
+
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto out;
@@ -132,12 +145,19 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
 
+static const struct acpi_device_id dw_spi_mmio_acpi_match[] = {
+		{"HISI0171", 0},
+		{ }
+};
+MODULE_DEVICE_TABLE(acpi, dw_spi_mmio_acpi_match);
+
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
 	.remove		= dw_spi_mmio_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = dw_spi_mmio_of_match,
+		.acpi_match_table = ACPI_PTR(dw_spi_mmio_acpi_match),
 	},
 };
 module_platform_driver(dw_spi_mmio_driver);
-- 
1.9.1

