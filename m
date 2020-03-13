From: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 12/12] mtd: spi-nor: add support for Cypress Semper flash
Date: Fri, 13 Mar 2020 21:16:45 +0530
Message-ID: <20200313154645.29293-13-p.yadav@ti.com>
References: <20200313154645.29293-1-p.yadav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
To: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200313154645.29293-1-p.yadav-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Cypress Semper flash is an xSPI compliant octal DTR flash. Add
support for using it in octal DTR mode.

The flash by default boots in a hybrid sector mode. But the sector map
table on the part I had was programmed incorrectly and the SMPT values
on the flash don't match the public datasheet. Specifically, in some
places erase type 3 was used instead of 4. In addition, the region sizes
were incorrect in some places. So, for testing I set CFR3N[3] to enable
uniform sector sizes. Since the uniform sector mode bit is a
non-volatile bit, this series does not change it to avoid making any
permanent changes to the flash configuration. The correct data to
implement a fixup is not available right now and will be done in a
follow-up patch if needed.

Signed-off-by: Pratyush Yadav <p.yadav-l0cyMroinI0@public.gmane.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 156 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  13 +++
 2 files changed, 169 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 32f7ecbc38d4..daaff3dc7376 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -264,6 +264,10 @@ struct flash_info {
 #define SPI_NOR_SRST_SLEEP_MIN	200
 #define SPI_NOR_SRST_SLEEP_MAX	400
 
+/* Forward declaration that will be used by s28hs512t_post_sfdp_fixup(). */
+static void spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
+				    u8 opcode, enum spi_nor_protocol proto);
+
 /**
  * spi_nor_get_cmd_ext() - Get the command opcode extension based on the
  *			   extension type.
@@ -2297,6 +2301,84 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	return ret;
 }
 
+/**
+ * spi_nor_cypress_octal_enable() - Enable octal DTR mode on Cypress flashes.
+ * @nor:		pointer to a 'struct spi_nor'
+ *
+ * This also sets the memory access latency cycles to 20, which is the default
+ * in the spi-nor framework.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_cypress_octal_enable(struct spi_nor *nor, bool enable)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	u8 addr_width;
+	int ret;
+
+	if (enable)
+		addr_width = 3;
+	else
+		addr_width = 4;
+
+	if (enable) {
+		/* Use 20 dummy cycles for memory array reads. */
+		ret = spi_nor_write_enable(nor);
+		if (ret)
+			return ret;
+
+		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20;
+		op = (struct spi_mem_op)
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
+				   SPI_MEM_OP_ADDR(addr_width,
+						   SPINOR_REG_CYPRESS_CFR2V,
+						   1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+		ret = spi_mem_exec_op(nor->spimem, &op);
+		if (ret) {
+			dev_warn(nor->dev,
+				 "failed to set default memory latency value: %d\n",
+				 ret);
+			return ret;
+		}
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			return ret;
+
+		nor->read_dummy = 20;
+	}
+
+	/* Set/unset the octal and DTR enable bits. */
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable)
+		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
+	else
+		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(addr_width,
+					   SPINOR_REG_CYPRESS_CFR5V,
+					   1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret) {
+		dev_warn(nor->dev, "Failed to enable octal DTR mode\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * spi_nor_sr1_bit6_quad_enable() - Set the Quad Enable BIT(6) in the Status
  * Register 1.
@@ -2509,6 +2591,77 @@ static struct spi_nor_fixups gd25q256_fixups = {
 	.default_init = gd25q256_default_init,
 };
 
+static void s28hs512t_default_init(struct spi_nor *nor)
+{
+	nor->params.octal_dtr_enable = spi_nor_cypress_octal_enable;
+}
+
+static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/*
+	 * On older versions of the flash the xSPI Profile 1.0 table has the
+	 * 8D-8D-8D Fast Read opcode as 0x00. But it actually should be 0xEE.
+	 */
+	if (nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].opcode == 0)
+		nor->params.reads[SNOR_CMD_READ_8_8_8_DTR].opcode =
+			SPINOR_OP_CYPRESS_RD_FAST;
+
+	/* This flash is also missing the 4-byte Page Program opcode bit. */
+	spi_nor_set_pp_settings(&nor->params.page_programs[SNOR_CMD_PP],
+				SPINOR_OP_PP_4B, SNOR_PROTO_1_1_1);
+	/*
+	 * Since xSPI Page Program opcode is backward compatible with
+	 * Legacy SPI, use Legacy SPI opcode there as well.
+	 */
+	spi_nor_set_pp_settings(&nor->params.page_programs[SNOR_CMD_PP_8_8_8_DTR],
+				SPINOR_OP_PP_4B, SNOR_PROTO_8_8_8_DTR);
+
+	/*
+	 * The xSPI Profile 1.0 table advertises the number of additional
+	 * address bytes needed for Read Status Register command as 0 but the
+	 * actual value for that is 4.
+	 */
+	nor->params.rdsr_addr_nbytes = 4;
+}
+
+static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
+				     const struct sfdp_parameter_header *bfpt_header,
+				     const struct sfdp_bfpt *bfpt,
+				     struct spi_nor_flash_parameter *params)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	u8 addr_width = 3;
+	int ret;
+
+	/*
+	 * The BFPT table advertises a 512B page size but the page size is
+	 * actually configurable (with the default being 256B). Read from
+	 * CFR3V[4] and set the correct size.
+	 */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(addr_width, SPINOR_REG_CYPRESS_CFR3V, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(1, buf, 1));
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (*buf & SPINOR_REG_CYPRESS_CFR3V_PGSZ)
+		params->page_size = 512;
+	else
+		params->page_size = 256;
+
+	return 0;
+}
+
+static struct spi_nor_fixups s28hs512t_fixups = {
+	.default_init = s28hs512t_default_init,
+	.post_sfdp = s28hs512t_post_sfdp_fixup,
+	.post_bfpt = s28hs512t_post_bfpt_fixup,
+};
+
 /* NOTE: double check command sets and memory organization when you add
  * more nor chips.  This current list focusses on newer chips, which
  * have been converging on command sets which including JEDEC ID.
@@ -2771,6 +2924,9 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "s25fl064l",  INFO(0x016017,      0,  64 * 1024, 128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "s25fl128l",  INFO(0x016018,      0,  64 * 1024, 256, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "s25fl256l",  INFO(0x016019,      0,  64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ "s28hs512t",  INFO(0x345b1a,      0, 256 * 1024, 256, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_SOFT_RESET)
+		.fixups = &s28hs512t_fixups,
+	},
 
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 13679197dec1..20337bcda207 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -154,6 +154,19 @@
 #define SR2_QUAD_EN_BIT1	BIT(1)
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/* For Cypress flash. */
+#define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
+#define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
+#define SPINOR_REG_CYPRESS_CFR2V		0x00800003
+#define SPINOR_REG_CYPRESS_CFR2V_MEMLAT_8_20	0x8
+#define SPINOR_REG_CYPRESS_CFR3V		0x00800004
+#define SPINOR_REG_CYPRESS_CFR3V_PGSZ		BIT(4) /* Page size. */
+#define SPINOR_REG_CYPRESS_CFR4V		0x00800005
+#define SPINOR_REG_CYPRESS_CFR5V		0x00800006
+#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN	0x3
+#define SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS	0
+#define SPINOR_OP_CYPRESS_RD_FAST		0xee
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
-- 
2.25.0
