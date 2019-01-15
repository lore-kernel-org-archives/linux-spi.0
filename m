From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v7 1/5] mtd: spi-nor: add opcodes for octal Read/Write
 commands
Date: Tue, 15 Jan 2019 10:05:10 +0000
Message-ID: <1547546584-5254-2-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

- Add opcodes for octal I/O commands
  * Read  : 1-1-8 and 1-8-8 protocol
  * Write : 1-1-8 and 1-8-8 protocol
  * opcodes for 4-byte address mode command

- Entry of macros in _convert_3to4_xxx function

- Add flag SPI_NOR_OCTAL_READ specifying flash support octal read
  commands. This flag is required for flashes which didn't provides
  support for auto detection of Octal mode capabilities i.e. not
  seems to support newer JESD216C standard.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++++++++--
 include/linux/mtd/spi-nor.h   | 16 ++++++++++++----
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6e13bbd1aaa5..872d70722672 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -68,7 +68,7 @@ enum spi_nor_read_command_index {
 	SNOR_CMD_READ_4_4_4,
 	SNOR_CMD_READ_1_4_4_DTR,
=20
-	/* Octo SPI */
+	/* Octal SPI */
 	SNOR_CMD_READ_1_1_8,
 	SNOR_CMD_READ_1_8_8,
 	SNOR_CMD_READ_8_8_8,
@@ -85,7 +85,7 @@ enum spi_nor_pp_command_index {
 	SNOR_CMD_PP_1_4_4,
 	SNOR_CMD_PP_4_4_4,
=20
-	/* Octo SPI */
+	/* Octal SPI */
 	SNOR_CMD_PP_1_1_8,
 	SNOR_CMD_PP_1_8_8,
 	SNOR_CMD_PP_8_8_8,
@@ -278,6 +278,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
=20
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -398,6 +399,8 @@ static u8 spi_nor_convert_3to4_read(u8 opcode)
 		{ SPINOR_OP_READ_1_2_2,	SPINOR_OP_READ_1_2_2_4B },
 		{ SPINOR_OP_READ_1_1_4,	SPINOR_OP_READ_1_1_4_4B },
 		{ SPINOR_OP_READ_1_4_4,	SPINOR_OP_READ_1_4_4_4B },
+		{ SPINOR_OP_READ_1_1_8,	SPINOR_OP_READ_1_1_8_4B },
+		{ SPINOR_OP_READ_1_8_8,	SPINOR_OP_READ_1_8_8_4B },
=20
 		{ SPINOR_OP_READ_1_1_1_DTR,	SPINOR_OP_READ_1_1_1_DTR_4B },
 		{ SPINOR_OP_READ_1_2_2_DTR,	SPINOR_OP_READ_1_2_2_DTR_4B },
@@ -414,6 +417,8 @@ static u8 spi_nor_convert_3to4_program(u8 opcode)
 		{ SPINOR_OP_PP,		SPINOR_OP_PP_4B },
 		{ SPINOR_OP_PP_1_1_4,	SPINOR_OP_PP_1_1_4_4B },
 		{ SPINOR_OP_PP_1_4_4,	SPINOR_OP_PP_1_4_4_4B },
+		{ SPINOR_OP_PP_1_1_8,	SPINOR_OP_PP_1_1_8_4B },
+		{ SPINOR_OP_PP_1_8_8,	SPINOR_OP_PP_1_8_8_4B },
 	};
=20
 	return spi_nor_convert_opcode(opcode, spi_nor_3to4_program,
@@ -3591,6 +3596,13 @@ static int spi_nor_init_params(struct spi_nor *nor,
 					  SNOR_PROTO_1_1_4);
 	}
=20
+	if (info->flags & SPI_NOR_OCTAL_READ) {
+		params->hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_8;
+		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_1_1_8],
+					  0, 8, SPINOR_OP_READ_1_1_8,
+					  SNOR_PROTO_1_1_8);
+	}
+
 	/* Page Program settings. */
 	params->hwcaps.mask |=3D SNOR_HWCAPS_PP;
 	spi_nor_set_pp_settings(&params->page_programs[SNOR_CMD_PP],
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fa2d89e38e40..2353af8bac99 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -46,9 +46,13 @@
 #define SPINOR_OP_READ_1_2_2	0xbb	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4	0x6b	/* Read data bytes (Quad Output SPI) */
 #define SPINOR_OP_READ_1_4_4	0xeb	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8	0x8b	/* Read data bytes (Octal Output SPI) */
+#define SPINOR_OP_READ_1_8_8	0xcb	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP		0x02	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4	0x32	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4	0x38	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8	0x82	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8	0xc2	/* Octal page program */
 #define SPINOR_OP_BE_4K		0x20	/* Erase 4KiB block */
 #define SPINOR_OP_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
 #define SPINOR_OP_BE_32K	0x52	/* Erase 32KiB block */
@@ -69,9 +73,13 @@
 #define SPINOR_OP_READ_1_2_2_4B	0xbc	/* Read data bytes (Dual I/O SPI) */
 #define SPINOR_OP_READ_1_1_4_4B	0x6c	/* Read data bytes (Quad Output SPI) =
*/
 #define SPINOR_OP_READ_1_4_4_4B	0xec	/* Read data bytes (Quad I/O SPI) */
+#define SPINOR_OP_READ_1_1_8_4B	0x7c	/* Read data bytes (Octal Output SPI)=
 */
+#define SPINOR_OP_READ_1_8_8_4B	0xcc	/* Read data bytes (Octal I/O SPI) */
 #define SPINOR_OP_PP_4B		0x12	/* Page program (up to 256 bytes) */
 #define SPINOR_OP_PP_1_1_4_4B	0x34	/* Quad page program */
 #define SPINOR_OP_PP_1_4_4_4B	0x3e	/* Quad page program */
+#define SPINOR_OP_PP_1_1_8_4B	0x84	/* Octal page program */
+#define SPINOR_OP_PP_1_8_8_4B	0x8e	/* Octal page program */
 #define SPINOR_OP_BE_4K_4B	0x21	/* Erase 4KiB block */
 #define SPINOR_OP_BE_32K_4B	0x5c	/* Erase 32KiB block */
 #define SPINOR_OP_SE_4B		0xdc	/* Sector erase (usually 64KiB) */
@@ -458,7 +466,7 @@ struct spi_nor_hwcaps {
 /*
  *(Fast) Read capabilities.
  * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
- * As a matter of performances, it is relevant to use Octo SPI protocols f=
irst,
+ * As a matter of performances, it is relevant to use Octal SPI protocols =
first,
  * then Quad SPI protocols before Dual SPI protocols, Fast Read and lastly
  * (Slow) Read.
  */
@@ -479,7 +487,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_READ_4_4_4		BIT(9)
 #define SNOR_HWCAPS_READ_1_4_4_DTR	BIT(10)
=20
-#define SNOR_HWCPAS_READ_OCTO		GENMASK(14, 11)
+#define SNOR_HWCPAS_READ_OCTAL		GENMASK(14, 11)
 #define SNOR_HWCAPS_READ_1_1_8		BIT(11)
 #define SNOR_HWCAPS_READ_1_8_8		BIT(12)
 #define SNOR_HWCAPS_READ_8_8_8		BIT(13)
@@ -488,7 +496,7 @@ struct spi_nor_hwcaps {
 /*
  * Page Program capabilities.
  * MUST be ordered by priority: the higher bit position, the higher priori=
ty.
- * Like (Fast) Read capabilities, Octo/Quad SPI protocols are preferred to=
 the
+ * Like (Fast) Read capabilities, Octal/Quad SPI protocols are preferred t=
o the
  * legacy SPI 1-1-1 protocol.
  * Note that Dual Page Programs are not supported because there is no exis=
ting
  * JEDEC/SFDP standard to define them. Also at this moment no SPI flash me=
mory
@@ -502,7 +510,7 @@ struct spi_nor_hwcaps {
 #define SNOR_HWCAPS_PP_1_4_4	BIT(18)
 #define SNOR_HWCAPS_PP_4_4_4	BIT(19)
=20
-#define SNOR_HWCAPS_PP_OCTO	GENMASK(22, 20)
+#define SNOR_HWCAPS_PP_OCTAL	GENMASK(22, 20)
 #define SNOR_HWCAPS_PP_1_1_8	BIT(20)
 #define SNOR_HWCAPS_PP_1_8_8	BIT(21)
 #define SNOR_HWCAPS_PP_8_8_8	BIT(22)
--=20
2.17.1
