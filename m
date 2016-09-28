From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2] spi: pxa2xx: Add support for GPIO descriptor chip selects
Date: Wed, 28 Sep 2016 16:04:52 +0300
Message-ID: <20160928130452.51831-1-mika.westerberg@linux.intel.com>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver uses custom chip_info coming from platform data for chip selects
implemented as GPIOs. If the system lacks board files setting up the
platform data, it is not possible to use GPIOs as chip selects.

This adds support for GPIO descriptors so that regardless of the underlying
firmware interface (DT, ACPI or platform data) the driver can request GPIOs
used as chip selects and configure them accordingly.

The custom chip_info GPIO support is still left there to make sure the
existing systems keep working as expected.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Changes from v1:
  * Include linux/gpio/consumer.h to prevent build error reported by kbuild
    test robot.

 drivers/spi/spi-pxa2xx.c | 58 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 935fab2972bb..49cd7ac2e9eb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
@@ -1176,9 +1177,26 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
 static int setup_cs(struct spi_device *spi, struct chip_data *chip,
 		    struct pxa2xx_spi_chip *chip_info)
 {
+	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 	int err = 0;
 
-	if (chip == NULL || chip_info == NULL)
+	if (chip == NULL)
+		return 0;
+
+	if (drv_data->cs_gpiods) {
+		struct gpio_desc *gpiod;
+
+		gpiod = drv_data->cs_gpiods[spi->chip_select];
+		if (gpiod) {
+			chip->gpio_cs = desc_to_gpio(gpiod);
+			chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
+			gpiod_set_value(gpiod, chip->gpio_cs_inverted);
+		}
+
+		return 0;
+	}
+
+	if (chip_info == NULL)
 		return 0;
 
 	/* NOTE: setup() can be called multiple times, possibly with
@@ -1352,7 +1370,8 @@ static void cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
+	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
+	    gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 
 	kfree(chip);
@@ -1538,7 +1557,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	const struct lpss_config *config;
-	int status;
+	int status, count;
 	u32 tmp;
 
 	platform_info = dev_get_platdata(dev);
@@ -1677,6 +1696,39 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	}
 	master->num_chipselect = platform_info->num_chipselect;
 
+	count = gpiod_count(&pdev->dev, "cs");
+	if (count > 0) {
+		int i;
+
+		master->num_chipselect = max_t(int, count,
+			master->num_chipselect);
+
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
 
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index d217ad55cc12..0ce1e41f574b 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -68,6 +68,9 @@ struct driver_data {
 	void (*cs_control)(u32 command);
 
 	void __iomem *lpss_base;
+
+	/* GPIOs for chip selects */
+	struct gpio_desc **cs_gpiods;
 };
 
 struct chip_data {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
