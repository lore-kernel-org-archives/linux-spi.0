From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Don't request CS GPIO in DT use-case" to the spi tree
Date: Fri,  5 Apr 2019 10:26:42 +0700 (+07)
Message-ID: <20190405032642.B0F2E441D3C@finisterre.ee.mobilebroadband>
References: <20190403040133.1459-7-andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-7-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Don't request CS GPIO in DT use-case

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 249e2632dcd0509b8f8f296f5aabf4d48dfd6da8 Mon Sep 17 00:00:00 2001
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 2 Apr 2019 21:01:27 -0700
Subject: [PATCH] spi: gpio: Don't request CS GPIO in DT use-case

DT use-case already relies on SPI core to control CS (requested by
of_spi_register_master() and controlled spi_set_cs()), so there's no
need to try to request those GPIO in spi-gpio code. Change the code
such that spi-gpio's CS related code is only used if device is probed
via pdata.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 134 ++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index c8fe87ebf8c8..3d05c6a71706 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -46,7 +46,6 @@ struct spi_gpio {
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
 	struct gpio_desc		**cs_gpios;
-	bool				has_cs;
 };
 
 /*----------------------------------------------------------------------*/
@@ -216,7 +215,7 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
 
 	/* Drive chip select line, if we have one */
-	if (spi_gpio->has_cs) {
+	if (spi_gpio->cs_gpios) {
 		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
 		/* SPI chip selects are normally active-low */
@@ -234,10 +233,12 @@ static int spi_gpio_setup(struct spi_device *spi)
 	 * The CS GPIOs have already been
 	 * initialized from the descriptor lookup.
 	 */
-	cs = spi_gpio->cs_gpios[spi->chip_select];
-	if (!spi->controller_state && cs)
-		status = gpiod_direction_output(cs,
-						!(spi->mode & SPI_CS_HIGH));
+	if (spi_gpio->cs_gpios) {
+		cs = spi_gpio->cs_gpios[spi->chip_select];
+		if (!spi->controller_state && cs)
+			status = gpiod_direction_output(cs,
+						  !(spi->mode & SPI_CS_HIGH));
+	}
 
 	if (!status)
 		status = spi_bitbang_setup(spi);
@@ -290,11 +291,8 @@ static void spi_gpio_cleanup(struct spi_device *spi)
  */
 static int spi_gpio_request(struct device *dev,
 			    struct spi_gpio *spi_gpio,
-			    unsigned int num_chipselects,
 			    u16 *mflags)
 {
-	int i;
-
 	spi_gpio->mosi = devm_gpiod_get_optional(dev, "mosi", GPIOD_OUT_LOW);
 	if (IS_ERR(spi_gpio->mosi))
 		return PTR_ERR(spi_gpio->mosi);
@@ -315,13 +313,6 @@ static int spi_gpio_request(struct device *dev,
 	if (IS_ERR(spi_gpio->sck))
 		return PTR_ERR(spi_gpio->sck);
 
-	for (i = 0; i < num_chipselects; i++) {
-		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs",
-							     i, GPIOD_OUT_HIGH);
-		if (IS_ERR(spi_gpio->cs_gpios[i]))
-			return PTR_ERR(spi_gpio->cs_gpios[i]);
-	}
-
 	return 0;
 }
 
@@ -332,90 +323,87 @@ static const struct of_device_id spi_gpio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
 
-static int spi_gpio_probe_dt(struct platform_device *pdev)
+static int spi_gpio_probe_dt(struct platform_device *pdev,
+			     struct spi_master *master)
 {
-	int ret;
-	u32 tmp;
-	struct spi_gpio_platform_data	*pdata;
-	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-			of_match_device(spi_gpio_dt_ids, &pdev->dev);
-
-	if (!of_id)
-		return 0;
+	master->dev.of_node = pdev->dev.of_node;
+	master->use_gpio_descriptors = true;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
+	return 0;
+}
+#else
+static inline int spi_gpio_probe_dt(struct platform_device *pdev,
+				    struct spi_master *master)
+{
+	return 0;
+}
+#endif
 
+static int spi_gpio_probe_pdata(struct platform_device *pdev,
+				struct spi_master *master)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_gpio_platform_data *pdata = dev_get_platdata(dev);
+	struct spi_gpio *spi_gpio = spi_master_get_devdata(master);
+	int i;
 
-	ret = of_property_read_u32(np, "num-chipselects", &tmp);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "num-chipselects property not found\n");
-		goto error_free;
-	}
+#ifdef GENERIC_BITBANG
+	if (!pdata || !pdata->num_chipselect)
+		return -ENODEV;
+#endif
+	/*
+	 * The master needs to think there is a chipselect even if not
+	 * connected
+	 */
+	master->num_chipselect = pdata->num_chipselect ?: 1;
 
-	pdata->num_chipselect = tmp;
-	pdev->dev.platform_data = pdata;
+	spi_gpio->cs_gpios = devm_kcalloc(dev, master->num_chipselect,
+					  sizeof(*spi_gpio->cs_gpios),
+					  GFP_KERNEL);
+	if (!spi_gpio->cs_gpios)
+		return -ENOMEM;
 
-	return 1;
+	for (i = 0; i < master->num_chipselect; i++) {
+		spi_gpio->cs_gpios[i] = devm_gpiod_get_index(dev, "cs", i,
+							     GPIOD_OUT_HIGH);
+		if (IS_ERR(spi_gpio->cs_gpios[i]))
+			return PTR_ERR(spi_gpio->cs_gpios[i]);
+	}
 
-error_free:
-	devm_kfree(&pdev->dev, pdata);
-	return ret;
-}
-#else
-static inline int spi_gpio_probe_dt(struct platform_device *pdev)
-{
 	return 0;
 }
-#endif
 
 static int spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
-	struct spi_gpio_platform_data	*pdata;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
+	const struct of_device_id	*of_id;
 	u16 master_flags = 0;
-	bool use_of = 0;
-
-	status = spi_gpio_probe_dt(pdev);
-	if (status < 0)
-		return status;
-	if (status > 0)
-		use_of = 1;
 
-	pdata = dev_get_platdata(dev);
-#ifdef GENERIC_BITBANG
-	if (!pdata || (!use_of && !pdata->num_chipselect))
-		return -ENODEV;
-#endif
+	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
 		return -ENOMEM;
 
-	spi_gpio = spi_master_get_devdata(master);
+	if (of_id)
+		status = spi_gpio_probe_dt(pdev, master);
+	else
+		status = spi_gpio_probe_pdata(pdev, master);
 
-	spi_gpio->cs_gpios = devm_kcalloc(dev,
-				pdata->num_chipselect,
-				sizeof(*spi_gpio->cs_gpios),
-				GFP_KERNEL);
-	if (!spi_gpio->cs_gpios)
-		return -ENOMEM;
+	if (status)
+		return status;
 
-	platform_set_drvdata(pdev, spi_gpio);
+	spi_gpio = spi_master_get_devdata(master);
 
-	/* Determine if we have chip selects connected */
-	spi_gpio->has_cs = !!pdata->num_chipselect;
+	platform_set_drvdata(pdev, spi_gpio);
 
 	spi_gpio->pdev = pdev;
 
-	status = spi_gpio_request(dev, spi_gpio,
-				  pdata->num_chipselect, &master_flags);
+	status = spi_gpio_request(dev, spi_gpio, &master_flags);
 	if (status)
 		return status;
 
@@ -424,13 +412,9 @@ static int spi_gpio_probe(struct platform_device *pdev)
 			    SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
-	/* The master needs to think there is a chipselect even if not connected */
-	master->num_chipselect = spi_gpio->has_cs ? pdata->num_chipselect : 1;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
-#ifdef CONFIG_OF
-	master->dev.of_node = dev->of_node;
-#endif
+
 	bb = &spi_gpio->bitbang;
 	bb->master = master;
 	bb->chipselect = spi_gpio_chipselect;
-- 
2.20.1
