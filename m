From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 2/3] spi: clps711x: Add devicetree support
Date: Sat, 20 Sep 2014 11:05:10 +0400
Message-ID: <1411196710-4961-2-git-send-email-shc_work@mail.ru>
References: <1411196710-4961-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411196710-4961-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds devicetree support for the clps711x-spi driver and
completely removes the non-DT support.
This change is safe, because the current kernel code does not have
a users of this driver.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c                 | 61 ++++++++++--------------------
 include/linux/platform_data/spi-clps711x.h | 21 ----------
 2 files changed, 20 insertions(+), 62 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 181cf22..355a6cc 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -20,9 +19,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/clps711x.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_data/spi-clps711x.h>
 
-#define DRIVER_NAME	"spi-clps711x"
+#define DRIVER_NAME		"clps711x-spi"
 
 #define SYNCIO_FRMLEN(x)	((x) << 8)
 #define SYNCIO_TXFRMEN		(1 << 14)
@@ -104,21 +102,10 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 static int spi_clps711x_probe(struct platform_device *pdev)
 {
 	struct spi_clps711x_data *hw;
-	struct spi_clps711x_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
 	struct resource *res;
 	int i, irq, ret;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "No platform data supplied\n");
-		return -EINVAL;
-	}
-
-	if (pdata->num_chipselect < 1) {
-		dev_err(&pdev->dev, "At least one CS must be defined\n");
-		return -EINVAL;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -127,40 +114,24 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
-	master->cs_gpios = devm_kzalloc(&pdev->dev, sizeof(int) *
-					pdata->num_chipselect, GFP_KERNEL);
-	if (!master->cs_gpios) {
-		ret = -ENOMEM;
-		goto err_out;
-	}
-
-	master->bus_num = pdev->id;
+	master->bus_num = -1;
 	master->mode_bits = SPI_CPHA | SPI_CS_HIGH;
 	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(1, 8);
-	master->num_chipselect = pdata->num_chipselect;
+	master->dev.of_node = pdev->dev.of_node;
 	master->setup = spi_clps711x_setup;
 	master->prepare_message = spi_clps711x_prepare_message;
 	master->transfer_one = spi_clps711x_transfer_one;
 
 	hw = spi_master_get_devdata(master);
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		master->cs_gpios[i] = pdata->chipselect[i];
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n", i);
-			goto err_out;
-		}
-	}
-
 	hw->spi_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(hw->spi_clk)) {
 		ret = PTR_ERR(hw->spi_clk);
 		goto err_out;
 	}
 
-	hw->syscon = syscon_regmap_lookup_by_pdevname("syscon.3");
+	hw->syscon =
+		syscon_regmap_lookup_by_compatible("cirrus,clps711x-syscon3");
 	if (IS_ERR(hw->syscon)) {
 		ret = PTR_ERR(hw->syscon);
 		goto err_out;
@@ -185,14 +156,15 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 		goto err_out;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-	if (!ret) {
-		dev_info(&pdev->dev,
-			 "SPI bus driver initialized. Master clock %u Hz\n",
-			 master->max_speed_hz);
-		return 0;
-	}
+	if (ret)
+		goto err_out;
 
-	dev_err(&pdev->dev, "Failed to register master\n");
+	for (i = 0; i < master->num_chipselect; i++) {
+		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
+					dev_name(&pdev->dev));
+		if (ret)
+			goto err_out;
+	}
 
 err_out:
 	spi_master_put(master);
@@ -200,10 +172,17 @@ err_out:
 	return ret;
 }
 
+static const struct of_device_id clps711x_spi_dt_ids[] = {
+	{ .compatible = "cirrus,clps711x-spi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_spi_dt_ids);
+
 static struct platform_driver clps711x_spi_driver = {
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = clps711x_spi_dt_ids,
 	},
 	.probe	= spi_clps711x_probe,
 };
diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
deleted file mode 100644
index 301956e..0000000
--- a/include/linux/platform_data/spi-clps711x.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  CLPS711X SPI bus driver definitions
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-
-/* Board specific platform_data */
-struct spi_clps711x_pdata {
-	int *chipselect;	/* Array of GPIO-numbers */
-	int num_chipselect;	/* Total count of GPIOs */
-};
-
-#endif
-- 
1.8.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
