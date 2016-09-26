From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx: Add support for GPIO descriptor chip selects" to the spi tree
Date: Mon, 26 Sep 2016 09:15:51 -0700
Message-ID: <E1boYZL-0005ab-4y@finisterre>
References: <20160926121950.61265-1-mika.westerberg@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160926121950.61265-1-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx: Add support for GPIO descriptor chip selects

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 99f499cd650405bbe6a9b5386d4b11ee81514fb7 Mon Sep 17 00:00:00 2001
From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 26 Sep 2016 15:19:50 +0300
Subject: [PATCH] spi: pxa2xx: Add support for GPIO descriptor chip selects

The driver uses custom chip_info coming from platform data for chip selects
implemented as GPIOs. If the system lacks board files setting up the
platform data, it is not possible to use GPIOs as chip selects.

This adds support for GPIO descriptors so that regardless of the underlying
firmware interface (DT, ACPI or platform data) the driver can request GPIOs
used as chip selects and configure them accordingly.

The custom chip_info GPIO support is still left there to make sure the
existing systems keep working as expected.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 57 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/spi/spi-pxa2xx.h |  3 +++
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index cab39b06bc89..5e2ed7d34487 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1194,9 +1194,26 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
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
@@ -1379,7 +1396,8 @@ static void cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if (drv_data->ssp_type != CE4100_SSP && gpio_is_valid(chip->gpio_cs))
+	if (drv_data->ssp_type != CE4100_SSP && !drv_data->cs_gpiods &&
+	    gpio_is_valid(chip->gpio_cs))
 		gpio_free(chip->gpio_cs);
 
 	kfree(chip);
@@ -1557,7 +1575,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	const struct lpss_config *config;
-	int status;
+	int status, count;
 	u32 tmp;
 
 	platform_info = dev_get_platdata(dev);
@@ -1701,6 +1719,39 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
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
index ae3b15ff6fb2..ce31b8199bb3 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -66,6 +66,9 @@ struct driver_data {
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
