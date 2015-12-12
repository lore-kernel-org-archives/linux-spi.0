From: Christophe Ricard <christophe.ricard@gmail.com>
Subject: [PATCH v5 2/3] ACPI / gpio: Add irq_type when a gpio is used as an interrupt
Date: Sun, 13 Dec 2015 00:30:03 +0100
Message-ID: <1449963004-8391-3-git-send-email-christophe-h.ricard@st.com>
References: <1449963004-8391-1-git-send-email-christophe-h.ricard@st.com>
Cc: linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Christophe Ricard <christophe-h.ricard@st.com>
To: rjw@rjwysocki.net, lenb@kernel.org, linus.walleij@linaro.org,
	gnurou@gmail.com, andriy.shevchenko@linux.intel.com,
	mika.westerberg@linux.intel.com, broonie@kernel.org
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1449963004-8391-1-git-send-email-christophe-h.ricard@st.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When a gpio is used as an interrupt in acpi, the irq_type was not
available for device driver.

Make available polarity and triggering information in acpi_find_gpio by
renaming acpi_gpio_info field active_low  to polarity and adding triggering
field (edge/level).
For sanity, in gpiolib.c replace info.active_low by
"info.polarity == GPIO_ACTIVE_LOW".

Set the irq_type if necessary in acpi_dev_gpio_irq_get.

Signed-off-by: Christophe Ricard <christophe-h.ricard@st.com>
---
 drivers/gpio/gpiolib-acpi.c | 28 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.c      |  4 ++--
 drivers/gpio/gpiolib.h      |  6 ++++--
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bbcac3a..04aa69e 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -416,9 +416,10 @@ static int acpi_find_gpio(struct acpi_resource *ares, void *data)
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
 	}
 
 	return 1;
@@ -510,7 +511,7 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	if (lookup.desc && info) {
 		*info = lookup.info;
 		if (active_low)
-			info->active_low = active_low;
+			info->polarity = active_low;
 	}
 
 	return lookup.desc ? lookup.desc : ERR_PTR(-ENOENT);
@@ -530,6 +531,7 @@ struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 {
 	int idx, i;
+	u32 irq_flags;
 
 	for (i = 0, idx = 0; idx <= index; i++) {
 		struct acpi_gpio_info info;
@@ -538,8 +540,22 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
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
 	}
 	return -ENOENT;
 }
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 6798355..90e737f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1873,7 +1873,7 @@ static struct gpio_desc *acpi_find_gpio(struct device *dev, const char *con_id,
 			return desc;
 	}
 
-	if (info.active_low)
+	if (info.polarity == GPIO_ACTIVE_LOW)
 		*flags |= GPIO_ACTIVE_LOW;
 
 	return desc;
@@ -2212,7 +2212,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 		desc = acpi_get_gpiod_by_index(to_acpi_node(fwnode), propname, 0,
 					       &info);
 		if (!IS_ERR(desc))
-			active_low = info.active_low;
+			active_low = info.polarity == GPIO_ACTIVE_LOW;
 	}
 
 	if (IS_ERR(desc))
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 78e634d..57063d2 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -22,11 +22,13 @@ struct acpi_device;
 /**
  * struct acpi_gpio_info - ACPI GPIO specific information
  * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
- * @active_low: in case of @gpioint, the pin is active low
+ * @polarity: in case of @gpioint, the pin is active low
+ * @triggering: in case of @gpioint, interrupt triggering mode (edge or level)
  */
 struct acpi_gpio_info {
 	bool gpioint;
-	bool active_low;
+	u32 polarity;
+	u32 triggering;
 };
 
 /* gpio suffixes used for ACPI and device tree lookup */
-- 
2.1.4

