From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 14/18] mtd: spi-nor: Clarify where DTR mode applies
Date: Fri, 12 Oct 2018 10:48:21 +0200
Message-ID: <20181012084825.23697-15-boris.brezillon@bootlin.com>
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

In its current state, '_DTR' means 'send everything except the
instruction in DTR mode'. Clarify that by renaming the macros into
_1_xD_xD so that we can later support full DTR modes (where the
instruction byte is also sent in DTR mode).

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 22 ++++++++--------
 include/linux/mtd/spi-nor.h   | 61 ++++++++++++++++++++++++++-----------------
 2 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9cd8677b8cb2..98dab7f6938e 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -58,25 +58,25 @@ struct spi_nor_pp_command {
 enum spi_nor_read_command_index {
 	SNOR_CMD_READ,
 	SNOR_CMD_READ_FAST,
-	SNOR_CMD_READ_1_1_1_DTR,
+	SNOR_CMD_READ_1_1D_1D,
 
 	/* Dual SPI */
 	SNOR_CMD_READ_1_1_2,
 	SNOR_CMD_READ_1_2_2,
 	SNOR_CMD_READ_2_2_2,
-	SNOR_CMD_READ_1_2_2_DTR,
+	SNOR_CMD_READ_1_2D_2D,
 
 	/* Quad SPI */
 	SNOR_CMD_READ_1_1_4,
 	SNOR_CMD_READ_1_4_4,
 	SNOR_CMD_READ_4_4_4,
-	SNOR_CMD_READ_1_4_4_DTR,
+	SNOR_CMD_READ_1_4D_4D,
 
 	/* Octo SPI */
 	SNOR_CMD_READ_1_1_8,
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
-	SNOR_CMD_READ_1_8_8_DTR,
+	SNOR_CMD_READ_1_8D_8D,
 
 	SNOR_CMD_READ_MAX
 };
@@ -613,9 +613,9 @@ static u8 spi_nor_convert_3to4_read(u8 opcode)
 		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
 		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
 
-		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
-		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
-		{ SPINOR_OP_READ_1_4_4_DTR,	SPINOR_OP_READ_1_4_4_DTR_4B },
+		{ SPINOR_OP_READ_1_1D_1D,	SPINOR_OP_READ_1_1D_1D_4B },
+		{ SPINOR_OP_READ_1_2D_2D,	SPINOR_OP_READ_1_2D_2D_4B },
+		{ SPINOR_OP_READ_1_4D_4D,	SPINOR_OP_READ_1_4D_4D_4B },
 	};
 
 	return spi_nor_convert_opcode(opcode, spi_nor_3to4_read,
@@ -2999,19 +2999,19 @@ static int spi_nor_hwcaps_read2cmd(u32 hwcaps)
 	static const int hwcaps_read2cmd[][2] = {
 		{ SNOR_HWCAPS_READ,		SNOR_CMD_READ },
 		{ SNOR_HWCAPS_READ_FAST,	SNOR_CMD_READ_FAST },
-		{ SNOR_HWCAPS_READ_1_1_1_DTR,	SNOR_CMD_READ_1_1_1_DTR },
+		{ SNOR_HWCAPS_READ_1_1D_1D,	SNOR_CMD_READ_1_1D_1D },
 		{ SNOR_HWCAPS_READ_1_1_2,	SNOR_CMD_READ_1_1_2 },
 		{ SNOR_HWCAPS_READ_1_2_2,	SNOR_CMD_READ_1_2_2 },
 		{ SNOR_HWCAPS_DPI,		SNOR_CMD_READ_2_2_2 },
-		{ SNOR_HWCAPS_READ_1_2_2_DTR,	SNOR_CMD_READ_1_2_2_DTR },
+		{ SNOR_HWCAPS_READ_1_2D_2D,	SNOR_CMD_READ_1_2D_2D },
 		{ SNOR_HWCAPS_READ_1_1_4,	SNOR_CMD_READ_1_1_4 },
 		{ SNOR_HWCAPS_READ_1_4_4,	SNOR_CMD_READ_1_4_4 },
 		{ SNOR_HWCAPS_QPI,		SNOR_CMD_READ_4_4_4 },
-		{ SNOR_HWCAPS_READ_1_4_4_DTR,	SNOR_CMD_READ_1_4_4_DTR },
+		{ SNOR_HWCAPS_READ_1_4D_4D,	SNOR_CMD_READ_1_4D_4D },
 		{ SNOR_HWCAPS_READ_1_1_8,	SNOR_CMD_READ_1_1_8 },
 		{ SNOR_HWCAPS_READ_1_8_8,	SNOR_CMD_READ_1_8_8 },
 		{ SNOR_HWCAPS_OPI,		SNOR_CMD_READ_8_8_8 },
-		{ SNOR_HWCAPS_READ_1_8_8_DTR,	SNOR_CMD_READ_1_8_8_DTR },
+		{ SNOR_HWCAPS_READ_1_8D_8D,	SNOR_CMD_READ_1_8D_8D },
 	};
 
 	return spi_nor_hwcaps2cmd(hwcaps, hwcaps_read2cmd,
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e497f3b93a74..1035706bc6db 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -81,13 +81,13 @@
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
 
 /* Double Transfer Rate opcodes - defined in JEDEC JESD216B. */
-#define SPINOR_OP_READ_1_1_1_DTR	0x0d
-#define SPINOR_OP_READ_1_2_2_DTR	0xbd
-#define SPINOR_OP_READ_1_4_4_DTR	0xed
+#define SPINOR_OP_READ_1_1D_1D		0x0d
+#define SPINOR_OP_READ_1_2D_2D		0xbd
+#define SPINOR_OP_READ_1_4D_4D		0xed
 
-#define SPINOR_OP_READ_1_1_1_DTR_4B	0x0e
-#define SPINOR_OP_READ_1_2_2_DTR_4B	0xbe
-#define SPINOR_OP_READ_1_4_4_DTR_4B	0xee
+#define SPINOR_OP_READ_1_1D_1D_4B	0x0e
+#define SPINOR_OP_READ_1_2D_2D_4B	0xbe
+#define SPINOR_OP_READ_1_4D_4D_4B	0xee
 
 /* Used for SST flashes only. */
 #define SPINOR_OP_BP		0x02	/* Byte program */
@@ -174,7 +174,10 @@
 	((((unsigned long)(_nbits)) << SNOR_PROTO_DATA_SHIFT) & \
 	 SNOR_PROTO_DATA_MASK)
 
-#define SNOR_PROTO_IS_DTR	BIT(24)	/* Double Transfer Rate */
+/* Double Transfer Rate flags */
+#define SNOR_PROTO_INST_IS_DTR	BIT(26)
+#define SNOR_PROTO_ADDR_IS_DTR	BIT(25)
+#define SNOR_PROTO_DATA_IS_DTR	BIT(24)
 
 #define SNOR_PROTO_INST_2BYTE	BIT(31)
 
@@ -182,9 +185,9 @@
 	(SNOR_PROTO_INST(_inst_nbits) |				\
 	 SNOR_PROTO_ADDR(_addr_nbits) |				\
 	 SNOR_PROTO_DATA(_data_nbits))
-#define SNOR_PROTO_DTR(_inst_nbits, _addr_nbits, _data_nbits)	\
-	(SNOR_PROTO_IS_DTR |					\
-	 SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits))
+#define SNOR_PROTO_1_XD_XD(_nbits)				\
+	(SNOR_PROTO_DATA_IS_DTR | SNOR_PROTO_ADDR_IS_DTR |	\
+	 SNOR_PROTO_STR(1, _nbits, _nbits))
 
 enum spi_nor_protocol {
 	SNOR_PROTO_1_1_1 = SNOR_PROTO_STR(1, 1, 1),
@@ -198,15 +201,25 @@ enum spi_nor_protocol {
 	SNOR_PROTO_4_4_4 = SNOR_PROTO_STR(4, 4, 4),
 	SNOR_PROTO_8_8_8 = SNOR_PROTO_STR(8, 8, 8),
 
-	SNOR_PROTO_1_1_1_DTR = SNOR_PROTO_DTR(1, 1, 1),
-	SNOR_PROTO_1_2_2_DTR = SNOR_PROTO_DTR(1, 2, 2),
-	SNOR_PROTO_1_4_4_DTR = SNOR_PROTO_DTR(1, 4, 4),
-	SNOR_PROTO_1_8_8_DTR = SNOR_PROTO_DTR(1, 8, 8),
+	SNOR_PROTO_1_1D_1D = SNOR_PROTO_1_XD_XD(1),
+	SNOR_PROTO_1_2D_2D = SNOR_PROTO_1_XD_XD(2),
+	SNOR_PROTO_1_4D_4D = SNOR_PROTO_1_XD_XD(4),
+	SNOR_PROTO_1_8D_8D = SNOR_PROTO_1_XD_XD(8),
 };
 
-static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
+static inline bool spi_nor_protocol_inst_is_dtr(enum spi_nor_protocol proto)
 {
-	return !!(proto & SNOR_PROTO_IS_DTR);
+	return !!(proto & SNOR_PROTO_INST_IS_DTR);
+}
+
+static inline bool spi_nor_protocol_addr_is_dtr(enum spi_nor_protocol proto)
+{
+	return !!(proto & SNOR_PROTO_ADDR_IS_DTR);
+}
+
+static inline bool spi_nor_protocol_data_is_dtr(enum spi_nor_protocol proto)
+{
+	return !!(proto & SNOR_PROTO_DATA_IS_DTR);
 }
 
 static inline u8 spi_nor_get_protocol_inst_nbits(enum spi_nor_protocol proto)
@@ -499,22 +512,22 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_READ_MASK		GENMASK(11, 0)
 #define SNOR_HWCAPS_READ		BIT(0)
 #define SNOR_HWCAPS_READ_FAST		BIT(1)
-#define SNOR_HWCAPS_READ_1_1_1_DTR	BIT(2)
+#define SNOR_HWCAPS_READ_1_1D_1D	BIT(2)
 
 #define SNOR_HWCAPS_READ_DUAL		GENMASK(5, 3)
 #define SNOR_HWCAPS_READ_1_1_2		BIT(3)
 #define SNOR_HWCAPS_READ_1_2_2		BIT(4)
-#define SNOR_HWCAPS_READ_1_2_2_DTR	BIT(5)
+#define SNOR_HWCAPS_READ_1_2D_2D	BIT(5)
 
 #define SNOR_HWCAPS_READ_QUAD		GENMASK(8, 6)
 #define SNOR_HWCAPS_READ_1_1_4		BIT(6)
 #define SNOR_HWCAPS_READ_1_4_4		BIT(7)
-#define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(8)
+#define SNOR_HWCAPS_READ_1_4D_4D	BIT(8)
 
 #define SNOR_HWCPAS_READ_OCTO		GENMASK(11, 9)
 #define SNOR_HWCAPS_READ_1_1_8		BIT(9)
 #define SNOR_HWCAPS_READ_1_8_8		BIT(10)
-#define SNOR_HWCAPS_READ_1_8_8_DTR	BIT(11)
+#define SNOR_HWCAPS_READ_1_8D_8D	BIT(11)
 
 /*
  * Page Program capabilities.
@@ -553,10 +566,10 @@ struct spi_nor_hwcaps {
 				 SNOR_HWCAPS_QPI |		\
 				 SNOR_HWCAPS_OPI)
 
-#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1_1_DTR |	\
-				 SNOR_HWCAPS_READ_1_2_2_DTR |	\
-				 SNOR_HWCAPS_READ_1_4_4_DTR |	\
-				 SNOR_HWCAPS_READ_1_8_8_DTR)
+#define SNOR_HWCAPS_DTR		(SNOR_HWCAPS_READ_1_1D_1D |	\
+				 SNOR_HWCAPS_READ_1_2D_2D |	\
+				 SNOR_HWCAPS_READ_1_4D_4D |	\
+				 SNOR_HWCAPS_READ_1_8D_8D)
 
 #define SNOR_HWCAPS_ALL		(SNOR_HWCAPS_READ_MASK |	\
 				 SNOR_HWCAPS_PP_MASK |		\
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
