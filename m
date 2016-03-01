From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Subject: [PATCH 2/6] spi: add add flow control test driver
Date: Tue,  1 Mar 2016 15:43:16 +0100
Message-ID: <1456843400-20696-2-git-send-email-linux@rempel-privat.de>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456843400-20696-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This testdriver can be used to test flow control
functionality by using some gpio pins to emulate
slave device.

Signed-off-by: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
---
 drivers/spi/Kconfig       |  12 ++
 drivers/spi/Makefile      |   1 +
 drivers/spi/spi_fc_test.c | 273 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)
 create mode 100644 drivers/spi/spi_fc_test.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7706416..fb96295 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -681,6 +681,18 @@ config SPI_DW_MMIO
 #
 comment "SPI Protocol Masters"
 
+config SPI_FC_TEST
+        tristate "Test for SPI flow control functionality"
+        depends on SPI
+        default n
+        help
+          This option enables test module for flow control SPI
+	  extensions. For testing use debugfs interface with count
+	  of packet wich should be used for testing. For example:
+	  echo 100000 > /sys/kernel/debug/spi_fc_test/spi0/test_fc_request
+
+          If unsure, say N.
+
 config SPI_SPIDEV
 	tristate "User mode SPI device driver support"
 	help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8991ffc..282224a 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -37,6 +37,7 @@ spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
 obj-$(CONFIG_SPI_EFM32)			+= spi-efm32.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
+obj-$(CONFIG_SPI_FC_TEST)		+= spi_fc_test.o
 obj-$(CONFIG_SPI_FSL_CPM)		+= spi-fsl-cpm.o
 obj-$(CONFIG_SPI_FSL_DSPI)		+= spi-fsl-dspi.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
diff --git a/drivers/spi/spi_fc_test.c b/drivers/spi/spi_fc_test.c
new file mode 100644
index 0000000..65bff99
--- /dev/null
+++ b/drivers/spi/spi_fc_test.c
@@ -0,0 +1,273 @@
+/*
+ * Copyright (C) Robert Bosch Car Multimedia GmbH
+ * Copyright (C) Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#define DRIVER_NAME "spi_fc_test"
+
+static struct dentry *debugfs_root;
+/*
+ * Some registers must be read back to modify.
+ * To save time we cache them here in memory
+ */
+struct spi_fc_test_priv {
+	struct mutex		lock;	/* protect from simultaneous accesses */
+	u8			port_config;
+	struct spi_device	*spi;
+	struct gpio_desc	*test_cs_in;
+	struct gpio_desc	*test_fc_out;
+	struct dentry		*debugfs;
+	struct completion	fc_complete;
+	atomic_t		active_rq;
+};
+
+static int spi_fc_test_set(struct spi_fc_test_priv *priv)
+{
+	u8 buf;
+
+	buf = 0xaa;
+	return spi_write(priv->spi, &buf, sizeof(buf));
+}
+
+static void spi_fc_test_request_cb(struct spi_device *spi)
+{
+	struct spi_fc_test_priv *priv = spi_get_drvdata(spi);
+
+	complete(&priv->fc_complete);
+}
+
+static ssize_t spi_fc_fops_request_write(struct file *file, const char
+		__user *user_buf, size_t count, loff_t *data)
+{
+	struct spi_fc_test_priv *priv = file_inode(file)->i_private ?:
+			PDE_DATA(file_inode(file));
+	unsigned long timeout = msecs_to_jiffies(10);
+	u32 rounds;
+	int ret;
+
+	if (kstrtouint_from_user(user_buf, count, 0, &rounds))
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+	while (rounds > 0) {
+		atomic_set(&priv->active_rq, 1);
+		reinit_completion(&priv->fc_complete);
+		gpiod_set_value(priv->test_fc_out, true);
+		ret = wait_for_completion_io_timeout(&priv->fc_complete,
+						     timeout);
+		if (!ret) {
+			dev_err(&priv->spi->dev, "Request timeout\n");
+			goto exit;
+		}
+		ret = spi_fc_test_set(priv);
+		if (ret < 0) {
+			dev_err(&priv->spi->dev, "SPI transfer error\n");
+			goto exit;
+		}
+		rounds--;
+	}
+exit:
+	gpiod_set_value(priv->test_fc_out, false);
+	mutex_unlock(&priv->lock);
+	return count;
+}
+
+const struct file_operations spi_fc_fops_request = {
+	.owner      = THIS_MODULE,
+	.write      = spi_fc_fops_request_write,
+};
+
+static ssize_t spi_fc_fops_ready_write(struct file *file, const char
+		__user *user_buf, size_t count, loff_t *data)
+{
+	struct spi_fc_test_priv *priv = file_inode(file)->i_private ?:
+			PDE_DATA(file_inode(file));
+	u32 rounds;
+	int ret;
+
+	if (kstrtouint_from_user(user_buf, count, 0, &rounds))
+		return -EINVAL;
+
+	mutex_lock(&priv->lock);
+	while (rounds > 0) {
+		ret = spi_fc_test_set(priv);
+		if (ret < 0) {
+			mutex_unlock(&priv->lock);
+			return ret;
+		}
+		rounds--;
+	}
+	mutex_unlock(&priv->lock);
+
+	return count;
+}
+
+const struct file_operations spi_fc_fops_ready = {
+	.owner      = THIS_MODULE,
+	.write      = spi_fc_fops_ready_write,
+};
+
+static irqreturn_t spi_fc_test_isr(int irq, void *dev_id)
+{
+	struct spi_fc_test_priv *priv = (struct spi_fc_test_priv *)dev_id;
+	int val;
+
+	if (atomic_read(&priv->active_rq)) {
+		atomic_set(&priv->active_rq, 0);
+		return IRQ_HANDLED;
+	}
+
+	val = gpiod_get_value(priv->test_cs_in);
+	gpiod_set_value(priv->test_fc_out, val);
+
+	return IRQ_HANDLED;
+}
+
+static int spi_fc_test_probe(struct spi_device *spi)
+{
+	struct spi_fc_test_priv *priv;
+	struct dentry *de;
+	int ret, cs_irq;
+
+	spi->bits_per_word = 8;
+
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	priv = devm_kzalloc(&spi->dev, sizeof(struct spi_fc_test_priv),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mutex_init(&priv->lock);
+	init_completion(&priv->fc_complete);
+
+	spi_set_drvdata(spi, priv);
+
+	priv->spi = spi;
+	spi->master->rt = 1;
+	spi->request_cb = spi_fc_test_request_cb;
+
+	ret = spi_fc_probe(spi);
+	if (ret) {
+		dev_err(&spi->dev, "filed to probe FC\n");
+		return ret;
+	}
+
+	priv->test_fc_out = devm_gpiod_get(&spi->dev, "test-fc-out",
+					   GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->test_fc_out)) {
+		ret = PTR_ERR(priv->test_fc_out);
+		dev_err(&spi->dev, "failed to request FC GPIO: %d\n", ret);
+		return ret;
+	}
+
+	priv->test_cs_in = devm_gpiod_get(&spi->dev, "test-cs-in", GPIOD_IN);
+	if (IS_ERR(priv->test_cs_in)) {
+		ret = PTR_ERR(priv->test_cs_in);
+		dev_err(&spi->dev, "failed to request CS GPIO: %d\n", ret);
+		return ret;
+	}
+
+	cs_irq = gpiod_to_irq(priv->test_cs_in);
+	if (cs_irq < 0) {
+		dev_err(&spi->dev, "failed to reques irq for GPIO\n");
+		return -ENODEV;
+	}
+
+	ret = devm_request_irq(&spi->dev, cs_irq, spi_fc_test_isr,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       "test_cs_in", priv);
+	if (ret) {
+		dev_err(&spi->dev, "failed to request IRQ\n");
+		return ret;
+	}
+
+	priv->debugfs = debugfs_create_dir(dev_name(&spi->dev), debugfs_root);
+	de = debugfs_create_file_size("test_fc_ready", S_IRUGO,
+				      priv->debugfs, priv, &spi_fc_fops_ready,
+				      sizeof(u32));
+	if (IS_ERR_OR_NULL(de)) {
+		dev_err(&spi->dev, "failed to create test_fc_ready\n");
+		return -ENODEV;
+	}
+
+	de = debugfs_create_file_size("test_fc_request", S_IRUGO,
+				      priv->debugfs, priv, &spi_fc_fops_request,
+				      sizeof(u32));
+	if (IS_ERR_OR_NULL(de)) {
+		dev_err(&spi->dev, "failed to create test_fc_request\n");
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static int spi_fc_test_remove(struct spi_device *spi)
+{
+	struct spi_fc_test_priv *priv;
+
+	priv = spi_get_drvdata(spi);
+	if (!priv)
+		return -ENODEV;
+
+	mutex_destroy(&priv->lock);
+
+	return 0;
+}
+
+static const struct of_device_id spi_fc_test_gpio_match[] = {
+	{
+		.compatible = "spi-fc-test",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, spi_fc_test_gpio_match);
+
+static struct spi_driver spi_fc_test_driver = {
+	.driver = {
+		.name		= DRIVER_NAME,
+		.of_match_table = of_match_ptr(spi_fc_test_gpio_match),
+	},
+	.probe		= spi_fc_test_probe,
+	.remove		= spi_fc_test_remove,
+};
+
+static int __init spi_fc_test_init(void)
+{
+	debugfs_root = debugfs_create_dir(DRIVER_NAME, NULL);
+	if (IS_ERR_OR_NULL(debugfs_root)) {
+		pr_err("%s: Filed to create debufs entry.\n", DRIVER_NAME);
+		return -ENOMEM;
+	}
+
+	return spi_register_driver(&spi_fc_test_driver);
+}
+subsys_initcall(spi_fc_test_init);
+
+static void __exit spi_fc_test_exit(void)
+{
+	debugfs_remove_recursive(debugfs_root);
+	spi_unregister_driver(&spi_fc_test_driver);
+}
+module_exit(spi_fc_test_exit);
+
+MODULE_AUTHOR("Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>");
+MODULE_LICENSE("GPL");
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
