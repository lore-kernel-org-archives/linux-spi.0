From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH 3/3] drivers core: allow id match override when manually binding driver
Date: Fri, 24 Jun 2016 16:20:34 +0200
Message-ID: <5e0397742f887f656d67bb0d61c8e10782c0e5af.1466696079.git.hramrach@gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466696079.git.hramrach@gmail.com>
In-Reply-To: <cover.1466696079.git.hramrach@gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This allows binding spidev on any slave device by hand using sysfs
without adding superfluous compatibles or any other needless
complication.

Note that any slave driver that requires configuration will fail to
probe anyway. Only a driver that binds to anything can be bound
successfully.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/base/Kconfig.debug | 14 +++++++++
 drivers/base/bus.c         | 72 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug          |  2 ++
 3 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/Kconfig.debug

diff --git a/drivers/base/Kconfig.debug b/drivers/base/Kconfig.debug
new file mode 100644
index 0000000..e21d3cc
--- /dev/null
+++ b/drivers/base/Kconfig.debug
@@ -0,0 +1,14 @@
+menuconfig DRIVER_MATCH_OVERRIDE
+	bool "Allow manual driver binding to override id match (DANGEROUS)"
+	default n
+	help
+	  When binding a driver manually bypass the check of driver id table
+	  against device id in driver core. This can be useful for development
+	  or on buses that don't provide reliable device identification.
+
+config DRIVER_MATCH_OVERRIDE_BUSES
+	string "Specify buses for which id matching will be overridden"
+	default "spi"
+	depends on DRIVER_MATCH_OVERRIDE
+	help
+	  space separated bus names
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 6470eb8..752c2a0 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -199,6 +199,73 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(unbind);
 
+#ifdef CONFIG_DRIVER_MATCH_OVERRIDE_BUSES
+
+/* nul separated "" terminated strings */
+static const char *driver_override_buses;
+
+static inline void init_overrides(void)
+{
+	const char *buses_str = CONFIG_DRIVER_MATCH_OVERRIDE_BUSES;
+	char *transcript;
+	int i, len = strlen(buses_str);
+
+	if (!len)
+		return;
+
+	transcript = kzalloc(len + 1, GFP_KERNEL);
+	if (!transcript)
+		return;
+	driver_override_buses = transcript;
+
+	for (i = 0; i < len; i++) {
+
+		while (buses_str[i] == ' ')
+			i++;
+
+		if (buses_str[i]) {
+			const char *name_start = buses_str + i;
+			const char *name_end = strchrnul(name_start, ' ');
+			int name_len = name_end - name_start;
+
+			strncpy(transcript, name_start, name_len);
+			i += name_len;
+			transcript += name_len;
+			transcript++;
+		}
+	}
+}
+
+static inline bool driver_match_override(struct device_driver *drv,
+					 struct device *dev)
+{
+	struct bus_type *bus = bus_get(drv->bus);
+	const char *cmp_name = driver_override_buses;
+
+	while (cmp_name && *cmp_name) {
+		if (!strcmp(bus->name, cmp_name)) {
+			pr_notice("Overriding id match on manual driver binding:\n bus: %s  driver: %s  device: %s\n",
+				  bus->name, drv->name, dev_name(dev));
+			return true;
+		}
+		cmp_name += strlen(cmp_name);
+		cmp_name++;
+	}
+
+	return false;
+}
+
+#else /*CONFIG_DRIVER_MATCH_OVERRIDE_BUSES*/
+
+static inline void init_overrides(void)
+{}
+
+static inline bool driver_match_override(struct device_driver *drv,
+					 struct device *dev)
+{ return false; }
+
+#endif
+
 /*
  * Manually attach a device to a driver.
  * Note: the driver must want to bind to the device,
@@ -212,7 +279,8 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	int err = -ENODEV;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && dev->driver == NULL && driver_match_device(drv, dev)) {
+	if (dev && dev->driver == NULL && (driver_match_device(drv, dev)
+	    || driver_match_override(drv, dev))) {
 		if (dev->parent)	/* Needed for USB */
 			device_lock(dev->parent);
 		device_lock(dev);
@@ -1280,5 +1348,7 @@ int __init buses_init(void)
 	if (!system_kset)
 		return -ENOMEM;
 
+	init_overrides();
+
 	return 0;
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1e9a607..f388212 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2002,3 +2002,5 @@ config IO_STRICT_DEVMEM
 	  if the driver using a given range cannot be disabled.
 
 	  If in doubt, say Y.
+
+source drivers/base/Kconfig.debug
-- 
2.8.1
