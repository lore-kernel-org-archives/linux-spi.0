From: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Add support for slave controllers plus
	sysfs entries for	power management
Date: Fri, 18 Dec 2009 13:06:56 -0800
Message-ID: <1261170416.10785.5.camel@ubuntu-vmware>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi mailing list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>From d429aaa794f8d578501c13fed3eae28e50049b1f Mon Sep 17 00:00:00 2001
From: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Wed, 16 Dec 2009 17:44:54 -0800
Subject: [PATCH] Add support for slave controllers plus sysfs entries for power
 management


Signed-off-by: Ken Mills <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig     |   12 ++
 drivers/spi/spi.c       |  402 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/spi/spi.h |   83 ++++++++++-
 3 files changed, 482 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 4b6f7cb..d1124b3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -278,6 +278,18 @@ config SPI_TLE62X0
 
 endif # SPI_MASTER
 
+	config SPI_SLAVE
+	bool "SPI Slave support"
+	help
+	  This will enable SPI slave controller support. In this mode, clock
+	  and frame are provided by the SPI master controller.
+
+if SPI_SLAVE
+
+comment "SPI SLAVE Controller Drivers"
+
 # (slave support would go here)
 
+endif # SPI_SLAVE
+
 endif # SPI
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b76f246..9a2a5c9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -36,10 +36,21 @@ static void spidev_release(struct device *dev)
 	struct spi_device	*spi = to_spi_device(dev);
 
 	/* spi masters may cleanup for released devices */
-	if (spi->master->cleanup)
-		spi->master->cleanup(spi);
+	if (spi->master) {
+		if (spi->master->cleanup)
+			spi->master->cleanup(spi);
 
-	spi_master_put(spi->master);
+		spi_master_put(spi->master);
+	}
+
+#ifdef CONFIG_SPI_SLAVE
+	if (spi->slave) {
+		if (spi->slave->cleanup)
+			spi->slave->cleanup(spi);
+
+		spi_slave_put(spi->slave);
+	}
+#endif
 	kfree(dev);
 }
 
@@ -129,6 +140,73 @@ static int spi_resume(struct device *dev)
 	}
 	return value;
 }
+static const char power_group[] = "power";
+static const char on_string[] = "on";
+static const char suspend_string[] = "suspend";
+
+static ssize_t
+show_level(struct device *s_dev, struct device_attribute *attr, char *buf)
+{
+	struct spi_device *dev = to_spi_device(s_dev);
+	const char *p;
+
+	if (dev->state == SPI_STATE_ON)
+		p = on_string;		/* ON or Active */
+	else
+		p = suspend_string;	/* Suspended */
+
+	return sprintf(buf, "%s\n", p);
+}
+
+static ssize_t
+set_level(struct device *s_dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct spi_device *dev = to_spi_device(s_dev);
+	int len = count;
+	char *cp;
+	int rc = 0;
+
+	cp = memchr(buf, '\n', count);
+	if (cp)
+		len = cp - buf;
+
+	if (len == sizeof on_string - 1 &&
+			strncmp(buf, on_string, len) == 0) {
+
+		spi_resume(s_dev);		/*  Turn ON SPI Device */
+		dev->state = SPI_STATE_ON;	/* Save new State */
+
+	} else if (len == sizeof suspend_string - 1 &&
+			strncmp(buf, suspend_string, len) == 0) {
+
+		spi_suspend(s_dev, PMSG_SUSPEND);	/*Suspend SPI Device*/
+		dev->state = SPI_STATE_SUSPENDED;	/* Save new State */
+
+	} else
+		rc = -EINVAL;
+
+	return (rc < 0 ? rc : count);
+}
+
+static DEVICE_ATTR(level, S_IRUGO | S_IWUSR, show_level, set_level);
+
+static int add_power_attributes(struct device *dev)
+{
+	int rc = 0;
+
+	rc = sysfs_add_file_to_group(&dev->kobj,
+					&dev_attr_level.attr,
+					power_group);
+	return rc;
+}
+
+static void remove_power_attributes(struct device *dev)
+{
+	sysfs_remove_file_from_group(&dev->kobj,
+			&dev_attr_level.attr,
+			power_group);
+}
 
 #else
 #define spi_suspend	NULL
@@ -150,13 +228,21 @@ static int spi_drv_probe(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
 
+#ifdef	CONFIG_PM
+	struct spi_device *sdev = to_spi_device(dev);
+	if (add_power_attributes(dev))
+		remove_power_attributes(dev);
+	sdev->state = SPI_STATE_ON;	/* By default set ON*/
+#endif
 	return sdrv->probe(to_spi_device(dev));
 }
 
 static int spi_drv_remove(struct device *dev)
 {
 	const struct spi_driver		*sdrv = to_spi_driver(dev->driver);
-
+#ifdef	CONFIG_PM
+	remove_power_attributes(dev);
+#endif
 	return sdrv->remove(to_spi_device(dev));
 }
 
@@ -181,6 +267,11 @@ int spi_register_driver(struct spi_driver *sdrv)
 		sdrv->driver.remove = spi_drv_remove;
 	if (sdrv->shutdown)
 		sdrv->driver.shutdown = spi_drv_shutdown;
+	if (sdrv->suspend)
+		sdrv->driver.suspend = spi_suspend;
+	if (sdrv->resume)
+		sdrv->driver.resume = spi_resume;
+
 	return driver_register(&sdrv->driver);
 }
 EXPORT_SYMBOL_GPL(spi_register_driver);
@@ -235,6 +326,7 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 	}
 
 	spi->master = master;
+	spi->slave = NULL;
 	spi->dev.parent = dev;
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
@@ -255,21 +347,31 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 int spi_add_device(struct spi_device *spi)
 {
 	static DEFINE_MUTEX(spi_add_lock);
-	struct device *dev = spi->master->dev.parent;
+	struct device *dev = NULL;
 	int status;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= spi->master->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n",
-			spi->chip_select,
-			spi->master->num_chipselect);
-		return -EINVAL;
-	}
-
+	if (spi->master) {
+		dev = spi->master->dev.parent;
+		/* Chipselects are numbered 0..max; validate. */
+		if (spi->chip_select >= spi->master->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n",
+				spi->chip_select,
+				spi->master->num_chipselect);
+			return -EINVAL;
+		}
 	/* Set the bus ID string */
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
 			spi->chip_select);
+	}
 
+#ifdef CONFIG_SPI_SLAVE
+	if (spi->slave) {
+		dev = spi->slave->dev.parent;
+		/* Set the bus ID string */
+		dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->slave->dev),
+				spi->chip_select);
+	}
+#endif
 
 	/* We need to make sure there's no other device with this
 	 * chipselect **BEFORE** we call setup(), else we'll trash
@@ -604,6 +706,262 @@ struct spi_master *spi_busnum_to_master(u16 bus_num)
 }
 EXPORT_SYMBOL_GPL(spi_busnum_to_master);
 
+#ifdef CONFIG_SPI_SLAVE
+/**
+* spi_slave_new_device - instantiate one new SPI device
+* @slave: Controller to which device is connected
+* @chip: Describes the SPI device
+* Context: can sleep
+*
+* On typical mainboards, this is purely internal; and it's not needed
+* after board init creates the hard-wired devices.  Some development
+* platforms may not be able to use spi_register_board_info though, and
+* this is exported so that for example a USB or parport based adapter
+* driver could add devices (which it would learn about out-of-band).
+*
+* Returns the new device, or NULL.
+*/
+struct spi_device *spi_slave_new_device(struct spi_slave *slave,
+				  struct spi_board_info *chip)
+{
+	struct spi_device	*proxy_slave;
+	int			status;
+
+	proxy_slave = spi_alloc_slave_device(slave);
+
+	if (!proxy_slave)
+		return NULL;
+
+	WARN_ON(strlen(chip->modalias) >= sizeof(proxy_slave->modalias));
+
+	proxy_slave->chip_select = chip->chip_select;
+	proxy_slave->max_speed_hz = chip->max_speed_hz;
+	proxy_slave->mode = chip->mode;
+	proxy_slave->irq = chip->irq;
+	strlcpy(proxy_slave->modalias, chip->modalias,
+					sizeof(proxy_slave->modalias));
+	proxy_slave->dev.platform_data = (void *) chip->platform_data;
+	proxy_slave->controller_data = chip->controller_data;
+	proxy_slave->controller_state = NULL;
+
+	status = spi_add_device(proxy_slave);
+	if (status < 0) {
+		spi_dev_put(proxy_slave);
+		return NULL;
+	}
+
+	return proxy_slave;
+}
+EXPORT_SYMBOL_GPL(spi_slave_new_device);
+
+
+static void spi_slave_scan_boardinfo(struct spi_slave *slave)
+{
+	struct boardinfo	*bi;
+
+	mutex_lock(&board_lock);
+	list_for_each_entry(bi, &board_list, list) {
+		struct spi_board_info	*chip = bi->board_info;
+		unsigned		n;
+
+		for (n = bi->n_board_info; n > 0; n--, chip++) {
+			if (chip->bus_num != slave->bus_num)
+				continue;
+			/* NOTE: this relies on spi_new_device to
+			 * issue diagnostics when given bogus inputs
+			 */
+			(void) spi_slave_new_device(slave, chip);
+
+		}
+	}
+	mutex_unlock(&board_lock);
+}
+
+static void spi_slave_release(struct device *dev)
+{
+	struct spi_slave *slave;
+
+	slave = container_of(dev, struct spi_slave, dev);
+	kfree(slave);
+}
+
+static struct class spi_slave_class = {
+	.name		= "spi_slave",
+	.owner		= THIS_MODULE,
+	.dev_release	= spi_slave_release,
+};
+
+
+
+
+
+/**
+* spi_alloc_slave - allocate SPI slave controller
+* @dev: the controller, possibly using the platform_bus
+* @size: how much zeroed driver-private data to allocate; the pointer to this
+*	memory is in the driver_data field of the returned device,
+*	accessible with spi_slave_get_devdata().
+* Context: can sleep
+*
+* This call is used only by SPI master controller drivers, which are the
+* only ones directly touching chip registers.  It's how they allocate
+* an spi_master structure, prior to calling spi_register_slave().
+*
+* This must be called from context that can sleep.  It returns the SPI
+* master structure on success, else NULL.
+*
+* The caller is responsible for assigning the bus number and initializing
+* the master's methods before calling spi_register_slave(); and (after errors
+* adding the device) calling spi_slave_put() to prevent a memory leak.
+*/
+struct spi_slave *spi_alloc_slave(struct device *dev, unsigned size)
+{
+	struct spi_slave	*slave;
+
+	if (!dev)
+		return NULL;
+
+	slave = kzalloc(size + sizeof *slave, GFP_KERNEL);
+	if (!slave)
+		return NULL;
+
+	device_initialize(&slave->dev);
+	slave->dev.class = &spi_slave_class;
+	slave->dev.parent = get_device(dev);
+	spi_slave_set_devdata(slave, &slave[1]);
+
+	return slave;
+}
+EXPORT_SYMBOL_GPL(spi_alloc_slave);
+
+
+/*
+* spi_alloc_slave_device - Allocate a new SPI device
+* @slave: Controller to which device is connected
+* Context: can sleep
+*
+* Allows a driver to allocate and initialize a spi_device without
+* registering it immediately.  This allows a driver to directly
+* fill the spi_device with device parameters before calling
+* spi_add_slave_device() on it.
+*
+* Caller is responsible to call spi_add_slave_device() on the returned
+* spi_device structure to add it to the SPI slave.  If the caller
+* needs to discard the spi_device without adding it, then it should
+* call spi_dev_slave_put() on it.
+* Returns a pointer to the new device, or NULL.
+*/
+struct spi_device *spi_alloc_slave_device(struct spi_slave *slave)
+{
+	struct spi_device	*spi_s;
+	struct device		*dev = slave->dev.parent;
+
+	if (!spi_slave_get(slave))
+		return NULL;
+
+	spi_s = kzalloc(sizeof *spi_s, GFP_KERNEL);
+	if (!spi_s) {
+		dev_err(dev, "cannot alloc spi_slave_device\n");
+		spi_slave_put(slave);
+		return NULL;
+	}
+
+	spi_s->slave = slave;
+	spi_s->master = NULL;
+	spi_s->dev.parent = dev;
+	spi_s->dev.bus = &spi_bus_type;
+	spi_s->dev.release = spidev_release;
+	device_initialize(&spi_s->dev);
+	return spi_s;
+}
+EXPORT_SYMBOL_GPL(spi_alloc_slave_device);
+
+
+/**
+* spi_register_slave - register SPI slave controller
+* @master: initialized master, originally from spi_alloc_slave()
+* Context: can sleep
+*
+* SPI slave controllers connect to their drivers using some non-SPI bus,
+* such as the platform bus.  The final stage of probe() in that code
+* includes calling spi_register_slave() to hook up to this SPI bus glue.
+*
+* SPI controllers use board specific (often SOC specific) bus numbers,
+* and board-specific addressing for SPI devices combines those numbers
+* with chip select numbers.  Since SPI does not directly support dynamic
+* device identification, boards need configuration tables telling which
+* chip is at which address.
+*
+* This must be called from context that can sleep.  It returns zero on
+* success, else a negative error code (dropping the slave's refcount).
+* After a successful return, the caller is responsible for calling
+* spi_unregister_slave().
+*/
+int spi_register_slave(struct spi_slave *slave)
+{
+	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
+	struct device		*dev = slave->dev.parent;
+	int			status = -ENODEV;
+	int			dynamic = 0;
+
+	if (!dev)
+		return -ENODEV;
+
+	/* even if it's just one always-selected device, there must
+	 * be at least one chipselect
+	 */
+	if (slave->num_chipselect == 0)
+		return -EINVAL;
+
+	/* convention:  dynamically assigned bus IDs count down from the max */
+	if (slave->bus_num < 0) {
+		/* FIXME switch to an IDR based scheme, something like
+		 * I2C now uses, so we can't run out of "dynamic" IDs
+		 */
+		slave->bus_num = atomic_dec_return(&dyn_bus_id);
+		dynamic = 1;
+	}
+
+	/* register the device, then userspace will see it.
+	 * registration fails if the bus ID is in use.
+	 */
+	dev_set_name(&slave->dev, "spi%u", slave->bus_num);
+	status = device_add(&slave->dev);
+	if (status < 0)
+		goto done;
+
+	dev_dbg(dev, "registered slave %s%s\n", dev_name(&slave->dev),
+			dynamic ? " (dynamic)" : "");
+
+	/* populate children from any spi device tables */
+	spi_slave_scan_boardinfo(slave);
+	status = 0;
+done:
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_register_slave);
+
+/**
+* spi_unregister_slave - unregister SPI slave controller
+* @master: the slave being unregistered
+* Context: can sleep
+*
+* This call is used only by SPI slave controller drivers, which are the
+* only ones directly touching chip registers.
+*
+* This must be called from context that can sleep.
+*/
+void spi_unregister_slave(struct spi_slave *slave)
+{
+	int dummy;
+
+	dummy = device_for_each_child(slave->dev.parent, &slave->dev,
+					__unregister);
+	device_unregister(&slave->dev);
+}
+EXPORT_SYMBOL_GPL(spi_unregister_slave);
+
+#endif
 
 /*-------------------------------------------------------------------------*/
 
@@ -634,6 +992,11 @@ int spi_setup(struct spi_device *spi)
 	unsigned	bad_bits;
 	int		status;
 
+#ifdef CONFIG_SPI_SLAVE
+	if (spi->slave)
+		return spi->slave->setup(spi);
+#endif
+
 	/* help drivers fail *cleanly* when they need options
 	 * that aren't supported with their current master
 	 */
@@ -695,7 +1058,15 @@ EXPORT_SYMBOL_GPL(spi_setup);
 int spi_async(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
+#ifdef CONFIG_SPI_SLAVE
+	struct spi_slave *slave = spi->slave;
 
+	if (slave) {
+		message->spi = spi;
+		message->status = -EINPROGRESS;
+		return slave->transfer(spi, message);
+	}
+#endif
 	/* Half-duplex links include original MicroWire, and ones with
 	 * only one data pin like SPI_3WIRE (switches direction) or where
 	 * either MOSI or MISO is missing.  They can also be caused by
@@ -871,6 +1242,11 @@ static int __init spi_init(void)
 	status = class_register(&spi_master_class);
 	if (status < 0)
 		goto err2;
+#ifdef CONFIG_SPI_SLAVE
+	status = class_register(&spi_slave_class);
+	if (status < 0)
+		goto err2;
+#endif
 	return 0;
 
 err2:
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 97b60b3..98781a7 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,15 +23,26 @@
 #include <linux/mod_devicetable.h>
 
 /*
- * INTERFACES between SPI master-side drivers and SPI infrastructure.
- * (There's no SPI slave support for Linux yet...)
+ * INTERFACES between SPI Master/Slave side drivers and
+ * SPI infrastructure.
+ * SPI Slave Support added : It uses few new APIs and
+ * a new spi_slave struct
  */
 extern struct bus_type spi_bus_type;
 
+/* SPI Device State for power managment */
+enum spi_device_state {
+
+	SPI_STATE_SUSPENDED = 0,
+	SPI_STATE_ON
+
+};
+
 /**
  * struct spi_device - Master side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
  * @master: SPI controller used with the device.
+ * @slave: SPI Slave Controller used with the device
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
@@ -68,6 +79,8 @@ extern struct bus_type spi_bus_type;
 struct spi_device {
 	struct device		dev;
 	struct spi_master	*master;
+	struct spi_slave	*slave;
+	enum spi_device_state 	state;
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			mode;
@@ -295,16 +308,56 @@ struct spi_master {
 	void			(*cleanup)(struct spi_device *spi);
 };
 
+/**
+ * struct spi_slave - interface to SPI Slave Controller
+ * @dev: device interface to this driver
+ * @bus_num: board-specific (and often SOC-specific) identifier for a
+ *	given SPI controller.
+ * @num_chipselect: chipselects are used to distinguish individual
+ *	SPI slaves, and are numbered from zero to num_chipselects.
+ *	each slave has a chipselect signal, but it's common that not
+ *	every chipselect is connected to a slave.
+ * @setup: updates the device mode and clocking records used by a
+ *	device's SPI controller; protocol code may call this.  This
+ *	must fail if an unrecognized or unsupported mode is requested.
+ *	It's always safe to call this unless transfers are pending on
+ *	the device whose settings are being modified.
+ * @transfer: adds a message to the controller's transfer queue.
+ * @cleanup: frees controller-specific state
+ */
+struct spi_slave {
+	struct device	dev;
+	s16			bus_num;
+	u16			num_chipselect;
+
+	int			(*setup)(struct spi_device *spi);
+
+	int			(*transfer)(struct spi_device *spi,
+						struct spi_message *mesg);
+
+	void			(*cleanup)(struct spi_device *spi);
+};
+
 static inline void *spi_master_get_devdata(struct spi_master *master)
 {
 	return dev_get_drvdata(&master->dev);
 }
 
+static inline void *spi_slave_get_devdata(struct spi_slave *slave)
+{
+	return dev_get_drvdata(&slave->dev);
+}
+
 static inline void spi_master_set_devdata(struct spi_master *master, void *data)
 {
 	dev_set_drvdata(&master->dev, data);
 }
 
+static inline void spi_slave_set_devdata(struct spi_slave *slave, void *data)
+{
+	dev_set_drvdata(&slave->dev, data);
+}
+
 static inline struct spi_master *spi_master_get(struct spi_master *master)
 {
 	if (!master || !get_device(&master->dev))
@@ -312,12 +365,24 @@ static inline struct spi_master *spi_master_get(struct spi_master *master)
 	return master;
 }
 
+static inline struct spi_slave *spi_slave_get(struct spi_slave *slave)
+{
+	if (!slave || !get_device(&slave->dev))
+		return NULL;
+	return slave;
+}
+
 static inline void spi_master_put(struct spi_master *master)
 {
 	if (master)
 		put_device(&master->dev);
 }
 
+static inline void spi_slave_put(struct spi_slave *slave)
+{
+	if (slave)
+		put_device(&slave->dev);
+}
 
 /* the spi driver core manages memory for the spi_master classdev */
 extern struct spi_master *
@@ -328,6 +393,11 @@ extern void spi_unregister_master(struct spi_master *master);
 
 extern struct spi_master *spi_busnum_to_master(u16 busnum);
 
+extern struct spi_slave *
+spi_alloc_slave(struct device *host, unsigned size);
+
+extern int spi_register_slave(struct spi_slave *slave);
+extern void spi_unregister_slave(struct spi_slave *slave);
 /*---------------------------------------------------------------------------*/
 
 /*
@@ -759,12 +829,21 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
 extern struct spi_device *
 spi_alloc_device(struct spi_master *master);
 
+extern struct spi_device *
+spi_alloc_slave_device(struct spi_slave *slave);
+
 extern int
 spi_add_device(struct spi_device *spi);
 
+extern int
+spi_add_slave_device(struct spi_device *spi);
+
 extern struct spi_device *
 spi_new_device(struct spi_master *, struct spi_board_info *);
 
+extern struct spi_device *
+spi_slave_new_device(struct spi_slave *, struct spi_board_info *);
+
 static inline void
 spi_unregister_device(struct spi_device *spi)
 {
-- 
1.5.4.3




------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
