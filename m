From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3 3/5] spi: dw-mmio: add device tree support
Date: Fri, 31 Jan 2014 12:07:46 +0200
Message-ID: <d9d868430ae3cecc0be8faecf5d188d160966533.1391162172.git.baruch@tkos.co.il>
References: <cover.1391162172.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1391162172.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cc: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 1492f5ee9aaa..86d247ecd2d2 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -16,6 +16,7 @@
 #include <linux/spi/spi.h>
 #include <linux/scatterlist.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include "spi-dw.h"
 
@@ -32,6 +33,7 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	struct dw_spi *dws;
 	struct resource *mem;
 	int ret;
+	u32 tmp;
 
 	dwsmmio = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_mmio),
 			GFP_KERNEL);
@@ -67,7 +69,15 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 		return ret;
 
 	dws->bus_num = pdev->id;
-	dws->num_cs = 4;
+	if (pdev->dev.of_node == NULL)
+		dws->num_cs = 4;
+	ret = of_property_read_u32(pdev->dev.of_node, "num-cs", &tmp);
+	if (ret == 0)
+		dws->num_cs = tmp;
+	if (dws->num_cs == 0) {
+		dev_err(&pdev->dev, "missing or wrong num-cs property\n");
+		goto out;
+	}
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
 	ret = dw_spi_add_host(&pdev->dev, dws);
@@ -92,12 +102,21 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id dw_spi_dt_ids[] = {
+	{ .compatible = "snps,designware-spi" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, dw_spi_dt_ids);
+#endif
+
 static struct platform_driver dw_spi_mmio_driver = {
 	.probe		= dw_spi_mmio_probe,
 	.remove		= dw_spi_mmio_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(dw_spi_dt_ids),
 	},
 };
 module_platform_driver(dw_spi_mmio_driver);
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
