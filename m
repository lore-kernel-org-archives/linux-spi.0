From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 2/4] spi: tegra sflash: assume CONFIG_OF, remove platform data
Date: Fri, 15 Feb 2013 15:03:48 -0700
Message-ID: <1360965830-19795-2-git-send-email-swarren@wwwdotorg.org>
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
directly into struct tegra_sflash_data.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-sflash.c |   41 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 3d6a12b..d65c000 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -33,7 +33,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi-tegra.h>
 #include <linux/clk/tegra.h>
 
 #define SPI_COMMAND				0x000
@@ -439,23 +438,13 @@ static irqreturn_t tegra_sflash_isr(int irq, void *context_data)
 	return handle_cpu_based_xfer(tsd);
 }
 
-static struct tegra_spi_platform_data *tegra_sflash_parse_dt(
-		struct platform_device *pdev)
+static void tegra_sflash_parse_dt(struct tegra_sflash_data *tsd)
 {
-	struct tegra_spi_platform_data *pdata;
-	struct device_node *np = pdev->dev.of_node;
-	u32 max_freq;
-
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "Memory alloc for pdata failed\n");
-		return NULL;
-	}
-
-	if (!of_property_read_u32(np, "spi-max-frequency", &max_freq))
-		pdata->spi_max_frequency = max_freq;
+	struct device_node *np = tsd->dev->of_node;
 
-	return pdata;
+	if (of_property_read_u32(np, "spi-max-frequency",
+					&tsd->spi_max_frequency))
+		tsd->spi_max_frequency = 25000000; /* 25MHz */
 }
 
 static struct of_device_id tegra_sflash_of_match[] = {
@@ -469,28 +458,15 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	struct spi_master	*master;
 	struct tegra_sflash_data	*tsd;
 	struct resource		*r;
-	struct tegra_spi_platform_data *pdata = pdev->dev.platform_data;
 	int ret;
 	const struct of_device_id *match;
 
-	match = of_match_device(of_match_ptr(tegra_sflash_of_match),
-					&pdev->dev);
+	match = of_match_device(tegra_sflash_of_match, &pdev->dev);
 	if (!match) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		return -ENODEV;
 	}
 
-	if (!pdata && pdev->dev.of_node)
-		pdata = tegra_sflash_parse_dt(pdev);
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data, exiting\n");
-		return -ENODEV;
-	}
-
-	if (!pdata->spi_max_frequency)
-		pdata->spi_max_frequency = 25000000; /* 25MHz */
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*tsd));
 	if (!master) {
 		dev_err(&pdev->dev, "master allocation failed\n");
@@ -510,6 +486,8 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	tsd->dev = &pdev->dev;
 	spin_lock_init(&tsd->lock);
 
+	tegra_sflash_parse_dt(tsd);
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		dev_err(&pdev->dev, "No IO memory resource\n");
@@ -538,7 +516,6 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		goto exit_free_irq;
 	}
 
-	tsd->spi_max_frequency = pdata->spi_max_frequency;
 	init_completion(&tsd->xfer_completion);
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
@@ -658,7 +635,7 @@ static struct platform_driver tegra_sflash_driver = {
 		.name		= "spi-tegra-sflash",
 		.owner		= THIS_MODULE,
 		.pm		= &slink_pm_ops,
-		.of_match_table	= of_match_ptr(tegra_sflash_of_match),
+		.of_match_table	= tegra_sflash_of_match,
 	},
 	.probe =	tegra_sflash_probe,
 	.remove =	tegra_sflash_remove,
-- 
1.7.10.4
