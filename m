From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC v2 3/7] spi: core: Add support for registering SPI slave controllers
Date: Mon, 12 Sep 2016 22:50:42 +0200
Message-ID: <1473713446-30366-4-git-send-email-geert+renesas@glider.be>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473713446-30366-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add support for registering SPI slave controllers using the existing SPI
master framework:
  - SPI slave controllers must set the SPI_CONTROLLER_IS_SLAVE flag in
    spi_master.flags, and should provide an additional callback
    "slave_abort" to abort an ongoing SPI transfer request.
  - SPI slave controllers are added to a new "spi_slave" device class,
  - (Un)binding an SPI slave handler to the SPI slave device represented
    by an SPI slave controller is done by (un)registering the slave
    device through a sysfs virtual file named "slave",
  - Initial slave-specific mode properties are parsed from the SPI slave
    controller DT node.

>From the point of view of an SPI slave protocol handler, an SPI slave
controller looks almost like an ordinary SPI master controller. The only
exception is that a transfer request will block on the remote SPI
master, and may be cancelled using spi_slave_abort().

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - Attach SPI slave controllers to a new "spi_slave" device class,
  - Don't call of_spi_register_master() instead of letting it return
    early for SPI slave controllers,
  - Skip registration of children from DT or ACPI for SPI slave
    controllers,
  - Use a "slave" virtual file in sysfs to (un)register the (single)
    slave device for an SPI slave controller, incl. specifying the slave
    protocol handler,
  - Parse slave-specific mode properties in the SPI slave controller DT
    node for the (single) slave device using of_spi_parse_dt(),
  - Add cancellation support using spi_master.slave_abort() and
    spi_slave_abort(),
  - Rename flag SPI_MASTER_IS_SLAVE to SPI_CONTROLLER_IS_SLAVE,
  - Introduce helper function spi_controller_is_slave(), making it easy
    to leave out SPI slave support where appropriate.

TBD:
  - s/spi_master/spi_controller/ where appropriate,
  - Provide wrappers (e.g. "#define spi_master spi_controller" until all
    SPI drivers have been converted),
  - Do we want a separate spi_register_slave() instead?
---
 drivers/spi/Kconfig     |  14 ++++-
 drivers/spi/Makefile    |   2 +
 drivers/spi/spi.c       | 162 +++++++++++++++++++++++++++++++++++++++++++-----
 include/linux/spi/spi.h |  17 ++++-
 4 files changed, 175 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6fb8d4b778672fd..fa13a3663de5bde0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -737,6 +737,18 @@ config SPI_TLE62X0
 
 endif # SPI_MASTER
 
-# (slave support would go here)
+#
+# SLAVE side ... listening to other SPI masters
+#
+
+config SPI_SLAVE
+	bool "SPI slave protocol handlers"
+	help
+	  If your system has a slave-capable SPI controller, you can enable
+	  slave protocol handlers.
+
+if SPI_SLAVE
+
+endif # SPI_SLAVE
 
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 185367ef65761a74..96e5c0d6e5bc6151 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -98,3 +98,5 @@ obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
 obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
+
+# SPI slave protocol handlers
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 79e5c1ba23c81dc1..cfb0d573fc4dedba 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1477,15 +1477,6 @@ static int of_spi_parse_dt(struct spi_master *master, struct spi_device *spi,
 	u32 value;
 	int rc;
 
-	/* Device address */
-	rc = of_property_read_u32(nc, "reg", &value);
-	if (rc) {
-		dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
-			nc->full_name, rc);
-		return rc;
-	}
-	spi->chip_select = value;
-
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_find_property(nc, "spi-cpha", NULL))
 		spi->mode |= SPI_CPHA;
@@ -1535,6 +1526,18 @@ static int of_spi_parse_dt(struct spi_master *master, struct spi_device *spi,
 		}
 	}
 
+	if (spi_controller_is_slave(master))
+		return 0;
+
+	/* Device address */
+	rc = of_property_read_u32(nc, "reg", &value);
+	if (rc) {
+		dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
+			nc->full_name, rc);
+		return rc;
+	}
+	spi->chip_select = value;
+
 	/* Device speed */
 	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
@@ -1619,6 +1622,8 @@ static void of_register_spi_devices(struct spi_master *master)
 	}
 }
 #else
+static int of_spi_parse_dt(struct spi_master *master, struct spi_device *spi,
+			   struct device_node *nc) { return 0; }
 static void of_register_spi_devices(struct spi_master *master) { }
 #endif
 
@@ -1764,6 +1769,110 @@ static struct class spi_master_class = {
 	.dev_groups	= spi_master_groups,
 };
 
+#ifdef CONFIG_SPI_SLAVE
+/**
+ * spi_slave_abort - abort the ongoing transfer request on an SPI slave
+ *		     controller
+ * @spi: device used for the current transfer
+ */
+int spi_slave_abort(struct spi_device *spi)
+{
+	struct spi_master *master = spi->master;
+
+	if (spi_controller_is_slave(master) && master->slave_abort)
+		return master->slave_abort(master);
+
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(spi_slave_abort);
+
+static int match_true(struct device *dev, void *data)
+{
+	return 1;
+}
+
+static ssize_t spi_slave_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct spi_master *ctlr = container_of(dev, struct spi_master, dev);
+	struct device *child;
+
+	child = device_find_child(&ctlr->dev, NULL, match_true);
+	return sprintf(buf, "%s\n",
+		       child ? to_spi_device(child)->modalias : NULL);
+}
+
+static ssize_t spi_slave_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	struct spi_master *ctlr = container_of(dev, struct spi_master, dev);
+	struct spi_device *spi;
+	struct device *child;
+	char name[32];
+	int rc;
+
+	rc = sscanf(buf, "%31s", name);
+	if (rc != 1 || !name[0])
+		return -EINVAL;
+
+	child = device_find_child(&ctlr->dev, NULL, match_true);
+	if (child) {
+		/* Remove registered slave */
+		device_unregister(child);
+		put_device(child);
+	}
+
+	if (strcmp(name, "(null)")) {
+		/* Register new slave */
+		spi = spi_alloc_device(ctlr);
+		if (!spi)
+			return -ENOMEM;
+
+		strlcpy(spi->modalias, name, sizeof(spi->modalias));
+
+		rc = of_spi_parse_dt(ctlr, spi, ctlr->dev.of_node);
+		if (rc)
+			goto err_out;
+
+		rc = spi_add_device(spi);
+		if (rc)
+			goto err_out;
+	}
+
+	return count;
+
+err_out:
+	spi_dev_put(spi);
+	return rc;
+}
+
+static DEVICE_ATTR(slave, S_IWUSR|S_IRUGO, spi_slave_show, spi_slave_store);
+
+static struct attribute *spi_slave_attrs[] = {
+	&dev_attr_slave.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_slave_group = {
+	.attrs = spi_slave_attrs,
+};
+
+static const struct attribute_group *spi_slave_groups[] = {
+	&spi_master_statistics_group,
+	&spi_slave_group,
+	NULL,
+};
+
+static struct class spi_slave_class = {
+	.name		= "spi_slave",
+	.owner		= THIS_MODULE,
+	.dev_release	= spi_master_release,
+	.dev_groups	= spi_slave_groups,
+};
+#else
+extern struct class spi_slave_class;	/* dummy */
+#endif
 
 /**
  * spi_alloc_master - allocate SPI master controller
@@ -1799,7 +1908,6 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 	device_initialize(&master->dev);
 	master->bus_num = -1;
 	master->num_chipselect = 1;
-	master->dev.class = &spi_master_class;
 	master->dev.parent = dev;
 	pm_suspend_ignore_children(&master->dev, true);
 	spi_master_set_devdata(master, &master[1]);
@@ -1882,9 +1990,18 @@ int spi_register_master(struct spi_master *master)
 	if (!dev)
 		return -ENODEV;
 
-	status = of_spi_register_master(master);
-	if (status)
-		return status;
+	if (master->flags & SPI_CONTROLLER_IS_SLAVE) {
+		if (!IS_ENABLED(CONFIG_SPI_SLAVE))
+			return -ENOSYS;
+
+		master->dev.class = &spi_slave_class;
+	} else {
+		master->dev.class = &spi_master_class;
+
+		status = of_spi_register_master(master);
+		if (status)
+			return status;
+	}
 
 	/* even if it's just one always-selected device, there must
 	 * be at least one chipselect
@@ -1921,8 +2038,9 @@ int spi_register_master(struct spi_master *master)
 	status = device_add(&master->dev);
 	if (status < 0)
 		goto done;
-	dev_dbg(dev, "registered master %s%s\n", dev_name(&master->dev),
-			dynamic ? " (dynamic)" : "");
+	dev_dbg(dev, "registered %s %s%s\n",
+			spi_controller_is_slave(master) ? "slave" : "master",
+			dev_name(&master->dev), dynamic ? " (dynamic)" : "");
 
 	/* If we're using a queued driver, start the queue */
 	if (master->transfer)
@@ -1944,8 +2062,10 @@ int spi_register_master(struct spi_master *master)
 	mutex_unlock(&board_lock);
 
 	/* Register devices from the device tree and ACPI */
-	of_register_spi_devices(master);
-	acpi_register_spi_devices(master);
+	if (!spi_controller_is_slave(master)) {
+		of_register_spi_devices(master);
+		acpi_register_spi_devices(master);
+	}
 done:
 	return status;
 }
@@ -3247,6 +3367,12 @@ static int __init spi_init(void)
 	if (status < 0)
 		goto err2;
 
+	if (IS_ENABLED(CONFIG_SPI_SLAVE)) {
+		status = class_register(&spi_slave_class);
+		if (status < 0)
+			goto err3;
+	}
+
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
 	if (IS_ENABLED(CONFIG_ACPI))
@@ -3254,6 +3380,8 @@ static int __init spi_init(void)
 
 	return 0;
 
+err3:
+	class_unregister(&spi_master_class);
 err2:
 	bus_unregister(&spi_bus_type);
 err1:
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 072cb2aa24139981..9a278e92b5b70e07 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -28,8 +28,8 @@ struct spi_transfer;
 struct spi_flash_read_message;
 
 /*
- * INTERFACES between SPI master-side drivers and SPI infrastructure.
- * (There's no SPI slave support for Linux yet...)
+ * INTERFACES between SPI master-side drivers and SPI slave protocol handers,
+ * and SPI infrastructure.
  */
 extern struct bus_type spi_bus_type;
 
@@ -371,6 +371,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
+ * @slave_abort: abort the ongoing transfer request on an SPI slave controller
  * @spi_flash_read: to support spi-controller hardwares that provide
  *                  accelerated interface to read from flash devices.
  * @flash_read_supported: spi device supports flash read
@@ -440,6 +441,7 @@ struct spi_master {
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+#define SPI_CONTROLLER_IS_SLAVE	BIT(5)		/* SPI slave controller */
 
 	/*
 	 * on some hardware transfer size may be constrained
@@ -532,6 +534,7 @@ struct spi_master {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_master *master,
 				 struct spi_message *message);
+	int (*slave_abort)(struct spi_master *spi);
 	int (*spi_flash_read)(struct  spi_device *spi,
 			      struct spi_flash_read_message *msg);
 	bool (*flash_read_supported)(struct spi_device *spi);
@@ -586,6 +589,15 @@ static inline void spi_master_put(struct spi_master *master)
 		put_device(&master->dev);
 }
 
+static inline bool spi_controller_is_slave(struct spi_master *ctlr)
+{
+#ifdef CONFIG_SPI_SLAVE
+	return ctlr->flags & SPI_CONTROLLER_IS_SLAVE;
+#else
+	return false;
+#endif
+}
+
 /* PM calls that need to be issued by the driver */
 extern int spi_master_suspend(struct spi_master *master);
 extern int spi_master_resume(struct spi_master *master);
@@ -903,6 +915,7 @@ extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
 			    struct spi_message *message);
+extern int spi_slave_abort(struct spi_device *spi);
 
 static inline size_t
 spi_max_transfer_size(struct spi_device *spi)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
