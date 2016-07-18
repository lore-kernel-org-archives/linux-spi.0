From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v3 1/3] spi: spidev: create spidev device for all spi slaves.
Date: Tue, 19 Jul 2016 00:35:40 +0200
Message-ID: <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1468880530.git.hramrach@gmail.com>
In-Reply-To: <cover.1468880530.git.hramrach@gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch makes spidev into a bus addon rather than a separate driver.
spidev character device is created for each spi slave. When a spi slave
driver is bound the spidev IOCTLs return -EBUSY.

This is similar to i2c bus which alows access to any address not claimed
by a kernel driver and should provide interface backwards compatible
with existing spidev tools.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 Documentation/spi/spidev |  40 ++---
 drivers/spi/Kconfig      |   2 +-
 drivers/spi/spi.c        |  19 ++-
 drivers/spi/spidev.c     | 370 ++++++++++++++++++++---------------------------
 include/linux/spi/spi.h  |  14 ++
 5 files changed, 197 insertions(+), 248 deletions(-)

diff --git a/Documentation/spi/spidev b/Documentation/spi/spidev
index 3d14035..dd8eac2 100644
--- a/Documentation/spi/spidev
+++ b/Documentation/spi/spidev
@@ -21,23 +21,14 @@ they need to access kernel interfaces (such as IRQ handlers or other layers
 of the driver stack) that are not accessible to userspace.
 
 
-DEVICE CREATION, DRIVER BINDING
-===============================
-The simplest way to arrange to use this driver is to just list it in the
-spi_board_info for a device as the driver it should use:  the "modalias"
-entry is "spidev", matching the name of the driver exposing this API.
-Set up the other device characteristics (bits per word, SPI clocking,
-chipselect polarity, etc) as usual, so you won't always need to override
-them later.
-
-(Sysfs also supports userspace driven binding/unbinding of drivers to
-devices.  That mechanism might be supported here in the future.)
-
-When you do that, the sysfs node for the SPI device will include a child
-device node with a "dev" attribute that will be understood by udev or mdev.
-(Larger systems will have "udev".  Smaller ones may configure "mdev" into
-busybox; it's less featureful, but often enough.)  For a SPI device with
-chipselect C on bus B, you should see:
+DEVICE CREATION
+===============
+
+When spidev is included in the kernel, the sysfs node for the SPI device will
+include a child device node with a "dev" attribute that will be understood by
+udev or mdev.  (Larger systems will have "udev".  Smaller ones may configure
+"mdev" into busybox; it's less featureful, but often enough.)  For a SPI device
+with chipselect C on bus B, you should see:
 
     /dev/spidevB.C ... character special device, major number 153 with
 	a dynamically chosen minor device number.  This is the node
@@ -54,18 +45,9 @@ Do not try to manage the /dev character device special file nodes by hand.
 That's error prone, and you'd need to pay careful attention to system
 security issues; udev/mdev should already be configured securely.
 
-If you unbind the "spidev" driver from that device, those two "spidev" nodes
-(in sysfs and in /dev) should automatically be removed (respectively by the
-kernel and by udev/mdev).  You can unbind by removing the "spidev" driver
-module, which will affect all devices using this driver.  You can also unbind
-by having kernel code remove the SPI device, probably by removing the driver
-for its SPI controller (so its spi_master vanishes).
-
-Since this is a standard Linux device driver -- even though it just happens
-to expose a low level API to userspace -- it can be associated with any number
-of devices at a time.  Just provide one spi_board_info record for each such
-SPI device, and you'll get a /dev device node for each device.
-
+When a device driver is loaded for the SPI device operations on the spidev
+character device return EBUSY. You can unbind a driver from the device using
+the driver unbind file in sysfs.
 
 BASIC CHARACTER DEVICE API
 ==========================
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f2bbb16..3806e3c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -699,7 +699,7 @@ config SPI_ZYNQMP_GQSPI
 comment "SPI Protocol Masters"
 
 config SPI_SPIDEV
-	tristate "User mode SPI device driver support"
+	bool "User mode SPI device driver support"
 	help
 	  This supports user mode SPI protocol drivers.
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 77e6e45..f3ea768 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -41,6 +41,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
 
+#include "spidev.h"
+
 static void spidev_release(struct device *dev)
 {
 	struct spi_device	*spi = to_spi_device(dev);
@@ -544,11 +546,15 @@ int spi_add_device(struct spi_device *spi)
 
 	/* Device may be bound to an active driver when this returns */
 	status = device_add(&spi->dev);
-	if (status < 0)
+	if (status < 0) {
 		dev_err(dev, "can't add %s, status %d\n",
 				dev_name(&spi->dev), status);
-	else
-		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
+		goto done;
+	}
+	dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
+
+	if (IS_ENABLED(CONFIG_SPI_SPIDEV))
+		spi_attach_spidev(spi);
 
 done:
 	mutex_unlock(&spi_add_lock);
@@ -622,6 +628,10 @@ void spi_unregister_device(struct spi_device *spi)
 
 	if (spi->dev.of_node)
 		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
+
+	if (IS_ENABLED(CONFIG_SPI_SPIDEV))
+		spi_detach_spidev(spi);
+
 	device_unregister(&spi->dev);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_device);
@@ -3128,6 +3138,9 @@ static int __init spi_init(void)
 	if (IS_ENABLED(CONFIG_OF_DYNAMIC))
 		WARN_ON(of_reconfig_notifier_register(&spi_of_notifier));
 
+	if (IS_ENABLED(CONFIG_SPI_SPIDEV))
+		WARN_ON(spidev_init());
+
 	return 0;
 
 err2:
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f3..57b47d0 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -27,14 +27,14 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
 
 #include <linux/uaccess.h>
 
+#include "spidev.h"
+
 
 /*
  * This supports access to SPI devices using normal userspace I/O calls.
@@ -72,23 +72,6 @@ static DECLARE_BITMAP(minors, N_SPI_MINORS);
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)
 
-struct spidev_data {
-	dev_t			devt;
-	spinlock_t		spi_lock;
-	struct spi_device	*spi;
-	struct list_head	device_entry;
-
-	/* TX/RX buffers are NULL unless this device is open (users > 0) */
-	struct mutex		buf_lock;
-	unsigned		users;
-	u8			*tx_buffer;
-	u8			*rx_buffer;
-	u32			speed_hz;
-};
-
-static LIST_HEAD(device_list);
-static DEFINE_MUTEX(device_list_lock);
-
 static unsigned bufsiz = 4096;
 module_param(bufsiz, uint, S_IRUGO);
 MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");
@@ -96,20 +79,11 @@ MODULE_PARM_DESC(bufsiz, "data bytes in biggest supported SPI message");
 /*-------------------------------------------------------------------------*/
 
 static ssize_t
-spidev_sync(struct spidev_data *spidev, struct spi_message *message)
+spidev_sync(struct spi_device *spi, struct spi_message *message)
 {
-	DECLARE_COMPLETION_ONSTACK(done);
 	int status;
-	struct spi_device *spi;
-
-	spin_lock_irq(&spidev->spi_lock);
-	spi = spidev->spi;
-	spin_unlock_irq(&spidev->spi_lock);
 
-	if (spi == NULL)
-		status = -ESHUTDOWN;
-	else
-		status = spi_sync(spi, message);
+	status = spi_sync(spi, message);
 
 	if (status == 0)
 		status = message->actual_length;
@@ -118,33 +92,33 @@ spidev_sync(struct spidev_data *spidev, struct spi_message *message)
 }
 
 static inline ssize_t
-spidev_sync_write(struct spidev_data *spidev, size_t len)
+spidev_sync_write(struct spi_device *spi, size_t len)
 {
 	struct spi_transfer	t = {
-			.tx_buf		= spidev->tx_buffer,
+			.tx_buf		= spi->tx_buffer,
 			.len		= len,
-			.speed_hz	= spidev->speed_hz,
+			.speed_hz	= spi->spidev_speed_hz,
 		};
 	struct spi_message	m;
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spidev_sync(spidev, &m);
+	return spidev_sync(spi, &m);
 }
 
 static inline ssize_t
-spidev_sync_read(struct spidev_data *spidev, size_t len)
+spidev_sync_read(struct spi_device *spi, size_t len)
 {
 	struct spi_transfer	t = {
-			.rx_buf		= spidev->rx_buffer,
+			.rx_buf		= spi->rx_buffer,
 			.len		= len,
-			.speed_hz	= spidev->speed_hz,
+			.speed_hz	= spi->spidev_speed_hz,
 		};
 	struct spi_message	m;
 
 	spi_message_init(&m);
 	spi_message_add_tail(&t, &m);
-	return spidev_sync(spidev, &m);
+	return spidev_sync(spi, &m);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -153,27 +127,27 @@ spidev_sync_read(struct spidev_data *spidev, size_t len)
 static ssize_t
 spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 {
-	struct spidev_data	*spidev;
+	struct spi_device	*spi;
 	ssize_t			status = 0;
 
 	/* chipselect only toggles at start or end of operation */
 	if (count > bufsiz)
 		return -EMSGSIZE;
 
-	spidev = filp->private_data;
+	spi = filp->private_data;
 
-	mutex_lock(&spidev->buf_lock);
-	status = spidev_sync_read(spidev, count);
+	mutex_lock(&spi->buf_lock);
+	status = spidev_sync_read(spi, count);
 	if (status > 0) {
 		unsigned long	missing;
 
-		missing = copy_to_user(buf, spidev->rx_buffer, status);
+		missing = copy_to_user(buf, spi->rx_buffer, status);
 		if (missing == status)
 			status = -EFAULT;
 		else
 			status = status - missing;
 	}
-	mutex_unlock(&spidev->buf_lock);
+	mutex_unlock(&spi->buf_lock);
 
 	return status;
 }
@@ -183,7 +157,7 @@ static ssize_t
 spidev_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
-	struct spidev_data	*spidev;
+	struct spi_device	*spi;
 	ssize_t			status = 0;
 	unsigned long		missing;
 
@@ -191,20 +165,20 @@ spidev_write(struct file *filp, const char __user *buf,
 	if (count > bufsiz)
 		return -EMSGSIZE;
 
-	spidev = filp->private_data;
+	spi = filp->private_data;
 
-	mutex_lock(&spidev->buf_lock);
-	missing = copy_from_user(spidev->tx_buffer, buf, count);
+	mutex_lock(&spi->buf_lock);
+	missing = copy_from_user(spi->tx_buffer, buf, count);
 	if (missing == 0)
-		status = spidev_sync_write(spidev, count);
+		status = spidev_sync_write(spi, count);
 	else
 		status = -EFAULT;
-	mutex_unlock(&spidev->buf_lock);
+	mutex_unlock(&spi->buf_lock);
 
 	return status;
 }
 
-static int spidev_message(struct spidev_data *spidev,
+static int spidev_message(struct spi_device *spi,
 		struct spi_ioc_transfer *u_xfers, unsigned n_xfers)
 {
 	struct spi_message	msg;
@@ -224,8 +198,8 @@ static int spidev_message(struct spidev_data *spidev,
 	 * We walk the array of user-provided transfers, using each one
 	 * to initialize a kernel version of the same transfer.
 	 */
-	tx_buf = spidev->tx_buffer;
-	rx_buf = spidev->rx_buffer;
+	tx_buf = spi->tx_buffer;
+	rx_buf = spi->rx_buffer;
 	total = 0;
 	tx_total = 0;
 	rx_total = 0;
@@ -281,27 +255,27 @@ static int spidev_message(struct spidev_data *spidev,
 		k_tmp->delay_usecs = u_tmp->delay_usecs;
 		k_tmp->speed_hz = u_tmp->speed_hz;
 		if (!k_tmp->speed_hz)
-			k_tmp->speed_hz = spidev->speed_hz;
+			k_tmp->speed_hz = spi->spidev_speed_hz;
 #ifdef VERBOSE
-		dev_dbg(&spidev->spi->dev,
+		dev_dbg(&spi->dev,
 			"  xfer len %u %s%s%s%dbits %u usec %uHz\n",
 			u_tmp->len,
 			u_tmp->rx_buf ? "rx " : "",
 			u_tmp->tx_buf ? "tx " : "",
 			u_tmp->cs_change ? "cs " : "",
-			u_tmp->bits_per_word ? : spidev->spi->bits_per_word,
+			u_tmp->bits_per_word ? : spi->bits_per_word,
 			u_tmp->delay_usecs,
-			u_tmp->speed_hz ? : spidev->spi->max_speed_hz);
+			u_tmp->speed_hz ? : spi->max_speed_hz);
 #endif
 		spi_message_add_tail(k_tmp, &msg);
 	}
 
-	status = spidev_sync(spidev, &msg);
+	status = spidev_sync(spi, &msg);
 	if (status < 0)
 		goto done;
 
 	/* copy any rx data out of bounce buffer */
-	rx_buf = spidev->rx_buffer;
+	rx_buf = spi->rx_buffer;
 	for (n = n_xfers, u_tmp = u_xfers; n; n--, u_tmp++) {
 		if (u_tmp->rx_buf) {
 			if (__copy_to_user((u8 __user *)
@@ -356,7 +330,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int			err = 0;
 	int			retval = 0;
-	struct spidev_data	*spidev;
 	struct spi_device	*spi;
 	u32			tmp;
 	unsigned		n_ioc;
@@ -382,21 +355,22 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	/* guard against device removal before, or while,
 	 * we issue this ioctl.
 	 */
-	spidev = filp->private_data;
-	spin_lock_irq(&spidev->spi_lock);
-	spi = spi_dev_get(spidev->spi);
-	spin_unlock_irq(&spidev->spi_lock);
+	spi = filp->private_data;
+	spi = spi_dev_get(spi);
 
 	if (spi == NULL)
 		return -ESHUTDOWN;
 
+	if (spi->dev.driver)
+		return -EBUSY;
+
 	/* use the buffer lock here for triple duty:
 	 *  - prevent I/O (from us) so calling spi_setup() is safe;
 	 *  - prevent concurrent SPI_IOC_WR_* from morphing
 	 *    data fields while SPI_IOC_RD_* reads them;
 	 *  - SPI_IOC_MESSAGE needs the buffer locked "normally".
 	 */
-	mutex_lock(&spidev->buf_lock);
+	mutex_lock(&spi->buf_lock);
 
 	switch (cmd) {
 	/* read requests */
@@ -416,7 +390,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		retval = __put_user(spi->bits_per_word, (__u8 __user *)arg);
 		break;
 	case SPI_IOC_RD_MAX_SPEED_HZ:
-		retval = __put_user(spidev->speed_hz, (__u32 __user *)arg);
+		retval = __put_user(spi->spidev_speed_hz, (__u32 __user *)arg);
 		break;
 
 	/* write requests */
@@ -474,14 +448,14 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case SPI_IOC_WR_MAX_SPEED_HZ:
-		retval = __get_user(tmp, (__u32 __user *)arg);
+	retval = __get_user(tmp, (__u32 __user *)arg);
 		if (retval == 0) {
 			u32	save = spi->max_speed_hz;
 
 			spi->max_speed_hz = tmp;
 			retval = spi_setup(spi);
 			if (retval >= 0)
-				spidev->speed_hz = tmp;
+				spi->spidev_speed_hz = tmp;
 			else
 				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
 			spi->max_speed_hz = save;
@@ -501,12 +475,12 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			break;	/* n_ioc is also 0 */
 
 		/* translate to spi_message, execute */
-		retval = spidev_message(spidev, ioc, n_ioc);
+		retval = spidev_message(spi, ioc, n_ioc);
 		kfree(ioc);
 		break;
 	}
 
-	mutex_unlock(&spidev->buf_lock);
+	mutex_unlock(&spi->buf_lock);
 	spi_dev_put(spi);
 	return retval;
 }
@@ -518,7 +492,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 {
 	struct spi_ioc_transfer __user	*u_ioc;
 	int				retval = 0;
-	struct spidev_data		*spidev;
 	struct spi_device		*spi;
 	unsigned			n_ioc, n;
 	struct spi_ioc_transfer		*ioc;
@@ -530,16 +503,17 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	/* guard against device removal before, or while,
 	 * we issue this ioctl.
 	 */
-	spidev = filp->private_data;
-	spin_lock_irq(&spidev->spi_lock);
-	spi = spi_dev_get(spidev->spi);
-	spin_unlock_irq(&spidev->spi_lock);
+	spi = filp->private_data;
+	spi = spi_dev_get(spi);
 
 	if (spi == NULL)
 		return -ESHUTDOWN;
 
+	if (spi->dev.driver)
+		return -EBUSY;
+
 	/* SPI_IOC_MESSAGE needs the buffer locked "normally" */
-	mutex_lock(&spidev->buf_lock);
+	mutex_lock(&spi->buf_lock);
 
 	/* Check message and copy into scratch area */
 	ioc = spidev_get_ioc_message(cmd, u_ioc, &n_ioc);
@@ -557,11 +531,11 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	}
 
 	/* translate to spi_message, execute */
-	retval = spidev_message(spidev, ioc, n_ioc);
+	retval = spidev_message(spi, ioc, n_ioc);
 	kfree(ioc);
 
 done:
-	mutex_unlock(&spidev->buf_lock);
+	mutex_unlock(&spi->buf_lock);
 	spi_dev_put(spi);
 	return retval;
 }
@@ -580,89 +554,108 @@ spidev_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 #define spidev_compat_ioctl NULL
 #endif /* CONFIG_COMPAT */
 
+static int spidev_devt_match(struct device *dev, void *data)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	dev_t devt = (dev_t) data;
+	int res = 0;
+
+	spin_lock_irq(&spi->spidev_lock);
+	if (spi->spidev_devt == devt)
+		res = 1;
+	spin_unlock_irq(&spi->spidev_lock);
+
+	return res;
+}
+
 static int spidev_open(struct inode *inode, struct file *filp)
 {
-	struct spidev_data	*spidev;
+	struct spi_device	*spi;
+	struct device		*dev;
 	int			status = -ENXIO;
 
-	mutex_lock(&device_list_lock);
+	dev = bus_find_device(&spi_bus_type, NULL, (void *) inode->i_rdev,
+			      spidev_devt_match);
 
-	list_for_each_entry(spidev, &device_list, device_entry) {
-		if (spidev->devt == inode->i_rdev) {
-			status = 0;
-			break;
-		}
-	}
-
-	if (status) {
+	if (!dev) {
 		pr_debug("spidev: nothing for minor %d\n", iminor(inode));
-		goto err_find_dev;
+		return status;
 	}
 
-	if (!spidev->tx_buffer) {
-		spidev->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
-		if (!spidev->tx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
+	spi = to_spi_device(dev);
+
+	mutex_lock(&spi->buf_lock);
+	spin_lock_irq(&spi->spidev_lock);
+	spi->spidev_users++;
+	spin_unlock_irq(&spi->spidev_lock);
+
+	if (!spi->tx_buffer) {
+		spi->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
+		if (!spi->tx_buffer) {
+			dev_dbg(&spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_find_dev;
 		}
 	}
 
-	if (!spidev->rx_buffer) {
-		spidev->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
-		if (!spidev->rx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
+	if (!spi->rx_buffer) {
+		spi->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
+		if (!spi->rx_buffer) {
+			dev_dbg(&spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_alloc_rx_buf;
 		}
 	}
 
-	spidev->users++;
-	filp->private_data = spidev;
+	mutex_unlock(&spi->buf_lock);
+
+	filp->private_data = spi;
 	nonseekable_open(inode, filp);
 
-	mutex_unlock(&device_list_lock);
 	return 0;
 
 err_alloc_rx_buf:
-	kfree(spidev->tx_buffer);
-	spidev->tx_buffer = NULL;
+	kfree(spi->tx_buffer);
+	spi->tx_buffer = NULL;
 err_find_dev:
-	mutex_unlock(&device_list_lock);
+	mutex_unlock(&spi->buf_lock);
+	spin_lock_irq(&spi->spidev_lock);
+	spi->spidev_users--;
+	spin_unlock_irq(&spi->spidev_lock);
 	return status;
 }
 
 static int spidev_release(struct inode *inode, struct file *filp)
 {
-	struct spidev_data	*spidev;
+	struct spi_device	*spi;
+	int do_free = 0;
 
-	mutex_lock(&device_list_lock);
-	spidev = filp->private_data;
+	spi = filp->private_data;
 	filp->private_data = NULL;
 
+	mutex_lock(&spi->buf_lock);
+	spin_lock_irq(&spi->spidev_lock);
+	spi->spidev_users--;
+
 	/* last close? */
-	spidev->users--;
-	if (!spidev->users) {
-		int		dofree;
+	if (!spi->spidev_users)
+		do_free = 1;
 
-		kfree(spidev->tx_buffer);
-		spidev->tx_buffer = NULL;
+	spin_unlock_irq(&spi->spidev_lock);
 
-		kfree(spidev->rx_buffer);
-		spidev->rx_buffer = NULL;
+	if (do_free) {
 
-		spin_lock_irq(&spidev->spi_lock);
-		if (spidev->spi)
-			spidev->speed_hz = spidev->spi->max_speed_hz;
+		kfree(spi->tx_buffer);
+		spi->tx_buffer = NULL;
 
-		/* ... after we unbound from the underlying device? */
-		dofree = (spidev->spi == NULL);
-		spin_unlock_irq(&spidev->spi_lock);
+		kfree(spi->rx_buffer);
+		spi->rx_buffer = NULL;
 
-		if (dofree)
-			kfree(spidev);
+		spi->spidev_speed_hz = spi->max_speed_hz;
 	}
-	mutex_unlock(&device_list_lock);
+	mutex_unlock(&spi->buf_lock);
+
+	spi_dev_put(spi);
 
 	return 0;
 }
@@ -691,152 +684,99 @@ static const struct file_operations spidev_fops = {
 
 static struct class *spidev_class;
 
-#ifdef CONFIG_OF
-static const struct of_device_id spidev_dt_ids[] = {
-	{ .compatible = "rohm,dh2228fv" },
-	{ .compatible = "lineartechnology,ltc2488" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-#endif
-
 /*-------------------------------------------------------------------------*/
 
-static int spidev_probe(struct spi_device *spi)
+int spi_attach_spidev(struct spi_device *spi)
 {
-	struct spidev_data	*spidev;
 	int			status;
 	unsigned long		minor;
 
-	/*
-	 * spidev should never be referenced in DT without a specific
-	 * compatible string, it is a Linux implementation thing
-	 * rather than a description of the hardware.
-	 */
-	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
-		dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
-		WARN_ON(spi->dev.of_node &&
-			!of_match_device(spidev_dt_ids, &spi->dev));
-	}
-
-	/* Allocate driver data */
-	spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
-	if (!spidev)
-		return -ENOMEM;
-
 	/* Initialize the driver data */
-	spidev->spi = spi;
-	spin_lock_init(&spidev->spi_lock);
-	mutex_init(&spidev->buf_lock);
-
-	INIT_LIST_HEAD(&spidev->device_entry);
+	spin_lock_init(&spi->spidev_lock);
+	mutex_init(&spi->buf_lock);
 
 	/* If we can allocate a minor number, hook up this device.
 	 * Reusing minors is fine so long as udev or mdev is working.
 	 */
-	mutex_lock(&device_list_lock);
 	minor = find_first_zero_bit(minors, N_SPI_MINORS);
 	if (minor < N_SPI_MINORS) {
-		struct device *dev;
 
-		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
-		dev = device_create(spidev_class, &spi->dev, spidev->devt,
-				    spidev, "spidev%d.%d",
-				    spi->master->bus_num, spi->chip_select);
-		status = PTR_ERR_OR_ZERO(dev);
+		spi->spidev_devt = MKDEV(SPIDEV_MAJOR, minor);
+
+		spi->spidev = device_create(spidev_class, &spi->dev,
+					    spi->spidev_devt,
+					    spi, "spidev%d.%d",
+					    spi->master->bus_num,
+					    spi->chip_select);
+		status = PTR_ERR_OR_ZERO(spi->spidev);
+		if (status != 0) {
+			dev_err(&spi->dev, "Error creating spidev device!\n");
+			spi->spidev_devt = 0;
+			spi->spidev = NULL;
+		}
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
 		status = -ENODEV;
 	}
 	if (status == 0) {
 		set_bit(minor, minors);
-		list_add(&spidev->device_entry, &device_list);
 	}
-	mutex_unlock(&device_list_lock);
-
-	spidev->speed_hz = spi->max_speed_hz;
-
-	if (status == 0)
-		spi_set_drvdata(spi, spidev);
-	else
-		kfree(spidev);
+	spi->spidev_speed_hz = spi->max_speed_hz;
 
 	return status;
 }
 
-static int spidev_remove(struct spi_device *spi)
+int spi_detach_spidev(struct spi_device *spi)
 {
-	struct spidev_data	*spidev = spi_get_drvdata(spi);
-
-	/* make sure ops on existing fds can abort cleanly */
-	spin_lock_irq(&spidev->spi_lock);
-	spidev->spi = NULL;
-	spin_unlock_irq(&spidev->spi_lock);
-
-	/* prevent new opens */
-	mutex_lock(&device_list_lock);
-	list_del(&spidev->device_entry);
-	device_destroy(spidev_class, spidev->devt);
-	clear_bit(MINOR(spidev->devt), minors);
-	if (spidev->users == 0)
-		kfree(spidev);
-	mutex_unlock(&device_list_lock);
+	dev_t	devt;
+	struct device *spidev;
+
+	/*
+	 * Make sure ops on existing fds can abort cleanly
+	 * and prevent new ones.
+	 */
+	spin_lock_irq(&spi->spidev_lock);
+	devt = spi->spidev_devt;
+	spidev = spi->spidev;
+	spi->spidev_devt = 0;
+	spi->spidev = NULL;
+	spin_unlock_irq(&spi->spidev_lock);
+
+	device_destroy(spidev_class, devt);
+	clear_bit(MINOR(devt), minors);
 
 	return 0;
 }
 
-static struct spi_driver spidev_spi_driver = {
-	.driver = {
-		.name =		"spidev",
-		.of_match_table = of_match_ptr(spidev_dt_ids),
-	},
-	.probe =	spidev_probe,
-	.remove =	spidev_remove,
-
-	/* NOTE:  suspend/resume methods are not necessary here.
-	 * We don't do anything except pass the requests to/from
-	 * the underlying controller.  The refrigerator handles
-	 * most issues; the controller driver handles the rest.
-	 */
-};
-
 /*-------------------------------------------------------------------------*/
 
-static int __init spidev_init(void)
+int __init spidev_init(void)
 {
 	int status;
 
 	/* Claim our 256 reserved device numbers.  Then register a class
-	 * that will key udev/mdev to add/remove /dev nodes.  Last, register
-	 * the driver which manages those device numbers.
+	 * that will key udev/mdev to add/remove /dev nodes.
 	 */
 	BUILD_BUG_ON(N_SPI_MINORS > 256);
-	status = register_chrdev(SPIDEV_MAJOR, "spi", &spidev_fops);
+	status = register_chrdev(SPIDEV_MAJOR, "spidev", &spidev_fops);
 	if (status < 0)
 		return status;
 
 	spidev_class = class_create(THIS_MODULE, "spidev");
 	if (IS_ERR(spidev_class)) {
-		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
+		unregister_chrdev(SPIDEV_MAJOR, "spidev");
 		return PTR_ERR(spidev_class);
 	}
 
-	status = spi_register_driver(&spidev_spi_driver);
-	if (status < 0) {
-		class_destroy(spidev_class);
-		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
-	}
 	return status;
 }
-module_init(spidev_init);
 
 static void __exit spidev_exit(void)
 {
-	spi_unregister_driver(&spidev_spi_driver);
 	class_destroy(spidev_class);
-	unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
+	unregister_chrdev(SPIDEV_MAJOR, "spidev");
 }
-module_exit(spidev_exit);
+EXPORT_SYMBOL_GPL(spidev_exit);
 
 MODULE_AUTHOR("Andrea Paterniani, <a.paterniani@swapp-eng.it>");
 MODULE_DESCRIPTION("User mode SPI device interface");
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 1f03483..7154559 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -178,6 +178,20 @@ struct spi_device {
 	 *  - chipselect delays
 	 *  - ...
 	 */
+
+	/* spidev stuff */
+#if config_enabled(CONFIG_SPI_SPIDEV)
+	dev_t                   spidev_devt;
+	struct device *		spidev;
+	spinlock_t              spidev_lock;
+
+	/* TX/RX buffers are NULL unless this device is open (users > 0) */
+	struct mutex            buf_lock;
+	unsigned                spidev_users;
+	u8                      *tx_buffer;
+	u8                      *rx_buffer;
+	u32                     spidev_speed_hz;
+#endif /*CONFIG_SPI_SPIDEV*/
 };
 
 static inline struct spi_device *to_spi_device(struct device *dev)
-- 
2.8.1
