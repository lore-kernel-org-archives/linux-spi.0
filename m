From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v3 4/6] ACPI / property: Support Apple _DSM properties
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <039c6190c4edbd55fd765ff79b8c3028d66a43ab.1499983092.git.lukas@wunner.de>
References: <cover.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1499983092.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

While the rest of the world has standardized on _DSD as the way to store
device properties in AML (introduced with ACPI 5.1 in 2014), Apple has
been using a custom _DSM to achieve the same for much longer (ever since
they switched from DeviceTree-based PowerPC to Intel in 2005, verified
with MacOS X 10.4.11).

The theory of operation on macOS is as follows:  AppleACPIPlatform.kext
invokes mergeEFIproperties() and mergeDSMproperties() for each device to
merge properties conveyed by EFI drivers as well as properties stored in
AML into the I/O Kit registry from which they can be retrieved by
drivers.  We've been supporting EFI properties since commit 58c5475aba67
("x86/efi: Retrieve and assign Apple device properties").  The present
commit adds support for _DSM properties, thereby completing our support
for Apple device properties.  The _DSM properties are made available
under the primary fwnode, the EFI properties under the secondary fwnode.
So for devices which possess both property types, they can all be
elegantly accessed with the uniform API in <linux/property.h>.

Until recently we had no need to support _DSM properties, they contained
only uninteresting garbage.  The situation has changed with MacBooks and
MacBook Pros introduced since 2015:  Their keyboard is attached with SPI
instead of USB and the _CRS data which is necessary to initialize the
spi driver only contains valid information if OSPM responds "false" to
_OSI("Darwin").  If OSPM responds "true", _CRS is empty and the spi
driver fails to initialize.  The rationale is very simple, Apple only
cares about macOS and Windows:  On Windows, _CRS contains valid data,
whereas on macOS it is empty.  Instead, macOS gleans the necessary data
from the _DSM properties.

Since Linux deliberately defaults to responding "true" to _OSI("Darwin"),
we need to emulate macOS' behaviour by initializing the spi driver with
data returned by the _DSM.

An out-of-tree driver for the SPI keyboard exists which currently binds
to the ACPI device, invokes the _DSM, parses the returned package and
instantiates an SPI device with the data gleaned from the _DSM:
https://github.com/cb22/macbook12-spi-driver/commit/9a416d699ef4
https://github.com/cb22/macbook12-spi-driver/commit/0c34936ed9a1

By adding support for Apple's _DSM properties in generic ACPI code, the
out-of-tree driver will be able to register as a regular SPI device,
significantly reducing its amount of code and improving its chances to
be mainlined.

The SPI keyboard will not be the only user of this commit:  E.g. on the
MacBook8,1, the UART-attached Bluetooth device likewise returns empty
_CRS data if OSPM returns "true" to _OSI("Darwin").

The _DSM returns a Package whose format unfortunately deviates slightly
from the _DSD spec:  The properties are marshalled up in a single Package
as alternating key/value elements, unlike _DSD which stores them as a
Package of 2-element Packages.  The present commit therefore converts
the Package to _DSD format and the ACPI core can then treat the data as
if Apple would follow the standard.

Well, except for one small annoyance:  The properties returned by the
_DSM only ever have one of two types, Integer or Buffer.  The former is
retrievable as usual with device_property_read_u64(), but the latter is
not part of the _DSD spec and it is not possible to retrieve Buffer
properties with the device_property_read_*() functions due to the type
checking performed in drivers/acpi/property.c.  It is however possible
to retrieve them with acpi_dev_get_property().  Apple is using the
Buffer type somewhat sloppily to store null-terminated strings but also
integers.  The real data type is not distinguishable by the ACPI core
and the onus is on the caller to use the contents of the Buffer in an
appropriate way.

In case Apple moves to _DSD in the future, this commit first checks for
_DSD and falls back to _DSM only if _DSD is not found.

Cc: Federico Lorenzi <florenzi@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ronald Tschalär <ronald@innovation.ch>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v2 -> v3:
- Use bitmap to keep track of valid properties.  Move to x86/apple.c
  to avoid cluttering up generic ACPI code. (Andy, Rafael)

 drivers/acpi/Makefile    |   1 +
 drivers/acpi/internal.h  |   6 +++
 drivers/acpi/property.c  |   3 ++
 drivers/acpi/x86/apple.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/acpi/x86/apple.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b1aacfc62b1f..90265ab4437a 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -50,6 +50,7 @@ acpi-$(CONFIG_ACPI_REDUCED_HARDWARE_ONLY) += evged.o
 acpi-y				+= sysfs.o
 acpi-y				+= property.o
 acpi-$(CONFIG_X86)		+= acpi_cmos_rtc.o
+acpi-$(CONFIG_X86)		+= x86/apple.o
 acpi-$(CONFIG_X86)		+= x86/utils.o
 acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index be79f7db1850..79ee29777909 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -229,6 +229,12 @@ static inline void suspend_nvs_restore(void) {}
 void acpi_init_properties(struct acpi_device *adev);
 void acpi_free_properties(struct acpi_device *adev);
 
+#ifdef CONFIG_X86
+void acpi_extract_apple_properties(struct acpi_device *adev);
+#else
+static inline void acpi_extract_apple_properties(struct acpi_device *adev) {}
+#endif
+
 /*--------------------------------------------------------------------------
 				Watchdog
   -------------------------------------------------------------------------- */
diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 27a9294c843c..d05f4f97c963 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -375,6 +375,9 @@ void acpi_init_properties(struct acpi_device *adev)
 	if (acpi_of && !adev->flags.of_compatible_ok)
 		acpi_handle_info(adev->handle,
 			 ACPI_DT_NAMESPACE_HID " requires 'compatible' property\n");
+
+	if (is_apple_system && !adev->data.pointer)
+		acpi_extract_apple_properties(adev);
 }
 
 static void acpi_destroy_nondev_subnodes(struct list_head *list)
diff --git a/drivers/acpi/x86/apple.c b/drivers/acpi/x86/apple.c
new file mode 100644
index 000000000000..bffa38f7460e
--- /dev/null
+++ b/drivers/acpi/x86/apple.c
@@ -0,0 +1,137 @@
+/*
+ * apple.c - Apple ACPI quirks
+ * Copyright (C) 2017 Lukas Wunner <lukas@wunner.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2) as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitmap.h>
+#include <linux/uuid.h>
+
+/* Apple _DSM device properties GUID */
+static const guid_t apple_prp_guid =
+	GUID_INIT(0xA0B5B7C6, 0x1318, 0x441C,
+		  0xB0, 0xC9, 0xFE, 0x69, 0x5E, 0xAF, 0x94, 0x9B);
+
+/**
+ * acpi_extract_apple_properties - retrieve and convert Apple _DSM properties
+ * @adev: ACPI device for which to retrieve the properties
+ *
+ * Invoke Apple's custom _DSM once to check the protocol version and once more
+ * to retrieve the properties.  They are marshalled up in a single package as
+ * alternating key/value elements, unlike _DSD which stores them as a package
+ * of 2-element packages.  Convert to _DSD format and make them available under
+ * the primary fwnode.
+ */
+void acpi_extract_apple_properties(struct acpi_device *adev)
+{
+	unsigned int i, j = 0, newsize = 0, numprops, numvalid;
+	union acpi_object *props, *newprops;
+	unsigned long *valid = NULL;
+	void *free_space;
+
+	props = acpi_evaluate_dsm_typed(adev->handle, &apple_prp_guid, 1, 0,
+					NULL, ACPI_TYPE_BUFFER);
+	if (!props)
+		return;
+
+	if (!props->buffer.length)
+		goto out_free;
+
+	if (props->buffer.pointer[0] != 3) {
+		acpi_handle_info(adev->handle, FW_INFO
+				 "unsupported properties version %*ph\n",
+				 props->buffer.length, props->buffer.pointer);
+		goto out_free;
+	}
+
+	ACPI_FREE(props);
+	props = acpi_evaluate_dsm_typed(adev->handle, &apple_prp_guid, 1, 1,
+					NULL, ACPI_TYPE_PACKAGE);
+	if (!props)
+		return;
+
+	numprops = props->package.count / 2;
+	if (!numprops)
+		goto out_free;
+
+	valid = kcalloc(BITS_TO_LONGS(numprops), sizeof(long), GFP_KERNEL);
+	if (!valid)
+		goto out_free;
+
+	/* newsize = key length + value length of each tuple */
+	for (i = 0; i < numprops; i++) {
+		union acpi_object *key = &props->package.elements[i * 2];
+		union acpi_object *val = &props->package.elements[i * 2 + 1];
+
+		if ( key->type != ACPI_TYPE_STRING ||
+		    (val->type != ACPI_TYPE_INTEGER &&
+		     val->type != ACPI_TYPE_BUFFER))
+			continue; /* skip invalid properties */
+
+		__set_bit(i, valid);
+		newsize += key->string.length + 1;
+		if ( val->type == ACPI_TYPE_BUFFER)
+			newsize += val->buffer.length;
+	}
+
+	numvalid = bitmap_weight(valid, numprops);
+	if (numprops > numvalid)
+		acpi_handle_info(adev->handle, FW_INFO
+				 "skipped %u properties: wrong type\n",
+				 numprops - numvalid);
+	if (numvalid == 0)
+		goto out_free;
+
+	/* newsize += top-level package + 3 objects for each key/value tuple */
+	newsize	+= (1 + 3 * numvalid) * sizeof(union acpi_object);
+	newprops = ACPI_ALLOCATE_ZEROED(newsize);
+	if (!newprops)
+		goto out_free;
+
+	/* layout: top-level package | packages | key/value tuples | strings */
+	newprops->type = ACPI_TYPE_PACKAGE;
+	newprops->package.count = numvalid;
+	newprops->package.elements = &newprops[1];
+	free_space = &newprops[1 + 3 * numvalid];
+
+	for_each_set_bit(i, valid, numprops) {
+		union acpi_object *key = &props->package.elements[i * 2];
+		union acpi_object *val = &props->package.elements[i * 2 + 1];
+		unsigned int k = 1 + numvalid + j * 2; /* index into newprops */
+		unsigned int v = k + 1;
+
+		newprops[1 + j].type = ACPI_TYPE_PACKAGE;
+		newprops[1 + j].package.count = 2;
+		newprops[1 + j].package.elements = &newprops[k];
+
+		newprops[k].type = ACPI_TYPE_STRING;
+		newprops[k].string.length = key->string.length;
+		newprops[k].string.pointer = free_space;
+		memcpy(free_space, key->string.pointer, key->string.length);
+		free_space += key->string.length + 1;
+
+		newprops[v].type = val->type;
+		if (val->type == ACPI_TYPE_INTEGER) {
+			newprops[v].integer.value = val->integer.value;
+		} else {
+			newprops[v].buffer.length = val->buffer.length;
+			newprops[v].buffer.pointer = free_space;
+			memcpy(free_space, val->buffer.pointer,
+			       val->buffer.length);
+			free_space += val->buffer.length;
+		}
+		j++; /* count valid properties */
+	}
+	WARN_ON(free_space != (void *)newprops + newsize);
+
+	adev->data.properties = newprops;
+	adev->data.pointer = newprops;
+
+out_free:
+	ACPI_FREE(props);
+	kfree(valid);
+}
-- 
2.11.0

