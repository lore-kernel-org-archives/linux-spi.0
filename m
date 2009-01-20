From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 4/4] Move 93cx6 eeprom driver to the new directory /drivers/misc/eeprom
Date: Tue, 20 Jan 2009 11:23:02 +0100
Message-ID: <1232446982-7842-5-git-send-email-w.sang@pengutronix.de>
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

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/misc/Kconfig               |    8 --
 drivers/misc/Makefile              |    1 -
 drivers/misc/eeprom/Kconfig        |    8 ++
 drivers/misc/eeprom/Makefile       |    1 +
 drivers/misc/eeprom/eeprom_93cx6.c |  240 ++++++++++++++++++++++++++++++++++++
 drivers/misc/eeprom_93cx6.c        |  240 ------------------------------------
 6 files changed, 249 insertions(+), 249 deletions(-)
 create mode 100644 drivers/misc/eeprom/eeprom_93cx6.c
 delete mode 100644 drivers/misc/eeprom_93cx6.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6c9cd9d..5607319 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -87,14 +87,6 @@ config PHANTOM
 	  If you choose to build module, its name will be phantom. If unsure,
 	  say N here.
 
-config EEPROM_93CX6
-	tristate "EEPROM 93CX6 support"
-	---help---
-	  This is a driver for the EEPROM chipsets 93c46 and 93c66.
-	  The driver supports both read as well as write commands.
-
-	  If unsure, say N.
-
 config SGI_IOC4
 	tristate "SGI IOC4 Base IO support"
 	depends on PCI
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 0ec2320..bc11998 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -13,7 +13,6 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_PHANTOM)		+= phantom.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
-obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
 obj-$(CONFIG_ENCLOSURE_SERVICES) += enclosure.o
 obj-$(CONFIG_KGDB_TESTS)	+= kgdbts.o
 obj-$(CONFIG_SGI_XP)		+= sgi-xp/
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 0853a8b..5d976ed 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -48,4 +48,12 @@ config SENSORS_EEPROM
 	  This driver can also be built as a module.  If so, the module
 	  will be called eeprom.
 
+config EEPROM_93CX6
+	tristate "EEPROM 93CX6 support"
+	---help---
+	  This is a driver for the EEPROM chipsets 93c46 and 93c66.
+	  The driver supports both read as well as write commands.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
index a4fb5cf..3b7af6d 100644
--- a/drivers/misc/eeprom/Makefile
+++ b/drivers/misc/eeprom/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_AT24)		+= at24.o
 obj-$(CONFIG_SPI_AT25)		+= at25.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
+obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eeprom_93cx6.c
new file mode 100644
index 0000000..15b1780
--- /dev/null
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -0,0 +1,240 @@
+/*
+	Copyright (C) 2004 - 2006 rt2x00 SourceForge Project
+	<http://rt2x00.serialmonkey.com>
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the
+	Free Software Foundation, Inc.,
+	59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+/*
+	Module: eeprom_93cx6
+	Abstract: EEPROM reader routines for 93cx6 chipsets.
+	Supported chipsets: 93c46 & 93c66.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/eeprom_93cx6.h>
+
+MODULE_AUTHOR("http://rt2x00.serialmonkey.com");
+MODULE_VERSION("1.0");
+MODULE_DESCRIPTION("EEPROM 93cx6 chip driver");
+MODULE_LICENSE("GPL");
+
+static inline void eeprom_93cx6_pulse_high(struct eeprom_93cx6 *eeprom)
+{
+	eeprom->reg_data_clock = 1;
+	eeprom->register_write(eeprom);
+
+	/*
+	 * Add a short delay for the pulse to work.
+	 * According to the specifications the "maximum minimum"
+	 * time should be 450ns.
+	 */
+	ndelay(450);
+}
+
+static inline void eeprom_93cx6_pulse_low(struct eeprom_93cx6 *eeprom)
+{
+	eeprom->reg_data_clock = 0;
+	eeprom->register_write(eeprom);
+
+	/*
+	 * Add a short delay for the pulse to work.
+	 * According to the specifications the "maximum minimum"
+	 * time should be 450ns.
+	 */
+	ndelay(450);
+}
+
+static void eeprom_93cx6_startup(struct eeprom_93cx6 *eeprom)
+{
+	/*
+	 * Clear all flags, and enable chip select.
+	 */
+	eeprom->register_read(eeprom);
+	eeprom->reg_data_in = 0;
+	eeprom->reg_data_out = 0;
+	eeprom->reg_data_clock = 0;
+	eeprom->reg_chip_select = 1;
+	eeprom->register_write(eeprom);
+
+	/*
+	 * kick a pulse.
+	 */
+	eeprom_93cx6_pulse_high(eeprom);
+	eeprom_93cx6_pulse_low(eeprom);
+}
+
+static void eeprom_93cx6_cleanup(struct eeprom_93cx6 *eeprom)
+{
+	/*
+	 * Clear chip_select and data_in flags.
+	 */
+	eeprom->register_read(eeprom);
+	eeprom->reg_data_in = 0;
+	eeprom->reg_chip_select = 0;
+	eeprom->register_write(eeprom);
+
+	/*
+	 * kick a pulse.
+	 */
+	eeprom_93cx6_pulse_high(eeprom);
+	eeprom_93cx6_pulse_low(eeprom);
+}
+
+static void eeprom_93cx6_write_bits(struct eeprom_93cx6 *eeprom,
+	const u16 data, const u16 count)
+{
+	unsigned int i;
+
+	eeprom->register_read(eeprom);
+
+	/*
+	 * Clear data flags.
+	 */
+	eeprom->reg_data_in = 0;
+	eeprom->reg_data_out = 0;
+
+	/*
+	 * Start writing all bits.
+	 */
+	for (i = count; i > 0; i--) {
+		/*
+		 * Check if this bit needs to be set.
+		 */
+		eeprom->reg_data_in = !!(data & (1 << (i - 1)));
+
+		/*
+		 * Write the bit to the eeprom register.
+		 */
+		eeprom->register_write(eeprom);
+
+		/*
+		 * Kick a pulse.
+		 */
+		eeprom_93cx6_pulse_high(eeprom);
+		eeprom_93cx6_pulse_low(eeprom);
+	}
+
+	eeprom->reg_data_in = 0;
+	eeprom->register_write(eeprom);
+}
+
+static void eeprom_93cx6_read_bits(struct eeprom_93cx6 *eeprom,
+	u16 *data, const u16 count)
+{
+	unsigned int i;
+	u16 buf = 0;
+
+	eeprom->register_read(eeprom);
+
+	/*
+	 * Clear data flags.
+	 */
+	eeprom->reg_data_in = 0;
+	eeprom->reg_data_out = 0;
+
+	/*
+	 * Start reading all bits.
+	 */
+	for (i = count; i > 0; i--) {
+		eeprom_93cx6_pulse_high(eeprom);
+
+		eeprom->register_read(eeprom);
+
+		/*
+		 * Clear data_in flag.
+		 */
+		eeprom->reg_data_in = 0;
+
+		/*
+		 * Read if the bit has been set.
+		 */
+		if (eeprom->reg_data_out)
+			buf |= (1 << (i - 1));
+
+		eeprom_93cx6_pulse_low(eeprom);
+	}
+
+	*data = buf;
+}
+
+/**
+ * eeprom_93cx6_read - Read multiple words from eeprom
+ * @eeprom: Pointer to eeprom structure
+ * @word: Word index from where we should start reading
+ * @data: target pointer where the information will have to be stored
+ *
+ * This function will read the eeprom data as host-endian word
+ * into the given data pointer.
+ */
+void eeprom_93cx6_read(struct eeprom_93cx6 *eeprom, const u8 word,
+	u16 *data)
+{
+	u16 command;
+
+	/*
+	 * Initialize the eeprom register
+	 */
+	eeprom_93cx6_startup(eeprom);
+
+	/*
+	 * Select the read opcode and the word to be read.
+	 */
+	command = (PCI_EEPROM_READ_OPCODE << eeprom->width) | word;
+	eeprom_93cx6_write_bits(eeprom, command,
+		PCI_EEPROM_WIDTH_OPCODE + eeprom->width);
+
+	/*
+	 * Read the requested 16 bits.
+	 */
+	eeprom_93cx6_read_bits(eeprom, data, 16);
+
+	/*
+	 * Cleanup eeprom register.
+	 */
+	eeprom_93cx6_cleanup(eeprom);
+}
+EXPORT_SYMBOL_GPL(eeprom_93cx6_read);
+
+/**
+ * eeprom_93cx6_multiread - Read multiple words from eeprom
+ * @eeprom: Pointer to eeprom structure
+ * @word: Word index from where we should start reading
+ * @data: target pointer where the information will have to be stored
+ * @words: Number of words that should be read.
+ *
+ * This function will read all requested words from the eeprom,
+ * this is done by calling eeprom_93cx6_read() multiple times.
+ * But with the additional change that while the eeprom_93cx6_read
+ * will return host ordered bytes, this method will return little
+ * endian words.
+ */
+void eeprom_93cx6_multiread(struct eeprom_93cx6 *eeprom, const u8 word,
+	__le16 *data, const u16 words)
+{
+	unsigned int i;
+	u16 tmp;
+
+	for (i = 0; i < words; i++) {
+		tmp = 0;
+		eeprom_93cx6_read(eeprom, word + i, &tmp);
+		data[i] = cpu_to_le16(tmp);
+	}
+}
+EXPORT_SYMBOL_GPL(eeprom_93cx6_multiread);
+
diff --git a/drivers/misc/eeprom_93cx6.c b/drivers/misc/eeprom_93cx6.c
deleted file mode 100644
index 15b1780..0000000
--- a/drivers/misc/eeprom_93cx6.c
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
-	Copyright (C) 2004 - 2006 rt2x00 SourceForge Project
-	<http://rt2x00.serialmonkey.com>
-
-	This program is free software; you can redistribute it and/or modify
-	it under the terms of the GNU General Public License as published by
-	the Free Software Foundation; either version 2 of the License, or
-	(at your option) any later version.
-
-	This program is distributed in the hope that it will be useful,
-	but WITHOUT ANY WARRANTY; without even the implied warranty of
-	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-	GNU General Public License for more details.
-
-	You should have received a copy of the GNU General Public License
-	along with this program; if not, write to the
-	Free Software Foundation, Inc.,
-	59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-/*
-	Module: eeprom_93cx6
-	Abstract: EEPROM reader routines for 93cx6 chipsets.
-	Supported chipsets: 93c46 & 93c66.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/eeprom_93cx6.h>
-
-MODULE_AUTHOR("http://rt2x00.serialmonkey.com");
-MODULE_VERSION("1.0");
-MODULE_DESCRIPTION("EEPROM 93cx6 chip driver");
-MODULE_LICENSE("GPL");
-
-static inline void eeprom_93cx6_pulse_high(struct eeprom_93cx6 *eeprom)
-{
-	eeprom->reg_data_clock = 1;
-	eeprom->register_write(eeprom);
-
-	/*
-	 * Add a short delay for the pulse to work.
-	 * According to the specifications the "maximum minimum"
-	 * time should be 450ns.
-	 */
-	ndelay(450);
-}
-
-static inline void eeprom_93cx6_pulse_low(struct eeprom_93cx6 *eeprom)
-{
-	eeprom->reg_data_clock = 0;
-	eeprom->register_write(eeprom);
-
-	/*
-	 * Add a short delay for the pulse to work.
-	 * According to the specifications the "maximum minimum"
-	 * time should be 450ns.
-	 */
-	ndelay(450);
-}
-
-static void eeprom_93cx6_startup(struct eeprom_93cx6 *eeprom)
-{
-	/*
-	 * Clear all flags, and enable chip select.
-	 */
-	eeprom->register_read(eeprom);
-	eeprom->reg_data_in = 0;
-	eeprom->reg_data_out = 0;
-	eeprom->reg_data_clock = 0;
-	eeprom->reg_chip_select = 1;
-	eeprom->register_write(eeprom);
-
-	/*
-	 * kick a pulse.
-	 */
-	eeprom_93cx6_pulse_high(eeprom);
-	eeprom_93cx6_pulse_low(eeprom);
-}
-
-static void eeprom_93cx6_cleanup(struct eeprom_93cx6 *eeprom)
-{
-	/*
-	 * Clear chip_select and data_in flags.
-	 */
-	eeprom->register_read(eeprom);
-	eeprom->reg_data_in = 0;
-	eeprom->reg_chip_select = 0;
-	eeprom->register_write(eeprom);
-
-	/*
-	 * kick a pulse.
-	 */
-	eeprom_93cx6_pulse_high(eeprom);
-	eeprom_93cx6_pulse_low(eeprom);
-}
-
-static void eeprom_93cx6_write_bits(struct eeprom_93cx6 *eeprom,
-	const u16 data, const u16 count)
-{
-	unsigned int i;
-
-	eeprom->register_read(eeprom);
-
-	/*
-	 * Clear data flags.
-	 */
-	eeprom->reg_data_in = 0;
-	eeprom->reg_data_out = 0;
-
-	/*
-	 * Start writing all bits.
-	 */
-	for (i = count; i > 0; i--) {
-		/*
-		 * Check if this bit needs to be set.
-		 */
-		eeprom->reg_data_in = !!(data & (1 << (i - 1)));
-
-		/*
-		 * Write the bit to the eeprom register.
-		 */
-		eeprom->register_write(eeprom);
-
-		/*
-		 * Kick a pulse.
-		 */
-		eeprom_93cx6_pulse_high(eeprom);
-		eeprom_93cx6_pulse_low(eeprom);
-	}
-
-	eeprom->reg_data_in = 0;
-	eeprom->register_write(eeprom);
-}
-
-static void eeprom_93cx6_read_bits(struct eeprom_93cx6 *eeprom,
-	u16 *data, const u16 count)
-{
-	unsigned int i;
-	u16 buf = 0;
-
-	eeprom->register_read(eeprom);
-
-	/*
-	 * Clear data flags.
-	 */
-	eeprom->reg_data_in = 0;
-	eeprom->reg_data_out = 0;
-
-	/*
-	 * Start reading all bits.
-	 */
-	for (i = count; i > 0; i--) {
-		eeprom_93cx6_pulse_high(eeprom);
-
-		eeprom->register_read(eeprom);
-
-		/*
-		 * Clear data_in flag.
-		 */
-		eeprom->reg_data_in = 0;
-
-		/*
-		 * Read if the bit has been set.
-		 */
-		if (eeprom->reg_data_out)
-			buf |= (1 << (i - 1));
-
-		eeprom_93cx6_pulse_low(eeprom);
-	}
-
-	*data = buf;
-}
-
-/**
- * eeprom_93cx6_read - Read multiple words from eeprom
- * @eeprom: Pointer to eeprom structure
- * @word: Word index from where we should start reading
- * @data: target pointer where the information will have to be stored
- *
- * This function will read the eeprom data as host-endian word
- * into the given data pointer.
- */
-void eeprom_93cx6_read(struct eeprom_93cx6 *eeprom, const u8 word,
-	u16 *data)
-{
-	u16 command;
-
-	/*
-	 * Initialize the eeprom register
-	 */
-	eeprom_93cx6_startup(eeprom);
-
-	/*
-	 * Select the read opcode and the word to be read.
-	 */
-	command = (PCI_EEPROM_READ_OPCODE << eeprom->width) | word;
-	eeprom_93cx6_write_bits(eeprom, command,
-		PCI_EEPROM_WIDTH_OPCODE + eeprom->width);
-
-	/*
-	 * Read the requested 16 bits.
-	 */
-	eeprom_93cx6_read_bits(eeprom, data, 16);
-
-	/*
-	 * Cleanup eeprom register.
-	 */
-	eeprom_93cx6_cleanup(eeprom);
-}
-EXPORT_SYMBOL_GPL(eeprom_93cx6_read);
-
-/**
- * eeprom_93cx6_multiread - Read multiple words from eeprom
- * @eeprom: Pointer to eeprom structure
- * @word: Word index from where we should start reading
- * @data: target pointer where the information will have to be stored
- * @words: Number of words that should be read.
- *
- * This function will read all requested words from the eeprom,
- * this is done by calling eeprom_93cx6_read() multiple times.
- * But with the additional change that while the eeprom_93cx6_read
- * will return host ordered bytes, this method will return little
- * endian words.
- */
-void eeprom_93cx6_multiread(struct eeprom_93cx6 *eeprom, const u8 word,
-	__le16 *data, const u16 words)
-{
-	unsigned int i;
-	u16 tmp;
-
-	for (i = 0; i < words; i++) {
-		tmp = 0;
-		eeprom_93cx6_read(eeprom, word + i, &tmp);
-		data[i] = cpu_to_le16(tmp);
-	}
-}
-EXPORT_SYMBOL_GPL(eeprom_93cx6_multiread);
-
-- 
1.5.6.5
