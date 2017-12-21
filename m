From: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
Subject: [PATCH] spi: Add a sysfs interface to instantiate devices
Date: Thu, 21 Dec 2017 14:03:09 -0600
Message-ID: <20171221200309.17967-1-kyle.roeschley@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Geert Uytterhoeven" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add a sysfs interface to instantiate and delete SPI devices using the
spidev driver. This can be used when developing a driver on a
self-soldered board which doesn't yet have proper SPI device declaration
at the platform level, and presumably for various debugging situations.

Inspired by 99cd8e25875a ("i2c: Add a sysfs interface to instantiate
devices").

Signed-off-by: Kyle Roeschley <kyle.roeschley-acOepvfBmUk@public.gmane.org>
---
 Documentation/spi/spi-summary | 14 ++++++++
 drivers/spi/spi.c             | 78 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h       |  3 ++
 3 files changed, 95 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 1721c1b570c3..51d9747c4426 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -339,6 +339,20 @@ up the spi bus master, and will likely need spi_new_device() to provide the
 board info based on the board that was hotplugged.  Of course, you'd later
 call at least spi_unregister_device() when that board is removed.
 
+Alternatively, a sysfs interface was added to let the user create devices which
+using the spidev driver. This interface is made of 2 attribute files which are
+created in every SPI master directory: new_device and delete_device. Both files
+are write only and you must write the decimal SPI chip select number to them in
+order to properly instantiate or delete a SPI device. As no two devices can be
+attached to the same master with the same chip select line, the chip select
+number is sufficient to uniquely identify the device to be deleted.
+
+Example:
+# echo 1 > /sys/class/spi_master/spi0/new_device
+
+In general, this interface should only be used when in-kernel device
+declaration can't be done.
+
 When Linux includes support for MMC/SD/SDIO/DataFlash cards through SPI, those
 configurations will also be dynamic.  Fortunately, such devices all support
 basic device identification probes, so they should hotplug normally.
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727a0158..648ccdf359f9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -242,8 +242,85 @@ static const struct attribute_group spi_controller_statistics_group = {
 	.attrs  = spi_controller_statistics_attrs,
 };
 
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi;
+	struct spi_board_info bi = {
+		.modalias = "spidev",
+		.max_speed_hz = ctlr->max_speed_hz,
+	};
+
+	if (kstrtou16(buf, 0, &bi.chip_select) < 0)
+		return -EINVAL;
+
+	spi = spi_new_device(ctlr, &bi);
+	if (!spi) {
+		dev_err(dev, "can't create new device\n");
+		return -ENXIO;
+	}
+
+	mutex_lock(&ctlr->bus_lock_mutex);
+	list_add_tail(&spi->userspace_device, &ctlr->userspace_devices);
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	dev_info(dev, "created spidev device %s\n", dev_name(&spi->dev));
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi, *next;
+	int ret = -ENXIO;
+	u16 cs;
+
+	if (kstrtou16(buf, 0, &cs) < 0)
+		return -EINVAL;
+
+	mutex_lock(&ctlr->bus_lock_mutex);
+	list_for_each_entry_safe(spi, next, &ctlr->userspace_devices,
+				 userspace_device) {
+		if (spi->chip_select != cs)
+			continue;
+
+		dev_info(dev, "deleting spidev device %s\n",
+			 dev_name(&spi->dev));
+		list_del(&spi->userspace_device);
+		spi_unregister_device(spi);
+		ret = count;
+		break;
+	}
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	if (ret == -ENXIO)
+		dev_err(dev, "can't find spidev device %u in list\n", cs);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(delete_device);
+
+static struct attribute *spi_controller_userspace_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_controller_userspace_group = {
+	.attrs  = spi_controller_userspace_attrs,
+};
+
 static const struct attribute_group *spi_master_groups[] = {
 	&spi_controller_statistics_group,
+	&spi_controller_userspace_group,
 	NULL,
 };
 
@@ -2129,6 +2206,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 			return id;
 		ctlr->bus_num = id;
 	}
+	INIT_LIST_HEAD(&ctlr->userspace_devices);
 	INIT_LIST_HEAD(&ctlr->queue);
 	spin_lock_init(&ctlr->queue_lock);
 	spin_lock_init(&ctlr->bus_lock_spinlock);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index bc6bb325d1bf..f7255745326d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -172,6 +172,8 @@ struct spi_device {
 	/* the statistics */
 	struct spi_statistics	statistics;
 
+	struct list_head	userspace_device;
+
 	/*
 	 * likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -410,6 +412,7 @@ struct spi_controller {
 	struct device	dev;
 
 	struct list_head list;
+	struct list_head userspace_devices;
 
 	/* other than negative (== assign one dynamically), bus_num is fully
 	 * board-specific.  usually that simplifies to being SOC-specific.
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
