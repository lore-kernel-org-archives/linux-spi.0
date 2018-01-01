From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] spi: spi-gpio: Make optional chipselect handling more explicit
Date: Mon,  1 Jan 2018 14:37:48 +0100
Message-ID: <20180101133749.29567-5-linus.walleij@linaro.org>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I don't like the use of a NULL GPIO descriptor to handle the
"no chipselect connected" case, as it makes the code hard to read.
Use a clear bool "has_cs" that we use to explicitly handle the
case when no chip select is connected to it is clear to readers
how this is achieved.

When there is no chip select connected, we don't even allocate a
placeholder for the GPIO descriptor.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-gpio.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index ab2cb9427481..c12e588e54e7 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -47,6 +47,7 @@ struct spi_gpio {
 	struct gpio_desc		*sck;
 	struct gpio_desc		*miso;
 	struct gpio_desc		*mosi;
+	bool				has_cs;
 	/* Will be allocated times number of devices beyond end of struct */
 	struct gpio_desc		*cs_gpios[0];
 };
@@ -215,15 +216,18 @@ static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
 static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 {
 	struct spi_gpio *spi_gpio = spi_to_spi_gpio(spi);
-	struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
 
 	/* set initial clock line level */
 	if (is_active)
 		gpiod_set_value_cansleep(spi_gpio->sck, spi->mode & SPI_CPOL);
 
-	if (cs)
+	/* Drive chip select line, if we have one */
+	if (spi_gpio->has_cs) {
+		struct gpio_desc *cs = spi_gpio->cs_gpios[spi->chip_select];
+
 		/* SPI chip selects are normally active-low */
 		gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
+	}
 }
 
 static int spi_gpio_setup(struct spi_device *spi)
@@ -293,9 +297,6 @@ static int spi_gpio_request(struct device *dev,
 		if (IS_ERR(spi_gpio->cs_gpios[i]))
 			return PTR_ERR(spi_gpio->cs_gpios[i]);
 	}
-	/* Dummy chipselect line if the single device is not using chipselect */
-	if (!num_chipselects)
-		spi_gpio->cs_gpios[0] = NULL;
 
 	return 0;
 }
@@ -354,7 +355,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio_platform_data	*pdata;
 	u16 master_flags = 0;
 	bool use_of = 0;
-	int num_devices;
 
 	status = spi_gpio_probe_dt(pdev);
 	if (status < 0)
@@ -368,19 +368,17 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 #endif
 
-	if (use_of && !pdata->num_chipselect)
-		num_devices = 1;
-	else
-		num_devices = pdata->num_chipselect;
-
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi_gpio) +
-				  (sizeof(struct gpio_desc *) * num_devices));
+				  (sizeof(struct gpio_desc *) * pdata->num_chipselect));
 	if (!master)
 		return -ENOMEM;
 
 	spi_gpio = spi_master_get_devdata(master);
 	platform_set_drvdata(pdev, spi_gpio);
 
+	/* Determine if we have chip selects connected */
+	spi_gpio->has_cs = !!pdata->num_chipselect;
+
 	spi_gpio->pdev = pdev;
 	if (pdata)
 		spi_gpio->pdata = *pdata;
@@ -393,7 +391,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
-	master->num_chipselect = num_devices;
+	/* The master needs to think there is a chipselect even if not connected */
+	master->num_chipselect = spi_gpio->has_cs ? pdata->num_chipselect : 1;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
 #ifdef CONFIG_OF
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
