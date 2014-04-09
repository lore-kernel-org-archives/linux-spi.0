From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/9] mtd: spi-nor: unify read opcode variants with ST SPI FSM
Date: Wed,  9 Apr 2014 10:32:48 -0700
Message-ID: <1397064774-31784-3-git-send-email-computersforpeace@gmail.com>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397064774-31784-1-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

serial_flash_cmds.h defines our opcodes a little differently. Let's
borrow its naming, since it's borrowed from the SFDP standard, and it's
more extensible.

This prepares us for merging serial_flash_cmds.h and spi-nor.h opcode
listing.

Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++--------
 include/linux/mtd/spi-nor.h   | 24 ++++++++++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 462f1c8c3a7d..de04d6e2cf02 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1010,16 +1010,16 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	/* Default commands */
 	switch (nor->flash_read) {
 	case SPI_NOR_QUAD:
-		nor->read_opcode = SPINOR_OP_QUAD_READ;
+		nor->read_opcode = SPINOR_OP_READ_1_1_4;
 		break;
 	case SPI_NOR_DUAL:
-		nor->read_opcode = SPINOR_OP_DUAL_READ;
+		nor->read_opcode = SPINOR_OP_READ_1_1_2;
 		break;
 	case SPI_NOR_FAST:
-		nor->read_opcode = SPINOR_OP_FAST_READ;
+		nor->read_opcode = SPINOR_OP_READ_FAST;
 		break;
 	case SPI_NOR_NORMAL:
-		nor->read_opcode = SPINOR_OP_NORM_READ;
+		nor->read_opcode = SPINOR_OP_READ;
 		break;
 	default:
 		dev_err(dev, "No Read opcode defined\n");
@@ -1037,16 +1037,16 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 			/* Dedicated 4-byte command set */
 			switch (nor->flash_read) {
 			case SPI_NOR_QUAD:
-				nor->read_opcode = SPINOR_OP_QUAD_READ_4B;
+				nor->read_opcode = SPINOR_OP_READ4_1_1_4;
 				break;
 			case SPI_NOR_DUAL:
-				nor->read_opcode = SPINOR_OP_DUAL_READ_4B;
+				nor->read_opcode = SPINOR_OP_READ4_1_1_2;
 				break;
 			case SPI_NOR_FAST:
-				nor->read_opcode = SPINOR_OP_FAST_READ_4B;
+				nor->read_opcode = SPINOR_OP_READ4_FAST;
 				break;
 			case SPI_NOR_NORMAL:
-				nor->read_opcode = SPINOR_OP_NORM_READ_4B;
+				nor->read_opcode = SPINOR_OP_READ4;
 				break;
 			}
 			nor->program_opcode = SPINOR_OP_PP_4B;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 2c827b5bf773..2a5c30196749 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -1,14 +1,22 @@
 #ifndef __LINUX_MTD_SPI_NOR_H
 #define __LINUX_MTD_SPI_NOR_H
 
+/*
+ * Note on opcode nomenclature: some opcodes have a format like
+ * SPINOR_OP_FUNCTION{4,}_x_y_z. The numbers x, y, and z stand for the number
+ * of I/O lines used for the opcode, address, and data (respectively). The
+ * FUNCTION has an optional suffix of '4', to represent an opcode which
+ * requires a 4-byte (32-bit) address.
+ */
+
 /* Flash opcodes. */
 #define SPINOR_OP_WREN		0x06	/* Write enable */
 #define SPINOR_OP_RDSR		0x05	/* Read status register */
 #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
-#define SPINOR_OP_NORM_READ	0x03	/* Read data bytes (low frequency) */
-#define SPINOR_OP_FAST_READ	0x0b	/* Read data bytes (high frequency) */
-#define SPINOR_OP_DUAL_READ	0x3b	/* Read data bytes (Dual SPI) */
-#define SPINOR_OP_QUAD_READ	0x6b	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
+#define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
+#define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual SPI) */
+#define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
@@ -19,10 +27,10 @@
 #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
-#define SPINOR_OP_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
-#define SPINOR_OP_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
-#define SPINOR_OP_DUAL_READ_4B	0x3c	/* Read data bytes (Dual SPI) */
-#define SPINOR_OP_QUAD_READ_4B	0x6c	/* Read data bytes (Quad SPI) */
+#define SPINOR_OP_READ4		0x13	/* Read data bytes (low frequency) */
+#define SPINOR_OP_READ4_FAST	0x0c	/* Read data bytes (high frequency) */
+#define SPINOR_OP_READ4_1_1_2	0x3c	/* Read data bytes (Dual SPI) */
+#define SPINOR_OP_READ4_1_1_4	0x6c	/* Read data bytes (Quad SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
