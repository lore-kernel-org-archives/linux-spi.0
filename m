From: Ben Dooks <ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Subject: [PATCH] Infineion TLE62X0 device driver
Date: Tue, 5 Jun 2007 19:32:44 +0100
Message-ID: <20070605183244.GE13353@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add support for the Infineon TLE62x0 series of low-side driver
chips, such as the TLE6220 or TLE6230.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.22-rc4-simtec/include/linux/spi/tle62x0.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22-rc4-simtec/include/linux/spi/tle62x0.h	2007-06-05 19:14:07.000000000 +0100
@@ -0,0 +1,23 @@
+/* include/linux/spi/tle62x0.h
+ *
+ * Copyright 2007 Simtec Electronics
+ *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+struct tle62x0_pdata {
+	unsigned int		init_state;
+	unsigned int		gpio_count;
+};
Index: linux-2.6.22-rc4-simtec/drivers/spi/Kconfig
===================================================================
--- linux-2.6.22-rc4-simtec.orig/drivers/spi/Kconfig	2007-06-05 18:27:11.000000000 +0100
+++ linux-2.6.22-rc4-simtec/drivers/spi/Kconfig	2007-06-05 19:14:07.000000000 +0100
@@ -160,6 +160,13 @@ config SPI_S3C24XX_GPIO
 # Add new SPI master controllers in alphabetical order above this line
 #
 
+config SPI_TLE62X0
+	tristate "Infineon TLE62X0"
+	depends on SPI_MASTER
+	help
+	  SPI driver for Infineion TLE62X0 series line driver chips,
+	  such as the TLE6220, TLE6230 and TLE6240.
+
 #
 # There are lots of SPI device types, with sensors and memory
 # being probably the most widely used ones.
Index: linux-2.6.22-rc4-simtec/drivers/spi/tle62x0.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22-rc4-simtec/drivers/spi/tle62x0.c	2007-06-05 19:14:07.000000000 +0100
@@ -0,0 +1,312 @@
+/* drivers/spi/tle62x0.c
+ *
+ * Copyright (c) 2007 Simtec Electronics
+ *	Ben Dooks, <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Infineon TLE62x0 series driver
+*/
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/tle62x0.h>
+
+#define CMD_READ	(0x00)
+#define CMD_SET		(0xff)
+
+#define DIAG_NORMAL	(0x03)
+#define DIAG_OVERLOAD	(0x02)
+#define DIAG_OPEN	(0x01)
+#define DIAG_SHORTGND	(0x00)
+
+struct tle62x0_state {
+	struct spi_device	*us;
+	struct mutex		lock;
+	unsigned int		nr_gpio;
+	unsigned int		gpio_state;
+
+	unsigned char		tx_buff[4];
+	unsigned char		rx_buff[4];
+};
+
+static int to_gpio_num(struct device_attribute *attr);
+
+static inline int tle62x0_write(struct tle62x0_state *st)
+{
+	unsigned char *buff = st->tx_buff;
+	unsigned int gpio_state = st->gpio_state;
+
+	buff[0] = CMD_SET;
+
+	if (st->nr_gpio == 16) {
+		buff[1] = gpio_state >> 8;
+		buff[2] = gpio_state;
+	} else {
+		buff[1] = gpio_state;
+	}
+
+	dev_dbg(&st->us->dev, "buff %02x,%02x,%02x\n",
+		buff[0], buff[1], buff[2]);
+
+	return spi_write(st->us, buff, (st->nr_gpio == 16) ? 3 : 2);
+}
+
+static inline int tle62x0_read(struct tle62x0_state *st)
+{
+	unsigned char *txbuff = st->tx_buff;
+	struct spi_transfer xfer = {
+		.tx_buf		= txbuff,
+		.rx_buf		= st->rx_buff,
+		.len		= (st->nr_gpio * 2) / 8,
+	};
+	struct spi_message msg;
+
+	txbuff[0] = CMD_READ;
+	txbuff[1] = 0x00;
+	txbuff[2] = 0x00;
+	txbuff[3] = 0x00;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+
+	return spi_sync(st->us, &msg);
+}
+
+static unsigned char *decode_fault(unsigned int fault_code)
+{
+	fault_code &= 3;
+
+	switch (fault_code) {
+	case DIAG_NORMAL:
+		return "N";
+	case DIAG_OVERLOAD:
+		return "V";
+	case DIAG_OPEN:
+		return "O";
+	case DIAG_SHORTGND:
+		return "G";
+	}
+
+	return "?";
+}
+
+static int tle62x0_status_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct tle62x0_state *st = dev_get_drvdata(dev);
+	char *bp = buf;
+	unsigned char *buff = st->rx_buff;
+	unsigned long fault = 0;
+	int ptr;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = tle62x0_read(st);
+
+	dev_dbg(dev, "tle62x0_read() returned %d\n", ret);
+
+	for (ptr = 0; ptr < (st->nr_gpio * 2)/8; ptr += 1) {
+		fault <<= 8;
+		fault  |= ((unsigned long)buff[ptr]);
+
+		dev_dbg(dev, "byte %d is %02x\n", ptr, buff[ptr]);
+	}
+
+	for (ptr = 0; ptr < st->nr_gpio; ptr++) {
+		bp += sprintf(bp, "%s ", decode_fault(fault >> (ptr * 2)));
+	}
+
+	*bp++ = '\n';
+
+	mutex_unlock(&st->lock);
+	return bp - buf;
+}
+
+static DEVICE_ATTR(status_show, 0444, tle62x0_status_show, NULL);
+
+static int tle62x0_gpio_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct tle62x0_state *st = dev_get_drvdata(dev);
+	int gpio_num = to_gpio_num(attr);
+	int value;
+
+	mutex_lock(&st->lock);
+	value = (st->gpio_state >> gpio_num) & 1;
+	mutex_unlock(&st->lock);
+
+	return snprintf(buf, PAGE_SIZE, "%d", value);
+}
+
+static int tle62x0_gpio_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct tle62x0_state *st = dev_get_drvdata(dev);
+	int gpio_num = to_gpio_num(attr);
+	unsigned long val;
+	char *endp;
+
+	val = simple_strtoul(buf, &endp, 0);
+	if (buf == endp)
+		return -EINVAL;
+
+	dev_dbg(dev, "setting gpio %d to %ld\n", gpio_num, val);
+
+	mutex_lock(&st->lock);
+
+	if (val)
+		st->gpio_state |= 1 << gpio_num;
+	else
+		st->gpio_state &= ~(1 << gpio_num);
+
+	tle62x0_write(st);
+	mutex_unlock(&st->lock);
+
+	return len;
+}
+
+static DEVICE_ATTR(gpio1, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio2, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio3, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio4, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio5, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio6, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio7, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio8, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio9, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio10, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio11, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio12, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio13, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio14, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio15, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+static DEVICE_ATTR(gpio16, 0644, tle62x0_gpio_show, tle62x0_gpio_store);
+
+static struct device_attribute *gpio_attrs[] = {
+	[0]		= &dev_attr_gpio1,
+	[1]		= &dev_attr_gpio2,
+	[2]		= &dev_attr_gpio3,
+	[3]		= &dev_attr_gpio4,
+	[4]		= &dev_attr_gpio5,
+	[5]		= &dev_attr_gpio6,
+	[6]		= &dev_attr_gpio7,
+	[7]		= &dev_attr_gpio8,
+	[8]		= &dev_attr_gpio9,
+	[9]		= &dev_attr_gpio10,
+	[10]		= &dev_attr_gpio11,
+	[11]		= &dev_attr_gpio12,
+	[12]		= &dev_attr_gpio13,
+	[13]		= &dev_attr_gpio14,
+	[14]		= &dev_attr_gpio15,
+	[15]		= &dev_attr_gpio16
+};
+
+static int to_gpio_num(struct device_attribute *attr)
+{
+	int ptr;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(gpio_attrs); ptr++) {
+		if (gpio_attrs[ptr] == attr)
+			return ptr;
+	}
+
+	return -1;
+}
+
+static int __devinit tle62x0_probe(struct spi_device *spi)
+{
+	struct tle62x0_state *st;
+	struct tle62x0_pdata *pdata;
+	int ptr;
+	int ret;
+
+	pdata = spi->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&spi->dev, "no device data specified\n");
+		return -EINVAL;
+	}
+
+	st = kzalloc(sizeof(struct tle62x0_state), GFP_KERNEL);
+	if (st == NULL) {
+		dev_err(&spi->dev, "no memory for device state\n");
+		return -ENOMEM;
+	}
+
+	st->us = spi;
+	st->nr_gpio = pdata->gpio_count;
+	st->gpio_state = pdata->init_state;
+
+	mutex_init(&st->lock);
+
+	ret = device_create_file(&spi->dev, &dev_attr_status_show);
+	if (ret) {
+		dev_err(&spi->dev, "cannot create status attribute\n");
+		goto err_status;
+	}
+
+	for (ptr = 0; ptr < pdata->gpio_count; ptr++) {
+		ret = device_create_file(&spi->dev, gpio_attrs[ptr]);
+		if (ret) {
+			dev_err(&spi->dev, "cannot create gpio attribute\n");
+			goto err_gpios;
+		}
+	}
+
+	//tle62x0_write(data);
+	spi_set_drvdata(spi, st);
+	return 0;
+
+ err_gpios:
+	for (; ptr > 0; ptr--)
+		device_remove_file(&spi->dev, gpio_attrs[ptr]);
+
+	device_remove_file(&spi->dev, &dev_attr_status_show);
+
+ err_status:
+	kfree(st);
+	return ret;
+}
+
+static int __devexit tle62x0_remove(struct spi_device *spi)
+{
+	struct tle62x0_state *st = spi_get_drvdata(spi);
+	int ptr;
+
+	for (ptr = 0; ptr < st->nr_gpio; ptr++)
+		device_remove_file(&spi->dev, gpio_attrs[ptr]);
+
+	kfree(st);
+	return 0;
+}
+
+static struct spi_driver tle62x0_driver = {
+	.driver = {
+		.name	= "tle62x0",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tle62x0_probe,
+	.remove		= __devexit_p(tle62x0_remove),
+};
+
+static __init int tle62x0_init(void)
+{
+	return spi_register_driver(&tle62x0_driver);
+}
+
+static __exit void tle62x0_exit(void)
+{
+	spi_unregister_driver(&tle62x0_driver);
+}
+
+module_init(tle62x0_init);
+module_exit(tle62x0_exit);
+
+MODULE_AUTHOR("Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
+MODULE_DESCRIPTION("TLE62x0 SPI driver");
+MODULE_LICENSE("GPL v2");
Index: linux-2.6.22-rc4-simtec/drivers/spi/Makefile
===================================================================
--- linux-2.6.22-rc4-simtec.orig/drivers/spi/Makefile	2007-06-05 19:14:22.000000000 +0100
+++ linux-2.6.22-rc4-simtec/drivers/spi/Makefile	2007-06-05 19:14:46.000000000 +0100
@@ -28,6 +28,7 @@ obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24x
 # SPI protocol drivers (device/link on bus)
 obj-$(CONFIG_SPI_AT25)		+= at25.o
 obj-$(CONFIG_SPI_SPIDEV)	+= spidev.o
+obj-$(CONFIG_SPI_TLE62X0)	+= tle62x0.o
 # 	... add above this line ...
 
 # SPI slave controller drivers (upstream link)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
