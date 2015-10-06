From: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
Subject: [PATCH] misc: eeprom: at25: add Cypress FRAM functionality
Date: Tue,  6 Oct 2015 16:01:32 +0200
Message-ID: <c7beacd629a47a0bd5023353378a3eda4d7d0f89.1444139729.git.jiri.prchal@aksignal.cz>
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds functionality for Cypress FRAMs on SPI bus, such as FM25V05,
FM25V10 etc.
Added to at25 driver:
- reading device ID and choose size and addr len from it
- serial number reading and exporting it to sysfs
- new compatible string

Signed-off-by: Jiri Prchal <jiri.prchal-cKCO0sOKHLPtwjQa/ONI9g@public.gmane.org>
---
 drivers/misc/eeprom/Kconfig |   5 +-
 drivers/misc/eeprom/at25.c  | 209 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 192 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 04f2e1f..99c7cff 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -28,10 +28,11 @@ config EEPROM_AT24
 	  will be called at24.
 
 config EEPROM_AT25
-	tristate "SPI EEPROMs from most vendors"
+	tristate "SPI EEPROMs (FRAMs) from most vendors"
 	depends on SPI && SYSFS
 	help
-	  Enable this driver to get read/write support to most SPI EEPROMs,
+	  Enable this driver to get read/write support to most SPI EEPROMs
+	  and Cypress FRAMs,
 	  after you configure the board init code to know about each eeprom
 	  on your target board.
 
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 0a1af93..60d1d39 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -1,5 +1,6 @@
 /*
  * at25.c -- support most SPI EEPROMs, such as Atmel AT25 models
+ *	     and Cypress FRAMs FM25 models
  *
  * Copyright (C) 2006 David Brownell
  *
@@ -19,6 +20,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/eeprom.h>
 #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 /*
  * NOTE: this is an *EEPROM* driver.  The vagaries of product naming
@@ -34,6 +37,7 @@ struct at25_data {
 	struct spi_eeprom	chip;
 	struct bin_attribute	bin;
 	unsigned		addrlen;
+	int			has_sernum;
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -42,6 +46,9 @@ struct at25_data {
 #define	AT25_WRSR	0x01		/* write status register */
 #define	AT25_READ	0x03		/* read byte(s) */
 #define	AT25_WRITE	0x02		/* write byte(s)/sector */
+#define	FM25_SLEEP	0xb9		/* enter sleep mode */
+#define	FM25_RDID	0x9f		/* read device ID */
+#define	FM25_RDSN	0xc3		/* read S/N */
 
 #define	AT25_SR_nRDY	0x01		/* nRDY = write-in-progress */
 #define	AT25_SR_WEN	0x02		/* write enable (latched) */
@@ -51,6 +58,9 @@ struct at25_data {
 
 #define	AT25_INSTR_BIT3	0x08		/* Additional address bit in instr */
 
+#define	FM25_ID_LEN	9		/* ID lenght */
+#define	FM25_SN_LEN	8		/* serial number lenght */
+
 #define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
 
 /* Specs often allow 5 msec for a page write, sometimes 20 msec;
@@ -58,6 +68,9 @@ struct at25_data {
  */
 #define	EE_TIMEOUT	25
 
+#define	IS_EEPROM	0
+#define	IS_FRAM		1
+
 /*-------------------------------------------------------------------------*/
 
 #define	io_limit	PAGE_SIZE	/* bytes */
@@ -132,6 +145,83 @@ at25_ee_read(
 }
 
 static ssize_t
+fm25_id_read(struct at25_data *at25, char *buf)
+{
+	u8			command = FM25_RDID;
+	ssize_t			status;
+	struct spi_transfer	t[2];
+	struct spi_message	m;
+
+	spi_message_init(&m);
+	memset(t, 0, sizeof t);
+
+	t[0].tx_buf = &command;
+	t[0].len = 1;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].rx_buf = buf;
+	t[1].len = FM25_ID_LEN;
+	spi_message_add_tail(&t[1], &m);
+
+	mutex_lock(&at25->lock);
+
+	status = spi_sync(at25->spi, &m);
+	dev_dbg(&at25->spi->dev,
+		"read %Zd bytes of ID --> %d\n",
+	 FM25_ID_LEN, (int) status);
+
+	mutex_unlock(&at25->lock);
+	return status ? status : FM25_ID_LEN;
+}
+
+static ssize_t
+fm25_sernum_read(struct at25_data *at25, char *buf)
+{
+	u8			command = FM25_RDSN;
+	ssize_t			status;
+	struct spi_transfer	t[2];
+	struct spi_message	m;
+
+	spi_message_init(&m);
+	memset(t, 0, sizeof t);
+
+	t[0].tx_buf = &command;
+	t[0].len = 1;
+	spi_message_add_tail(&t[0], &m);
+
+	t[1].rx_buf = buf;
+	t[1].len = FM25_SN_LEN;
+	spi_message_add_tail(&t[1], &m);
+
+	mutex_lock(&at25->lock);
+
+	status = spi_sync(at25->spi, &m);
+	dev_dbg(&at25->spi->dev,
+		"read %Zd bytes of serial number --> %d\n",
+		FM25_SN_LEN, (int) status);
+
+	mutex_unlock(&at25->lock);
+	return status ? status : FM25_SN_LEN;
+}
+
+static ssize_t
+sernum_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	char			binbuf[FM25_SN_LEN];
+	struct at25_data	*at25;
+	int			i;
+	char			*pbuf = buf;
+
+	at25 = dev_get_drvdata(dev);
+	fm25_sernum_read(at25, binbuf);
+	for (i = 0; i < FM25_SN_LEN; i++)
+		pbuf += sprintf(pbuf, "%02x ", binbuf[i]);
+	sprintf(--pbuf, "\n");
+	return (3 * i);
+}
+static const DEVICE_ATTR_RO(sernum);
+
+static ssize_t
 at25_bin_read(struct file *filp, struct kobject *kobj,
 	      struct bin_attribute *bin_attr,
 	      char *buf, loff_t off, size_t count)
@@ -301,12 +391,21 @@ static ssize_t at25_mem_write(struct memory_accessor *mem, const char *buf,
 
 /*-------------------------------------------------------------------------*/
 
-static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
+static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip,
+			   int is_fram)
 {
 	u32 val;
+	char *name;
 
 	memset(chip, 0, sizeof(*chip));
-	strncpy(chip->name, "at25", sizeof(chip->name));
+	device_property_read_string(dev, "name", &name);
+	strncpy(chip->name, name, sizeof(chip->name));
+
+	if (is_fram) {
+		if (device_property_present(dev, "read-only"))
+			chip->flags |= EE_READONLY;
+		return 0;
+	}
 
 	if (device_property_read_u32(dev, "size", &val) == 0 ||
 	    device_property_read_u32(dev, "at25,byte-len", &val) == 0) {
@@ -354,6 +453,13 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
 	return 0;
 }
 
+static const struct of_device_id at25_of_match[] = {
+	{ .compatible = "atmel,at25", .data = (const void *)IS_EEPROM },
+	{ .compatible = "cypress,fm25", .data = (const void *)IS_FRAM },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, at25_of_match);
+
 static int at25_probe(struct spi_device *spi)
 {
 	struct at25_data	*at25 = NULL;
@@ -361,25 +467,34 @@ static int at25_probe(struct spi_device *spi)
 	int			err;
 	int			sr;
 	int			addrlen;
+	char			id[FM25_ID_LEN];
+	const struct of_device_id *match;
+	int			is_fram = 0;
+
+	match = of_match_device(of_match_ptr(at25_of_match), &spi->dev);
+	if (match)
+		is_fram = (int)(uintptr_t)match->data;
 
 	/* Chip description */
 	if (!spi->dev.platform_data) {
-		err = at25_fw_to_chip(&spi->dev, &chip);
+		err = at25_fw_to_chip(&spi->dev, &chip, is_fram);
 		if (err)
 			return err;
 	} else
 		chip = *(struct spi_eeprom *)spi->dev.platform_data;
 
 	/* For now we only support 8/16/24 bit addressing */
-	if (chip.flags & EE_ADDR1)
-		addrlen = 1;
-	else if (chip.flags & EE_ADDR2)
-		addrlen = 2;
-	else if (chip.flags & EE_ADDR3)
-		addrlen = 3;
-	else {
-		dev_dbg(&spi->dev, "unsupported address type\n");
-		return -EINVAL;
+	if (!is_fram) {
+		if (chip.flags & EE_ADDR1)
+			addrlen = 1;
+		else if (chip.flags & EE_ADDR2)
+			addrlen = 2;
+		else if (chip.flags & EE_ADDR3)
+			addrlen = 3;
+		else {
+			dev_dbg(&spi->dev, "unsupported address type\n");
+			return -EINVAL;
+		}
 	}
 
 	/* Ping the chip ... the status register is pretty portable,
@@ -402,6 +517,56 @@ static int at25_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, at25);
 	at25->addrlen = addrlen;
 
+	if (is_fram) {
+		/* Get ID of chip */
+		fm25_id_read(at25, id);
+		if (id[6] != 0xc2) {
+			dev_err(&spi->dev,
+				"Error: no Cypress FRAM (id %02x)\n", id[6]);
+			return -ENODEV;
+		}
+		/* set size found in ID */
+		switch (id[7]) {
+			case 0x21:
+				at25->chip.byte_len = 16 * 1024;
+				break;
+			case 0x22:
+				at25->chip.byte_len = 32 * 1024;
+				break;
+			case 0x23:
+				at25->chip.byte_len = 64 * 1024;
+				break;
+			case 0x24:
+				at25->chip.byte_len = 128 * 1024;
+				break;
+			case 0x25:
+				at25->chip.byte_len = 256 * 1024;
+				break;
+			default:
+				dev_err(&spi->dev,
+					"Error: unsupported size (id %02x)\n",
+					id[7]);
+				return -ENODEV;
+				break;
+		}
+
+		if (at25->chip.byte_len > 64 * 1024) {
+			at25->addrlen = 3;
+			at25->chip.flags |= EE_ADDR3;
+		}
+		else {
+			at25->addrlen = 2;
+			at25->chip.flags |= EE_ADDR2;
+		}
+
+		if (id[8])
+			at25->has_sernum = 1;
+		else
+			at25->has_sernum = 0;
+
+		at25->chip.page_size = PAGE_SIZE;
+	}
+
 	/* Export the EEPROM bytes through sysfs, since that's convenient.
 	 * And maybe to other kernel code; it might hold a board's Ethernet
 	 * address, or board-specific calibration data generated on the
@@ -412,7 +577,7 @@ static int at25_probe(struct spi_device *spi)
 	 * security codes, board-specific manufacturing calibrations, etc.
 	 */
 	sysfs_bin_attr_init(&at25->bin);
-	at25->bin.attr.name = "eeprom";
+	at25->bin.attr.name = is_fram ? "fram" : "eeprom";
 	at25->bin.attr.mode = S_IRUSR;
 	at25->bin.read = at25_bin_read;
 	at25->mem.read = at25_mem_read;
@@ -428,15 +593,23 @@ static int at25_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
+	/* Export the FM25 serial number */
+	if (at25->has_sernum) {
+		err = device_create_file(&spi->dev, &dev_attr_sernum);
+		if (err)
+			return err;
+	}
+
 	if (chip.setup)
 		chip.setup(&at25->mem, chip.context);
 
-	dev_info(&spi->dev, "%Zd %s %s eeprom%s, pagesize %u\n",
+	dev_info(&spi->dev, "%Zd %s %s %s%s, pagesize %u\n",
 		(at25->bin.size < 1024)
 			? at25->bin.size
 			: (at25->bin.size / 1024),
 		(at25->bin.size < 1024) ? "Byte" : "KByte",
 		at25->chip.name,
+		is_fram ? "fram" : "eeprom",
 		(chip.flags & EE_READONLY) ? " (readonly)" : "",
 		at25->chip.page_size);
 	return 0;
@@ -448,17 +621,13 @@ static int at25_remove(struct spi_device *spi)
 
 	at25 = spi_get_drvdata(spi);
 	sysfs_remove_bin_file(&spi->dev.kobj, &at25->bin);
+	if (at25->has_sernum)
+		device_remove_file(&spi->dev, &dev_attr_sernum);
 	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
 
-static const struct of_device_id at25_of_match[] = {
-	{ .compatible = "atmel,at25", },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, at25_of_match);
-
 static struct spi_driver at25_driver = {
 	.driver = {
 		.name		= "at25",
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
