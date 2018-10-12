From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 06/18] mtd: spi-nor: Move m25p80 code in spi-nor.c
Date: Fri, 12 Oct 2018 10:48:13 +0200
Message-ID: <20181012084825.23697-7-boris.brezillon@bootlin.com>
References: <20181012084825.23697-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Julien Su <juliensu@mxic.com.tw>, Mark Brown <broonie@kernel.org>,
 Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
 zhengxunli@mxic.com.tw
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
 Vignesh R <vigneshr@ti.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20181012084825.23697-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The m25p80 driver is actually a generic wrapper around the spi-mem
layer. Not only the driver name is misleading, but we'd expect such a
common logic to be directly available in the core. Another reason for
moving this code is that SPI NOR controller drivers should
progressively be replaced by SPI controller drivers implementing the
spi_mem_ops interface, and when the conversion is done, we should have
a single spi-nor driver directly interfacing with the spi-mem layer.

While moving the code we also fix a longstanding issue when
non-DMA-able buffers are passed by the MTD layer.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/devices/Kconfig   |  18 --
 drivers/mtd/devices/Makefile  |   1 -
 drivers/mtd/devices/m25p80.c  | 324 ---------------------
 drivers/mtd/spi-nor/Kconfig   |   3 +-
 drivers/mtd/spi-nor/spi-nor.c | 657 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/mtd/spi-nor.h   |  10 +-
 6 files changed, 646 insertions(+), 367 deletions(-)
 delete mode 100644 drivers/mtd/devices/m25p80.c

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index e514d57a0419..93122dd011b3 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -78,24 +78,6 @@ config MTD_DATAFLASH_OTP
 	  other key product data.  The second half is programmed with a
 	  unique-to-each-chip bit pattern at the factory.
 
-config MTD_M25P80
-	tristate "Support most SPI Flash chips (AT26DF, M25P, W25X, ...)"
-	depends on SPI_MASTER && MTD_SPI_NOR
-	select SPI_MEM
-	help
-	  This enables access to most modern SPI flash chips, used for
-	  program and data storage.   Series supported include Atmel AT26DF,
-	  Spansion S25SL, SST 25VF, ST M25P, and Winbond W25X.  Other chips
-	  are supported as well.  See the driver source for the current list,
-	  or to add other chips.
-
-	  Note that the original DataFlash chips (AT45 series, not AT26DF),
-	  need an entirely different driver.
-
-	  Set up your spi devices with the right board-specific platform data,
-	  if you want to specify device partitioning or to use a device which
-	  doesn't support the JEDEC ID instruction.
-
 config MTD_MCHP23K256
 	tristate "Microchip 23K256 SRAM"
 	depends on SPI_MASTER
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index 94895eab3066..991c8d12c016 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_MTD_MTDRAM)	+= mtdram.o
 obj-$(CONFIG_MTD_LART)		+= lart.o
 obj-$(CONFIG_MTD_BLOCK2MTD)	+= block2mtd.o
 obj-$(CONFIG_MTD_DATAFLASH)	+= mtd_dataflash.o
-obj-$(CONFIG_MTD_M25P80)	+= m25p80.o
 obj-$(CONFIG_MTD_MCHP23K256)	+= mchp23k256.o
 obj-$(CONFIG_MTD_SPEAR_SMI)	+= spear_smi.o
 obj-$(CONFIG_MTD_SST25L)	+= sst25l.o
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
deleted file mode 100644
index cb14cf985b95..000000000000
--- a/drivers/mtd/devices/m25p80.c
+++ /dev/null
@@ -1,324 +0,0 @@
-/*
- * MTD SPI driver for ST M25Pxx (and similar) serial flash chips
- *
- * Author: Mike Lavender, mike@steroidmicros.com
- *
- * Copyright (c) 2005, Intec Automation Inc.
- *
- * Some parts are based on lart.c by Abraham Van Der Merwe
- *
- * Cleaned up and generalized based on mtd_dataflash.c
- *
- * This code is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/device.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-
-#include <linux/spi/spi.h>
-#include <linux/spi/spi-mem.h>
-#include <linux/spi/flash.h>
-#include <linux/mtd/spi-nor.h>
-
-struct m25p {
-	struct spi_mem		*spimem;
-	struct spi_nor		spi_nor;
-};
-
-static int m25p80_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
-{
-	struct m25p *flash = nor->priv;
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_IN(len, val, 1));
-	int ret;
-
-	ret = spi_mem_exec_op(flash->spimem, &op);
-	if (ret < 0)
-		dev_err(&flash->spimem->spi->dev, "error %d reading %x\n", ret,
-			code);
-
-	return ret;
-}
-
-static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
-{
-	struct m25p *flash = nor->priv;
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
-					  SPI_MEM_OP_NO_ADDR,
-					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_OUT(len, buf, 1));
-
-	return spi_mem_exec_op(flash->spimem, &op);
-}
-
-static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
-			    const u_char *buf)
-{
-	struct m25p *flash = nor->priv;
-	struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
-				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
-	int ret;
-
-	/* get transfer protocols. */
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
-
-	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
-		op.addr.nbytes = 0;
-
-	ret = spi_mem_adjust_op_size(flash->spimem, &op);
-	if (ret)
-		return ret;
-	op.data.nbytes = len < op.data.nbytes ? len : op.data.nbytes;
-
-	ret = spi_mem_exec_op(flash->spimem, &op);
-	if (ret)
-		return ret;
-
-	return op.data.nbytes;
-}
-
-/*
- * Read an address range from the nor chip.  The address range
- * may be any size provided it is within the physical boundaries.
- */
-static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
-			   u_char *buf)
-{
-	struct m25p *flash = nor->priv;
-	struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
-				   SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
-				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
-				   SPI_MEM_OP_DATA_IN(len, buf, 1));
-	size_t remaining = len;
-	int ret;
-
-	/* get transfer protocols. */
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	op.dummy.buswidth = op.addr.buswidth;
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
-
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.in += op.data.nbytes;
-	}
-
-	return len;
-}
-
-/*
- * board specific setup should have ensured the SPI clock used here
- * matches what the READ command supports, at least until this driver
- * understands FAST_READ (for clocks over 25 MHz).
- */
-static int m25p_probe(struct spi_mem *spimem)
-{
-	struct spi_device *spi = spimem->spi;
-	struct flash_platform_data	*data;
-	struct m25p *flash;
-	struct spi_nor *nor;
-	struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_PP,
-	};
-	char *flash_name;
-	int ret;
-
-	data = dev_get_platdata(&spimem->spi->dev);
-
-	flash = devm_kzalloc(&spimem->spi->dev, sizeof(*flash), GFP_KERNEL);
-	if (!flash)
-		return -ENOMEM;
-
-	nor = &flash->spi_nor;
-
-	/* install the hooks */
-	nor->read = m25p80_read;
-	nor->write = m25p80_write;
-	nor->write_reg = m25p80_write_reg;
-	nor->read_reg = m25p80_read_reg;
-
-	nor->dev = &spimem->spi->dev;
-	spi_nor_set_flash_node(nor, spi->dev.of_node);
-	nor->priv = flash;
-
-	spi_mem_set_drvdata(spimem, flash);
-	flash->spimem = spimem;
-
-	if (spi->mode & SPI_RX_QUAD) {
-		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
-
-		if (spi->mode & SPI_TX_QUAD)
-			hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
-					SNOR_HWCAPS_PP_1_1_4 |
-					SNOR_HWCAPS_PP_1_4_4);
-	} else if (spi->mode & SPI_RX_DUAL) {
-		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
-
-		if (spi->mode & SPI_TX_DUAL)
-			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
-	}
-
-	if (data && data->name)
-		nor->mtd.name = data->name;
-
-	if (!nor->mtd.name)
-		nor->mtd.name = spi_mem_get_name(spimem);
-
-	/* For some (historical?) reason many platforms provide two different
-	 * names in flash_platform_data: "name" and "type". Quite often name is
-	 * set to "m25p80" and then "type" provides a real chip name.
-	 * If that's the case, respect "type" and ignore a "name".
-	 */
-	if (data && data->type)
-		flash_name = data->type;
-	else if (!strcmp(spi->modalias, "spi-nor"))
-		flash_name = NULL; /* auto-detect */
-	else
-		flash_name = spi->modalias;
-
-	ret = spi_nor_scan(nor, flash_name, &hwcaps);
-	if (ret)
-		return ret;
-
-	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
-				   data ? data->nr_parts : 0);
-}
-
-
-static int m25p_remove(struct spi_mem *spimem)
-{
-	struct m25p	*flash = spi_mem_get_drvdata(spimem);
-
-	spi_nor_restore(&flash->spi_nor);
-
-	/* Clean up MTD stuff. */
-	return mtd_device_unregister(&flash->spi_nor.mtd);
-}
-
-static void m25p_shutdown(struct spi_mem *spimem)
-{
-	struct m25p *flash = spi_mem_get_drvdata(spimem);
-
-	spi_nor_restore(&flash->spi_nor);
-}
-/*
- * Do NOT add to this array without reading the following:
- *
- * Historically, many flash devices are bound to this driver by their name. But
- * since most of these flash are compatible to some extent, and their
- * differences can often be differentiated by the JEDEC read-ID command, we
- * encourage new users to add support to the spi-nor library, and simply bind
- * against a generic string here (e.g., "jedec,spi-nor").
- *
- * Many flash names are kept here in this list (as well as in spi-nor.c) to
- * keep them available as module aliases for existing platforms.
- */
-static const struct spi_device_id m25p_ids[] = {
-	/*
-	 * Allow non-DT platform devices to bind to the "spi-nor" modalias, and
-	 * hack around the fact that the SPI core does not provide uevent
-	 * matching for .of_match_table
-	 */
-	{"spi-nor"},
-
-	/*
-	 * Entries not used in DTs that should be safe to drop after replacing
-	 * them with "spi-nor" in platform data.
-	 */
-	{"s25sl064a"},	{"w25x16"},	{"m25p10"},	{"m25px64"},
-
-	/*
-	 * Entries that were used in DTs without "jedec,spi-nor" fallback and
-	 * should be kept for backward compatibility.
-	 */
-	{"at25df321a"},	{"at25df641"},	{"at26df081a"},
-	{"mx25l4005a"},	{"mx25l1606e"},	{"mx25l6405d"},	{"mx25l12805d"},
-	{"mx25l25635e"},{"mx66l51235l"},
-	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q512a"},
-	{"s25fl256s1"},	{"s25fl512s"},	{"s25sl12801"},	{"s25fl008k"},
-	{"s25fl064k"},
-	{"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
-	{"m25p40"},	{"m25p80"},	{"m25p16"},	{"m25p32"},
-	{"m25p64"},	{"m25p128"},
-	{"w25x80"},	{"w25x32"},	{"w25q32"},	{"w25q32dw"},
-	{"w25q80bl"},	{"w25q128"},	{"w25q256"},
-
-	/* Flashes that can't be detected using JEDEC */
-	{"m25p05-nonjedec"},	{"m25p10-nonjedec"},	{"m25p20-nonjedec"},
-	{"m25p40-nonjedec"},	{"m25p80-nonjedec"},	{"m25p16-nonjedec"},
-	{"m25p32-nonjedec"},	{"m25p64-nonjedec"},	{"m25p128-nonjedec"},
-
-	/* Everspin MRAMs (non-JEDEC) */
-	{ "mr25h128" }, /* 128 Kib, 40 MHz */
-	{ "mr25h256" }, /* 256 Kib, 40 MHz */
-	{ "mr25h10" },  /*   1 Mib, 40 MHz */
-	{ "mr25h40" },  /*   4 Mib, 40 MHz */
-
-	{ },
-};
-MODULE_DEVICE_TABLE(spi, m25p_ids);
-
-static const struct of_device_id m25p_of_table[] = {
-	/*
-	 * Generic compatibility for SPI NOR that can be identified by the
-	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
-	 */
-	{ .compatible = "jedec,spi-nor" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, m25p_of_table);
-
-static struct spi_mem_driver m25p80_driver = {
-	.spidrv = {
-		.driver = {
-			.name	= "m25p80",
-			.of_match_table = m25p_of_table,
-		},
-		.id_table	= m25p_ids,
-	},
-	.probe	= m25p_probe,
-	.remove	= m25p_remove,
-	.shutdown	= m25p_shutdown,
-
-	/* REVISIT: many of these chips have deep power-down modes, which
-	 * should clearly be entered on suspend() to minimize power use.
-	 * And also when they're otherwise idle...
-	 */
-};
-
-module_spi_mem_driver(m25p80_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Mike Lavender");
-MODULE_DESCRIPTION("MTD SPI driver for ST M25Pxx flash chips");
diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 6cc9c929ff57..a1b0019edafa 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -1,6 +1,7 @@
 menuconfig MTD_SPI_NOR
 	tristate "SPI-NOR device support"
-	depends on MTD
+	depends on MTD && SPI_MASTER
+	select SPI_MEM
 	help
 	  This is the framework for the SPI NOR which can be used by the SPI
 	  device drivers and the SPI-NOR device driver.
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 03c5d86ea687..d9b9dd76b987 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/math64.h>
+#include <linux/sched/task_stack.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -96,6 +97,173 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+static int spi_nor_exec_op(struct spi_nor *nor, struct spi_mem_op *op,
+			   u64 *addr, void *buf, unsigned int len)
+{
+	int ret;
+	bool usebouncebuf;
+
+	if (!op || (len && !buf))
+		return -EINVAL;
+
+	if (op->addr.nbytes && addr)
+		op->addr.val = *addr;
+
+	op->data.nbytes = len;
+
+	if (object_is_on_stack(buf) || !virt_addr_valid(buf))
+		usebouncebuf = true;
+	if (len && usebouncebuf) {
+		if (len > nor->bouncebuf_size)
+			return -ENOTSUPP;
+
+		if (op->data.dir == SPI_MEM_DATA_IN) {
+			op->data.buf.in = nor->bouncebuf;
+		} else {
+			op->data.buf.out = nor->bouncebuf;
+			memcpy(nor->bouncebuf, buf, len);
+		}
+	} else {
+		op->data.buf.out = buf;
+	}
+
+	ret = spi_mem_exec_op(nor->spimem, op);
+	if (ret)
+		return ret;
+
+	if (usebouncebuf && len && op->data.dir == SPI_MEM_DATA_IN)
+		memcpy(buf, nor->bouncebuf, len);
+
+	return 0;
+}
+
+static int spi_nor_data_op(struct spi_nor *nor, struct spi_mem_op *op,
+			   void *buf, unsigned int len)
+{
+	return spi_nor_exec_op(nor, op, NULL, buf, len);
+}
+
+static int spi_nor_nodata_op(struct spi_nor *nor, struct spi_mem_op *op)
+{
+	return spi_nor_exec_op(nor, op, NULL, NULL, 0);
+}
+
+static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,
+					size_t len, u8 *buf)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
+					  SPI_MEM_OP_ADDR(nor->addr_width, ofs,
+							  1),
+					  SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
+					  SPI_MEM_OP_DATA_IN(len, buf, 1));
+	bool usebouncebuf = false;
+	size_t remaining = len;
+	int ret;
+
+	if (object_is_on_stack(buf) || !virt_addr_valid(buf)) {
+		usebouncebuf = true;
+		op.data.buf.in = nor->bouncebuf;
+	}
+
+	/* get transfer protocols. */
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
+	op.dummy.buswidth = op.addr.buswidth;
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+
+	while (remaining) {
+		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
+		if (!usebouncebuf)
+			op.data.buf.out = buf;
+		else if (op.data.nbytes > nor->bouncebuf_size)
+			op.data.nbytes = nor->bouncebuf_size;
+
+		ret = spi_mem_adjust_op_size(nor->spimem, &op);
+		if (ret)
+			return ret;
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+		if (ret)
+			return ret;
+
+		if (usebouncebuf)
+			memcpy(buf, nor->bouncebuf, op.data.nbytes);
+
+		op.addr.val += op.data.nbytes;
+		remaining -= op.data.nbytes;
+		buf += op.data.nbytes;
+	}
+
+	return len;
+}
+
+static ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t ofs, size_t len,
+				 u8 *buf)
+{
+	if (nor->spimem)
+		return spi_nor_spimem_read_data(nor, ofs, len, buf);
+
+	return nor->read(nor, ofs, len, buf);
+}
+
+static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t ofs,
+					 size_t len, const u8 *buf)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
+					  SPI_MEM_OP_ADDR(nor->addr_width, ofs,
+							  1),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(len, NULL, 1));
+	bool usebouncebuf = false;
+	int ret;
+
+	if (object_is_on_stack(buf) || !virt_addr_valid(buf)) {
+		usebouncebuf = true;
+		op.data.buf.out = nor->bouncebuf;
+	}
+
+	/* get transfer protocols. */
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
+
+	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
+		op.addr.nbytes = 0;
+
+	op.data.nbytes = len < UINT_MAX ? len : UINT_MAX;
+
+	if (!usebouncebuf) {
+		op.data.buf.out = buf;
+	} else {
+		if (op.data.nbytes > nor->bouncebuf_size)
+			op.data.nbytes = nor->bouncebuf_size;
+
+		memcpy(nor->bouncebuf, buf, op.data.nbytes);
+	}
+
+	ret = spi_mem_adjust_op_size(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	return op.data.nbytes;
+}
+
+static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t ofs, size_t len,
+				  const u8 *buf)
+{
+	if (nor->spimem)
+		return spi_nor_spimem_write_data(nor, ofs, len, buf);
+
+	return nor->write(nor, ofs, len, buf);
+}
+
 /*
  * Read the status register, returning its value in the location
  * Return the status register value.
@@ -106,7 +274,18 @@ static int read_sr(struct spi_nor *nor)
 	int ret;
 	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+		ret = spi_nor_data_op(nor, &op, &val, 1);
+	} else {
+		ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
+	}
+
 	if (ret < 0) {
 		pr_err("error %d reading SR\n", (int) ret);
 		return ret;
@@ -125,7 +304,18 @@ static int read_fsr(struct spi_nor *nor)
 	int ret;
 	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+		ret = spi_nor_data_op(nor, &op, &val, 1);
+	} else {
+		ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
+	}
+
 	if (ret < 0) {
 		pr_err("error %d reading FSR\n", ret);
 		return ret;
@@ -144,7 +334,18 @@ static int read_cr(struct spi_nor *nor)
 	int ret;
 	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_RDCR, &val, 1);
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+		ret = spi_nor_data_op(nor, &op, &val, 1);
+	} else {
+		ret = nor->read_reg(nor, SPINOR_OP_RDCR, &val, 1);
+	}
+
 	if (ret < 0) {
 		dev_err(nor->dev, "error %d reading CR\n", ret);
 		return ret;
@@ -159,16 +360,37 @@ static int read_cr(struct spi_nor *nor)
  */
 static int write_sr(struct spi_nor *nor, u8 val)
 {
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(1, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, &val, 1);
+	}
+
 	nor->cmd_buf[0] = val;
 	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 1);
 }
 
+
 /*
  * Set write enable latch with Write Enable command.
  * Returns negative if error occurred.
  */
 static int write_enable(struct spi_nor *nor)
 {
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
 	return nor->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 }
 
@@ -177,6 +399,16 @@ static int write_enable(struct spi_nor *nor)
  */
 static int write_disable(struct spi_nor *nor)
 {
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
 	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
 
@@ -272,15 +504,41 @@ static int set_4byte(struct spi_nor *nor, bool enable)
 	 * ->set_4byte() implementation.
 	 */
 	nor->cmd_buf[0] = enable << 7;
+
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_OUT(1, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, nor->cmd_buf, 1);
+	}
+
 	return nor->write_reg(nor, SPINOR_OP_BRWR, nor->cmd_buf, 1);
 }
 
+static int xread_sr(struct spi_nor *nor, u8 *sr)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, sr, 1);
+	}
+
+	return nor->read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
+}
+
 static int s3an_sr_ready(struct spi_nor *nor)
 {
 	int ret;
 	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_XRDSR, &val, 1);
+	ret = xread_sr(nor, &val);
 	if (ret < 0) {
 		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
 		return ret;
@@ -289,6 +547,22 @@ static int s3an_sr_ready(struct spi_nor *nor)
 	return !!(val & XSR_RDY);
 }
 
+
+static int clear_sr(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
+	return nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+}
+
 static int spi_nor_sr_ready(struct spi_nor *nor)
 {
 	int sr = read_sr(nor);
@@ -301,13 +575,28 @@ static int spi_nor_sr_ready(struct spi_nor *nor)
 		else
 			dev_err(nor->dev, "Programming Error occurred\n");
 
-		nor->write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
+		clear_sr(nor);
 		return -EIO;
 	}
 
 	return !(sr & SR_WIP);
 }
 
+static int clear_fsr(struct spi_nor *nor)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
+	return nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+}
+
 static int spi_nor_fsr_ready(struct spi_nor *nor)
 {
 	int fsr = read_fsr(nor);
@@ -324,7 +613,8 @@ static int spi_nor_fsr_ready(struct spi_nor *nor)
 			dev_err(nor->dev,
 			"Attempted to modify a protected sector.\n");
 
-		nor->write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
+		clear_fsr(nor);
+
 		return -EIO;
 	}
 
@@ -392,6 +682,16 @@ static int erase_chip(struct spi_nor *nor)
 {
 	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
 
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
 	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
 }
 
@@ -454,6 +754,17 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 	if (nor->erase)
 		return nor->erase(nor, addr);
 
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(nor->erase_opcode, 1),
+					SPI_MEM_OP_ADDR(nor->addr_width, addr,
+							1),
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
 	/*
 	 * Default implementation, if driver doesn't have a specialized HW
 	 * control
@@ -1550,13 +1861,28 @@ static const struct flash_info spi_nor_ids[] = {
 	{ },
 };
 
+static int read_id(struct spi_nor *nor, u8 *id)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, id, SPI_NOR_MAX_ID_LEN);
+	}
+
+	return nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
+}
+
 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
 	int			tmp;
 	u8			id[SPI_NOR_MAX_ID_LEN];
 	const struct flash_info	*info;
 
-	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
+	tmp = read_id(nor, id);
 	if (tmp < 0) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
 		return ERR_PTR(tmp);
@@ -1592,7 +1918,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 		if (nor->flags & SNOR_F_S3AN_ADDR_DEFAULT)
 			addr = spi_nor_s3an_addr_convert(nor, addr);
 
-		ret = nor->read(nor, addr, len, buf);
+		ret = spi_nor_read_data(nor, addr, len, buf);
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
@@ -1637,7 +1963,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		nor->program_opcode = SPINOR_OP_BP;
 
 		/* write one byte. */
-		ret = nor->write(nor, to, 1, buf);
+		ret = spi_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
@@ -1653,7 +1979,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		nor->program_opcode = SPINOR_OP_AAI_WP;
 
 		/* write two bytes. */
-		ret = nor->write(nor, to, 2, buf + actual);
+		ret = spi_nor_write_data(nor, to, 2, buf + actual);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 2, "While writing 2 bytes written %i bytes\n",
@@ -1676,7 +2002,7 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 		write_enable(nor);
 
 		nor->program_opcode = SPINOR_OP_BP;
-		ret = nor->write(nor, to, 1, buf + actual);
+		ret = spi_nor_write_data(nor, to, 1, buf + actual);
 		if (ret < 0)
 			goto sst_write_err;
 		WARN(ret != 1, "While writing 1 byte written %i bytes\n",
@@ -1738,7 +2064,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			addr = spi_nor_s3an_addr_convert(nor, addr);
 
 		write_enable(nor);
-		ret = nor->write(nor, addr, page_remain, buf + i);
+		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
 		if (ret < 0)
 			goto write_err;
 		written = ret;
@@ -1767,7 +2093,18 @@ static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 
 	write_enable(nor);
 
-	ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_OUT(0, NULL, 1));
+
+		ret = spi_nor_data_op(nor, &op, sr_cr, 2);
+	} else {
+		ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
+	}
+
 	if (ret < 0) {
 		dev_err(nor->dev,
 			"error while writing configuration register\n");
@@ -1909,6 +2246,36 @@ static int spansion_read_cr_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
+static int write_sr2(struct spi_nor *nor, u8 sr2)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_OUT(0, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, &sr2, 1);
+	}
+
+	return nor->write_reg(nor, SPINOR_OP_WRSR2, &sr2, 1);
+}
+
+static int read_sr2(struct spi_nor *nor, u8 *sr2)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, sr2, 1);
+	}
+
+	return nor->read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
+}
+
 /**
  * sr2_bit7_quad_enable() - set QE bit in Status Register 2.
  * @nor:	pointer to a 'struct spi_nor'
@@ -1927,7 +2294,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	int ret;
 
 	/* Check current Quad Enable bit value. */
-	ret = nor->read_reg(nor, SPINOR_OP_RDSR2, &sr2, 1);
+	ret = read_sr2(nor, &sr2);
 	if (ret)
 		return ret;
 	if (sr2 & SR2_QUAD_EN_BIT7)
@@ -1938,7 +2305,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 
 	write_enable(nor);
 
-	ret = nor->write_reg(nor, SPINOR_OP_WRSR2, &sr2, 1);
+	ret = write_sr2(nor, sr2);
 	if (ret < 0) {
 		dev_err(nor->dev, "error while writing status register 2\n");
 		return -EINVAL;
@@ -1951,7 +2318,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 	}
 
 	/* Read back and check it. */
-	ret = nor->read_reg(nor, SPINOR_OP_RDSR2, &sr2, 1);
+	ret = read_sr2(nor, &sr2);
 	if (!(ret > 0 && (sr2 & SR2_QUAD_EN_BIT7))) {
 		dev_err(nor->dev, "SR2 Quad bit not set\n");
 		return -EINVAL;
@@ -1962,8 +2329,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 
 static int spi_nor_check(struct spi_nor *nor)
 {
-	if (!nor->dev || !nor->read || !nor->write ||
-		!nor->read_reg || !nor->write_reg) {
+	if (!nor->dev ||
+            (!nor->spimem &&
+	     (!nor->read || !nor->write || !nor->read_reg ||
+	      !nor->write_reg))) {
 		pr_err("spi-nor: please fill all the necessary fields!\n");
 		return -EINVAL;
 	}
@@ -1976,7 +2345,7 @@ static int s3an_nor_scan(const struct flash_info *info, struct spi_nor *nor)
 	int ret;
 	u8 val;
 
-	ret = nor->read_reg(nor, SPINOR_OP_XRDSR, &val, 1);
+	ret = xread_sr(nor, &val);
 	if (ret < 0) {
 		dev_err(nor->dev, "error %d reading XRDSR\n", (int) ret);
 		return ret;
@@ -2120,7 +2489,7 @@ static int spi_nor_read_raw(struct spi_nor *nor, u32 addr, size_t len, u8 *buf)
 	int ret;
 
 	while (len) {
-		ret = nor->read(nor, addr, len, buf);
+		ret = spi_nor_read_data(nor, addr, len, buf);
 		if (!ret || ret > len)
 			return -EIO;
 		if (ret < 0)
@@ -3545,6 +3914,19 @@ EXPORT_SYMBOL_GPL(spi_nor_restore);
 
 static int macronix_set_4byte(struct spi_nor *nor, bool enable)
 {
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(enable ?
+						       SPINOR_OP_EN4B :
+						       SPINOR_OP_EX4B,
+						       1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_NO_DATA);
+
+		return spi_nor_nodata_op(nor, &op);
+	}
+
 	return nor->write_reg(nor, enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B,
 			      NULL, 0);
 }
@@ -3560,6 +3942,22 @@ static int micron_set_4byte(struct spi_nor *nor, bool enable)
 	return ret;
 }
 
+static int write_ear(struct spi_nor *nor, u8 ear)
+{
+	if (nor->spimem) {
+		struct spi_mem_op op = SPI_MEM_OP(
+					SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 1),
+					SPI_MEM_OP_NO_ADDR,
+					SPI_MEM_OP_NO_DUMMY,
+					SPI_MEM_OP_DATA_OUT(0, NULL, 1));
+
+		return spi_nor_data_op(nor, &op, &ear, 1);
+	}
+
+	nor->cmd_buf[0] = ear;
+	return nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
+}
+
 static int winbond_set_4byte(struct spi_nor *nor, bool enable)
 {
 	int ret;
@@ -3575,8 +3973,7 @@ static int winbond_set_4byte(struct spi_nor *nor, bool enable)
 	 * We must clear the register to enable normal behavior.
 	 */
 	write_enable(nor);
-	nor->cmd_buf[0] = 0;
-	nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
+	write_ear(nor, 0);
 	write_disable(nor);
 
 	return ret;
@@ -3839,6 +4236,222 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 }
 EXPORT_SYMBOL_GPL(spi_nor_scan);
 
+static int spi_nor_probe(struct spi_mem *spimem)
+{
+	struct spi_device *spi = spimem->spi;
+	struct flash_platform_data *data;
+	struct spi_nor *nor;
+	struct spi_nor_hwcaps hwcaps = {
+		.mask = SNOR_HWCAPS_READ |
+			SNOR_HWCAPS_READ_FAST |
+			SNOR_HWCAPS_PP,
+	};
+	char *flash_name;
+	int ret;
+
+	data = dev_get_platdata(&spi->dev);
+
+	nor = devm_kzalloc(&spi->dev, sizeof(*nor), GFP_KERNEL);
+	if (!nor)
+		return -ENOMEM;
+
+	/*
+	 * We need the bounce buffer early to read/write registers when going
+	 * through the spi-mem layer (buffers have to be DMA-able).
+	 * We'll reallocate a new buffer if nor->page_size turns out to be
+	 * greater than PAGE_SIZE (which shouldn't happen before long since NOR
+	 * pages are usually less than 1KB) after spi_nor_scan() returns.
+	 * Note: we can't use devm_kmalloc() here because it returns an address
+	 * that is not cache-line aligned and is thus not suitable for DMA
+	 * operations.
+	 */
+	nor->bouncebuf_size = PAGE_SIZE;
+	nor->bouncebuf = kmalloc(nor->bouncebuf_size, GFP_KERNEL);
+	if (!nor->bouncebuf)
+		return -ENOMEM;
+
+	nor->spimem = spimem;
+	nor->dev = &spi->dev;
+	spi_nor_set_flash_node(nor, spi->dev.of_node);
+
+	spi_mem_set_drvdata(spimem, nor);
+
+	if (spi->mode & SPI_RX_QUAD) {
+		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
+
+		if (spi->mode & SPI_TX_QUAD)
+			hwcaps.mask |= (SNOR_HWCAPS_READ_1_4_4 |
+					SNOR_HWCAPS_PP_1_1_4 |
+					SNOR_HWCAPS_PP_1_4_4);
+	} else if (spi->mode & SPI_RX_DUAL) {
+		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_2;
+
+		if (spi->mode & SPI_TX_DUAL)
+			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
+	}
+
+	if (data && data->name)
+		nor->mtd.name = data->name;
+
+	if (!nor->mtd.name)
+		nor->mtd.name = spi_mem_get_name(spimem);
+
+	/*
+	 * For some (historical?) reason many platforms provide two different
+	 * names in flash_platform_data: "name" and "type". Quite often name is
+	 * set to "m25p80" and then "type" provides a real chip name.
+	 * If that's the case, respect "type" and ignore a "name".
+	 */
+	if (data && data->type)
+		flash_name = data->type;
+	else if (!strcmp(spi->modalias, "spi-nor"))
+		flash_name = NULL; /* auto-detect */
+	else
+		flash_name = spi->modalias;
+
+	ret = spi_nor_scan(nor, flash_name, &hwcaps);
+	if (ret)
+		goto err_free_bouncebuf;
+
+	/*
+	 * None of the existing parts have > 512B pages, but let's play safe
+	 * and add this logic so that if anyone ever adds support for such
+	 * a NOR we don't end up with buffer overflows.
+	 */
+	if (nor->page_size > PAGE_SIZE) {
+		nor->bouncebuf_size = nor->page_size;
+		kfree(nor->bouncebuf);
+		nor->bouncebuf = kmalloc(nor->bouncebuf_size, GFP_KERNEL);
+		if (!nor->bouncebuf) {
+			ret = -ENOMEM;
+			goto err_free_bouncebuf;
+		}
+	}
+
+	ret = mtd_device_register(&nor->mtd, data ? data->parts : NULL,
+				  data ? data->nr_parts : 0);
+	if (ret)
+		goto err_free_bouncebuf;
+
+	return 0;
+
+err_free_bouncebuf:
+	kfree(nor->bouncebuf);
+
+	return ret;
+}
+
+
+static int spi_nor_remove(struct spi_mem *spimem)
+{
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+	int ret;
+
+	spi_nor_restore(nor);
+
+	/* Clean up MTD stuff. */
+	ret = mtd_device_unregister(&nor->mtd);
+	if (ret)
+		return ret;
+
+	kfree(nor->bouncebuf);
+
+	return 0;
+}
+
+static void spi_nor_shutdown(struct spi_mem *spimem)
+{
+	struct spi_nor *nor = spi_mem_get_drvdata(spimem);
+
+	spi_nor_restore(nor);
+}
+
+/*
+ * Do NOT add to this array without reading the following:
+ *
+ * Historically, many flash devices are bound to this driver by their name. But
+ * since most of these flash are compatible to some extent, and their
+ * differences can often be differentiated by the JEDEC read-ID command, we
+ * encourage new users to add support to the spi-nor library, and simply bind
+ * against a generic string here (e.g., "jedec,spi-nor").
+ *
+ * Many flash names are kept here in this list (as well as in spi-nor.c) to
+ * keep them available as module aliases for existing platforms.
+ */
+static const struct spi_device_id spi_nor_dev_ids[] = {
+	/*
+	 * Allow non-DT platform devices to bind to the "spi-nor" modalias, and
+	 * hack around the fact that the SPI core does not provide uevent
+	 * matching for .of_match_table
+	 */
+	{"spi-nor"},
+
+	/*
+	 * Entries not used in DTs that should be safe to drop after replacing
+	 * them with "spi-nor" in platform data.
+	 */
+	{"s25sl064a"},	{"w25x16"},	{"m25p10"},	{"m25px64"},
+
+	/*
+	 * Entries that were used in DTs without "jedec,spi-nor" fallback and
+	 * should be kept for backward compatibility.
+	 */
+	{"at25df321a"},	{"at25df641"},	{"at26df081a"},
+	{"mx25l4005a"},	{"mx25l1606e"},	{"mx25l6405d"},	{"mx25l12805d"},
+	{"mx25l25635e"},{"mx66l51235l"},
+	{"n25q064"},	{"n25q128a11"},	{"n25q128a13"},	{"n25q512a"},
+	{"s25fl256s1"},	{"s25fl512s"},	{"s25sl12801"},	{"s25fl008k"},
+	{"s25fl064k"},
+	{"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
+	{"m25p40"},	{"m25p80"},	{"m25p16"},	{"m25p32"},
+	{"m25p64"},	{"m25p128"},
+	{"w25x80"},	{"w25x32"},	{"w25q32"},	{"w25q32dw"},
+	{"w25q80bl"},	{"w25q128"},	{"w25q256"},
+
+	/* Flashes that can't be detected using JEDEC */
+	{"m25p05-nonjedec"},	{"m25p10-nonjedec"},	{"m25p20-nonjedec"},
+	{"m25p40-nonjedec"},	{"m25p80-nonjedec"},	{"m25p16-nonjedec"},
+	{"m25p32-nonjedec"},	{"m25p64-nonjedec"},	{"m25p128-nonjedec"},
+
+	/* Everspin MRAMs (non-JEDEC) */
+	{ "mr25h128" }, /* 128 Kib, 40 MHz */
+	{ "mr25h256" }, /* 256 Kib, 40 MHz */
+	{ "mr25h10" },  /*   1 Mib, 40 MHz */
+	{ "mr25h40" },  /*   4 Mib, 40 MHz */
+
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, spi_nor_ids);
+
+static const struct of_device_id spi_nor_of_table[] = {
+	/*
+	 * Generic compatibility for SPI NOR that can be identified by the
+	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
+	*/
+	{ .compatible = "jedec,spi-nor" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, spi_nor_of_table);
+
+/*
+ * REVISIT: many of these chips have deep power-down modes, which
+ * should clearly be entered on suspend() to minimize power use.
+ * And also when they're otherwise idle...
+ */
+static struct spi_mem_driver spi_nor_driver = {
+	.spidrv = {
+		.driver = {
+			.name = "spi-nor",
+			.of_match_table = spi_nor_of_table,
+		},
+		.id_table = spi_nor_dev_ids,
+	},
+	.probe = spi_nor_probe,
+	.remove = spi_nor_remove,
+	.shutdown = spi_nor_shutdown,
+};
+module_spi_mem_driver(spi_nor_driver);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Huang Shijie <shijie8@gmail.com>");
 MODULE_AUTHOR("Mike Lavender");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 09cb85e02de1..7ab70651a0f8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -13,6 +13,7 @@
 #include <linux/bitops.h>
 #include <linux/mtd/cfi.h>
 #include <linux/mtd/mtd.h>
+#include <linux/spi/spi-mem.h>
 
 /*
  * Manufacturer IDs
@@ -337,6 +338,10 @@ struct flash_info;
  * @mtd:		point to a mtd_info structure
  * @lock:		the lock for the read/write/erase/lock/unlock operations
  * @dev:		point to a spi device, or a spi nor controller device.
+ * @spimem:		point to the spi mem device
+ * @bouncebuf:		bounce buffer used when the buffer passed by the MTD
+ *			layer is not DMA-able
+ * @bouncebuf_size:	size of the bounce buffer
  * @info:		spi-nor part JDEC MFR id and other info
  * @page_size:		the page size of the SPI NOR
  * @addr_width:		number of address bytes
@@ -353,7 +358,7 @@ struct flash_info;
  * @erase_map:		the erase map of the SPI NOR
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
- * @unprepare:		[OPTIONAL] do some post work after the
+* @unprepare:		[OPTIONAL] do some post work after the
  *			read/write/erase/lock/unlock operations
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
@@ -373,6 +378,9 @@ struct spi_nor {
 	struct mtd_info		mtd;
 	struct mutex		lock;
 	struct device		*dev;
+	struct spi_mem		*spimem;
+	void			*bouncebuf;
+	unsigned int		bouncebuf_size;
 	const struct flash_info	*info;
 	u32			page_size;
 	u8			addr_width;
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
