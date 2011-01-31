From: Aaron.Wu <Aaron.Wu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi:add support for slave function in current spi framework
Date: Mon, 31 Jan 2011 16:46:51 +0800
Message-ID: <1296463611-18764-1-git-send-email-Aaron.Wu06@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Aaron.Wu" <Aaron.Wu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
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

This is for the current git trunk and it's basically from  the patch once post by Ken Mills.  It's a draft version showing how we plan to implement the spi slave funtion by introducing some changes on the current spi framework, if this style of implementation is going to be accepted then we will go on to do more work on it.

Signed-off-by: Aaron.Wu <Aaron.Wu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c       |  401 ++++++++++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi.h |   97 ++++++++++--
 2 files changed, 432 insertions(+), 66 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b02d0cb..b2757d4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -29,19 +29,39 @@
 #include <linux/spi/spi.h>
 #include <linux/of_spi.h>
 
+
+/* SPI bustype, spi_master and spi_slave class are registered after board
+ * init code provides the SPI device tables, ensuring that both are present
+ * by the time controller driver registration causes spi_devices
+ * to "enumerate".
+ */
+
+/* SPI Slave Support is added for new spi slave devices: It uses common APIs,
+ * apart from few new APIs and a spi_slave structure.
+ */
+
 static void spidev_release(struct device *dev)
 {
 	struct spi_device	*spi = to_spi_device(dev);
 
-	/* spi masters may cleanup for released devices */
-	if (spi->master->cleanup)
-		spi->master->cleanup(spi);
+	if (spi->master) {
+		/* spi masters may cleanup for released devices */
+		if (spi->master->cleanup)
+			spi->master->cleanup(spi);
+
+		spi_master_put(spi->master);
+	} else {
+		/* spi slave controller */
+		if (spi->slave->cleanup)
+			spi->slave->cleanup(spi);
+
+		spi_slave_put(spi->slave);
+	}
 
-	spi_master_put(spi->master);
 	kfree(spi);
 }
 
-static ssize_t
+	static ssize_t
 modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 {
 	const struct spi_device	*spi = to_spi_device(dev);
@@ -59,7 +79,7 @@ static struct device_attribute spi_dev_attrs[] = {
  */
 
 static const struct spi_device_id *spi_match_id(const struct spi_device_id *id,
-						const struct spi_device *sdev)
+		const struct spi_device *sdev)
 {
 	while (id->name[0]) {
 		if (!strcmp(sdev->modalias, id->name))
@@ -194,7 +214,6 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
  * Device registration normally goes into like arch/.../mach.../board-YYY.c
  * with other readonly (flashable) information about mainboard devices.
  */
-
 struct boardinfo {
 	struct list_head	list;
 	struct spi_board_info	board_info;
@@ -202,6 +221,7 @@ struct boardinfo {
 
 static LIST_HEAD(board_list);
 static LIST_HEAD(spi_master_list);
+static LIST_HEAD(spi_slave_list);
 
 /*
  * Used to protect add/del opertion for board_info list and
@@ -228,28 +248,70 @@ static DEFINE_MUTEX(board_lock);
  */
 struct spi_device *spi_alloc_device(struct spi_master *master)
 {
-	struct spi_device	*spi;
+	struct spi_device	*spi_m_dev;
 	struct device		*dev = master->dev.parent;
 
 	if (!spi_master_get(master))
 		return NULL;
 
-	spi = kzalloc(sizeof *spi, GFP_KERNEL);
-	if (!spi) {
+	spi_m_dev = kzalloc(sizeof *spi_m_dev, GFP_KERNEL);
+	if (!spi_m_dev) {
 		dev_err(dev, "cannot alloc spi_device\n");
 		spi_master_put(master);
 		return NULL;
 	}
 
-	spi->master = master;
-	spi->dev.parent = dev;
-	spi->dev.bus = &spi_bus_type;
-	spi->dev.release = spidev_release;
-	device_initialize(&spi->dev);
-	return spi;
+	spi_m_dev->master = master;
+	spi_m_dev->slave = NULL;
+	spi_m_dev->dev.parent = dev;
+	spi_m_dev->dev.bus = &spi_bus_type;
+	spi_m_dev->dev.release = spidev_release;
+	device_initialize(&spi_m_dev->dev);
+	return spi_m_dev;
 }
 EXPORT_SYMBOL_GPL(spi_alloc_device);
 
+/*
+ * spi_alloc_slave_device - Allocate a new SPI device
+ * @slave: Controller to which device is connected
+ * Context: can sleep
+ *
+ * Allows a driver to allocate and initialize a spi_device without
+ * registering it immediately.  This allows a driver to directly
+ * fill the spi_device with device parameters before calling
+ * spi_add_slave_device() on it.
+ *
+ * Caller is responsible to call spi_add_slave_device() on the returned
+ * spi_device structure to add it to the SPI slave.  If the caller
+ * needs to discard the spi_device without adding it, then it should
+ * call spi_dev_slave_put() on it.
+ * Returns a pointer to the new device, or NULL.
+ */
+struct spi_device *spi_alloc_slave_device(struct spi_slave *slave)
+{
+	struct spi_device       *spi_s;
+	struct device           *dev = slave->dev.parent;
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
 /**
  * spi_add_device - Add spi_device allocated with spi_alloc_device
  * @spi: spi_device to register
@@ -262,22 +324,32 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 int spi_add_device(struct spi_device *spi)
 {
 	static DEFINE_MUTEX(spi_add_lock);
-	struct device *dev = spi->master->dev.parent;
+	struct device *dev;
 	struct device *d;
 	int status;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= spi->master->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n",
-			spi->chip_select,
-			spi->master->num_chipselect);
-		return -EINVAL;
+	if (spi->master) {
+		/* Master Controller */
+		dev = spi->master->dev.parent;
+		/* Chipselects are numbered 0..max; validate. */
+		if (spi->chip_select >= spi->master->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n",
+					spi->chip_select,
+					spi->master->num_chipselect);
+			return -EINVAL;
 	}
 
-	/* Set the bus ID string */
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
-			spi->chip_select);
+		/* Set the bus ID string */
+		dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->master->dev),
+				spi->chip_select);
 
+	} else {
+		/* Slave Controller */
+		dev = spi->slave->dev.parent;
+		/* Set the bus ID string */
+		dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->slave->dev),
+				spi->chip_select);
+	}
 
 	/* We need to make sure there's no other device with this
 	 * chipselect **BEFORE** we call setup(), else we'll trash
@@ -298,7 +370,11 @@ int spi_add_device(struct spi_device *spi)
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
-	status = spi_setup(spi);
+	if (spi->master)
+		status = spi->master->setup(spi);
+	else
+		status = spi->slave->setup(spi);        /* Slave Controller */
+
 	if (status < 0) {
 		dev_err(dev, "can't setup %s, status %d\n",
 				dev_name(&spi->dev), status);
@@ -371,6 +447,54 @@ struct spi_device *spi_new_device(struct spi_master *master,
 }
 EXPORT_SYMBOL_GPL(spi_new_device);
 
+
+/**
+ * spi_slave_new_device - instantiate one new SPI device
+ * @slave: Controller to which device is connected
+ * @chip: Describes the SPI device
+ * Context: can sleep
+ *
+ * On typical mainboards, this is purely internal; and it's not needed
+ * after board init creates the hard-wired devices.  Some development
+ * platforms may not be able to use spi_register_board_info though, and
+ * this is exported so that for example a USB or parport based adapter
+ * driver could add devices (which it would learn about out-of-band).
+ *
+ * Returns the new device, or NULL.
+ */
+struct spi_device *spi_slave_new_device(struct spi_slave *slave,
+		struct spi_board_info *chip)
+{
+	struct spi_device       *proxy_slave;
+	int                     status;
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
+			sizeof(proxy_slave->modalias));
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
 static void spi_match_master_to_boardinfo(struct spi_master *master,
 				struct spi_board_info *bi)
 {
@@ -385,6 +509,19 @@ static void spi_match_master_to_boardinfo(struct spi_master *master,
 			bi->modalias);
 }
 
+static void spi_match_slave_to_boardinfo(struct spi_slave *slave,
+		struct spi_board_info *bi)
+{
+	struct spi_device *dev;
+
+	if (slave->bus_num != bi->bus_num)
+		return;
+
+	dev = spi_slave_new_device(slave, bi);
+	if (!dev)
+		dev_err(slave->dev.parent, "can't create new device for %s\n",
+				bi->modalias);
+}
 /**
  * spi_register_board_info - register SPI devices for a given board
  * @info: array of chip descriptors
@@ -427,7 +564,6 @@ spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 	return 0;
 }
-
 /*-------------------------------------------------------------------------*/
 
 static void spi_master_release(struct device *dev)
@@ -444,6 +580,21 @@ static struct class spi_master_class = {
 	.dev_release	= spi_master_release,
 };
 
+static void spi_slave_release(struct device *dev)
+{
+	struct spi_slave *slave;
+
+	slave = container_of(dev, struct spi_slave, dev);
+	kfree(slave);
+}
+
+
+static struct class spi_slave_class = {
+	.name           = "spi_slave",
+	.owner          = THIS_MODULE,
+	.dev_release    = spi_slave_release,
+};
+
 
 /**
  * spi_alloc_master - allocate SPI master controller
@@ -485,6 +636,46 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 EXPORT_SYMBOL_GPL(spi_alloc_master);
 
 /**
+ * spi_alloc_slave - allocate SPI slave controller
+ * @dev: the controller, possibly using the platform_bus
+ * @size: how much zeroed driver-private data to allocate; the pointer to this
+ *      memory is in the driver_data field of the returned device,
+ *      accessible with spi_slave_get_devdata().
+ * Context: can sleep
+ *
+ * This call is used only by SPI master controller drivers, which are the
+ * only ones directly touching chip registers.  It's how they allocate
+ * an spi_master structure, prior to calling spi_register_slave().
+ *
+ * This must be called from context that can sleep.  It returns the SPI
+ * master structure on success, else NULL.
+ *
+ * The caller is responsible for assigning the bus number and initializing
+ * the master's methods before calling spi_register_slave(); and (after errors
+ * adding the device) calling spi_slave_put() to prevent a memory leak.
+ */
+struct spi_slave *spi_alloc_slave(struct device *dev, unsigned size)
+{
+	struct spi_slave        *slave;
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
+/**
  * spi_register_master - register SPI master controller
  * @master: initialized master, originally from spi_alloc_master()
  * Context: can sleep
@@ -560,6 +751,82 @@ done:
 EXPORT_SYMBOL_GPL(spi_register_master);
 
 
+/**
+ * spi_register_slave - register SPI slave controller
+ * @master: initialized master, originally from spi_alloc_slave()
+ * Context: can sleep
+ *
+ * SPI slave controllers connect to their drivers using some non-SPI bus,
+ * such as the platform bus.  The final stage of probe() in that code
+ * includes calling spi_register_slave() to hook up to this SPI bus glue.
+ *
+ * SPI controllers use board specific (often SOC specific) bus numbers,
+ * and board-specific addressing for SPI devices combines those numbers
+ * with chip select numbers.  Since SPI does not directly support dynamic
+ * device identification, boards need configuration tables telling which
+ * chip is at which address.
+ *
+ * This must be called from context that can sleep.  It returns zero on
+ * success, else a negative error code (dropping the slave's refcount).
+ * After a successful return, the caller is responsible for calling
+ * spi_unregister_slave().
+ */
+int spi_register_slave(struct spi_slave *slave)
+{
+	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
+	struct device		*dev = slave->dev.parent;
+	struct boardinfo	*bi;
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
+	spin_lock_init(&slave->bus_lock_spinlock);
+	mutex_init(&slave->bus_lock_mutex);
+	slave->bus_lock_flag = 0;
+
+	/* register the device, then userspace will see it.
+	 * registration fails if the bus ID is in use.
+	 */
+	dev_set_name(&slave->dev, "spi%u", slave->bus_num);
+	status = device_add(&slave->dev);
+	if (status < 0)
+		goto done;
+	dev_dbg(dev, "registered master %s%s\n", dev_name(&slave->dev),
+			dynamic ? " (dynamic)" : "");
+
+	mutex_lock(&board_lock);
+	list_add_tail(&slave->list, &spi_slave_list);
+	list_for_each_entry(bi, &board_list, list)
+		spi_match_slave_to_boardinfo(slave, &bi->board_info);
+	mutex_unlock(&board_lock);
+
+	status = 0;
+
+	/* Register devices from the device tree */
+	of_register_spi_devices(slave);
+done:
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_register_slave);
+
+
 static int __unregister(struct device *dev, void *null)
 {
 	spi_unregister_device(to_spi_device(dev));
@@ -580,15 +847,30 @@ void spi_unregister_master(struct spi_master *master)
 {
 	int dummy;
 
-	mutex_lock(&board_lock);
-	list_del(&master->list);
-	mutex_unlock(&board_lock);
-
 	dummy = device_for_each_child(&master->dev, NULL, __unregister);
 	device_unregister(&master->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_master);
 
+/**
+  +* spi_unregister_slave - unregister SPI slave controller
+  +* @master: the slave being unregistered
+  +* Context: can sleep
+  +*
+  +* This call is used only by SPI slave controller drivers, which are the
+  +* only ones directly touching chip registers.
+  +*
+  +* This must be called from context that can sleep.
+  +*/
+void spi_unregister_slave(struct spi_slave *slave)
+{
+	int dummy;
+
+	dummy = device_for_each_child(slave->dev.parent, &slave->dev, __unregister);
+	device_unregister(&slave->dev);
+}
+EXPORT_SYMBOL_GPL(spi_unregister_slave);
+
 static int __spi_master_match(struct device *dev, void *data)
 {
 	struct spi_master *m;
@@ -664,8 +946,10 @@ int spi_setup(struct spi_device *spi)
 
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
-
-	status = spi->master->setup(spi);
+	if (spi->master)
+		status = spi->master->setup(spi);
+	else
+		status = spi->slave->setup(spi);
 
 	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s"
 				"%u bits/w, %u Hz max --> %d\n",
@@ -683,31 +967,35 @@ EXPORT_SYMBOL_GPL(spi_setup);
 
 static int __spi_async(struct spi_device *spi, struct spi_message *message)
 {
-	struct spi_master *master = spi->master;
+	if (spi->master) {
 
-	/* Half-duplex links include original MicroWire, and ones with
-	 * only one data pin like SPI_3WIRE (switches direction) or where
-	 * either MOSI or MISO is missing.  They can also be caused by
-	 * software limitations.
-	 */
-	if ((master->flags & SPI_MASTER_HALF_DUPLEX)
-			|| (spi->mode & SPI_3WIRE)) {
-		struct spi_transfer *xfer;
-		unsigned flags = master->flags;
-
-		list_for_each_entry(xfer, &message->transfers, transfer_list) {
-			if (xfer->rx_buf && xfer->tx_buf)
-				return -EINVAL;
-			if ((flags & SPI_MASTER_NO_TX) && xfer->tx_buf)
-				return -EINVAL;
-			if ((flags & SPI_MASTER_NO_RX) && xfer->rx_buf)
-				return -EINVAL;
+		/* Half-duplex links include original MicroWire, and ones with
+		 * only one data pin like SPI_3WIRE (switches direction) or where
+		 * either MOSI or MISO is missing.  They can also be caused by
+		 * software limitations.
+		 */
+		if ((spi->master->flags & SPI_MASTER_HALF_DUPLEX)
+				|| (spi->mode & SPI_3WIRE)) {
+			struct spi_transfer *xfer;
+			unsigned flags = spi->master->flags;
+
+			list_for_each_entry(xfer, &message->transfers, transfer_list) {
+				if (xfer->rx_buf && xfer->tx_buf)
+					return -EINVAL;
+				if ((flags & SPI_MASTER_NO_TX) && xfer->tx_buf)
+					return -EINVAL;
+				if ((flags & SPI_MASTER_NO_RX) && xfer->rx_buf)
+					return -EINVAL;
+			}
 		}
 	}
 
 	message->spi = spi;
 	message->status = -EINPROGRESS;
-	return master->transfer(spi, message);
+	if (spi->master)
+		return spi->master->transfer(spi, message);
+	else
+		return spi->slave->transfer(spi, message);
 }
 
 /**
@@ -818,7 +1106,7 @@ static void spi_complete(void *arg)
 }
 
 static int __spi_sync(struct spi_device *spi, struct spi_message *message,
-		      int bus_locked)
+			int bus_locked)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
@@ -1044,6 +1332,10 @@ static int __init spi_init(void)
 	status = class_register(&spi_master_class);
 	if (status < 0)
 		goto err2;
+
+	status = class_register(&spi_slave_class);
+	if (status < 0)
+		goto err2;
 	return 0;
 
 err2:
@@ -1063,4 +1355,3 @@ err0:
  * include needing to have boardinfo data structures be much more public.
  */
 postcore_initcall(spi_init);
-
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a3059c2..8663947 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -24,15 +24,18 @@
 #include <linux/slab.h>
 
 /*
- * INTERFACES between SPI master-side drivers and SPI infrastructure.
- * (There's no SPI slave support for Linux yet...)
- */
+ * INTERFACES between SPI Master/Slave side drivers and
+ * SPI infrastructure.
+ * SPI Slave Support added : It uses few new APIs and
+ * a new spi_slave struct
+*/
 extern struct bus_type spi_bus_type;
 
 /**
  * struct spi_device - Master side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
- * @master: SPI controller used with the device.
+ * @master: SPI Master controller used with the device.
+ * @slave: SPI Slave Controller used with the device
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
@@ -70,6 +73,7 @@ extern struct bus_type spi_bus_type;
 struct spi_device {
 	struct device		dev;
 	struct spi_master	*master;
+	struct spi_slave        *slave;
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			mode;
@@ -206,8 +210,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 /**
  * struct spi_master - interface to SPI master controller
  * @dev: device interface to this driver
- * @list: link with the global spi_master list
  * @bus_num: board-specific (and often SOC-specific) identifier for a
+ * @list: link with the global spi_master list
  *	given SPI controller.
  * @num_chipselect: chipselects are used to distinguish individual
  *	SPI slaves, and are numbered from zero to num_chipselects.
@@ -226,6 +230,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	the device whose settings are being modified.
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
+ * @lock_bus: lock SPI bus for exclusive access
+ * @unlock_bus: unlock SPI bus so other devices can access
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -240,9 +246,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  */
 struct spi_master {
 	struct device	dev;
-
 	struct list_head list;
 
+
 	/* other than negative (== assign one dynamically), bus_num is fully
 	 * board-specific.  usually that simplifies to being SOC-specific.
 	 * example:  one SOC has three SPI controllers, numbered 0..2,
@@ -309,6 +315,50 @@ struct spi_master {
 
 	/* called on release() to free memory provided by spi_master */
 	void			(*cleanup)(struct spi_device *spi);
+
+	int			(*lock_bus)(struct spi_device *spi);
+	int			(*unlock_bus)(struct spi_device *spi);
+};
+
+/**
+ * struct spi_slave - interface to SPI Slave Controller
+ * @dev: device interface to this driver
+ * @bus_num: board-specific (and often SOC-specific) identifier for a
+ *     given SPI controller.
+ * @num_chipselect: chipselects are used to distinguish individual
+ *     SPI slaves, and are numbered from zero to num_chipselects.
+ *     each slave has a chipselect signal, but it's common that not
+ *     every chipselect is connected to a slave.
+ * @setup: updates the device mode and clocking records used by a
+ *     device's SPI controller; protocol code may call this.  This
+ *     must fail if an unrecognized or unsupported mode is requested.
+ *     It's always safe to call this unless transfers are pending on
+ *     the device whose settings are being modified.
+ * @transfer: adds a message to the controller's transfer queue.
+ * @cleanup: frees controller-specific state
+ */
+struct spi_slave {
+	struct device   dev;
+	struct list_head list;
+	s16                     bus_num;
+	u16                     num_chipselect;
+
+	/* lock and mutex for SPI bus locking */
+	spinlock_t		bus_lock_spinlock;
+	struct mutex		bus_lock_mutex;
+
+	/* flag indicating that the SPI bus is locked for exclusive use */
+	bool			bus_lock_flag;
+
+	int                     (*setup)(struct spi_device *spi);
+
+	int                     (*transfer)(struct spi_device *spi,
+						struct spi_message *mesg);
+
+	void                    (*cleanup)(struct spi_device *spi);
+
+	int			(*lock_bus)(struct spi_device *spi);
+	int			(*unlock_bus)(struct spi_device *spi);
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
@@ -316,11 +366,21 @@ static inline void *spi_master_get_devdata(struct spi_master *master)
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
@@ -328,19 +388,37 @@ static inline struct spi_master *spi_master_get(struct spi_master *master)
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
 spi_alloc_master(struct device *host, unsigned size);
 
+extern struct spi_slave *
+spi_alloc_slave(struct device *host, unsigned size);
+
 extern int spi_register_master(struct spi_master *master);
+extern int spi_register_slave(struct spi_slave *slave);
+
 extern void spi_unregister_master(struct spi_master *master);
+extern void spi_unregister_slave(struct spi_slave *slave);
 
 extern struct spi_master *spi_busnum_to_master(u16 busnum);
 
@@ -557,8 +635,6 @@ static inline void spi_message_free(struct spi_message *m)
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
-extern int spi_async_locked(struct spi_device *spi,
-			    struct spi_message *message);
 
 /*---------------------------------------------------------------------------*/
 
@@ -568,9 +644,8 @@ extern int spi_async_locked(struct spi_device *spi,
  */
 
 extern int spi_sync(struct spi_device *spi, struct spi_message *message);
-extern int spi_sync_locked(struct spi_device *spi, struct spi_message *message);
-extern int spi_bus_lock(struct spi_master *master);
-extern int spi_bus_unlock(struct spi_master *master);
+extern int spi_lock_bus(struct spi_device *spi);
+extern int spi_unlock_bus(struct spi_device *spi);
 
 /**
  * spi_write - SPI synchronous write
-- 
1.7.0.4


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
