From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: efm32: Clean up non-DT paths
Date: Mon, 10 Mar 2014 08:01:45 +0800
Message-ID: <1394409705.12514.2.camel@phoenix>
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

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-efm32.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index f53bbea..26e0362 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -294,9 +294,6 @@ static int efm32_spi_probe_dt(struct platform_device *pdev,
 	u32 location;
 	int ret;
 
-	if (!np)
-		return 1;
-
 	ret = of_property_read_u32(np, "location", &location);
 	if (!ret) {
 		dev_dbg(&pdev->dev, "using location %u\n", location);
@@ -318,9 +315,14 @@ static int efm32_spi_probe(struct platform_device *pdev)
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
@@ -412,23 +414,7 @@ static int efm32_spi_probe(struct platform_device *pdev)
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
