From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 13/18] mtd: spi-nor: Add 8-8-8 mode support to Macronix
 mx25uw51245g
Date: Fri, 12 Oct 2018 10:48:20 +0200
Message-ID: <20181012084825.23697-14-boris.brezillon@bootlin.com>
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

mx25uw51245g support only 1-1-1 and 8-8-8. Add the necessary hooks to
support 8-8-8 mode.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 198 +++++++++++++++++++++++++++++++++++++-----
 include/linux/mtd/spi-nor.h   |  10 +++
 2 files changed, 187 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 7660fe27d82a..9cd8677b8cb2 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -166,6 +166,26 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+static void
+spi_nor_set_read_settings(struct spi_nor_read_command *read,
+			  u8 num_mode_clocks,
+			  u8 num_wait_states,
+			  u16 opcode, u32 proto)
+{
+	read->num_mode_clocks = num_mode_clocks;
+	read->num_wait_states = num_wait_states;
+	read->opcode = opcode;
+	read->proto = proto;
+}
+
+static void
+spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
+			u16 opcode, u32 proto)
+{
+	pp->opcode = opcode;
+	pp->proto = proto;
+}
+
 static void spi_nor_adjust_op(struct spi_nor *nor, struct spi_mem_op *op)
 {
 	if (nor->adjust_op)
@@ -515,6 +535,37 @@ static int write_disable(struct spi_nor *nor)
 	return spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 }
 
+static int read_cr2(struct spi_nor *nor, u32 addr, u8 *cr2)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR2, 1),
+					  SPI_MEM_OP_ADDR(4, addr, 1),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+	if (!nor->spimem)
+		return -ENOTSUPP;
+
+	return spi_nor_data_op(nor, &op, cr2, 1);
+}
+
+static int write_cr2(struct spi_nor *nor, u32 addr, u8 cr2)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRCR2, 1),
+					  SPI_MEM_OP_ADDR(4, addr, 1),
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(0, NULL, 1));
+	int ret;
+
+	if (!nor->spimem)
+		return -ENOTSUPP;
+
+	ret = write_enable(nor);
+	if (ret)
+		return ret;
+
+	return spi_nor_data_op(nor, &op, &cr2, 1);
+}
+
 static int spi_nor_change_mode(struct spi_nor *nor, u32 newmode)
 {
 	int ret;
@@ -1626,6 +1677,125 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
+static int macronix_opi_change_mode(struct spi_nor *nor,
+				    enum spi_nor_mode newmode)
+{
+	int ret;
+	u8 val;
+
+	ret = read_cr2(nor, CR2_REG0, &val);
+	if (ret)
+		return ret;
+
+	val &= ~GENMASK(1, 0);
+
+	switch (newmode) {
+	case SPI_NOR_MODE_SPI:
+		val |= CR2_REG0_MODE_SPI;
+		break;
+
+	case SPI_NOR_MODE_OPI:
+		val |= CR2_REG0_MODE_OPI_STR;
+		break;
+
+	default:
+		/*
+		 * If we reach that point, there's a serious problem in the
+		 * hwcaps selection logic.
+		 */
+		WARN_ONCE(1, "mode %08x is not supported", newmode);
+		return -ENOTSUPP;
+	}
+
+	return write_cr2(nor, CR2_REG0, val);
+}
+
+static void macronix_opi_adjust_op(struct spi_nor *nor, struct spi_mem_op *op)
+{
+	if (nor->mode == SPI_NOR_MODE_SPI)
+		return;
+
+	switch (op->cmd.opcode) {
+	case SPINOR_OP_READ:
+	case SPINOR_OP_READ_FAST:
+	case SPINOR_OP_READ_4B:
+	case SPINOR_OP_READ_FAST_4B:
+		op->dummy.nbytes = 20;
+		op->cmd.opcode = 0xec;
+		break;
+
+	case SPINOR_OP_PP:
+		op->cmd.opcode = SPINOR_OP_PP_4B;
+		op->addr.nbytes = 4;
+		break;
+
+	case SPINOR_OP_SE:
+		op->cmd.opcode = SPINOR_OP_SE_4B;
+		op->addr.nbytes = 4;
+		break;
+
+	case SPINOR_OP_BE_4K:
+		op->cmd.opcode = SPINOR_OP_BE_4K_4B;
+		op->addr.nbytes = 4;
+		break;
+
+	case SPINOR_OP_RDSFDP:
+		op->dummy.nbytes = 20;
+		op->addr.nbytes = 4;
+		break;
+
+	case SPINOR_OP_RDCR2:
+		op->dummy.nbytes = 4;
+		break;
+
+	case SPINOR_OP_RDID:
+	case SPINOR_OP_RDSR:
+		op->dummy.nbytes = 4;
+		/* fallthrough */
+
+	case SPINOR_OP_WRSR:
+		op->addr.nbytes = 4;
+		op->addr.val = 0;
+		break;
+
+	case SPINOR_OP_RDCR:
+		op->addr.nbytes = 4;
+		op->addr.val = 1;
+		break;
+	}
+
+	/* Force buswidth to 8. */
+	op->cmd.buswidth = 8;
+
+	if (op->addr.nbytes)
+		op->addr.buswidth = 8;
+
+	if (op->dummy.nbytes)
+		op->dummy.buswidth = 8;
+
+	if (op->data.buswidth)
+		op->data.buswidth = 8;
+
+	/*
+	 * OPI mode implies 2 bytes opcodes, the first byte (MSB) being the
+	 * original opcode, and the second the reverse of the original opcode.
+	 */
+	op->cmd.nbytes = 2;
+	op->cmd.opcode = (op->cmd.opcode << 8) | ((~op->cmd.opcode) & 0xff);
+}
+
+static void macronix_opi_tweak_params(struct spi_nor *nor,
+				      struct spi_nor_flash_parameter *params)
+{
+	params->hwcaps.mask |= SNOR_HWCAPS_OPI;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8],
+				  0, 20, 0xec13,
+				  SNOR_PROTO_8_8_8 | SNOR_PROTO_INST_2BYTE);
+	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP_8_8_8],
+				0x12ed,
+				SNOR_PROTO_8_8_8 | SNOR_PROTO_INST_2BYTE);
+}
+
 /* Used when the "_ext_id" is two bytes at most */
 #define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
 		.id = {							\
@@ -1807,7 +1977,13 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "mx25u25635f", INFO(0xc22539, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_4B_OPCODES) },
 	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
-	{ "mx25uw51245g", INFO(0xc2813a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_4B_OPCODES) },
+	{
+		"mx25uw51245g",	INFO(0xc2813a, 0, 64 * 1024, 1024,
+			SECT_4K | SPI_NOR_4B_OPCODES)
+			.tweak_params = macronix_opi_tweak_params,
+			.adjust_op = macronix_opi_adjust_op,
+			.change_mode = macronix_opi_change_mode,
+	},
 	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
@@ -2503,26 +2679,6 @@ static int s3an_nor_scan(const struct flash_info *info, struct spi_nor *nor)
 	return 0;
 }
 
-static void
-spi_nor_set_read_settings(struct spi_nor_read_command *read,
-			  u8 num_mode_clocks,
-			  u8 num_wait_states,
-			  u16 opcode, u32 proto)
-{
-	read->num_mode_clocks = num_mode_clocks;
-	read->num_wait_states = num_wait_states;
-	read->opcode = opcode;
-	read->proto = proto;
-}
-
-static void
-spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
-			u16 opcode, u32 proto)
-{
-	pp->opcode = opcode;
-	pp->proto = proto;
-}
-
 /*
  * Serial Flash Discoverable Parameters (SFDP) parsing.
  */
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5b0045720049..e497f3b93a74 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -102,6 +102,9 @@
 #define XSR_PAGESIZE		BIT(0)	/* Page size in Po2 or Linear */
 #define XSR_RDY			BIT(7)	/* Ready */
 
+/* Used for Macronix flashes only. */
+#define SPINOR_OP_RDCR2		0x71	/* Read configuration register 2 */
+#define SPINOR_OP_WRCR2		0x72	/* Write configuration register 2 */
 
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
@@ -145,6 +148,13 @@
 /* Status Register 2 bits. */
 #define SR2_QUAD_EN_BIT7	BIT(7)
 
+/* Configuration register 2, offset 0 */
+#define CR2_REG0			0x0
+#define CR2_REG0_MODE_MASK	GENMASK(1, 0)
+#define CR2_REG0_MODE_SPI	0
+#define CR2_REG0_MODE_OPI_STR	1
+#define CR2_REG0_MODE_OPI_DTR	2
+
 /* Supported SPI protocols */
 #define SNOR_PROTO_INST_MASK	GENMASK(23, 16)
 #define SNOR_PROTO_INST_SHIFT	16
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
