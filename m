From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH v2 2/2] mtd: spi-nor: add a stateless method to support memory
 size above 128Mib
Date: Thu, 8 Dec 2016 13:41:37 +0100
Message-ID: <1362ba746fee8d8ad359d4fd67d2d6d8fd544a57.1481200454.git.cyrille.pitchen@atmel.com>
References: <cover.1481200454.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: boris.brezillon@free-electrons.com, richard@nod.at,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, broonie@kernel.org,
 linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>,
 computersforpeace@gmail.com
To: <marek.vasut@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <cover.1481200454.git.cyrille.pitchen@atmel.com>
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

This patch provides an alternative mean to support memory above 16MiB
(128Mib) by replacing 3byte address op codes by their associated 4byte
address versions.

Using the dedicated 4byte address op codes doesn't change the internal
state of the SPI NOR memory as opposed to using other means such as
updating a Base Address Register (BAR) and sending command to enter/leave
the 4byte mode.

Hence when a CPU reset occurs, early bootloaders don't need to be aware
of BAR value or 4byte mode being enabled: they can still access the first
16MiB of the SPI NOR memory using the regular 3byte address op codes.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Tested-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 78 +++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8abe134e174a..40b78ebb9900 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -75,6 +75,10 @@ struct flash_info {
 					 * bit. Must be used with
 					 * SPI_NOR_HAS_LOCK.
 					 */
+#define SPI_NOR_4B_OPCODES	BIT(10)	/*
+					 * Use dedicated 4byte address op codes
+					 * to support memory size above 128Mib.
+					 */
 };
 
 #define JEDEC_MFR(info)	((info)->id[0])
@@ -188,6 +192,55 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 	return mtd->priv;
 }
 
+
+static u8 spi_nor_3to4_opcode(u8 opcode)
+{
+#define ENTRY_3TO4(_opcode)	{ _opcode, _opcode##_4B }
+	static const u8 spi_nor_3to4_table[][2] = {
+		ENTRY_3TO4(SPINOR_OP_READ),
+		ENTRY_3TO4(SPINOR_OP_READ_FAST),
+		ENTRY_3TO4(SPINOR_OP_READ_1_1_2),
+		ENTRY_3TO4(SPINOR_OP_READ_1_2_2),
+		ENTRY_3TO4(SPINOR_OP_READ_1_1_4),
+		ENTRY_3TO4(SPINOR_OP_READ_1_4_4),
+		ENTRY_3TO4(SPINOR_OP_PP),
+		ENTRY_3TO4(SPINOR_OP_PP_1_1_4),
+		ENTRY_3TO4(SPINOR_OP_PP_1_4_4),
+		ENTRY_3TO4(SPINOR_OP_BE_4K),
+		ENTRY_3TO4(SPINOR_OP_BE_32K),
+		ENTRY_3TO4(SPINOR_OP_SE),
+	};
+#undef ENTRY_3TO4
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(spi_nor_3to4_table); ++i)
+		if (spi_nor_3to4_table[i][0] == opcode)
+			return spi_nor_3to4_table[i][1];
+
+	/* No conversion found, keep input op code. */
+	return opcode;
+}
+
+static void spi_nor_set_4byte_opcodes(struct spi_nor *nor,
+				      const struct flash_info *info)
+{
+	/* Do some manufacturer fixups first */
+	switch (JEDEC_MFR(info)) {
+	case SNOR_MFR_SPANSION:
+		/* No small sector erase for 4-byte command set */
+		nor->erase_opcode = SPINOR_OP_SE;
+		nor->mtd.erasesize = info->sector_size;
+		break;
+
+	default:
+		break;
+	}
+
+	nor->read_opcode	= spi_nor_3to4_opcode(nor->read_opcode);
+	nor->program_opcode	= spi_nor_3to4_opcode(nor->program_opcode);
+	nor->erase_opcode	= spi_nor_3to4_opcode(nor->erase_opcode);
+}
+
 /* Enable/disable 4-byte addressing mode. */
 static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
 			    int enable)
@@ -1486,27 +1539,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	else if (mtd->size > 0x1000000) {
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
-		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION) {
-			/* Dedicated 4-byte command set */
-			switch (nor->flash_read) {
-			case SPI_NOR_QUAD:
-				nor->read_opcode = SPINOR_OP_READ_1_1_4_4B;
-				break;
-			case SPI_NOR_DUAL:
-				nor->read_opcode = SPINOR_OP_READ_1_1_2_4B;
-				break;
-			case SPI_NOR_FAST:
-				nor->read_opcode = SPINOR_OP_READ_FAST_4B;
-				break;
-			case SPI_NOR_NORMAL:
-				nor->read_opcode = SPINOR_OP_READ_4B;
-				break;
-			}
-			nor->program_opcode = SPINOR_OP_PP_4B;
-			/* No small sector erase for 4-byte command set */
-			nor->erase_opcode = SPINOR_OP_SE_4B;
-			mtd->erasesize = info->sector_size;
-		} else
+		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
+		    info->flags & SPI_NOR_4B_OPCODES)
+			spi_nor_set_4byte_opcodes(nor, info);
+		else
 			set_4byte(nor, info, 1);
 	} else {
 		nor->addr_width = 3;
-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
