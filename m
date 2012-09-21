From: Bastian Hecht <hechtb-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 3/4] spi: sh-msiof: Add device tree parsing to driver
Date: Fri, 21 Sep 2012 13:00:48 +0200
Message-ID: <1348225249-1294-3-git-send-email-hechtb@gmail.com>
References: <1348225249-1294-1-git-send-email-hechtb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348225249-1294-1-git-send-email-hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This adds the capability to retrieve setup data from the device tree
node. The usage of platform data is still available.

The type of chip_select has been changed from u16 to int so that
of_property_read_u32 does not overwrite other data.

Signed-off-by: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c   |   51 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/sh_msiof.h |    2 +-
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 96358d0..467d645 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -592,6 +593,32 @@ static u32 sh_msiof_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
+{
+	struct sh_msiof_spi_info *info;
+	struct device_node *np = dev->of_node;
+
+	info = devm_kzalloc(dev, sizeof(struct sh_msiof_spi_info), GFP_KERNEL);
+	if (!info) {
+		dev_err(dev, "failed to allocate setup data\n");
+		return NULL;
+	}
+
+	/* Parse the MSIOF properties */
+	of_property_read_u32(np, "chip-select", &info->num_chipselect);
+	of_property_read_u32(np, "tx_fifo_size", &info->tx_fifo_override);
+	of_property_read_u32(np, "rx_fifo_size", &info->rx_fifo_override);
+
+	return info;
+}
+#else
+static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
@@ -610,7 +637,17 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p = spi_master_get_devdata(master);
 
 	platform_set_drvdata(pdev, p);
-	p->info = pdev->dev.platform_data;
+	if (pdev->dev.of_node)
+		p->info = sh_msiof_spi_parse_dt(&pdev->dev);
+	else
+		p->info = pdev->dev.platform_data;
+
+	if (!p->info) {
+		dev_err(&pdev->dev, "failed to obtain device info\n");
+		ret = -ENXIO;
+		goto err1;
+	}
+
 	init_completion(&p->done);
 
 	p->clk = clk_get(&pdev->dev, NULL);
@@ -715,6 +752,17 @@ static int sh_msiof_spi_runtime_nop(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id sh_msiof_match[] = {
+	{ .compatible = "renesas,sh-msiof", },
+	{ .compatible = "renesas,sh-mobile-msiof", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_msiof_match);
+#else
+#define sh_msiof_match NULL
+#endif
+
 static struct dev_pm_ops sh_msiof_spi_dev_pm_ops = {
 	.runtime_suspend = sh_msiof_spi_runtime_nop,
 	.runtime_resume = sh_msiof_spi_runtime_nop,
@@ -727,6 +775,7 @@ static struct platform_driver sh_msiof_spi_drv = {
 		.name		= "spi_sh_msiof",
 		.owner		= THIS_MODULE,
 		.pm		= &sh_msiof_spi_dev_pm_ops,
+		.of_match_table = sh_msiof_match,
 	},
 };
 module_platform_driver(sh_msiof_spi_drv);
diff --git a/include/linux/spi/sh_msiof.h b/include/linux/spi/sh_msiof.h
index 2e8db3d..58bc0e1 100644
--- a/include/linux/spi/sh_msiof.h
+++ b/include/linux/spi/sh_msiof.h
@@ -4,7 +4,7 @@
 struct sh_msiof_spi_info {
 	int tx_fifo_override;
 	int rx_fifo_override;
-	u16 num_chipselect;
+	int num_chipselect;
 };
 
 #endif /* __SPI_SH_MSIOF_H__ */
-- 
1.7.5.4


------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
