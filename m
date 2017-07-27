From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] Revert "spi: pxa2xx: Only claim CS GPIOs when the slave device is created"
Date: Thu, 27 Jul 2017 13:09:54 +0300
Message-ID: <20170727100954.46801-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There is a valid case to call setup() following by setup_cs() several
times for the same chip.

With the commit

	676a4e3bab44 ("spi: pxa2xx: Only claim CS GPIOs when the slave device is created")

it is not possible anymore due to GPIO line being requested already
during the first call to setup_cs().

For now, revert the commit to make things work again.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 59 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index be991266a6ce..38d053682892 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1213,33 +1213,21 @@ static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
-	struct device *pdev = &drv_data->pdev->dev;
-	struct gpio_desc *gpiod;
 	int err = 0;
-	int count;
 
 	if (chip == NULL)
 		return 0;
 
-	count = gpiod_count(pdev, "cs");
-	if (count > 0) {
-		if (spi->chip_select >= count)
-			return -EINVAL;
-
-		gpiod = gpiod_get_index(pdev, "cs", spi->chip_select,
-					GPIOD_OUT_HIGH);
-		if (IS_ERR(gpiod)) {
-			/* Means use native chip select */
-			if (PTR_ERR(gpiod) == -ENOENT)
-				return 0;
+	if (drv_data->cs_gpiods) {
+		struct gpio_desc *gpiod;
 
-			return PTR_ERR(gpiod);
+		gpiod = drv_data->cs_gpiods[spi->chip_select];
+		if (gpiod) {
+			chip->gpio_cs = desc_to_gpio(gpiod);
+			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+			gpiod_set_value(gpiod, chip->gpio_cs_inverted);
 		}
 
-		chip->gpio_cs = desc_to_gpio(gpiod);
-		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
-		gpiod_set_value(gpiod, chip->gpio_cs_inverted);
-
 		return 0;
 	}
 
@@ -1427,7 +1415,8 @@ static void cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
+	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
+	    gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 
 	kfree(chip);
@@ -1763,10 +1752,38 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = platform_info->num_chipselect;
 
 	count = gpiod_count(&pdev->dev, "cs");
-	if (count > 0)
+	if (count > 0) {
+		int i;
+
 		master->num_chipselect = max_t(int, count,
 			master->num_chipselect);
 
+		drv_data->cs_gpiods = devm_kcalloc(&pdev->dev,
+			master->num_chipselect, sizeof(struct gpio_desc *),
+			GFP_KERNEL);
+		if (!drv_data->cs_gpiods) {
+			status = -ENOMEM;
+			goto out_error_clock_enabled;
+		}
+
+		for (i = 0; i < master->num_chipselect; i++) {
+			struct gpio_desc *gpiod;
+
+			gpiod = devm_gpiod_get_index(dev, "cs", i,
+						     GPIOD_OUT_HIGH);
+			if (IS_ERR(gpiod)) {
+				/* Means use native chip select */
+				if (PTR_ERR(gpiod) == -ENOENT)
+					continue;
+
+				status = (int)PTR_ERR(gpiod);
+				goto out_error_clock_enabled;
+			} else {
+				drv_data->cs_gpiods[i] = gpiod;
+			}
+		}
+	}
+
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
 
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
