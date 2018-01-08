From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3] gpio: of: Support SPI nonstandard GPIO properties
Date: Mon,  8 Jan 2018 16:02:21 +0100
Message-ID: <20180108150221.14193-1-linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Before it was clearly established that all GPIO properties in the
device tree shall be named "foo-gpios" (with the deprecated variant
"foo-gpio" for single lines) we unfortunately merged a few bindings
which named the lines "gpio-foo" instead.

This is most prominent in the GPIO SPI driver in Linux which names
the lines "gpio-sck", "gpio-mosi" and "gpio-miso".

As we want to switch the GPIO SPI driver to using descriptors, we
need devm_gpiod_get() to return something reasonable when looking
up these in the device tree.

Put in a special #ifdef:ed kludge to do this special lookup only
for the SPI case and gets compiled out if we're not enabling SPI.
If we have more oddly defined legacy GPIOs like this, they can be
handled in a similar manner.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Put the if(!IS_ENABLED()) inside the SPI GPIO retrieveal function
  and rely on the compiler to stub out unused code.
ChangeLog v1->v2:
- Us if IS_ENABLED(CONFIG_SPI_MASTER) instead of
  #ifdef CONFIG_SPI_MASTER
---
 drivers/gpio/gpiolib-of.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index e0d59e61b52f..317e54f95035 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -117,6 +117,36 @@ int of_get_named_gpio_flags(struct device_node *np, const char *list_name,
 }
 EXPORT_SYMBOL(of_get_named_gpio_flags);
 
+/*
+ * The SPI GPIO bindings happened before we managed to establish that GPIO
+ * properties should be named "foo-gpios" so we have this special kludge for
+ * them.
+ */
+static struct gpio_desc *of_find_spi_gpio(struct device *dev, const char *con_id,
+					  enum of_gpio_flags *of_flags)
+{
+	char prop_name[32]; /* 32 is max size of property name */
+	struct device_node *np = dev->of_node;
+	struct gpio_desc *desc;
+
+	/*
+	 * Hopefully the compiler stubs the rest of the function if this
+	 * is false.
+	 */
+	if (!IS_ENABLED(CONFIG_SPI_MASTER))
+		return ERR_PTR(-ENOENT);
+
+	/* Allow this specifically for "spi-gpio" devices */
+	if (!of_device_is_compatible(np, "spi-gpio") || !con_id)
+		return ERR_PTR(-ENOENT);
+
+	/* Will be "gpio-sck", "gpio-mosi" or "gpio-miso" */
+	snprintf(prop_name, sizeof(prop_name), "%s-%s", "gpio", con_id);
+
+	desc = of_get_named_gpiod_flags(np, prop_name, 0, of_flags);
+	return desc;
+}
+
 struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			       unsigned int idx,
 			       enum gpio_lookup_flags *flags)
@@ -126,6 +156,7 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	struct gpio_desc *desc;
 	unsigned int i;
 
+	/* Try GPIO property "foo-gpios" and "foo-gpio" */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id)
 			snprintf(prop_name, sizeof(prop_name), "%s-%s", con_id,
@@ -140,6 +171,10 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 			break;
 	}
 
+	/* Special handling for SPI GPIOs if used */
+	if (IS_ERR(desc))
+		desc = of_find_spi_gpio(dev, con_id, &of_flags);
+
 	if (IS_ERR(desc))
 		return desc;
 
-- 
2.14.3

