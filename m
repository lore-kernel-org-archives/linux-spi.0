From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2] spi: efm32: Clean up non-DT paths
Date: Wed, 12 Mar 2014 18:35:23 +0800
Message-ID: <1394620523.3290.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a DT-only driver, so remove all non-DT paths.
of_gpio_named_count() may fail, thus also add checking it's return value.
efm32_spi_probe_dt() never fails, make it return void.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-efm32.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index f53bbea..b9983ef 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -287,16 +287,13 @@ static u32 efm32_spi_get_configured_location(struct efm32_spi_ddata *ddata)
 	return (reg & REG_ROUTE_LOCATION__MASK) >> __ffs(REG_ROUTE_LOCATION__MASK);
 }
 
-static int efm32_spi_probe_dt(struct platform_device *pdev,
+static void efm32_spi_probe_dt(struct platform_device *pdev,
 		struct spi_master *master, struct efm32_spi_ddata *ddata)
 {
 	struct device_node *np = pdev->dev.of_node;
 	u32 location;
 	int ret;
 
-	if (!np)
-		return 1;
-
 	ret = of_property_read_u32(np, "location", &location);
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
@@ -308,7 +305,6 @@ static int efm32_spi_probe_dt(struct platform_device *pdev,
 	}
 
 	ddata->pdata.location = location;
-	return 0;
 }
 
 static int efm32_spi_probe(struct platform_device *pdev)
@@ -318,9 +314,14 @@ static int efm32_spi_probe(struct platform_device *pdev)
 	int ret;
 	struct spi_master *master;
 	struct device_node *np = pdev->dev.of_node;
-	unsigned int num_cs, i;
+	int num_cs, i;
+
+	if (!np)
+		return -EINVAL;
 
 	num_cs = of_gpio_named_count(np, "cs-gpios");
+	if (num_cs < 0)
+		return num_cs;
 
 	master = spi_alloc_master(&pdev->dev,
 			sizeof(*ddata) + num_cs * sizeof(unsigned));
@@ -412,23 +413,7 @@ static int efm32_spi_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = efm32_spi_probe_dt(pdev, master, ddata);
-	if (ret > 0) {
-		/* not created by device tree */
-		const struct efm32_spi_pdata *pdata =
-			dev_get_platdata(&pdev->dev);
-
-		if (pdata)
-			ddata->pdata = *pdata;
-		else
-			ddata->pdata.location =
-				efm32_spi_get_configured_location(ddata);
-
-		master->bus_num = pdev->id;
-
-	} else if (ret < 0) {
-		goto err_disable_clk;
-	}
+	efm32_spi_probe_dt(pdev, master, ddata);
 
 	efm32_spi_write32(ddata, 0, REG_IEN);
 	efm32_spi_write32(ddata, REG_ROUTE_TXPEN | REG_ROUTE_RXPEN |
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
