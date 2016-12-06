From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: [PATCH 2/2] mtd: spi-nor: add a stateless method to support memory size above 128Mib
Date: Tue, 6 Dec 2016 17:52:32 +0100
Message-ID: <97e02fd9d6328bc591f98d5ae3da98b0ad9051d2.1481041702.git.cyrille.pitchen@atmel.com>
References: <cover.1481041702.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <computersforpeace@gmail.com>,
        <boris.brezillon@free-electrons.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <broonie@kernel.org>,
        Cyrille Pitchen <cyrille.pitchen@atmel.com>
To: <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1481041702.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/mtd/spi-nor/spi-nor.c | 114 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 8abe134e174a..606c030c566d 100644
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
@@ -188,6 +192,91 @@ static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 	return mtd->priv;
 }
 
+
+struct spi_nor_address_entry {
+	u8	src_opcode;
+	u8	dst_opcode;
+};
+
+static u8 spi_nor_convert_opcode(u8 opcode,
+				 const struct spi_nor_address_entry *entries,
+				 size_t num_entries)
+{
+	int min, max;
+
+	/*
+	 * This function implements a dichotomic search in the entries[]
+	 * array indexed by src_opcode. Hence we assume that the entries[]
+	 * array is sorted by src_opcode.
+	 * The dichotomic search has a logarithmic complexity as opposed
+	 * to a simple loop on all entires, which has a linear complexity:
+	 * it means that when n is the number of entries in the input array,
+	 * the dichotomic search performs O(log2(n)) comparisons whereas
+	 * a simple loop performs O(n) comparisons.
+	 */
+	min = 0;
+	max = num_entries - 1;
+	while (min <= max) {
+		int mid = (min + max) >> 1;
+		const struct spi_nor_address_entry *entry = &entries[mid];
+
+		if (opcode == entry->src_opcode)
+			return entry->dst_opcode;
+
+		if (opcode < entry->src_opcode)
+			max = mid - 1;
+		else
+			min = mid + 1;
+	}
+
+	/* No conversion found */
+	return opcode;
+}
+
+static u8 spi_nor_3to4_opcode(u8 opcode)
+{
+	/* MUST be sorted by 3byte opcode (cf spi_nor_convert_opcode). */
+#define ENTRY_3TO4(_opcode)	{ _opcode, _opcode##_4B }
+	static const struct spi_nor_address_entry spi_nor_3to4_table[] = {
+		ENTRY_3TO4(SPINOR_OP_PP),		/* 0x02 */
+		ENTRY_3TO4(SPINOR_OP_READ),		/* 0x03 */
+		ENTRY_3TO4(SPINOR_OP_READ_FAST),	/* 0x0b */
+		ENTRY_3TO4(SPINOR_OP_BE_4K),		/* 0x20 */
+		ENTRY_3TO4(SPINOR_OP_PP_1_1_4),		/* 0x32 */
+		ENTRY_3TO4(SPINOR_OP_PP_1_4_4),		/* 0x38 */
+		ENTRY_3TO4(SPINOR_OP_READ_1_1_2),	/* 0x3b */
+		ENTRY_3TO4(SPINOR_OP_BE_32K),		/* 0x52 */
+		ENTRY_3TO4(SPINOR_OP_READ_1_1_4),	/* 0x6b */
+		ENTRY_3TO4(SPINOR_OP_READ_1_2_2),	/* 0xbb */
+		ENTRY_3TO4(SPINOR_OP_SE),		/* 0xd8 */
+		ENTRY_3TO4(SPINOR_OP_READ_1_4_4),	/* 0xeb */
+	};
+#undef ENTRY_3TO4
+
+	return spi_nor_convert_opcode(opcode, spi_nor_3to4_table,
+				      ARRAY_SIZE(spi_nor_3to4_table));
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
@@ -1486,27 +1575,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
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
