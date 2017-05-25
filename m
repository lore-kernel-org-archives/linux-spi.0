From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [RFC PATCH 4/5] spi: core: convert spi_master to use gpio_desc
Date: Thu, 25 May 2017 16:30:42 +1200
Message-ID: <20170525043043.1930-5-chris.packham@alliedtelesis.co.nz>
References: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Cc: linux@armlinux.org.uk,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, andy.shevchenko@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rmallon@gmail.com, shawnguo@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Instead of numeric gpios make struct spi_master hold an array of struct
gpio_desc. For now struct spi_device still maintains a numeric gpio
which will be updated in a subsequent change.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/spi-ep93xx.c | 18 ++++++++----------
 drivers/spi/spi-imx.c    | 25 +++++++++----------------
 drivers/spi/spi-mt65xx.c | 13 -------------
 drivers/spi/spi.c        | 24 +++++++++++++++++-------
 include/linux/spi/spi.h  |  2 +-
 5 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index b5d766064b7b..8ff795e65b38 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -816,7 +816,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	master->num_chipselect = info->num_chipselect;
 	master->cs_gpios = devm_kzalloc(&master->dev,
-					sizeof(int) * master->num_chipselect,
+					sizeof(*master->cs_gpios) * master->num_chipselect,
 					GFP_KERNEL);
 	if (!master->cs_gpios) {
 		error = -ENOMEM;
@@ -824,19 +824,17 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	}
 
 	for (i = 0; i < master->num_chipselect; i++) {
-		master->cs_gpios[i] = info->chipselect[i];
+		struct gpio_desc *cs;
 
-		if (!gpio_is_valid(master->cs_gpios[i]))
-			continue;
-
-		error = devm_gpio_request_one(&pdev->dev, master->cs_gpios[i],
-					      GPIOF_OUT_INIT_HIGH,
-					      "ep93xx-spi");
-		if (error) {
+		cs = devm_gpiod_get_index(&pdev->dev, "spi-cs", i,
+					  GPIOD_OUT_HIGH);
+		if (IS_ERR(cs)) {
 			dev_err(&pdev->dev, "could not request cs gpio %d\n",
-				master->cs_gpios[i]);
+				i);
+			error = PTR_ERR(cs);
 			goto fail_release_master;
 		}
+		master->cs_gpios[i] = cs;
 	}
 
 	platform_set_drvdata(pdev, master);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 19b30cf7d2b7..efbf03ac7cf1 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1360,12 +1360,18 @@ static int spi_imx_probe(struct platform_device *pdev)
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
 		master->cs_gpios = devm_kzalloc(&master->dev,
-			sizeof(int) * master->num_chipselect, GFP_KERNEL);
+			sizeof(*master->cs_gpios) * master->num_chipselect, GFP_KERNEL);
 		if (!master->cs_gpios)
 			return -ENOMEM;
 
-		for (i = 0; i < master->num_chipselect; i++)
-			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
+		for (i = 0; i < master->num_chipselect; i++) {
+			struct gpio_desc *cs;
+
+			cs = devm_gpiod_get_index(&pdev->dev, "spi-cs", i,
+						  GPIOD_OUT_HIGH);
+			if (!IS_ERR(cs))
+				master->cs_gpios[i] = cs;
+		}
  	}
 
 	spi_imx->bitbang.chipselect = spi_imx_chipselect;
@@ -1456,19 +1462,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	for (i = 0; i < master->num_chipselect; i++) {
-		if (!gpio_is_valid(master->cs_gpios[i]))
-			continue;
-
-		ret = devm_gpio_request(&pdev->dev, master->cs_gpios[i],
-					DRIVER_NAME);
-		if (ret) {
-			dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
-				master->cs_gpios[i]);
-			goto out_clk_put;
-		}
-	}
-
 	dev_info(&pdev->dev, "probed\n");
 
 	clk_disable(spi_imx->clk_ipg);
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 278867a31950..36e0d865fd02 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -681,19 +681,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 			ret = -EINVAL;
 			goto err_disable_runtime_pm;
 		}
-
-		if (master->cs_gpios) {
-			for (i = 0; i < master->num_chipselect; i++) {
-				ret = devm_gpio_request(&pdev->dev,
-							master->cs_gpios[i],
-							dev_name(&pdev->dev));
-				if (ret) {
-					dev_err(&pdev->dev,
-						"can't get CS GPIO %i\n", i);
-					goto err_disable_runtime_pm;
-				}
-			}
-		}
 	}
 
 	return 0;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b39c0f9956dd..8be01520b02e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -40,6 +40,7 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/gpio/consumer.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -531,8 +532,10 @@ int spi_add_device(struct spi_device *spi)
 		goto done;
 	}
 
-	if (master->cs_gpios)
-		spi->cs_gpio = master->cs_gpios[spi->chip_select];
+	if (master->cs_gpios[spi->chip_select])
+		spi->cs_gpio = desc_to_gpio(master->cs_gpios[spi->chip_select]);
+	else
+		spi->cs_gpio = -ENOENT;
 
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
@@ -1878,7 +1881,8 @@ EXPORT_SYMBOL_GPL(spi_alloc_master);
 #ifdef CONFIG_OF
 static int of_spi_register_master(struct spi_master *master)
 {
-	int nb, i, *cs;
+	int nb, i;
+	struct gpio_desc **cs;
 	struct device_node *np = master->dev.of_node;
 
 	if (!np)
@@ -1894,7 +1898,7 @@ static int of_spi_register_master(struct spi_master *master)
 		return nb;
 
 	cs = devm_kzalloc(&master->dev,
-			  sizeof(int) * master->num_chipselect,
+			  sizeof(*master->cs_gpios) * master->num_chipselect,
 			  GFP_KERNEL);
 	master->cs_gpios = cs;
 
@@ -1902,10 +1906,16 @@ static int of_spi_register_master(struct spi_master *master)
 		return -ENOMEM;
 
 	for (i = 0; i < master->num_chipselect; i++)
-		cs[i] = -ENOENT;
+		cs[i] = NULL;
+
+	for (i = 0; i < nb; i++) {
+		struct gpio_desc *gpio;
 
-	for (i = 0; i < nb; i++)
-		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
+		gpio = devm_gpiod_get_index(&master->dev, "cs", i,
+					    GPIOD_OUT_HIGH);
+		if (!IS_ERR(gpio))
+			cs[i] = gpio;
+	}
 
 	return 0;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 935bd2854ff1..46960ca62d5b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -556,7 +556,7 @@ struct spi_master {
 			   struct spi_message *message);
 
 	/* gpio chip select */
-	int			*cs_gpios;
+	struct gpio_desc	**cs_gpios;
 
 	/* statistics */
 	struct spi_statistics	statistics;
-- 
2.13.0
