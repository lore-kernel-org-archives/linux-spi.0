From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 2/3] ACPI / gpio: Add irq_type when a gpio is used as an interrupt
Date: Mon,  7 Dec 2015 23:39:11 +0100
Message-ID: <1449527952-8399-3-git-send-email-christophe-h.ricard@st.com>
References: <1449527952-8399-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449527952-8399-1-git-send-email-christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When a gpio is used as an interrupt in acpi, the irq_type was not
available for device driver.

Make it available in acpi_find_gpio with a new acpi_gpio_info field
(irq_type) and setthe irq_type if necessary in acpi_dev_gpio_irq_get.

Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
---
 drivers/gpio/gpiolib-acpi.c | 22 ++++++++++++++++++----
 drivers/gpio/gpiolib.h      |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bbcac3a..4b893c8 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -416,9 +416,12 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
 		 * GpioIo is used then the only way to set the flag is
 		 * to use _DSD "gpios" property.
 		 */
-		if (lookup->info.gpioint)
+		if (lookup->info.gpioint) {
 			lookup->info.active_low =
 				agpio->polarity == ACPI_ACTIVE_LOW;
+			lookup->info.irq_type = acpi_get_irq_type(agpio->triggering,
+								  agpio->polarity);
+		}
 	}
 
 	return 1;
@@ -529,7 +532,7 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
  */
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
-	int idx, i;
+	int idx, i, irq;
 
 	for (i = 0, idx = 0; idx <= index; i++) {
 		struct acpi_gpio_info info;
@@ -538,8 +541,19 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 		desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
 		if (IS_ERR(desc))
 			break;
-		if (info.gpioint && idx++ == index)
-			return gpiod_to_irq(desc);
+		if (info.gpioint && idx++ == index) {
+			irq = gpiod_to_irq(desc);
+			if (irq < 0) {
+				dev_err(&adev->dev,
+					"Failed to translate GPIO to IRQ\n");
+				return irq;
+			}
+			/* Set type if specified and different than the current one */
+			if (info.irq_type != IRQ_TYPE_NONE &&
+			    info.irq_type != irq_get_trigger_type(irq))
+				irq_set_irq_type(irq, info.irq_type);
+			return irq;
+		}
 	}
 	return -ENOENT;
 }
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 78e634d..624fbc4 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -27,6 +27,7 @@ struct acpi_device;
 struct acpi_gpio_info {
 	bool gpioint;
 	bool active_low;
+	int irq_type;
 };
 
 /* gpio suffixes used for ACPI and device tree lookup */
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
