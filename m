From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/4] Move old eeprom driver to the new directory /drivers/misc/eeprom
Date: Tue, 20 Jan 2009 11:23:00 +0100
Message-ID: <1232446982-7842-3-git-send-email-w.sang@pengutronix.de>
References: <1232446982-7842-1-git-send-email-w.sang@pengutronix.de>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	rt2400-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1232446982-7842-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Update Kconfig text to specify this driver as I2C.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/chips/Kconfig    |   11 --
 drivers/i2c/chips/Makefile   |    1 -
 drivers/i2c/chips/eeprom.c   |  257 ------------------------------------------
 drivers/misc/eeprom/Kconfig  |   11 ++
 drivers/misc/eeprom/Makefile |    1 +
 drivers/misc/eeprom/eeprom.c |  257 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 269 insertions(+), 269 deletions(-)
 delete mode 100644 drivers/i2c/chips/eeprom.c
 create mode 100644 drivers/misc/eeprom/eeprom.c

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index b58e770..c80312c 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -16,17 +16,6 @@ config DS1682
 	  This driver can also be built as a module.  If so, the module
 	  will be called ds1682.
 
-config SENSORS_EEPROM
-	tristate "EEPROM reader"
-	depends on EXPERIMENTAL
-	help
-	  If you say yes here you get read-only access to the EEPROM data
-	  available on modern memory DIMMs and Sony Vaio laptops.  Such
-	  EEPROMs could theoretically be available on other devices as well.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called eeprom.
-
 config SENSORS_PCF8574
 	tristate "Philips PCF8574 and PCF8574A (DEPRECATED)"
 	depends on EXPERIMENTAL && GPIO_PCF857X = "n"
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 5c14776..d142f23 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,7 +11,6 @@
 #
 
 obj-$(CONFIG_DS1682)		+= ds1682.o
-obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
deleted file mode 100644
index 2c27193..0000000
--- a/drivers/i2c/chips/eeprom.c
+++ /dev/null
@@ -1,257 +0,0 @@
-/*
-    Copyright (C) 1998, 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
-			       Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
-    Copyright (C) 2003 Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2003 IBM Corp.
-    Copyright (C) 2004 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/jiffies.h>
-#include <linux/i2c.h>
-#include <linux/mutex.h>
-
-/* Addresses to scan */
-static const unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
-					0x55, 0x56, 0x57, I2C_CLIENT_END };
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_1(eeprom);
-
-
-/* Size of EEPROM in bytes */
-#define EEPROM_SIZE		256
-
-/* possible types of eeprom devices */
-enum eeprom_nature {
-	UNKNOWN,
-	VAIO,
-};
-
-/* Each client has this additional data */
-struct eeprom_data {
-	struct mutex update_lock;
-	u8 valid;			/* bitfield, bit!=0 if slice is valid */
-	unsigned long last_updated[8];	/* In jiffies, 8 slices */
-	u8 data[EEPROM_SIZE];		/* Register values */
-	enum eeprom_nature nature;
-};
-
-
-static void eeprom_update_client(struct i2c_client *client, u8 slice)
-{
-	struct eeprom_data *data = i2c_get_clientdata(client);
-	int i;
-
-	mutex_lock(&data->update_lock);
-
-	if (!(data->valid & (1 << slice)) ||
-	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
-		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
-
-		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
-			for (i = slice << 5; i < (slice + 1) << 5; i += 32)
-				if (i2c_smbus_read_i2c_block_data(client, i,
-							32, data->data + i)
-							!= 32)
-					goto exit;
-		} else {
-			for (i = slice << 5; i < (slice + 1) << 5; i += 2) {
-				int word = i2c_smbus_read_word_data(client, i);
-				if (word < 0)
-					goto exit;
-				data->data[i] = word & 0xff;
-				data->data[i + 1] = word >> 8;
-			}
-		}
-		data->last_updated[slice] = jiffies;
-		data->valid |= (1 << slice);
-	}
-exit:
-	mutex_unlock(&data->update_lock);
-}
-
-static ssize_t eeprom_read(struct kobject *kobj, struct bin_attribute *bin_attr,
-			   char *buf, loff_t off, size_t count)
-{
-	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
-	struct eeprom_data *data = i2c_get_clientdata(client);
-	u8 slice;
-
-	if (off > EEPROM_SIZE)
-		return 0;
-	if (off + count > EEPROM_SIZE)
-		count = EEPROM_SIZE - off;
-
-	/* Only refresh slices which contain requested bytes */
-	for (slice = off >> 5; slice <= (off + count - 1) >> 5; slice++)
-		eeprom_update_client(client, slice);
-
-	/* Hide Vaio private settings to regular users:
-	   - BIOS passwords: bytes 0x00 to 0x0f
-	   - UUID: bytes 0x10 to 0x1f
-	   - Serial number: 0xc0 to 0xdf */
-	if (data->nature == VAIO && !capable(CAP_SYS_ADMIN)) {
-		int i;
-
-		for (i = 0; i < count; i++) {
-			if ((off + i <= 0x1f) ||
-			    (off + i >= 0xc0 && off + i <= 0xdf))
-				buf[i] = 0;
-			else
-				buf[i] = data->data[off + i];
-		}
-	} else {
-		memcpy(buf, &data->data[off], count);
-	}
-
-	return count;
-}
-
-static struct bin_attribute eeprom_attr = {
-	.attr = {
-		.name = "eeprom",
-		.mode = S_IRUGO,
-	},
-	.size = EEPROM_SIZE,
-	.read = eeprom_read,
-};
-
-/* Return 0 if detection is successful, -ENODEV otherwise */
-static int eeprom_detect(struct i2c_client *client, int kind,
-			 struct i2c_board_info *info)
-{
-	struct i2c_adapter *adapter = client->adapter;
-
-	/* EDID EEPROMs are often 24C00 EEPROMs, which answer to all
-	   addresses 0x50-0x57, but we only care about 0x50. So decline
-	   attaching to addresses >= 0x51 on DDC buses */
-	if (!(adapter->class & I2C_CLASS_SPD) && client->addr >= 0x51)
-		return -ENODEV;
-
-	/* There are four ways we can read the EEPROM data:
-	   (1) I2C block reads (faster, but unsupported by most adapters)
-	   (2) Word reads (128% overhead)
-	   (3) Consecutive byte reads (88% overhead, unsafe)
-	   (4) Regular byte data reads (265% overhead)
-	   The third and fourth methods are not implemented by this driver
-	   because all known adapters support one of the first two. */
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)
-	 && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
-		return -ENODEV;
-
-	strlcpy(info->type, "eeprom", I2C_NAME_SIZE);
-
-	return 0;
-}
-
-static int eeprom_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
-{
-	struct i2c_adapter *adapter = client->adapter;
-	struct eeprom_data *data;
-	int err;
-
-	if (!(data = kzalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	memset(data->data, 0xff, EEPROM_SIZE);
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-	data->nature = UNKNOWN;
-
-	/* Detect the Vaio nature of EEPROMs.
-	   We use the "PCG-" or "VGN-" prefix as the signature. */
-	if (client->addr == 0x57
-	 && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
-		char name[4];
-
-		name[0] = i2c_smbus_read_byte_data(client, 0x80);
-		name[1] = i2c_smbus_read_byte_data(client, 0x81);
-		name[2] = i2c_smbus_read_byte_data(client, 0x82);
-		name[3] = i2c_smbus_read_byte_data(client, 0x83);
-
-		if (!memcmp(name, "PCG-", 4) || !memcmp(name, "VGN-", 4)) {
-			dev_info(&client->dev, "Vaio EEPROM detected, "
-				 "enabling privacy protection\n");
-			data->nature = VAIO;
-		}
-	}
-
-	/* create the sysfs eeprom file */
-	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
-	if (err)
-		goto exit_kfree;
-
-	return 0;
-
-exit_kfree:
-	kfree(data);
-exit:
-	return err;
-}
-
-static int eeprom_remove(struct i2c_client *client)
-{
-	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
-	kfree(i2c_get_clientdata(client));
-
-	return 0;
-}
-
-static const struct i2c_device_id eeprom_id[] = {
-	{ "eeprom", 0 },
-	{ }
-};
-
-static struct i2c_driver eeprom_driver = {
-	.driver = {
-		.name	= "eeprom",
-	},
-	.probe		= eeprom_probe,
-	.remove		= eeprom_remove,
-	.id_table	= eeprom_id,
-
-	.class		= I2C_CLASS_DDC | I2C_CLASS_SPD,
-	.detect		= eeprom_detect,
-	.address_data	= &addr_data,
-};
-
-static int __init eeprom_init(void)
-{
-	return i2c_add_driver(&eeprom_driver);
-}
-
-static void __exit eeprom_exit(void)
-{
-	i2c_del_driver(&eeprom_driver);
-}
-
-
-MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
-		"Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org> and "
-		"Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>");
-MODULE_DESCRIPTION("I2C EEPROM driver");
-MODULE_LICENSE("GPL");
-
-module_init(eeprom_init);
-module_exit(eeprom_exit);
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 198525f..5a69ac8 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -26,4 +26,15 @@ config AT24
 	  This driver can also be built as a module.  If so, the module
 	  will be called at24.
 
+config SENSORS_EEPROM
+	tristate "Old I2C EEPROM reader"
+	depends on EXPERIMENTAL
+	help
+	  If you say yes here you get read-only access to the EEPROM data
+	  available on modern memory DIMMs and Sony Vaio laptops via I2C. Such
+	  EEPROMs could theoretically be available on other devices as well.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called eeprom.
+
 endmenu
diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
index 72cd478..a3dad28 100644
--- a/drivers/misc/eeprom/Makefile
+++ b/drivers/misc/eeprom/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_AT24)		+= at24.o
+obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
new file mode 100644
index 0000000..2c27193
--- /dev/null
+++ b/drivers/misc/eeprom/eeprom.c
@@ -0,0 +1,257 @@
+/*
+    Copyright (C) 1998, 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
+			       Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
+    Copyright (C) 2003 Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
+    Copyright (C) 2003 IBM Corp.
+    Copyright (C) 2004 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+
+/* Addresses to scan */
+static const unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
+					0x55, 0x56, 0x57, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(eeprom);
+
+
+/* Size of EEPROM in bytes */
+#define EEPROM_SIZE		256
+
+/* possible types of eeprom devices */
+enum eeprom_nature {
+	UNKNOWN,
+	VAIO,
+};
+
+/* Each client has this additional data */
+struct eeprom_data {
+	struct mutex update_lock;
+	u8 valid;			/* bitfield, bit!=0 if slice is valid */
+	unsigned long last_updated[8];	/* In jiffies, 8 slices */
+	u8 data[EEPROM_SIZE];		/* Register values */
+	enum eeprom_nature nature;
+};
+
+
+static void eeprom_update_client(struct i2c_client *client, u8 slice)
+{
+	struct eeprom_data *data = i2c_get_clientdata(client);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (!(data->valid & (1 << slice)) ||
+	    time_after(jiffies, data->last_updated[slice] + 300 * HZ)) {
+		dev_dbg(&client->dev, "Starting eeprom update, slice %u\n", slice);
+
+		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			for (i = slice << 5; i < (slice + 1) << 5; i += 32)
+				if (i2c_smbus_read_i2c_block_data(client, i,
+							32, data->data + i)
+							!= 32)
+					goto exit;
+		} else {
+			for (i = slice << 5; i < (slice + 1) << 5; i += 2) {
+				int word = i2c_smbus_read_word_data(client, i);
+				if (word < 0)
+					goto exit;
+				data->data[i] = word & 0xff;
+				data->data[i + 1] = word >> 8;
+			}
+		}
+		data->last_updated[slice] = jiffies;
+		data->valid |= (1 << slice);
+	}
+exit:
+	mutex_unlock(&data->update_lock);
+}
+
+static ssize_t eeprom_read(struct kobject *kobj, struct bin_attribute *bin_attr,
+			   char *buf, loff_t off, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
+	struct eeprom_data *data = i2c_get_clientdata(client);
+	u8 slice;
+
+	if (off > EEPROM_SIZE)
+		return 0;
+	if (off + count > EEPROM_SIZE)
+		count = EEPROM_SIZE - off;
+
+	/* Only refresh slices which contain requested bytes */
+	for (slice = off >> 5; slice <= (off + count - 1) >> 5; slice++)
+		eeprom_update_client(client, slice);
+
+	/* Hide Vaio private settings to regular users:
+	   - BIOS passwords: bytes 0x00 to 0x0f
+	   - UUID: bytes 0x10 to 0x1f
+	   - Serial number: 0xc0 to 0xdf */
+	if (data->nature == VAIO && !capable(CAP_SYS_ADMIN)) {
+		int i;
+
+		for (i = 0; i < count; i++) {
+			if ((off + i <= 0x1f) ||
+			    (off + i >= 0xc0 && off + i <= 0xdf))
+				buf[i] = 0;
+			else
+				buf[i] = data->data[off + i];
+		}
+	} else {
+		memcpy(buf, &data->data[off], count);
+	}
+
+	return count;
+}
+
+static struct bin_attribute eeprom_attr = {
+	.attr = {
+		.name = "eeprom",
+		.mode = S_IRUGO,
+	},
+	.size = EEPROM_SIZE,
+	.read = eeprom_read,
+};
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int eeprom_detect(struct i2c_client *client, int kind,
+			 struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+
+	/* EDID EEPROMs are often 24C00 EEPROMs, which answer to all
+	   addresses 0x50-0x57, but we only care about 0x50. So decline
+	   attaching to addresses >= 0x51 on DDC buses */
+	if (!(adapter->class & I2C_CLASS_SPD) && client->addr >= 0x51)
+		return -ENODEV;
+
+	/* There are four ways we can read the EEPROM data:
+	   (1) I2C block reads (faster, but unsupported by most adapters)
+	   (2) Word reads (128% overhead)
+	   (3) Consecutive byte reads (88% overhead, unsafe)
+	   (4) Regular byte data reads (265% overhead)
+	   The third and fourth methods are not implemented by this driver
+	   because all known adapters support one of the first two. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_WORD_DATA)
+	 && !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		return -ENODEV;
+
+	strlcpy(info->type, "eeprom", I2C_NAME_SIZE);
+
+	return 0;
+}
+
+static int eeprom_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	struct eeprom_data *data;
+	int err;
+
+	if (!(data = kzalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	memset(data->data, 0xff, EEPROM_SIZE);
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+	data->nature = UNKNOWN;
+
+	/* Detect the Vaio nature of EEPROMs.
+	   We use the "PCG-" or "VGN-" prefix as the signature. */
+	if (client->addr == 0x57
+	 && i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
+		char name[4];
+
+		name[0] = i2c_smbus_read_byte_data(client, 0x80);
+		name[1] = i2c_smbus_read_byte_data(client, 0x81);
+		name[2] = i2c_smbus_read_byte_data(client, 0x82);
+		name[3] = i2c_smbus_read_byte_data(client, 0x83);
+
+		if (!memcmp(name, "PCG-", 4) || !memcmp(name, "VGN-", 4)) {
+			dev_info(&client->dev, "Vaio EEPROM detected, "
+				 "enabling privacy protection\n");
+			data->nature = VAIO;
+		}
+	}
+
+	/* create the sysfs eeprom file */
+	err = sysfs_create_bin_file(&client->dev.kobj, &eeprom_attr);
+	if (err)
+		goto exit_kfree;
+
+	return 0;
+
+exit_kfree:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int eeprom_remove(struct i2c_client *client)
+{
+	sysfs_remove_bin_file(&client->dev.kobj, &eeprom_attr);
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static const struct i2c_device_id eeprom_id[] = {
+	{ "eeprom", 0 },
+	{ }
+};
+
+static struct i2c_driver eeprom_driver = {
+	.driver = {
+		.name	= "eeprom",
+	},
+	.probe		= eeprom_probe,
+	.remove		= eeprom_remove,
+	.id_table	= eeprom_id,
+
+	.class		= I2C_CLASS_DDC | I2C_CLASS_SPD,
+	.detect		= eeprom_detect,
+	.address_data	= &addr_data,
+};
+
+static int __init eeprom_init(void)
+{
+	return i2c_add_driver(&eeprom_driver);
+}
+
+static void __exit eeprom_exit(void)
+{
+	i2c_del_driver(&eeprom_driver);
+}
+
+
+MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
+		"Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org> and "
+		"Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>");
+MODULE_DESCRIPTION("I2C EEPROM driver");
+MODULE_LICENSE("GPL");
+
+module_init(eeprom_init);
+module_exit(eeprom_exit);
-- 
1.5.6.5
