From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 3/4] spi: tegra slink: assume CONFIG_OF, remove platform data
Date: Fri, 15 Feb 2013 15:03:49 -0700
Message-ID: <1360965830-19795-3-git-send-email-swarren@wwwdotorg.org>
References: <1360965830-19795-1-git-send-email-swarren@wwwdotorg.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360965830-19795-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Tegra only supports, and always enables, device tree. Remove all ifdefs
and runtime checks for DT support from the driver. Platform data is
therefore no longer required. Rework the driver to parse the device tree
directly into struct tegra_slink_data.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c |   45 ++++++++++-----------------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 00f1b06..6a15f63 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -34,7 +34,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi-tegra.h>
 #include <linux/clk/tegra.h>
 
 #define SLINK_COMMAND			0x000
@@ -1042,29 +1041,18 @@ static irqreturn_t tegra_slink_isr(int irq, void *context_data)
 	return IRQ_WAKE_THREAD;
 }
 
-static struct tegra_spi_platform_data *tegra_slink_parse_dt(
-		struct platform_device *pdev)
+static void tegra_slink_parse_dt(struct tegra_slink_data *tspi)
 {
-	struct tegra_spi_platform_data *pdata;
-	const unsigned int *prop;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = tspi->dev->of_node;
 	u32 of_dma[2];
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "Memory alloc for pdata failed\n");
-		return NULL;
-	}
-
 	if (of_property_read_u32_array(np, "nvidia,dma-request-selector",
 				of_dma, 2) >= 0)
-		pdata->dma_req_sel = of_dma[1];
+		tspi->dma_req_sel = of_dma[1];
 
-	prop = of_get_property(np, "spi-max-frequency", NULL);
-	if (prop)
-		pdata->spi_max_frequency = be32_to_cpup(prop);
-
-	return pdata;
+	if (of_property_read_u32(np, "spi-max-frequency",
+					&tspi->spi_max_frequency))
+		tspi->spi_max_frequency = 25000000; /* 25MHz */
 }
 
 const struct tegra_slink_chip_data tegra30_spi_cdata = {
@@ -1087,27 +1075,16 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	struct spi_master	*master;
 	struct tegra_slink_data	*tspi;
 	struct resource		*r;
-	struct tegra_spi_platform_data *pdata = pdev->dev.platform_data;
 	int ret, spi_irq;
 	const struct tegra_slink_chip_data *cdata = NULL;
 	const struct of_device_id *match;
 
-	match = of_match_device(of_match_ptr(tegra_slink_of_match), &pdev->dev);
+	match = of_match_device(tegra_slink_of_match, &pdev->dev);
 	if (!match) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		return -ENODEV;
 	}
 	cdata = match->data;
-	if (!pdata && pdev->dev.of_node)
-		pdata = tegra_slink_parse_dt(pdev);
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data, exiting\n");
-		return -ENODEV;
-	}
-
-	if (!pdata->spi_max_frequency)
-		pdata->spi_max_frequency = 25000000; /* 25MHz */
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
 	if (!master) {
@@ -1127,11 +1104,12 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, master);
 	tspi = spi_master_get_devdata(master);
 	tspi->master = master;
-	tspi->dma_req_sel = pdata->dma_req_sel;
 	tspi->dev = &pdev->dev;
 	tspi->chip_data = cdata;
 	spin_lock_init(&tspi->lock);
 
+	tegra_slink_parse_dt(tspi);
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "No IO memory resource\n");
@@ -1165,9 +1143,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
-	tspi->spi_max_frequency = pdata->spi_max_frequency;
 
-	if (pdata->dma_req_sel) {
+	if (tspi->dma_req_sel) {
 		ret = tegra_slink_init_dma_param(tspi, true);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "RxDma Init failed, err %d\n", ret);
@@ -1310,7 +1287,7 @@ static struct platform_driver tegra_slink_driver = {
 		.name		= "spi-tegra-slink",
 		.owner		= THIS_MODULE,
 		.pm		= &slink_pm_ops,
-		.of_match_table	= of_match_ptr(tegra_slink_of_match),
+		.of_match_table	= tegra_slink_of_match,
 	},
 	.probe =	tegra_slink_probe,
 	.remove =	tegra_slink_remove,
-- 
1.7.10.4
