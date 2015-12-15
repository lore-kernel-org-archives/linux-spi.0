From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v7 2/3] ACPI / gpio: Add irq_type when a gpio is used as an interrupt
Date: Tue, 15 Dec 2015 08:11:32 +0100
Message-ID: <1450163493-4938-3-git-send-email-christophe-h.ricard@st.com>
References: <1450163493-4938-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450163493-4938-1-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When a gpio is used as an interrupt in acpi, the irq_type was not
available for device driver.

Make available polarity and triggering information in acpi_find_gpio by
renaming acpi_gpio_info field active_low  to polarity and adding triggering
field (edge/level).
For sanity, in gpiolib.c replace info.active_low by
"info.polarity == GPIO_ACTIVE_LOW".

Set the irq_type if necessary in acpi_dev_gpio_irq_get.

Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
---
 drivers/gpio/gpiolib-acpi.c | 30 ++++++++++++++++++++++++------
 drivers/gpio/gpiolib.c      |  4 ++--
 drivers/gpio/gpiolib.h      |  3 ++-
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 16a7b68..9f83fc6 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -418,9 +418,11 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
 		 * GpioIo is used then the only way to set the flag is
 		 * to use _DSD "gpios" property.
 		 */
-		if (lookup->info.gpioint)
-			lookup->info.active_low =
-				agpio->polarity == ACPI_ACTIVE_LOW;
+		if (lookup->info.gpioint) {
+			lookup->info.polarity = agpio->polarity;
+			lookup->info.triggering = agpio->triggering;
+		}
+
 	}
 
 	return 1;
@@ -447,7 +449,7 @@ static int acpi_gpio_resource_lookup(struct acpi_gpio_lookup *lookup,
 	if (info) {
 		*info = lookup->info;
 		if (lookup->active_low)
-			info->active_low = lookup->active_low;
+			info->polarity = lookup->active_low;
 	}
 	return 0;
 }
@@ -595,6 +597,7 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
 	int idx, i;
+	unsigned int irq_flags;
 
 	for (i = 0, idx = 0; idx <= index; i++) {
 		struct acpi_gpio_info info;
@@ -603,8 +606,23 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 		desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
 		if (IS_ERR(desc))
 			break;
-		if (info.gpioint && idx++ == index)
-			return gpiod_to_irq(desc);
+		if (info.gpioint && idx++ == index) {
+			int irq = gpiod_to_irq(desc);
+
+			if (irq < 0)
+				return irq;
+
+			irq_flags = acpi_dev_get_irq_type(info.triggering,
+							  info.polarity);
+
+			/* Set type if specified and different than the current one */
+			if (irq_flags != IRQ_TYPE_NONE &&
+			    irq_flags != irq_get_trigger_type(irq))
+				irq_set_irq_type(irq, irq_flags);
+
+			return irq;
+		}
+
 	}
 	return -ENOENT;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 2a91f32..5b67177 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1873,7 +1873,7 @@ static struct gpio_desc *acpi_find_gpio(struct device *dev, const char *con_id,
 			return desc;
 	}
 
-	if (info.active_low)
+	if (info.polarity == GPIO_ACTIVE_LOW)
 		*flags |= GPIO_ACTIVE_LOW;
 
 	return desc;
@@ -2211,7 +2211,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 
 		desc = acpi_node_get_gpiod(fwnode, propname, 0, &info);
 		if (!IS_ERR(desc))
-			active_low = info.active_low;
+			active_low = info.polarity == GPIO_ACTIVE_LOW;
 	}
 
 	if (IS_ERR(desc))
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 98ab08c..5ac3b88 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -26,7 +26,8 @@ struct acpi_device;
  */
 struct acpi_gpio_info {
 	bool gpioint;
-	bool active_low;
+	int polarity;
+	int triggering;
 };
 
 /* gpio suffixes used for ACPI and device tree lookup */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
