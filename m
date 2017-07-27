From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [RFC PATCH v2 10/12] spi: core: convert spi_master to use gpio_desc
Date: Fri, 28 Jul 2017 10:03:20 +1200
Message-ID: <20170727220322.26654-11-chris.packham@alliedtelesis.co.nz>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Instead of numeric gpios make struct spi_master hold an array of struct
gpio_desc. For now struct spi_device still maintains a numeric gpio
which will be updated in a subsequent change.

Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 18 ++++++++----------
 drivers/spi/spi-imx.c    | 25 +++++++++----------------
 drivers/spi/spi-mt65xx.c | 13 -------------
 drivers/spi/spi.c        | 23 +++++++++++++++++------
 include/linux/spi/spi.h  |  2 +-
 5 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index d48d0508a886..9d8328fee737 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -672,7 +672,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	master->num_chipselect = info->num_chipselect;
 	master->cs_gpios = devm_kzalloc(&master->dev,
-					sizeof(int) * master->num_chipselect,
+					sizeof(*master->cs_gpios) * master->num_chipselect,
 					GFP_KERNEL);
 	if (!master->cs_gpios) {
 		error = -ENOMEM;
@@ -680,19 +680,17 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
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
index 930e47597db3..d240aa4082c8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1229,12 +1229,18 @@ static int spi_imx_probe(struct platform_device *pdev)
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
@@ -1327,19 +1333,6 @@ static int spi_imx_probe(struct platform_device *pdev)
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
index 86bf45667a04..91a498e25cbb 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -732,19 +732,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
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
index 918a53c884dd..3860f0c84e1a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -40,6 +40,7 @@
 #include <linux/ioport.h>
 #include <linux/acpi.h>
 #include <linux/highmem.h>
+#include <linux/gpio/consumer.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
@@ -531,7 +532,9 @@ int spi_add_device(struct spi_device *spi)
 	}
 
 	if (ctlr->cs_gpios)
-		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
+		spi->cs_gpio = desc_to_gpio(ctlr->cs_gpios[spi->chip_select]);
+	else
+		spi->cs_gpio = -ENOENT;
 
 	/* Drivers may modify this initial i/o setup, but will
 	 * normally rely on the device being setup.  Devices
@@ -1988,7 +1991,8 @@ EXPORT_SYMBOL_GPL(__spi_alloc_controller);
 #ifdef CONFIG_OF
 static int of_spi_register_master(struct spi_controller *ctlr)
 {
-	int nb, i, *cs;
+	int nb, i;
+	struct gpio_desc **cs;
 	struct device_node *np = ctlr->dev.of_node;
 
 	if (!np)
@@ -2003,7 +2007,8 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 	else if (nb < 0)
 		return nb;
 
-	cs = devm_kzalloc(&ctlr->dev, sizeof(int) * ctlr->num_chipselect,
+	cs = devm_kzalloc(&ctlr->dev,
+			  sizeof(*ctlr->cs_gpios) * ctlr->num_chipselect,
 			  GFP_KERNEL);
 	ctlr->cs_gpios = cs;
 
@@ -2011,10 +2016,16 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 		return -ENOMEM;
 
 	for (i = 0; i < ctlr->num_chipselect; i++)
-		cs[i] = -ENOENT;
+		cs[i] = NULL;
+
+	for (i = 0; i < nb; i++) {
+		struct gpio_desc *gpio;
 
-	for (i = 0; i < nb; i++)
-		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
+		gpio = devm_gpiod_get_index(&ctlr->dev, "cs", i,
+					    GPIOD_OUT_HIGH);
+		if (!IS_ERR(gpio))
+			cs[i] = gpio;
+	}
 
 	return 0;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7b2170bfd6e7..7e170db7bc9d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -565,7 +565,7 @@ struct spi_controller {
 			   struct spi_message *message);
 
 	/* gpio chip select */
-	int			*cs_gpios;
+	struct gpio_desc	**cs_gpios;
 
 	/* statistics */
 	struct spi_statistics	statistics;
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
