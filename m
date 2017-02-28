From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] spi: allow attaching device properties to SPI board info
Date: Mon, 27 Feb 2017 20:08:46 -0800
Message-ID: <20170228040848.9447-1-dmitry.torokhov@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Generic device properties support statically defined property sets. For
them to be usable, we need to attach these property sets before devices
are registered and probed. Allowing to attach property list to
spi_board_info structure will allow non-ACPI non-DT boards switch to using
generic properties and get rid of custom platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       | 27 +++++++++++++++++++++++----
 include/linux/spi/spi.h |  4 ++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 656dd3e3220c..b948d8cdbace 100644
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
@@ -599,13 +600,25 @@ struct spi_device *spi_new_device(struct spi_master *master,
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
+			goto err_out;
+		}
 	}
 
+	status = spi_add_device(proxy);
+	if (status < 0)
+		goto err_out;
+
 	return proxy;
+
+err_out:
+	spi_dev_put(proxy);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
@@ -661,6 +674,7 @@ static void spi_match_master_to_boardinfo(struct spi_master *master,
  *
  * The board info passed can safely be __initdata ... but be careful of
  * any embedded pointers (platform_data, etc), they're copied as-is.
+ * Device properties are deep-copied though.
  *
  * Return: zero on success, else a negative error code.
  */
@@ -680,6 +694,11 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 		struct spi_master *master;
 
 		memcpy(&bi->board_info, info, sizeof(*info));
+		bi->board_info.properties =
+			property_entries_dup(info->properties);
+		if (IS_ERR(bi->board_info.properties))
+			return PTR_ERR(bi->board_info.properties);
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
