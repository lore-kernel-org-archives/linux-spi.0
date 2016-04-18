From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC 1/2] spi: spidev: Use 'new_id' sysfs file for enabling spidev
Date: Mon, 18 Apr 2016 16:48:27 +0530
Message-ID: <1460978308-8062-2-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, <stefan-XLVq0VzYD2Y@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	Stefan Agner <stefan.agner-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460978308-8062-1-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use sysfs new_id file to enable spidev at runtime. new_id file accepts bus
number and chip select in 'B.C' format.

With reference to the last ML discussion here[1] regarding the solution for
spidev with device trees. This patch adds support to load spidevB.C via sysfs
new_id file as suggested by Greg.

[1] http://thread.gmane.org/gmane.linux.kernel.spi.devel/20331/focus=20369

Suggested-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Stefan Agner <stefan.agner-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---
 Documentation/ABI/testing/sysfs-bus-spi-spidev |  8 +++
 drivers/spi/spidev.c                           | 75 +++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-spidev

diff --git a/Documentation/ABI/testing/sysfs-bus-spi-spidev b/Documentation/ABI/testing/sysfs-bus-spi-spidev
new file mode 100644
index 0000000..3f6e092
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-spi-spidev
@@ -0,0 +1,8 @@
+What:		/sys/bus/spi/drivers/spidev/new_id
+Date:		March 2016
+Description:
+		This allows to load spidev at runtime. new_id file accepts bus
+		number and chip select in 'B.C' format.
+		e.g.
+		To load spidev1.1 at runtime:
+		$ echo 1.1 > /sys/bus/spi/drivers/spidev/new_id
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f3..99e9842 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -667,6 +667,57 @@ static int spidev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/**
+ * new_id_store - add a new spidevB.C instance
+ * @driver: target device driver
+ * @buf: buffer for scanning bus number and chip select
+ * @count: input size
+ *
+ * Adds a new dynamic spidev instance based on the requested bus number
+ * and chip select.
+ */
+static ssize_t new_id_store(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	int ret;
+	u32 bus, cs;
+	struct spi_device *spi;
+	struct spi_master *master;
+
+	ret = sscanf(buf, "%u.%u", &bus, &cs);
+
+	if (ret < 2)
+		return -EINVAL;
+
+	master = spi_busnum_to_master(bus);
+	if (!master)
+		return -ENODEV;
+
+	if (cs >= master->num_chipselect)
+		return -ENODEV;
+
+	spi = spi_alloc_device(master);
+	if (!spi) {
+		dev_err(&master->dev, "Couldn't allocate spidev device\n");
+		return -ENOMEM;;
+	}
+
+	spi->chip_select = cs;
+	master->bus_num = bus;
+
+	strlcpy(spi->modalias, "spidev", sizeof(spi->modalias));
+
+	ret = spi_add_device(spi);
+	if (ret) {
+		dev_err(&master->dev, "Couldn't add spidev device\n");
+		spi_dev_put(spi);
+		return ret;
+	}
+
+	return count;
+}
+static DRIVER_ATTR_WO(new_id);
+
 static const struct file_operations spidev_fops = {
 	.owner =	THIS_MODULE,
 	/* REVISIT switch to aio primitives, so that userspace
@@ -817,21 +868,33 @@ static int __init spidev_init(void)
 
 	spidev_class = class_create(THIS_MODULE, "spidev");
 	if (IS_ERR(spidev_class)) {
-		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
-		return PTR_ERR(spidev_class);
+		status = PTR_ERR(spidev_class);
+		goto err_unregister_chrdev;
 	}
 
 	status = spi_register_driver(&spidev_spi_driver);
-	if (status < 0) {
-		class_destroy(spidev_class);
-		unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
-	}
+	if (status < 0)
+		goto err_destroy_class;
+
+	status = driver_create_file(&spidev_spi_driver.driver, &driver_attr_new_id);
+	if (status < 0)
+		goto err_unregister_driver;
+
+	return status;
+
+err_unregister_driver:
+	spi_unregister_driver(&spidev_spi_driver);
+err_destroy_class:
+	class_destroy(spidev_class);
+err_unregister_chrdev:
+	unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
 	return status;
 }
 module_init(spidev_init);
 
 static void __exit spidev_exit(void)
 {
+	driver_remove_file(&spidev_spi_driver.driver, &driver_attr_new_id);
 	spi_unregister_driver(&spidev_spi_driver);
 	class_destroy(spidev_class);
 	unregister_chrdev(SPIDEV_MAJOR, spidev_spi_driver.driver.name);
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
