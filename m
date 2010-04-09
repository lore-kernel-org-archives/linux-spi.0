From: "Miguel Angel Alvarez" <ma.alvarez-4+3kA1y9f6Q@public.gmane.org>
Subject: [Patch]: Driver for MT29F
Date: Fri, 09 Apr 2010 10:30:52 +0200
Message-ID: <1270801852.23278.33.camel@mac2>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear all

I am trying to use an SPI based NAND (Micron MT29F) in my board.

As I have not found a suitable driver that implements an SPI based NAND
and that is integrated in the MTD system, I have written one on my own.

Here I attach a patch to implement it. I am sure it is not as clean as
it should be, and could be improved, but I would like to offer it and
also to offer my help in improving it and (perhaps) adding it to the
kernel.

Please let me know what you think about it.

diff -urN linux-2.6.28.6_orig/arch/blackfin/mach-bf527/boards/ezkit.c
linux-2.6.28.6/arch/blackfin/mach-bf527/boards/ezkit.c
--- linux-2.6.28.6_orig/arch/blackfin/mach-bf527/boards/ezkit.c
2010-03-25 14:44:55.000000000 +0100
+++
linux-2.6.28.6/arch/blackfin/mach-bf527/boards/ezkit.c      2010-03-25
14:48:06.000000000 +0100
@@ -202,6 +202,33 @@
 };
 #endif
 =

+#if defined(CONFIG_MTD_NAND_MT29F)
+static struct mtd_partition mt29f_spi_flash_partitions[] =3D {
+       {
+               .name =3D "storage(spi)",
+               .size =3D 0x8000000,
+               .offset =3D 0,
+       }
+};
+
+static struct flash_platform_data mt29f_spi_flash_data =3D {
+       .name =3D "mt29f",
+       .parts =3D mt29f_spi_flash_partitions,
+       .nr_parts =3D ARRAY_SIZE(mt29f_spi_flash_partitions),
+       .type =3D "MT29F",
+//     .page_size =3D NFC_PG_SIZE_256,
+//     .data_width =3D NFC_NWIDTH_8,
+//     .rd_dly =3D 3,
+//     .wr_dly =3D 3,
+};
+
+
+static struct bfin5xx_spi_chip mt29f_spi_chip_info =3D {
+       .enable_dma     =3D 0,
+       .bits_per_word  =3D 8,
+};
+#endif
+
 #if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
 static struct mtd_partition ezkit_partitions[] =3D {
        {
@@ -627,6 +654,18 @@
 #endif
 =

 static struct spi_board_info bfin_spi_board_info[] __initdata =3D {
+#if defined(CONFIG_MTD_NAND_MT29F)
+       {
+               /* the modalias must be the same as spi device driver
name */
+               .modalias =3D "mt29f", /* Name of spi_driver for this
device */
+               .max_speed_hz =3D 5000000,     /* max spi clock (SCK)
speed in HZ */
+               .bus_num =3D 0, /* Framework bus number */
+               .chip_select =3D 0x31, /* Framework chip select. On
STAMP537 it is
SPISSEL1*/
+               .platform_data =3D &mt29f_spi_flash_data,
+               .controller_data =3D &mt29f_spi_chip_info,
+               .mode =3D SPI_MODE_3,
+       },
+#endif
 #if defined(CONFIG_MTD_M25P80) \
        || defined(CONFIG_MTD_M25P80_MODULE)
        {
diff -urN linux-2.6.28.6_orig/drivers/mtd/nand/Kconfig
linux-2.6.28.6/drivers/mtd/nand/Kconfig
--- linux-2.6.28.6_orig/drivers/mtd/nand/Kconfig        2010-03-25
14:45:48.000000000 +0100
+++ linux-2.6.28.6/drivers/mtd/nand/Kconfig     2010-03-25
14:48:06.000000000 +0100
@@ -463,4 +463,10 @@
          Several Renesas SuperH CPU has FLCTL. This option enables
support
          for NAND Flash using FLCTL. This driver support SH7723.
 =

+config MTD_NAND_MT29F
+       tristate "Support Micron MT29F"
+       depends on MTD_NAND && SPI_MASTER
+       help
+         This enables access to Micron MT29F SPI Flash.
+
 endif # MTD_NAND
diff -urN linux-2.6.28.6_orig/drivers/mtd/nand/Makefile
linux-2.6.28.6/drivers/mtd/nand/Makefile
--- linux-2.6.28.6_orig/drivers/mtd/nand/Makefile       2010-03-25
14:45:48.000000000 +0100
+++ linux-2.6.28.6/drivers/mtd/nand/Makefile    2010-03-25
14:48:06.000000000 +0100
@@ -37,5 +37,6 @@
 obj-$(CONFIG_MTD_NAND_FSL_UPM)         +=3D fsl_upm.o
 obj-$(CONFIG_MTD_NAND_SH_FLCTL)                +=3D sh_flctl.o
 obj-$(CONFIG_MTD_NAND_MXC)             +=3D mxc_nand.o
+obj-$(CONFIG_MTD_NAND_MT29F)   +=3D mt29f.o
 =

 nand-objs :=3D nand_base.o nand_bbt.o
diff -urN linux-2.6.28.6_orig/drivers/mtd/nand/mt29f.c
linux-2.6.28.6/drivers/mtd/nand/mt29f.c
--- linux-2.6.28.6_orig/drivers/mtd/nand/mt29f.c        1970-01-01
01:00:00.000000000 +0100
+++ linux-2.6.28.6/drivers/mtd/nand/mt29f.c     2010-03-31
20:51:53.000000000 +0200
@@ -0,0 +1,833 @@
+/*
+ * Micron MT29F MTD driver for lightweight SPI framework
+ *
+ * Largely derived from mtd_mt29f.c:
+ *  Copyright (C) 2010 ZIV
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+*/
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+
+#include <linux/mtd/mtd.h>
+#include <asm/nand.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/bfin5xx_spi.h>
+
+#define DRV_NAME       "mt29f"
+//#define DEBUG_MT29F
+//#define DEBUG_MT29F_EXAMINE
+
+/* newer chips report JEDEC manufacturer and device IDs; chip
+ * serial number and OTP bits; and per-sector writeprotect.
+ */
+#define OP_BLOCK_ERASE              0xD8
+#define OP_GET_FEATURE              0x0F
+#define OP_PAGE_READ                0x13
+#define OP_PROGRAM_EXECUTE          0x10
+#define OP_PROGRAM_LOAD             0x02
+#define OP_PROGRAM_LOAD_RANDOM_DATA 0x84
+#define OP_READ_FROM_CACHE1         0x03
+#define OP_READ_FROM_CACHE2         0x0B
+#define OP_READ_ID                         0x9F
+#define OP_RESET                    0xFF
+#define OP_SET_FEATURE              0x1F
+#define OP_WRITE_DISABLE            0x04
+#define OP_WRITE_ENABLE             0x06
+
+#define REG_FEATURE_BLOCKLOCK          0xA0
+#define REG_FEATURE_OTP                                0xB0
+#define REG_FEATURE_STATUS                     0xC0
+
+#define SPI_MAX_TRANSFER max(32,SMP_CACHE_BYTES)
+
+struct mt29f_flash_info {
+       char            *name;
+
+       /* JEDEC id has a high byte of zero plus three data bytes:
+        * the manufacturer id, then a two byte device id.
+        */
+       uint32_t        jedec_id;
+
+       /* The size listed here is what works with OP_ERASE_PAGE. */
+       uint16_t        nblocks;
+       uint32_t        npages;
+       uint32_t        writesize;
+       uint32_t        size;
+};
+
+struct mt29f_info {
+       struct mt29f_flash_info *flash_info;
+       struct spi_device       *spi;
+       struct flash_platform_data *platform;
+
+       struct nand_hw_control  controller;
+       struct mtd_info                 mtd;
+       struct nand_chip                chip;
+       uint8_t auxbyte;
+       uint8_t useauxbyte;
+       uint8_t lastcommand;
+       uint8_t status;
+       uint16_t pageoffset;
+       uint16_t byteoffset;
+       uint8_t aleoffset;
+       struct spi_message      message;
+       struct spi_transfer     x[2];
+};
+
+static int mt29f_examine_features(struct spi_device *spi);
+
+static struct mt29f_info *mtd_to_mt29f_info(struct mtd_info *mtd)
+{
+       return container_of(mtd, struct mt29f_info, mtd);
+}
+
+static void mt29f_error(struct mt29f_info *info, int tmp, int cmd)
+{
+       if (tmp < 0) {
+               printk(KERN_ERR DRV_NAME "%s: error %d reading spi in
command %02x
\n",
+                       info->spi->dev.bus_id, tmp, cmd);
+               return;
+       }
+}
+
+static int mt29f_reset(struct mt29f_info *info)
+{
+       uint8_t dummy;
+       uint8_t code =3D OP_RESET;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_RESET\n");
+       #endif
+       return spi_write_then_read(info->spi, &code, 1, &dummy, 1);
+}
+
+static int mt29f_none(struct mt29f_info *info)
+{
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_NONE\n");
+       #ifdef DEBUG_MT29F_EXAMINE
+       mt29f_examine_features(info->spi);
+       #endif
+       #endif
+       return 0;
+}
+
+static int mt29f_read0(struct mt29f_info *info)
+{
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_READ0\n");
+       #endif
+       return 0;
+}
+
+static int mt29f_get_features(struct spi_device *spi, uint8_t reg, =

+           uint8_t *val)
+{
+       uint8_t code[2];
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_get_features\n");
+       #endif
+       code[0] =3D OP_GET_FEATURE;
+       code[1] =3D reg;
+       return spi_write_then_read(spi, code, 2, val, 1);
+}
+
+static int mt29f_examine_features(struct spi_device *spi)
+{
+       uint8_t code[2];
+       uint8_t val;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_examine_features\n");
+       #endif
+       code[0] =3D OP_GET_FEATURE;
+       code[1] =3D REG_FEATURE_BLOCKLOCK;
+       spi_write_then_read(spi, code, 2, &val, 1);
+       printk(KERN_NOTICE DRV_NAME " REG_FEATURE_BLOCKLOCK %02x\n",
val);
+
+       code[1] =3D REG_FEATURE_OTP;
+       spi_write_then_read(spi, code, 2, &val, 1);
+       printk(KERN_NOTICE DRV_NAME " REG_FEATURE_OTP %02x\n", val);
+
+       code[1] =3D REG_FEATURE_STATUS;
+       spi_write_then_read(spi, code, 2, &val, 1);
+       printk(KERN_NOTICE DRV_NAME " REG_FEATURE_STATUS %02x\n", val);
+
+       return 0;
+}
+
+static int mt29f_set_features(struct spi_device *spi, uint8_t reg, =

+           uint8_t val)
+{
+       uint8_t code[3];
+       uint8_t dummy;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_set_features\n");
+       #endif
+       code[0] =3D OP_SET_FEATURE;
+       code[1] =3D reg;
+       code[2] =3D val;
+       return spi_write_then_read(spi, code, 3, &dummy, 0);
+}
+
+static int mt29f_read_status(struct mt29f_info *info)
+{
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_STATUS\n");
+       #endif
+       uint8_t aux;
+       uint8_t returnvalue =3D NAND_STATUS_WP;
+       int tmp =3D mt29f_get_features(info->spi, REG_FEATURE_STATUS,
&aux);
+       if (tmp < 0)
+               return tmp;
+
+       if (!(aux & 0x01))
+               returnvalue |=3D NAND_STATUS_READY;
+
+       if (aux & 0x2c) {
+               #ifdef DEBUG_MT29F
+               printk(KERN_ERR DRV_NAME " NAND_STATUS_FAIL %02x Page: %
04x\n", aux,
+info->pageoffset);
+               #endif
+               returnvalue |=3D NAND_STATUS_FAIL;
+       }
+
+       info->auxbyte =3D returnvalue;
+       info->useauxbyte =3D 1;
+
+       return returnvalue;
+}
+
+static int mt29f_write_enable(struct mt29f_info *info)
+{
+       uint8_t dummy;
+       uint8_t code;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_write_enable\n");
+       #endif
+       code =3D OP_WRITE_ENABLE;
+       return spi_write_then_read(info->spi, &code, 1, &dummy, 0);
+}
+
+static int mt29f_eraseblock(struct mt29f_info *info)
+{
+       int tmp;
+       uint8_t dummy;
+       uint8_t code[4];
+       int i =3D 0;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_ERASE2\n");
+       printk(KERN_NOTICE DRV_NAME " mt29f_eraseblock. pageoffset %04x
\n", =

+info->pageoffset);
+       #endif
+
+       tmp =3D mt29f_write_enable(info);
+       if (tmp < 0)
+               return tmp;
+
+       uint32_t aux =3D info->pageoffset /*<< 2*/;
+       =

+       code[0] =3D OP_BLOCK_ERASE;
+       code[1] =3D (aux >> 16) & 0xff;
+       code[2] =3D (aux >> 8) & 0xff;
+       code[3] =3D aux & 0xff;
+       //printk(KERN_NOTICE DRV_NAME " MAC %02x %02x %02x\n", code[1],
code[2], code[3]);
+       tmp =3D spi_write_then_read(info->spi, code, 4, &dummy, 0);
+       if (tmp < 0)
+               return tmp;
+       =

+       for (i =3D 0; i < 1000; i++) {
+               if (mt29f_get_features(info->spi, REG_FEATURE_STATUS,
&dummy) < 0)
+                       return -1;
+               if (!(dummy & 0x01))
+                       break;
+       }
+       info->useauxbyte =3D 0;
+       if (i =3D=3D 1000) {
+               #ifdef DEBUG_MT29F
+               printk(KERN_NOTICE DRV_NAME " not read in 1000 cycles
\n");
+               #endif
+               return -1;
+       }
+       return 0;
+}
+
+static int mt29f_readstart(struct mt29f_info *info)
+{
+       int tmp;
+       uint8_t dummy;
+       uint8_t code[4];
+       int i =3D 0;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_READSTART\n");
+       printk(KERN_NOTICE DRV_NAME " mt29f_readstart. pageoffset %04x.
\
+byteoffset %04x\n", info->pageoffset, info->byteoffset);
+       #endif
+       code[0] =3D OP_PAGE_READ;
+       code[1] =3D 0x00;
+       code[2] =3D info->pageoffset >> 8;
+       code[3] =3D info->pageoffset & 0xff;
+       tmp =3D spi_write_then_read(info->spi, code, 4, &dummy, 0);
+       if (tmp < 0)
+               return tmp;
+       =

+       for (i =3D 0; i < 1000; i++) {
+               if (mt29f_get_features(info->spi, REG_FEATURE_STATUS,
&dummy) < 0)
+                       return -1;
+               if (!(dummy & 0x01))
+                       break;
+       }
+       info->useauxbyte =3D 0;
+       if (i =3D=3D 1000) {
+               #ifdef DEBUG_MT29F
+               printk(KERN_NOTICE DRV_NAME " not read in 1000 cycles
\n");
+               #endif
+               return -1;
+       }
+       return 0;
+}
+
+static int mt29f_disable_hwecc(struct mt29f_info *info)
+{
+       uint8_t val;
+       int tmp;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_disable_hwecc\n");
+       #endif
+       tmp =3D mt29f_get_features(info->spi, REG_FEATURE_OTP, &val);
+       if (tmp < 0)
+               return tmp;
+
+       return mt29f_set_features(info->spi, REG_FEATURE_OTP, val &
0xef);
+}
+
+static int mt29f_unlockall(struct mt29f_info *info)
+{
+       uint8_t val;
+       int tmp;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_unlockall\n");
+       #endif
+       tmp =3D mt29f_get_features(info->spi, REG_FEATURE_BLOCKLOCK,
&val);
+       if (tmp < 0)
+               return tmp;
+
+       return mt29f_set_features(info->spi, REG_FEATURE_BLOCKLOCK, 0);
+}
+
+static int mt29f_program_load(struct mt29f_info *info)
+{
+       int tmp;
+       uint8_t dummy;
+       uint8_t code[3];
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_program_load\n");
+       #endif
+       code[0] =3D OP_PROGRAM_LOAD;
+       code[1] =3D 0x00;
+       code[2] =3D 0x00;
+       tmp =3D spi_write_then_read(info->spi, code, 3, &dummy, 0);
+       if (tmp < 0) {
+               printk(KERN_ERR DRV_NAME "%s: error %d reading JEDEC ID
\n", =

+                       info->spi->dev.bus_id, tmp);
+               return -1;
+       }
+       return 0;
+}
+
+static int mt29f_program_execute(struct mt29f_info *info)
+{
+       uint8_t dummy;
+       uint8_t code[4];
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " NAND_CMD_PAGEPROG\n");
+       #endif
+       code[0] =3D OP_PROGRAM_EXECUTE;
+       code[1] =3D 0x00;
+       code[2] =3D info->pageoffset >> 8;
+       code[3] =3D info->pageoffset & 0xff;
+       return spi_write_then_read(info->spi, code, 4, &dummy, 0);
+}
+
+static int mt29f_nand_calculate_ecc(struct mtd_info *mtd,
+               const u_char *dat, u_char *ecc_code)
+{
+       return 0;
+}
+
+static int mt29f_nand_correct_data(struct mtd_info *mtd, u_char *dat,
+                                       u_char *read_ecc, u_char
*calc_ecc)
+{
+       return 0;
+}
+
+static void mt29f_nand_enable_hwecc(struct mtd_info *mtd, int mode)
+{
+       return;
+}
+
+static void mt29f_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+       struct mt29f_info *info =3D mtd_to_mt29f_info(mtd);
+       int status;
+       uint8_t code[4];
+       code[0] =3D OP_READ_FROM_CACHE1;
+       code[1] =3D info->byteoffset >> 8;
+       code[2] =3D info->byteoffset & 0xff;
+       code[3] =3D 0x00;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_read_buf %04x\n", len);
+       #endif
+
+       spi_message_init(&info->message);
+       memset(info->x, 0, sizeof info->x);
+       info->x[0].len =3D 4;
+       spi_message_add_tail(&info->x[0], &info->message);
+       info->x[1].len =3D len;
+       spi_message_add_tail(&info->x[1], &info->message);
+
+       info->x[0].tx_buf =3D code;
+       info->x[1].rx_buf =3D buf;
+
+       /* do the i/o */
+       status =3D spi_sync(info->spi, &info->message);
+       if (status !=3D 0) {
+               #ifdef DEBUG_MT29F
+               printk(KERN_ERR DRV_NAME " mt29f_write_buf error\n");
+               #endif
+       }
+
+       return;
+}
+
+static void mt29f_write_buf(struct mtd_info *mtd,
+                               const uint8_t *buf, int len)
+{
+       int status;
+       uint8_t code[3];
+       code[0] =3D OP_PROGRAM_LOAD;
+       code[1] =3D 0x00;
+       code[2] =3D 0x00;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_write_buf %04x\n", len);
+       #endif
+       if (len =3D=3D 0x40)
+               return;
+
+       struct mt29f_info *info =3D mtd_to_mt29f_info(mtd);
+
+       if (mt29f_write_enable(info) < 0)
+               return;
+
+       spi_message_init(&info->message);
+       memset(info->x, 0, sizeof info->x);
+       info->x[0].len =3D 3;
+       spi_message_add_tail(&info->x[0], &info->message);
+       info->x[1].len =3D len;
+       spi_message_add_tail(&info->x[1], &info->message);
+
+       info->x[0].tx_buf =3D code;
+       info->x[1].tx_buf =3D buf;
+
+       /* do the i/o */
+       status =3D spi_sync(info->spi, &info->message);
+       if (status !=3D 0) {
+               #ifdef DEBUG_MT29F
+               printk(KERN_ERR DRV_NAME " mt29f_write_buf error\n");
+               #endif
+       }
+       return;
+}
+
+static uint8_t mt29f_read_byte(struct mtd_info *mtd)
+{
+       int tmp;
+       uint8_t useaux =3D 0;
+       uint8_t read;
+       struct mt29f_info *info =3D mtd_to_mt29f_info(mtd);
+       if (info->useauxbyte) {
+               useaux =3D 1;
+               if (info->lastcommand =3D=3D NAND_CMD_READID) {
+                       if (info->useauxbyte =3D=3D 1) {
+                               info->useauxbyte++;
+                               read =3D 0x2c;
+                       } else {
+                               info->useauxbyte =3D 0;
+                               read =3D 0x12;
+                       }
+               } else {
+                       info->useauxbyte =3D 0;
+                       read =3D info->auxbyte;
+               }
+       } else =

+               mt29f_read_buf(mtd, &read, 1);
+       =

+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_read_byte %02x %0d %02x\n",
read,
useaux, info->lastcommand);
+       #endif
+       return read;
+}
+
+static void mt29f_hwcontrol(struct mtd_info *mtd, int cmd,
+                                  unsigned int ctrl)
+{
+       int tmp =3D 0;
+       uint8_t code;
+       struct mt29f_info *info =3D mtd_to_mt29f_info(mtd);
+
+       // ALE
+       if (ctrl & NAND_ALE) {
+               #ifdef DEBUG_MT29F
+               printk(KERN_NOTICE DRV_NAME " NAND_ALE %02x %02x %02x %d
\n", cmd,
ctrl,
+info->lastcommand, info->aleoffset);
+               #endif
+               switch (info->lastcommand) {
+                       case NAND_CMD_READID:
+                               // Do not do anything
+                               break;
+                       case NAND_CMD_READ0:
+                       case NAND_CMD_SEQIN:
+                               if (info->aleoffset =3D=3D 0) {
+                                       info->byteoffset =3D cmd;
+                               } else if (info->aleoffset =3D=3D 2) {
+                                       info->pageoffset =3D cmd;
+                               }
+                               info->aleoffset++;
+                               break;
+                       case NAND_CMD_ERASE1:
+                               if (info->aleoffset =3D=3D 0)
+                                       info->pageoffset =3D cmd;
+                               info->aleoffset++;
+                       default:
+                               break;
+               }
+               return;
+       }
+       // NAND_CMD_NONE produces strange effects as it appears "inside"
+       // other commands
+       if (cmd =3D=3D NAND_CMD_NONE) {
+               tmp =3D mt29f_none(info);
+               mt29f_error(info, tmp, cmd);
+               return;
+       }
+
+       info->auxbyte =3D 0;
+       info->useauxbyte =3D 0;
+       info->aleoffset =3D 0;
+       // CLE
+       switch (cmd) {
+               case NAND_CMD_READID:
+                       #ifdef DEBUG_MT29F
+                       printk(KERN_NOTICE DRV_NAME " NAND_CMD_READID
\n");
+                       #endif
+                       info->useauxbyte =3D 1;
+                       // One detected, we unlock all blocks
+                       mt29f_unlockall(info);
+                       //mt29f_disable_hwecc(info);
+                       break;
+               case NAND_CMD_RESET:
+                       tmp =3D mt29f_reset(info);
+                       udelay(1000);
+                       break;
+               case NAND_CMD_NONE:
+                       tmp =3D mt29f_none(info);
+                       break;
+               case NAND_CMD_READ0:
+                       tmp =3D mt29f_read0(info);
+                       break;
+               case NAND_CMD_READSTART:
+                       tmp =3D mt29f_readstart(info);
+                       break;
+               case NAND_CMD_STATUS:
+                       tmp =3D mt29f_read_status(info);
+                       // We should adapt the status bits to the NAND
standard.
+                       /*info->auxbuffer[info->auxbufferwpos] =3D tmp;
+                       info->auxbufferwpos =3D (info->auxbufferwpos + 1)
& AUXBUFFERMASK;
+                       tmp =3D 0;*/
+                       break;
+               case NAND_CMD_SEQIN:
+                       /* Directly done in write_buf */
+                       break;
+               case NAND_CMD_ERASE1:
+                       /* Just store page */
+                       break;
+               case NAND_CMD_ERASE2:
+                       tmp =3D mt29f_eraseblock(info);
+                       break;
+               case NAND_CMD_PAGEPROG:
+                       tmp =3D mt29f_program_execute(info);
+                       break;
+               default:
+                       #ifdef DEBUG_MT29F
+                       printk(KERN_NOTICE DRV_NAME " Unknown command %
02x, control %02x
\n", =

+cmd, ctrl);
+                       #endif
+                       break;
+       }
+       mt29f_error(info, tmp, cmd);
+       info->lastcommand =3D cmd;
+}
+
+// The nand_wait from nand_base.c does a read_byte after dev_ready that
+// does not suit us.
+static int mt29f_nand_wait(struct mtd_info *mtd, struct nand_chip
*chip)
+{
+       unsigned long timeo =3D jiffies;
+       int status, state =3D chip->state;
+
+       if (state =3D=3D FL_ERASING)
+               timeo +=3D (HZ * 400) / 1000;
+       else
+               timeo +=3D (HZ * 20) / 1000;
+
+       /* Apply this short delay always to ensure that we do wait tWB
in
+        * any case on any machine. */
+       ndelay(100);
+
+       if ((state =3D=3D FL_ERASING) && (chip->options & NAND_IS_AND))
+               chip->cmdfunc(mtd, NAND_CMD_STATUS_MULTI, -1, -1);
+       else
+               chip->cmdfunc(mtd, NAND_CMD_STATUS, -1, -1);
+
+       while (time_before(jiffies, timeo)) {
+               status =3D chip->dev_ready(mtd);
+               if (status)
+                       break;
+               cond_resched();
+       }
+
+       return status;
+}
+
+static int mt29f_devready(struct mtd_info *mtd)
+{
+       uint8_t val;
+       #ifdef DEBUG_MT29F
+       printk(KERN_NOTICE DRV_NAME " mt29f_devready\n");
+       #endif
+       struct mt29f_info *info =3D mtd_to_mt29f_info(mtd);
+
+       val =3D mt29f_read_status(info);
+       // Workaround
+       if (info->lastcommand !=3D NAND_CMD_READID)
+               info->useauxbyte =3D 0;
+       return val;
+}
+
+/* .......................................................................=
.. */
+
+/*
+ * Device management interface
+ */
+static int __devinit mt29f_add_partition(struct mt29f_info *info)
+{
+       struct mtd_info *mtd =3D &info->mtd;
+
+#ifdef CONFIG_MTD_PARTITIONS
+       struct mtd_partition *parts =3D info->platform->parts;
+       int nr =3D info->platform->nr_parts;
+
+       return add_mtd_partitions(mtd, parts, nr);
+#else
+       return add_mtd_device(mtd);
+#endif
+}
+
+static struct mt29f_flash_info __devinitdata mt29f_data [] =3D {
+
+       { "MT29F",  0x2C11, 1024, 1024*64, 2048, 0x8000000},
+};
+
+static struct mt29f_flash_info *__devinit jedec_probe(struct spi_device
*spi)
+{
+       int                     tmp;
+       uint8_t                 code =3D OP_READ_ID;
+       uint8_t                 id[3];
+       uint32_t                jedec;
+       struct mt29f_flash_info *flash_info;
+
+       /* JEDEC also defines an optional "extended device information"
+        * string for after vendor-specific data, after the three bytes
+        * we use here.  Supporting some chips might require using it.
+        *
+        * If the vendor ID isn't Micron's (0x2C), assume this call
failed.
+        */
+       tmp =3D spi_write_then_read(spi, &code, 1, id, 3);
+       if (tmp < 0) {
+               printk(KERN_ERR DRV_NAME "%s: error %d reading JEDEC ID
\n",
+                       spi->dev.bus_id, tmp);
+               return ERR_PTR(tmp);
+       }
+       /* First byte is a dummy byte */
+       if (id[1] !=3D 0x2c)
+               return NULL;
+
+       jedec =3D id[1];
+       jedec =3D jedec << 8;
+       if (id[2] =3D=3D 0x11 || id[2] =3D=3D 0x12 || id[2] =3D=3D 0x13)
+               jedec |=3D 0x11;
+
+       for (tmp =3D 0, flash_info =3D mt29f_data; tmp <
ARRAY_SIZE(mt29f_data);
+                       tmp++, flash_info++) {
+               if (flash_info->jedec_id =3D=3D jedec) {
+                       return flash_info;
+               }
+       }
+
+       dev_err(&spi->dev, "unrecognized JEDEC id %06x\n", jedec);
+       return ERR_PTR(-ENODEV);
+}
+
+/*
+ * Detect and initialize mt29f device, using JEDEC IDs on newer chips
+ * or else the ID code embedded in the status bits:
+ *
+ *   Device      Density         ID code   #Blocks #Pages  PageSize
+ *   MT29F       1Gbit   (128M)  (0x12)    1024    1024*64 2048
+ */
+static int __devinit mt29f_probe(struct spi_device *spi)
+{
+       struct mt29f_flash_info *flash_info;
+       struct flash_platform_data      *data;
+       unsigned                        i;
+       struct mt29f_info *info =3D NULL;
+       struct nand_chip *chip =3D NULL;
+
+       /* Platform data helps sort out which chip type we have, as
+        * well as how this board partitions it.  If we don't have
+        * a chip ID, try the JEDEC id commands; they'll work for most
+        * newer chips, even if we don't recognize the particular chip.
+        */
+       data =3D spi->dev.platform_data;
+       if (data && data->type) {
+               for (i =3D 0, flash_info =3D mt29f_data; i <
ARRAY_SIZE(mt29f_data);
+                       i++, flash_info++) {
+                       if (strcmp(data->type, flash_info->name) =3D=3D 0)
+                               break;
+               }
+
+               /* unrecognized chip? */
+               if (i =3D=3D ARRAY_SIZE(mt29f_data)) {
+                       printk(KERN_ERR DRV_NAME "%s: unrecognized id %s
\n",
+                                       spi->dev.bus_id, data->type);
+                       flash_info =3D NULL;
+               /* recognized; is that chip really what's there? */
+               } else if (flash_info->jedec_id) {
+                       struct mt29f_flash_info *chip =3D
jedec_probe(spi);
+
+                       if (!chip || chip !=3D flash_info) {
+                               dev_warn(&spi->dev, "found %s, expected
%s\n",
+                                       chip ? chip->name : "UNKNOWN",
+                                       flash_info->name);
+                               flash_info =3D ERR_PTR(-ENODEV);
+                       }
+               }
+       } else {
+               flash_info =3D jedec_probe(spi);
+       }
+
+       if (IS_ERR(flash_info)) {
+               return PTR_ERR(flash_info);
+       }
+
+       info =3D kzalloc(sizeof *info, GFP_KERNEL);
+       if (!info)
+               return -ENOMEM;
+
+       info->spi =3D spi;
+       info->platform =3D spi->dev.platform_data;
+
+       printk(KERN_NOTICE "%s found\n", flash_info->name);
+
+       info->auxbyte =3D 0;
+       info->useauxbyte =3D 0;
+       info->lastcommand =3D 0;
+
+       /* initialise chip data struct */
+       chip =3D &info->chip;
+
+       chip->options |=3D NAND_CACHEPRG | NAND_SKIP_BBTSCAN;
+
+       chip->read_buf   =3D mt29f_read_buf;
+       chip->write_buf  =3D mt29f_write_buf;
+       chip->read_byte  =3D mt29f_read_byte;
+       chip->cmd_ctrl   =3D mt29f_hwcontrol;
+       chip->dev_ready  =3D mt29f_devready;
+       chip->waitfunc   =3D mt29f_nand_wait;
+       chip->priv           =3D &info->mtd;
+       //chip->controller =3D &info->controller;
+       chip->chip_delay =3D 0;
+       chip->ecc.size      =3D flash_info->writesize;
+       chip->ecc.calculate =3D mt29f_nand_calculate_ecc;
+       chip->ecc.correct   =3D mt29f_nand_correct_data;
+       chip->ecc.mode      =3D NAND_ECC_HW;
+       chip->ecc.hwctl     =3D mt29f_nand_enable_hwecc;
+
+       /* initialise mtd info data struct */
+       info->mtd.priv  =3D chip;
+       info->mtd.name =3D flash_info->name;
+       info->mtd.owner =3D THIS_MODULE;
+       info->mtd.size  =3D flash_info->size;
+
+       /* scan hardware nand chip and setup mtd info data struct */
+       if (nand_scan(&info->mtd, 1)) {
+               return -1;
+       }
+
+       mt29f_add_partition(info);
+
+       return 0;
+}
+
+static int __devexit mt29f_remove(struct spi_device *spi)
+{
+/*     struct mt29f    *flash =3D dev_get_drvdata(&spi->dev);
+
+       DEBUG(MTD_DEBUG_LEVEL1, "%s: remove\n", spi->dev.bus_id);
+
+       if (flash->mtd) {
+               nand_release(flash->mtd);
+               kfree(flash->mtd);
+       }*/
+
+       return 0;
+}
+
+static struct spi_driver mt29f_driver =3D {
+       .driver =3D {
+               .name           =3D DRV_NAME,
+               .bus            =3D &spi_bus_type,
+               .owner          =3D THIS_MODULE,
+       },
+
+       .probe          =3D mt29f_probe,
+       .remove         =3D __devexit_p(mt29f_remove),
+};
+
+static int __init mt29f_init(void)
+{
+       return spi_register_driver(&mt29f_driver);
+}
+module_init(mt29f_init);
+
+static void __exit mt29f_exit(void)
+{
+       spi_unregister_driver(&mt29f_driver);
+}
+module_exit(mt29f_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Miguel =C1ngel =C1lvarez");
+MODULE_DESCRIPTION("MT29F driver");
diff -urN linux-2.6.28.6_orig/drivers/mtd/nand/nand_ids.c
linux-2.6.28.6/drivers/mtd/nand/nand_ids.c
--- linux-2.6.28.6_orig/drivers/mtd/nand/nand_ids.c     2010-03-25
14:45:48.000000000 +0100
+++ linux-2.6.28.6/drivers/mtd/nand/nand_ids.c  2010-03-25
14:48:06.000000000 +0100
@@ -84,6 +84,7 @@
        {"NAND 128MiB 3,3V 8-bit",      0xF1, 0, 128, 0, LP_OPTIONS},
        {"NAND 128MiB 1,8V 16-bit",     0xB1, 0, 128, 0, LP_OPTIONS16},
        {"NAND 128MiB 3,3V 16-bit",     0xC1, 0, 128, 0, LP_OPTIONS16},
+       {"SPI NAND 128MiB 3,3V 8-bit",  0x12, 2048, 128, 0x20000,
LP_OPTIONS},
 =

        /* 2 Gigabit */
        {"NAND 256MiB 1,8V 8-bit",      0xAA, 0, 256, 0, LP_OPTIONS},
diff -urN linux-2.6.28.6_orig/drivers/spi/spi_bfin5xx.c
linux-2.6.28.6/drivers/spi/spi_bfin5xx.c
--- linux-2.6.28.6_orig/drivers/spi/spi_bfin5xx.c       2010-03-25
14:46:07.000000000 +0100
+++ linux-2.6.28.6/drivers/spi/spi_bfin5xx.c    2010-03-29
16:20:10.000000000 +0200
@@ -48,59 +48,6 @@
 /* Value to send if no TX value is supplied */
 #define SPI_IDLE_TXVAL 0x0000
 =

-#ifdef CONFIG_XWING3
-
-int bfin_spi_multiplexer_initialized =3D 0;
-int bfin_spi_chip_select_requested =3D 0;
-
-int bfin_spi_request_multiplexer();
-int bfin_spi_release_multiplexer();
-void bfin_spi_set_multiplexer(int muxposition);
-
-int bfin_spi_request_multiplexer()
-{
-       if (bfin_spi_multiplexer_initialized)
-               return 0;
-       int gpio_sel[3] =3D { GPIO_PG11, GPIO_PG12, GPIO_PG13 };
-       int i =3D 0;
-       for (i =3D 0; i < 3; i ++) {
-               if (gpio_request(gpio_sel[i], "SPI_SEL")) {
-                       printk(KERN_ERR "Failed ro request SPI_SEL GPIO_
%d \n",
-                               gpio_sel[i]);
-                       return -ENODEV;
-               }
-               gpio_direction_output(gpio_sel[i], 0);
-       }
-       bfin_spi_multiplexer_initialized =3D 1;
-       return 0;
-}
-
-int bfin_spi_release_multiplexer()
-{
-       int gpio_sel[3] =3D { GPIO_PG11, GPIO_PG12, GPIO_PG13 };
-       int i =3D 0;
-       for (i =3D 0; i < 3; i++)
-               gpio_free(gpio_sel[i]);
-       bfin_spi_multiplexer_initialized =3D 0;
-       return 0;
-}
-
-void bfin_spi_set_multiplexer(int muxposition)
-{
-       if (bfin_spi_request_multiplexer() < 0)
-               return;
-       int gpio_sel[3] =3D { GPIO_PG11, GPIO_PG12, GPIO_PG13 };
-       int aux =3D muxposition - 1;
-
-       if (muxposition =3D=3D 0)
-               return;
-
-       gpio_set_value(gpio_sel[0], aux & 0x01);
-       gpio_set_value(gpio_sel[1], aux & 0x02);
-       gpio_set_value(gpio_sel[2], aux & 0x04);
-}      =

-#endif
-
 struct driver_data {
        /* Driver model hookup */
        struct platform_device *pdev;
@@ -191,6 +138,63 @@
 DEFINE_SPI_REG(BAUD, 0x14)
 DEFINE_SPI_REG(SHAW, 0x18)
 =

+static void bfin_spi_cs_active(struct driver_data *drv_data, struct
chip_data *chip);
+static void bfin_spi_cs_deactive(struct driver_data *drv_data, struct
chip_data *chip);
+
+
+#ifdef CONFIG_XWING3
+
+int bfin_spi_multiplexer_initialized =3D 0;
+int bfin_spi_chip_select_requested =3D 0;
+
+int bfin_spi_request_multiplexer();
+int bfin_spi_release_multiplexer();
+void bfin_spi_set_multiplexer(int muxposition);
+
+int bfin_spi_request_multiplexer()
+{
+       if (bfin_spi_multiplexer_initialized)
+               return 0;
+       int gpio_sel[3] =3D { GPIO_PG11, GPIO_PG12, GPIO_PG13 };
+       int i =3D 0;
+       for (i =3D 0; i < 3; i ++) {
+               if (gpio_request(gpio_sel[i], "SPI_SEL")) {
+                       printk(KERN_ERR "Failed ro request SPI_SEL GPIO_
%d \n",
+                               gpio_sel[i]);
+                       return -ENODEV;
+               }
+               gpio_direction_output(gpio_sel[i], 0);
+       }
+       bfin_spi_multiplexer_initialized =3D 1;
+       return 0;
+}
+
+int bfin_spi_release_multiplexer()
+{
+       int gpio_sel[3] =3D { GPIO_PG11, GPIO_PG12, GPIO_PG13 };
+       int i =3D 0;
+       for (i =3D 0; i < 3; i++)
+               gpio_free(gpio_sel[i]);
+       bfin_spi_multiplexer_initialized =3D 0;
+       return 0;
+}
+
+void bfin_spi_set_multiplexer(int muxposition)
+{
+       if (bfin_spi_request_multiplexer() < 0)
+               return;
+       int gpio_sel[3] =3D { GPIO_PG11, GPIO_PG12, GPIO_PG13 };
+       int aux =3D muxposition - 1;
+
+       if (muxposition =3D=3D 0)
+               return;
+
+       gpio_set_value(gpio_sel[0], aux & 0x01);
+       gpio_set_value(gpio_sel[1], aux & 0x02);
+       gpio_set_value(gpio_sel[2], aux & 0x04);
+}      =

+#endif
+
 static void bfin_spi_enable(struct driver_data *drv_data)
 {
        u16 cr; =

 =

----------------------------------------- PLEASE NOTE ---------------------=
----------------------
This message, along with any attachments, may be confidential or legally pr=
ivileged. =

It is intended only for the named person(s), who is/are the only authorized=
 recipients.
If this message has reached you in error, kindly destroy it without review =
and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses con=
tained in any attachment.
 =

------------------------------------ ROGAMOS LEA ESTE TEXTO ---------------=
----------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o co=
n derecho legal. =

Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas como=
 =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin rev=
isarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. Gracias p=
or su colaboraci=F3n.  =

ZIV utiliza software antivirus, pero no se hace responsable de los virus co=
ntenidos en los ficheros anexos.

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
