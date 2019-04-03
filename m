From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 06/12] spi: gpio: Don't request CS GPIO in DT use-case
Date: Tue,  2 Apr 2019 21:01:27 -0700
Message-ID: <20190403040133.1459-7-andrew.smirnov@gmail.com>
References: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403040133.1459-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

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
---
 drivers/spi/spi-gpio.c | 134 ++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1cff30adc836..8feb036aaf36 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -47,7 +47,6 @@ struct spi_gpio {
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
 	struct gpio_desc		**cs_gpios;
-	bool				has_cs;
 };
 
 /*----------------------------------------------------------------------*/
@@ -217,7 +216,7 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
 
 	/* Drive chip select line, if we have one */
-	if (spi_gpio->has_cs) {
+	if (spi_gpio->cs_gpios) {
 		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
 		/* SPI chip selects are normally active-low */
@@ -235,10 +234,12 @@ static int spi_gpio_setup(struct spi_device *spi)
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
@@ -291,11 +292,8 @@ static void spi_gpio_cleanup(struct spi_device *spi)
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
@@ -316,13 +314,6 @@ static int spi_gpio_request(struct device *dev,
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
 
@@ -333,90 +324,87 @@ static const struct of_device_id spi_gpio_dt_ids[] = {
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
 
@@ -425,13 +413,9 @@ static int spi_gpio_probe(struct platform_device *pdev)
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
