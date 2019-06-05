From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 11/13] drivers: Introduce variants for bus_find_device()
Date: Wed,  5 Jun 2019 16:13:48 +0100
Message-ID: <1559747630-28065-12-git-send-email-suzuki.poulose@arm.com>
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Lunn <andrew@lunn.ch>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-i2c@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Mathieu Po
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Similar to the class_find_device_by_*() introduce the variants
for bus_find_device() to automatically search for device by
generic device properties.

Here is the list of new helpers :

	bus_find_device_by_of_node
	bus_find_device_by_fwnode
	bus_find_device_by_devt
	bus_find_next_device

While at it convert the bus_find_device_by_name to static inline
reusing the generic helper to match the name.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-i2c@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-spi@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/base/bus.c     | 24 -------------------
 include/linux/device.h | 64 +++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index df3cac7..a1d1e82 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -342,30 +342,6 @@ struct device *bus_find_device(struct bus_type *bus,
 }
 EXPORT_SYMBOL_GPL(bus_find_device);
 
-static int match_name(struct device *dev, const void *data)
-{
-	const char *name = data;
-
-	return sysfs_streq(name, dev_name(dev));
-}
-
-/**
- * bus_find_device_by_name - device iterator for locating a particular device of a specific name
- * @bus: bus type
- * @start: Device to begin with
- * @name: name of the device to match
- *
- * This is similar to the bus_find_device() function above, but it handles
- * searching by a name automatically, no need to write another strcmp matching
- * function.
- */
-struct device *bus_find_device_by_name(struct bus_type *bus,
-				       struct device *start, const char *name)
-{
-	return bus_find_device(bus, start, (void *)name, match_name);
-}
-EXPORT_SYMBOL_GPL(bus_find_device_by_name);
-
 /**
  * subsys_find_device_by_id - find a device with a specific enumeration number
  * @subsys: subsystem
diff --git a/include/linux/device.h b/include/linux/device.h
index 4396edc..10de79d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -175,9 +175,67 @@ int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
 struct device *bus_find_device(struct bus_type *bus, struct device *start,
 			       const void *data,
 			       int (*match)(struct device *dev, const void *data));
-struct device *bus_find_device_by_name(struct bus_type *bus,
-				       struct device *start,
-				       const char *name);
+/**
+ * bus_find_device_by_name - device iterator for locating a particular device
+ * of a specific name.
+ * @bus: bus type
+ * @start: Device to begin with
+ * @name: name of the device to match
+ */
+static inline struct device *bus_find_device_by_name(struct bus_type *bus,
+						     struct device *start,
+						     const char *name)
+{
+	return bus_find_device(bus, start, name, device_match_name);
+}
+
+/**
+ * bus_find_device_by_of_node : device iterator for locating a particular device
+ * matching the of_node.
+ * @bus: bus type
+ * @np: of_node of the device to match.
+ */
+static inline struct device *
+bus_find_device_by_of_node(struct bus_type *bus, const struct device_node *np)
+{
+	return bus_find_device(bus, NULL, np, device_match_of_node);
+}
+
+/**
+ * bus_find_device_by_fwnode : device iterator for locating a particular device
+ * matching the fwnode.
+ * @bus: bus type
+ * @fwnode: fwnode of the device to match.
+ */
+static inline struct device *
+bus_find_device_by_fwnode(struct bus_type *bus, const struct fwnode_handle *fwnode)
+{
+	return bus_find_device(bus, NULL, fwnode, device_match_fwnode);
+}
+
+/**
+ * bus_find_device_by_devt : device iterator for locating a particular device
+ * matching the device type.
+ * @bus: bus type
+ * @start: device to start the search from
+ * @devt: device type of the device to match.
+ */
+static inline struct device *
+bus_find_device_by_devt(struct bus_type *bus, struct device *start, dev_t devt)
+{
+	return bus_find_device(bus, start, &devt, device_match_devt);
+}
+
+/**
+ * bus_find_next_device - Find the next device after a given device in a
+ * given bus.
+ */
+static inline struct device *
+bus_find_next_device(struct bus_type *bus,struct device *cur)
+{
+	return bus_find_device(bus, cur, NULL, device_match_any);
+}
+
 struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
 					struct device *hint);
 int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
-- 
2.7.4
