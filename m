From: kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
Subject: [PATCH] spi: vulcan: Add ACPI support for SPI driver
Date: Tue, 26 Jul 2016 10:52:06 +0530
Message-ID: <1469510526-7593-1-git-send-email-kamlakant.patel@broadcom.com>
Cc: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

Add ACPI support for SPI controller driver on Broadcom Vulcan ARM64
plateform.

Signed-off-by: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-xlp.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 8f04fec..7494254 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -11,6 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -85,7 +86,7 @@
 #define XLP_SPI_TXRXTH			0x80
 #define XLP_SPI_FIFO_SIZE		8
 #define XLP_SPI_MAX_CS			4
-#define XLP_SPI_DEFAULT_FREQ		133333333
+#define VULCAN_SPI_DEFAULT_FREQ		133000000
 #define XLP_SPI_FDIV_MIN		4
 #define XLP_SPI_FDIV_MAX		65535
 /*
@@ -403,11 +404,24 @@ static int xlp_spi_probe(struct platform_device *pdev)
 	}
 
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		dev_err(&pdev->dev, "could not get spi clock\n");
-		return -ENODEV;
+	if (!IS_ERR(clk)) {
+		xspi->spi_clk = clk_get_rate(clk);
+	} else {
+		u32 freq;
+
+		err = device_property_read_u32(&pdev->dev,
+					"clock-frequency", &freq);
+		if (err) {
+			/*
+			 * Use default SPI frequency for Vulcan unless
+			 * changed by firmaware.
+			 */
+			dev_err(&pdev->dev, "Can't get clock-frequency,
+						using default\n");
+			freq = VULCAN_SPI_DEFAULT_FREQ;
+		}
+		xspi->spi_clk = freq;
 	}
-	xspi->spi_clk = clk_get_rate(clk);
 
 	master = spi_alloc_master(&pdev->dev, 0);
 	if (!master) {
@@ -437,6 +451,14 @@ static int xlp_spi_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id xlp_spi_acpi_match[] = {
+	{ "BRCM900D", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, xlp_spi_acpi_match);
+#endif
+
 static const struct of_device_id xlp_spi_dt_id[] = {
 	{ .compatible = "netlogic,xlp832-spi" },
 	{ },
@@ -447,6 +469,7 @@ static struct platform_driver xlp_spi_driver = {
 	.driver = {
 		.name	= "xlp-spi",
 		.of_match_table = xlp_spi_dt_id,
+		.acpi_match_table = ACPI_PTR(xlp_spi_acpi_match),
 	},
 };
 module_platform_driver(xlp_spi_driver);
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
