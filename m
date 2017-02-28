From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 1/2] spi: allow attaching device properties to SPI board info
Date: Tue, 28 Feb 2017 14:25:18 -0800
Message-ID: <20170228222519.38217-2-dmitry.torokhov@gmail.com>
References: <20170228222519.38217-1-dmitry.torokhov@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170228222519.38217-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Generic device properties support statically defined property sets. For
them to be usable, we need to attach these property sets before devices
are registered and probed. Allowing to attach property list to
spi_board_info structure will allow non-ACPI non-DT boards switch to using
generic properties and get rid of custom platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi.c       | 32 ++++++++++++++++++++++++++++----
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..bdecba9be2fa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -31,6 +31,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/property.h>
 #include <linux/export.h>
 #include <linux/sched/rt.h>
 #include <linux/delay.h>
@@ -599,13 +600,28 @@ struct spi_device *spi_new_device(struct spi_master *master,
 	proxy->controller_data = chip->controller_data;
 	proxy->controller_state = NULL;
 
-	status = spi_add_device(proxy);
-	if (status < 0) {
-		spi_dev_put(proxy);
-		return NULL;
+	if (chip->properties) {
+		status = device_add_properties(&proxy->dev, chip->properties);
+		if (status) {
+			dev_err(&master->dev,
+				"failed to add properties to '%s': %d\n",
+				chip->modalias, status);
+			goto err_dev_put;
+		}
 	}
 
+	status = spi_add_device(proxy);
+	if (status < 0)
+		goto err_remove_props;
+
 	return proxy;
+
+err_remove_props:
+	if (chip->properties)
+		device_remove_properties(&proxy->dev);
+err_dev_put:
+	spi_dev_put(proxy);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
@@ -661,6 +677,7 @@ static void spi_match_master_to_boardinfo(struct spi_master *master,
  *
  * The board info passed can safely be __initdata ... but be careful of
  * any embedded pointers (platform_data, etc), they're copied as-is.
+ * Device properties are deep-copied though.
  *
  * Return: zero on success, else a negative error code.
  */
@@ -680,6 +697,13 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 		struct spi_master *master;
 
 		memcpy(&bi->board_info, info, sizeof(*info));
+		if (info->properties) {
+			bi->board_info.properties =
+					property_entries_dup(info->properties);
+			if (IS_ERR(bi->board_info.properties))
+				return PTR_ERR(bi->board_info.properties);
+		}
+
 		mutex_lock(&board_lock);
 		list_add_tail(&bi->list, &board_list);
 		list_for_each_entry(master, &spi_master_list, list)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 75c6bd0ac605..5a8c4b24f2dc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,7 @@
 #include <linux/scatterlist.h>
 
 struct dma_chan;
+struct property_entry;
 struct spi_master;
 struct spi_transfer;
 struct spi_flash_read_message;
@@ -1209,6 +1210,7 @@ int spi_flash_read(struct spi_device *spi,
  * @modalias: Initializes spi_device.modalias; identifies the driver.
  * @platform_data: Initializes spi_device.platform_data; the particular
  *	data stored there is driver-specific.
+ * @properties: Additional device properties for the device.
  * @controller_data: Initializes spi_device.controller_data; some
  *	controllers need hints about hardware setup, e.g. for DMA.
  * @irq: Initializes spi_device.irq; depends on how the board is wired.
@@ -1241,10 +1243,12 @@ struct spi_board_info {
 	 *
 	 * platform_data goes to spi_device.dev.platform_data,
 	 * controller_data goes to spi_device.controller_data,
+	 * device properties are copied and attached to spi_device,
 	 * irq is copied too
 	 */
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
+	const struct property_entry *properties;
 	void		*controller_data;
 	int		irq;
 
-- 
2.11.0.483.g087da7b7c-goog
