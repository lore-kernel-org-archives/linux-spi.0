From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 3/3] drivers core: allow id match override when manually binding driver
Date: Mon, 27 Jun 2016 21:02:32 +0200
Message-ID: <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1467053363.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1467053363.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1467053363.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi bus has no autodetection whatsoever. The 'detection' of the
device that's suposed to be on the other side completely relies on user
supplied information coming from devicetree on many platforms. It is
completely reasonable then to allow the user to supply the information
at runtime by doing echo 'somedevice' >
/sys/bus/spi/drivers/somedriver/bind
This fails if somedriver does not have in its id table compatible of
somedevice so just skip this check for manual driver binding.

This allows binding spidev on any slave device by hand using sysfs
without adding superfluous compatibles or any other needless
complication.

Note that any slave driver that requires configuration will fail to
probe anyway if the configuration is not provided in the devicetree node.
A driver like spidev that requires no configuration can bind to any slave.

Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

 drivers/base/bus.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 6470eb8..a896aed 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -199,6 +199,28 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(unbind);
 
+static const char *driver_override_buses[] = {
+	"spi",
+	NULL
+};
+
+static inline bool driver_match_override(struct device_driver *drv,
+					 struct device *dev)
+{
+	struct bus_type *bus = bus_get(drv->bus);
+	int i;
+
+	for (i = 0; driver_override_buses[i]; i++) {
+		if (!strcmp(bus->name, driver_override_buses[i])) {
+			pr_notice("Overriding id match on manual driver binding:\n bus: %s  driver: %s  device: %s\n",
+				  bus->name, drv->name, dev_name(dev));
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Manually attach a device to a driver.
  * Note: the driver must want to bind to the device,
@@ -212,7 +234,8 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	int err = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
+	if (dev && dev->driver == NULL && (driver_match_device(drv, dev)
+	    || driver_match_override(drv, dev))) {
 		if (dev->parent)	/* Needed for USB */
 			device_lock(dev->parent);
 		device_lock(dev);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
