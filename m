From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH resend 2/2] SPI: spi-gpio: Add DT bindings
Date: Wed,  1 Aug 2012 22:57:18 +0200
Message-ID: <1343854638-32563-2-git-send-email-zonque@gmail.com>
References: <1343854638-32563-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1343854638-32563-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch adds DT bindings to the spi-gpio driver and some
documentation about how to use it.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-gpio.txt | 29 +++++++
 drivers/spi/spi-gpio.c                             | 99 +++++++++++++++++++++-
 2 files changed, 125 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
new file mode 100644
index 0000000..8a824be
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.txt
@@ -0,0 +1,29 @@
+SPI-GPIO devicetree bindings
+
+Required properties:
+
+ - compatible: should be set to "spi-gpio"
+ - #address-cells: should be set to <0x1>
+ - ranges
+ - gpio-sck: GPIO spec for the SCK line to use
+ - gpio-miso: GPIO spec for the MISO line to use
+ - gpio-mosi: GPIO spec for the MOSI line to use
+ - cs-gpios: GPIOs to use for chipselect lines
+ - num-chipselects: number of chipselect lines
+
+Example:
+
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <0x1>;
+		ranges;
+
+		gpio-sck = <&gpio 95 0>;
+		gpio-miso = <&gpio 98 0>;
+		gpio-mosi = <&gpio 97 0>;
+		cs-gpios = <&gpio 125 0>;
+		num-chipselects = <1>;
+
+		/* clients */
+	};
+
diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index ff7263c..aed1615 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -22,6 +22,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -232,13 +234,27 @@ static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
 
 static int spi_gpio_setup(struct spi_device *spi)
 {
-	unsigned int		cs = (unsigned int) spi->controller_data;
+	unsigned int		cs;
 	int			status = 0;
 	struct spi_gpio		*spi_gpio = spi_to_spi_gpio(spi);
+	struct device_node	*np = spi->master->dev.of_node;
 
 	if (spi->bits_per_word > 32)
 		return -EINVAL;
 
+	if (np) {
+		/*
+		 * In DT environments, the CS GPIOs have already been
+		 * initialized from the "cs-gpios" property of the node.
+		 */
+		cs = spi_gpio->cs_gpios[spi->chip_select];
+	} else {
+		/*
+		 * ... otherwise, take it from spi->controller_data
+		 */
+		cs = (unsigned int) spi->controller_data;
+	}
+
 	if (!spi->controller_state) {
 		if (cs != SPI_GPIO_NO_CHIPSELECT) {
 			status = gpio_request(cs, dev_name(&spi->dev));
@@ -250,6 +266,7 @@ static int spi_gpio_setup(struct spi_device *spi)
 	}
 	if (!status) {
 		status = spi_bitbang_setup(spi);
+		/* in case it was initialized from static board data */
 		spi_gpio->cs_gpios[spi->chip_select] = cs;
 	}
 
@@ -326,6 +343,55 @@ done:
 	return value;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id spi_gpio_dt_ids[] = {
+	{ .compatible = "spi-gpio" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_gpio_dt_ids);
+
+static int spi_gpio_probe_dt(struct platform_device *pdev)
+{
+	int ret;
+	u32 tmp;
+	struct spi_gpio_platform_data	*pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+			of_match_device(spi_gpio_dt_ids, &pdev->dev);
+
+	if (!of_id)
+		return 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->sck = of_get_named_gpio(np, "gpio-sck", 0);
+	pdata->miso = of_get_named_gpio(np, "gpio-miso", 0);
+	pdata->mosi = of_get_named_gpio(np, "gpio-mosi", 0);
+
+	ret = of_property_read_u32(np, "num-chipselects", &tmp);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "num-chipselects property not found\n");
+		goto error_free;
+	}
+
+	pdata->num_chipselect = tmp;
+	pdev->dev.platform_data = pdata;
+
+	return 1;
+
+error_free:
+	devm_kfree(&pdev->dev, pdata);
+	return ret;
+}
+#else
+static inline int spi_probe_dt(struct platform_device *)
+{
+	return 0;
+}
+#endif
+
 static int __devinit spi_gpio_probe(struct platform_device *pdev)
 {
 	int				status;
@@ -333,6 +399,13 @@ static int __devinit spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
 	u16 master_flags = 0;
+	bool use_of = 0;
+
+	status = spi_gpio_probe_dt(pdev);
+	if (status < 0)
+		return status;
+	if (status > 0)
+		use_of = 1;
 
 	pdata = pdev->dev.platform_data;
 #ifdef GENERIC_BITBANG
@@ -362,6 +435,23 @@ static int __devinit spi_gpio_probe(struct platform_device *pdev)
 	master->num_chipselect = SPI_N_CHIPSEL;
 	master->setup = spi_gpio_setup;
 	master->cleanup = spi_gpio_cleanup;
+#ifdef CONFIG_OF
+	master->dev.of_node = pdev->dev.of_node;
+
+	if (use_of) {
+		int i;
+		struct device_node *np = pdev->dev.of_node;
+
+		/*
+		 * In DT environments, take the CS GPIO from the "cs-gpios"
+		 * property of the node.
+		 */
+
+		for (i = 0; i < SPI_N_CHIPSEL; i++)
+			spi_gpio->cs_gpios[i] =
+				of_get_named_gpio(np, "cs-gpios", i);
+	}
+#endif
 
 	spi_gpio->bitbang.master = spi_master_get(master);
 	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
@@ -422,8 +512,11 @@ static int __devexit spi_gpio_remove(struct platform_device *pdev)
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
 static struct platform_driver spi_gpio_driver = {
-	.driver.name	= DRIVER_NAME,
-	.driver.owner	= THIS_MODULE,
+	.driver = {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(spi_gpio_dt_ids),
+	},
 	.probe		= spi_gpio_probe,
 	.remove		= __devexit_p(spi_gpio_remove),
 };
-- 
1.7.11.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
