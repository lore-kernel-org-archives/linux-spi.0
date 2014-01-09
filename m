From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] spi: Check conflicting CS based on spi->chip_select instead of device name
Date: Thu,  9 Jan 2014 15:23:55 +0200
Message-ID: <1389273835-8615-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit e13ac47bec20 (spi: Use stable dev_name for ACPI enumerated SPI
slaves) changed the SPI device naming to be based on ACPI device name
instead of carrying bus number and chip select for devices enumerated
from ACPI namespace.

In case of a buggy BIOS that lists multiple SPI devices sharing the same
chip select (even though they should use different) the current code fails
to detect that and allows the devices to be added to the bus.

Fix this by walking through the bus and comparing spi->chip_select instead
of device name. This should work regardless what the device name will be in
future.

Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 349ebba4b199..13dcc360bde6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -370,6 +370,17 @@ static void spi_dev_set_name(struct spi_device *spi)
 		     spi->chip_select);
 }
 
+static int spi_dev_check(struct device *dev, void *data)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_device *new_spi = data;
+
+	if (spi->master == new_spi->master &&
+	    spi->chip_select == new_spi->chip_select)
+		return -EBUSY;
+	return 0;
+}
+
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -384,7 +395,6 @@ int spi_add_device(struct spi_device *spi)
 	static DEFINE_MUTEX(spi_add_lock);
 	struct spi_master *master = spi->master;
 	struct device *dev = master->dev.parent;
-	struct device *d;
 	int status;
 
 	/* Chipselects are numbered 0..max; validate. */
@@ -404,12 +414,10 @@ int spi_add_device(struct spi_device *spi)
 	 */
 	mutex_lock(&spi_add_lock);
 
-	d = bus_find_device_by_name(&spi_bus_type, NULL, dev_name(&spi->dev));
-	if (d != NULL) {
+	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
+	if (status) {
 		dev_err(dev, "chipselect %d already in use\n",
 				spi->chip_select);
-		put_device(d);
-		status = -EBUSY;
 		goto done;
 	}
 
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
