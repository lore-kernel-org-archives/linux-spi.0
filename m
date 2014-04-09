From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 8/9] mtd: st_spi_fsm: replace FLACH_CMD_* with SPINOR_OP_*
Date: Wed,  9 Apr 2014 10:32:53 -0700
Message-ID: <1397064774-31784-8-git-send-email-computersforpeace@gmail.com>
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

Begin to unify the differences between serial_flash_cmds.h and
spi-nor.h.

Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mtd/devices/serial_flash_cmds.h |  62 +++++++++---------
 drivers/mtd/devices/st_spi_fsm.c        | 112 ++++++++++++++++----------------
 2 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/mtd/devices/serial_flash_cmds.h b/drivers/mtd/devices/serial_flash_cmds.h
index 4f0c2c7c898e..82fa1687a2d3 100644
--- a/drivers/mtd/devices/serial_flash_cmds.h
+++ b/drivers/mtd/devices/serial_flash_cmds.h
@@ -13,43 +13,43 @@
 #define _MTD_SERIAL_FLASH_CMDS_H
 
 /* Generic Flash Commands/OPCODEs */
-#define FLASH_CMD_WREN		0x06
-#define FLASH_CMD_WRDI		0x04
-#define FLASH_CMD_RDID		0x9f
-#define FLASH_CMD_RDSR		0x05
-#define FLASH_CMD_RDSR2		0x35
-#define FLASH_CMD_WRSR		0x01
-#define FLASH_CMD_SE_4K		0x20
-#define FLASH_CMD_SE_32K	0x52
-#define FLASH_CMD_SE		0xd8
-#define FLASH_CMD_CHIPERASE	0xc7
-#define FLASH_CMD_WRVCR		0x81
-#define FLASH_CMD_RDVCR		0x85
+#define SPINOR_OP_WREN		0x06
+#define SPINOR_OP_WRDI		0x04
+#define SPINOR_OP_RDID		0x9f
+#define SPINOR_OP_RDSR		0x05
+#define SPINOR_OP_RDSR2		0x35
+#define SPINOR_OP_WRSR		0x01
+#define SPINOR_OP_SE_4K		0x20
+#define SPINOR_OP_SE_32K	0x52
+#define SPINOR_OP_SE		0xd8
+#define SPINOR_OP_CHIPERASE	0xc7
+#define SPINOR_OP_WRVCR		0x81
+#define SPINOR_OP_RDVCR		0x85
 
 /* JEDEC Standard - Serial Flash Discoverable Parmeters (SFDP) Commands */
-#define FLASH_CMD_READ		0x03	/* READ */
-#define FLASH_CMD_READ_FAST	0x0b	/* FAST READ */
-#define FLASH_CMD_READ_1_1_2	0x3b	/* DUAL OUTPUT READ */
-#define FLASH_CMD_READ_1_2_2	0xbb	/* DUAL I/O READ */
-#define FLASH_CMD_READ_1_1_4	0x6b	/* QUAD OUTPUT READ */
-#define FLASH_CMD_READ_1_4_4	0xeb	/* QUAD I/O READ */
+#define SPINOR_OP_READ		0x03	/* READ */
+#define SPINOR_OP_READ_FAST	0x0b	/* FAST READ */
+#define SPINOR_OP_READ_1_1_2	0x3b	/* DUAL OUTPUT READ */
+#define SPINOR_OP_READ_1_2_2	0xbb	/* DUAL I/O READ */
+#define SPINOR_OP_READ_1_1_4	0x6b	/* QUAD OUTPUT READ */
+#define SPINOR_OP_READ_1_4_4	0xeb	/* QUAD I/O READ */
 
-#define FLASH_CMD_WRITE		0x02	/* PAGE PROGRAM */
-#define FLASH_CMD_WRITE_1_1_2	0xa2	/* DUAL INPUT PROGRAM */
-#define FLASH_CMD_WRITE_1_2_2	0xd2	/* DUAL INPUT EXT PROGRAM */
-#define FLASH_CMD_WRITE_1_1_4	0x32	/* QUAD INPUT PROGRAM */
-#define FLASH_CMD_WRITE_1_4_4	0x12	/* QUAD INPUT EXT PROGRAM */
+#define SPINOR_OP_WRITE		0x02	/* PAGE PROGRAM */
+#define SPINOR_OP_WRITE_1_1_2	0xa2	/* DUAL INPUT PROGRAM */
+#define SPINOR_OP_WRITE_1_2_2	0xd2	/* DUAL INPUT EXT PROGRAM */
+#define SPINOR_OP_WRITE_1_1_4	0x32	/* QUAD INPUT PROGRAM */
+#define SPINOR_OP_WRITE_1_4_4	0x12	/* QUAD INPUT EXT PROGRAM */
 
-#define FLASH_CMD_EN4B_ADDR	0xb7	/* Enter 4-byte address mode */
-#define FLASH_CMD_EX4B_ADDR	0xe9	/* Exit 4-byte address mode */
+#define SPINOR_OP_EN4B_ADDR	0xb7	/* Enter 4-byte address mode */
+#define SPINOR_OP_EX4B_ADDR	0xe9	/* Exit 4-byte address mode */
 
 /* READ commands with 32-bit addressing */
-#define FLASH_CMD_READ4		0x13
-#define FLASH_CMD_READ4_FAST	0x0c
-#define FLASH_CMD_READ4_1_1_2	0x3c
-#define FLASH_CMD_READ4_1_2_2	0xbc
-#define FLASH_CMD_READ4_1_1_4	0x6c
-#define FLASH_CMD_READ4_1_4_4	0xec
+#define SPINOR_OP_READ4		0x13
+#define SPINOR_OP_READ4_FAST	0x0c
+#define SPINOR_OP_READ4_1_1_2	0x3c
+#define SPINOR_OP_READ4_1_2_2	0xbc
+#define SPINOR_OP_READ4_1_1_4	0x6c
+#define SPINOR_OP_READ4_1_4_4	0xec
 
 /* Configuration flags */
 #define FLASH_FLAG_SINGLE	0x000000ff
diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 122a8a14ef84..fc193a94307d 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -208,7 +208,7 @@
 #define S25FL_CMD_DYBWR                0xe1
 #define S25FL_CMD_DYBRD                0xe0
 #define S25FL_CMD_WRITE4       0x12    /* Note, opcode clashes with
-					* 'FLASH_CMD_WRITE_1_4_4'
+					* 'SPINOR_OP_WRITE_1_4_4'
 					* as found on N25Qxxx devices! */
 
 /* Status register */
@@ -296,7 +296,7 @@ struct flash_info {
 	u32             jedec_id;
 	u16             ext_id;
 	/*
-	 * The size listed here is what works with FLASH_CMD_SE, which isn't
+	 * The size listed here is what works with SPINOR_OP_SE, which isn't
 	 * necessarily called a "sector" by the vendor.
 	 */
 	unsigned        sector_size;
@@ -451,22 +451,22 @@ static struct flash_info flash_types[] = {
 
 /* Default READ configurations, in order of preference */
 static struct seq_rw_config default_read_configs[] = {
-	{FLASH_FLAG_READ_1_4_4, FLASH_CMD_READ_1_4_4,	0, 4, 4, 0x00, 2, 4},
-	{FLASH_FLAG_READ_1_1_4, FLASH_CMD_READ_1_1_4,	0, 1, 4, 0x00, 4, 0},
-	{FLASH_FLAG_READ_1_2_2, FLASH_CMD_READ_1_2_2,	0, 2, 2, 0x00, 4, 0},
-	{FLASH_FLAG_READ_1_1_2, FLASH_CMD_READ_1_1_2,	0, 1, 2, 0x00, 0, 8},
-	{FLASH_FLAG_READ_FAST,	FLASH_CMD_READ_FAST,	0, 1, 1, 0x00, 0, 8},
-	{FLASH_FLAG_READ_WRITE, FLASH_CMD_READ,		0, 1, 1, 0x00, 0, 0},
+	{FLASH_FLAG_READ_1_4_4, SPINOR_OP_READ_1_4_4,	0, 4, 4, 0x00, 2, 4},
+	{FLASH_FLAG_READ_1_1_4, SPINOR_OP_READ_1_1_4,	0, 1, 4, 0x00, 4, 0},
+	{FLASH_FLAG_READ_1_2_2, SPINOR_OP_READ_1_2_2,	0, 2, 2, 0x00, 4, 0},
+	{FLASH_FLAG_READ_1_1_2, SPINOR_OP_READ_1_1_2,	0, 1, 2, 0x00, 0, 8},
+	{FLASH_FLAG_READ_FAST,	SPINOR_OP_READ_FAST,	0, 1, 1, 0x00, 0, 8},
+	{FLASH_FLAG_READ_WRITE, SPINOR_OP_READ,		0, 1, 1, 0x00, 0, 0},
 	{0x00,			0,			0, 0, 0, 0x00, 0, 0},
 };
 
 /* Default WRITE configurations */
 static struct seq_rw_config default_write_configs[] = {
-	{FLASH_FLAG_WRITE_1_4_4, FLASH_CMD_WRITE_1_4_4, 1, 4, 4, 0x00, 0, 0},
-	{FLASH_FLAG_WRITE_1_1_4, FLASH_CMD_WRITE_1_1_4, 1, 1, 4, 0x00, 0, 0},
-	{FLASH_FLAG_WRITE_1_2_2, FLASH_CMD_WRITE_1_2_2, 1, 2, 2, 0x00, 0, 0},
-	{FLASH_FLAG_WRITE_1_1_2, FLASH_CMD_WRITE_1_1_2, 1, 1, 2, 0x00, 0, 0},
-	{FLASH_FLAG_READ_WRITE,  FLASH_CMD_WRITE,       1, 1, 1, 0x00, 0, 0},
+	{FLASH_FLAG_WRITE_1_4_4, SPINOR_OP_WRITE_1_4_4, 1, 4, 4, 0x00, 0, 0},
+	{FLASH_FLAG_WRITE_1_1_4, SPINOR_OP_WRITE_1_1_4, 1, 1, 4, 0x00, 0, 0},
+	{FLASH_FLAG_WRITE_1_2_2, SPINOR_OP_WRITE_1_2_2, 1, 2, 2, 0x00, 0, 0},
+	{FLASH_FLAG_WRITE_1_1_2, SPINOR_OP_WRITE_1_1_2, 1, 1, 2, 0x00, 0, 0},
+	{FLASH_FLAG_READ_WRITE,  SPINOR_OP_WRITE,       1, 1, 1, 0x00, 0, 0},
 	{0x00,			 0,			0, 0, 0, 0x00, 0, 0},
 };
 
@@ -489,12 +489,12 @@ static struct seq_rw_config default_write_configs[] = {
  * cycles.
  */
 static struct seq_rw_config n25q_read3_configs[] = {
-	{FLASH_FLAG_READ_1_4_4, FLASH_CMD_READ_1_4_4,	0, 4, 4, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_1_4, FLASH_CMD_READ_1_1_4,	0, 1, 4, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_2_2, FLASH_CMD_READ_1_2_2,	0, 2, 2, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_1_2, FLASH_CMD_READ_1_1_2,	0, 1, 2, 0x00, 0, 8},
-	{FLASH_FLAG_READ_FAST,	FLASH_CMD_READ_FAST,	0, 1, 1, 0x00, 0, 8},
-	{FLASH_FLAG_READ_WRITE, FLASH_CMD_READ,	        0, 1, 1, 0x00, 0, 0},
+	{FLASH_FLAG_READ_1_4_4, SPINOR_OP_READ_1_4_4,	0, 4, 4, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_1_4, SPINOR_OP_READ_1_1_4,	0, 1, 4, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_2_2, SPINOR_OP_READ_1_2_2,	0, 2, 2, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_1_2, SPINOR_OP_READ_1_1_2,	0, 1, 2, 0x00, 0, 8},
+	{FLASH_FLAG_READ_FAST,	SPINOR_OP_READ_FAST,	0, 1, 1, 0x00, 0, 8},
+	{FLASH_FLAG_READ_WRITE, SPINOR_OP_READ,	        0, 1, 1, 0x00, 0, 0},
 	{0x00,			0,			0, 0, 0, 0x00, 0, 0},
 };
 
@@ -504,12 +504,12 @@ static struct seq_rw_config n25q_read3_configs[] = {
  *	- 'FAST' variants configured for 8 dummy cycles (see note above.)
  */
 static struct seq_rw_config n25q_read4_configs[] = {
-	{FLASH_FLAG_READ_1_4_4, FLASH_CMD_READ4_1_4_4,	0, 4, 4, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_1_4, FLASH_CMD_READ4_1_1_4,	0, 1, 4, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_2_2, FLASH_CMD_READ4_1_2_2,	0, 2, 2, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_1_2, FLASH_CMD_READ4_1_1_2,	0, 1, 2, 0x00, 0, 8},
-	{FLASH_FLAG_READ_FAST,	FLASH_CMD_READ4_FAST,	0, 1, 1, 0x00, 0, 8},
-	{FLASH_FLAG_READ_WRITE, FLASH_CMD_READ4,	0, 1, 1, 0x00, 0, 0},
+	{FLASH_FLAG_READ_1_4_4, SPINOR_OP_READ4_1_4_4,	0, 4, 4, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_1_4, SPINOR_OP_READ4_1_1_4,	0, 1, 4, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_2_2, SPINOR_OP_READ4_1_2_2,	0, 2, 2, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_1_2, SPINOR_OP_READ4_1_1_2,	0, 1, 2, 0x00, 0, 8},
+	{FLASH_FLAG_READ_FAST,	SPINOR_OP_READ4_FAST,	0, 1, 1, 0x00, 0, 8},
+	{FLASH_FLAG_READ_WRITE, SPINOR_OP_READ4,	0, 1, 1, 0x00, 0, 0},
 	{0x00,			0,			0, 0, 0, 0x00, 0, 0},
 };
 
@@ -522,7 +522,7 @@ static int stfsm_mx25_en_32bit_addr_seq(struct stfsm_seq *seq)
 {
 	seq->seq_opc[0] = (SEQ_OPC_PADS_1 |
 			   SEQ_OPC_CYCLES(8) |
-			   SEQ_OPC_OPCODE(FLASH_CMD_EN4B_ADDR) |
+			   SEQ_OPC_OPCODE(SPINOR_OP_EN4B_ADDR) |
 			   SEQ_OPC_CSDEASSERT);
 
 	seq->seq[0] = STFSM_INST_CMD1;
@@ -550,12 +550,12 @@ static int stfsm_mx25_en_32bit_addr_seq(struct stfsm_seq *seq)
  * entering a state that is incompatible with the SPIBoot Controller.
  */
 static struct seq_rw_config stfsm_s25fl_read4_configs[] = {
-	{FLASH_FLAG_READ_1_4_4,  FLASH_CMD_READ4_1_4_4,  0, 4, 4, 0x00, 2, 4},
-	{FLASH_FLAG_READ_1_1_4,  FLASH_CMD_READ4_1_1_4,  0, 1, 4, 0x00, 0, 8},
-	{FLASH_FLAG_READ_1_2_2,  FLASH_CMD_READ4_1_2_2,  0, 2, 2, 0x00, 4, 0},
-	{FLASH_FLAG_READ_1_1_2,  FLASH_CMD_READ4_1_1_2,  0, 1, 2, 0x00, 0, 8},
-	{FLASH_FLAG_READ_FAST,   FLASH_CMD_READ4_FAST,   0, 1, 1, 0x00, 0, 8},
-	{FLASH_FLAG_READ_WRITE,  FLASH_CMD_READ4,        0, 1, 1, 0x00, 0, 0},
+	{FLASH_FLAG_READ_1_4_4,  SPINOR_OP_READ4_1_4_4,  0, 4, 4, 0x00, 2, 4},
+	{FLASH_FLAG_READ_1_1_4,  SPINOR_OP_READ4_1_1_4,  0, 1, 4, 0x00, 0, 8},
+	{FLASH_FLAG_READ_1_2_2,  SPINOR_OP_READ4_1_2_2,  0, 2, 2, 0x00, 4, 0},
+	{FLASH_FLAG_READ_1_1_2,  SPINOR_OP_READ4_1_1_2,  0, 1, 2, 0x00, 0, 8},
+	{FLASH_FLAG_READ_FAST,   SPINOR_OP_READ4_FAST,   0, 1, 1, 0x00, 0, 8},
+	{FLASH_FLAG_READ_WRITE,  SPINOR_OP_READ4,        0, 1, 1, 0x00, 0, 0},
 	{0x00,                   0,                      0, 0, 0, 0x00, 0, 0},
 };
 
@@ -574,7 +574,7 @@ static struct stfsm_seq stfsm_seq_read_jedec = {
 	.data_size = TRANSFER_SIZE(8),
 	.seq_opc[0] = (SEQ_OPC_PADS_1 |
 		       SEQ_OPC_CYCLES(8) |
-		       SEQ_OPC_OPCODE(FLASH_CMD_RDID)),
+		       SEQ_OPC_OPCODE(SPINOR_OP_RDID)),
 	.seq = {
 		STFSM_INST_CMD1,
 		STFSM_INST_DATA_READ,
@@ -590,7 +590,7 @@ static struct stfsm_seq stfsm_seq_read_status_fifo = {
 	.data_size = TRANSFER_SIZE(4),
 	.seq_opc[0] = (SEQ_OPC_PADS_1 |
 		       SEQ_OPC_CYCLES(8) |
-		       SEQ_OPC_OPCODE(FLASH_CMD_RDSR)),
+		       SEQ_OPC_OPCODE(SPINOR_OP_RDSR)),
 	.seq = {
 		STFSM_INST_CMD1,
 		STFSM_INST_DATA_READ,
@@ -606,10 +606,10 @@ static struct stfsm_seq stfsm_seq_erase_sector = {
 	/* 'addr_cfg' configured during initialisation */
 	.seq_opc = {
 		(SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-		 SEQ_OPC_OPCODE(FLASH_CMD_WREN) | SEQ_OPC_CSDEASSERT),
+		 SEQ_OPC_OPCODE(SPINOR_OP_WREN) | SEQ_OPC_CSDEASSERT),
 
 		(SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-		 SEQ_OPC_OPCODE(FLASH_CMD_SE)),
+		 SEQ_OPC_OPCODE(SPINOR_OP_SE)),
 	},
 	.seq = {
 		STFSM_INST_CMD1,
@@ -627,10 +627,10 @@ static struct stfsm_seq stfsm_seq_erase_sector = {
 static struct stfsm_seq stfsm_seq_erase_chip = {
 	.seq_opc = {
 		(SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-		 SEQ_OPC_OPCODE(FLASH_CMD_WREN) | SEQ_OPC_CSDEASSERT),
+		 SEQ_OPC_OPCODE(SPINOR_OP_WREN) | SEQ_OPC_CSDEASSERT),
 
 		(SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-		 SEQ_OPC_OPCODE(FLASH_CMD_CHIPERASE) | SEQ_OPC_CSDEASSERT),
+		 SEQ_OPC_OPCODE(SPINOR_OP_CHIPERASE) | SEQ_OPC_CSDEASSERT),
 	},
 	.seq = {
 		STFSM_INST_CMD1,
@@ -647,9 +647,9 @@ static struct stfsm_seq stfsm_seq_erase_chip = {
 
 static struct stfsm_seq stfsm_seq_write_status = {
 	.seq_opc[0] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-		       SEQ_OPC_OPCODE(FLASH_CMD_WREN) | SEQ_OPC_CSDEASSERT),
+		       SEQ_OPC_OPCODE(SPINOR_OP_WREN) | SEQ_OPC_CSDEASSERT),
 	.seq_opc[1] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-		       SEQ_OPC_OPCODE(FLASH_CMD_WRSR)),
+		       SEQ_OPC_OPCODE(SPINOR_OP_WRSR)),
 	.seq = {
 		STFSM_INST_CMD1,
 		STFSM_INST_CMD2,
@@ -665,9 +665,9 @@ static struct stfsm_seq stfsm_seq_write_status = {
 static int stfsm_n25q_en_32bit_addr_seq(struct stfsm_seq *seq)
 {
 	seq->seq_opc[0] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-			   SEQ_OPC_OPCODE(FLASH_CMD_EN4B_ADDR));
+			   SEQ_OPC_OPCODE(SPINOR_OP_EN4B_ADDR));
 	seq->seq_opc[1] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-			   SEQ_OPC_OPCODE(FLASH_CMD_WREN) |
+			   SEQ_OPC_OPCODE(SPINOR_OP_WREN) |
 			   SEQ_OPC_CSDEASSERT);
 
 	seq->seq[0] = STFSM_INST_CMD2;
@@ -788,7 +788,7 @@ static int stfsm_write_fifo(struct stfsm *fsm, const uint32_t *buf,
 static int stfsm_enter_32bit_addr(struct stfsm *fsm, int enter)
 {
 	struct stfsm_seq *seq = &fsm->stfsm_seq_en_32bit_addr;
-	uint32_t cmd = enter ? FLASH_CMD_EN4B_ADDR : FLASH_CMD_EX4B_ADDR;
+	uint32_t cmd = enter ? SPINOR_OP_EN4B_ADDR : SPINOR_OP_EX4B_ADDR;
 
 	seq->seq_opc[0] = (SEQ_OPC_PADS_1 |
 			   SEQ_OPC_CYCLES(8) |
@@ -812,7 +812,7 @@ static uint8_t stfsm_wait_busy(struct stfsm *fsm)
 	/* Use RDRS1 */
 	seq->seq_opc[0] = (SEQ_OPC_PADS_1 |
 			   SEQ_OPC_CYCLES(8) |
-			   SEQ_OPC_OPCODE(FLASH_CMD_RDSR));
+			   SEQ_OPC_OPCODE(SPINOR_OP_RDSR));
 
 	/* Load read_status sequence */
 	stfsm_load_seq(fsm, seq);
@@ -985,7 +985,7 @@ static void stfsm_prepare_rw_seq(struct stfsm *fsm,
 	if (cfg->write)
 		seq->seq_opc[i++] = (SEQ_OPC_PADS_1 |
 				     SEQ_OPC_CYCLES(8) |
-				     SEQ_OPC_OPCODE(FLASH_CMD_WREN) |
+				     SEQ_OPC_OPCODE(SPINOR_OP_WREN) |
 				     SEQ_OPC_CSDEASSERT);
 
 	/* Address configuration (24 or 32-bit addresses) */
@@ -1121,21 +1121,21 @@ static int stfsm_mx25_config(struct stfsm *fsm)
 	}
 
 	/* Check status of 'QE' bit, update if required. */
-	stfsm_read_status(fsm, FLASH_CMD_RDSR, &sta, 1);
+	stfsm_read_status(fsm, SPINOR_OP_RDSR, &sta, 1);
 	data_pads = ((fsm->stfsm_seq_read.seq_cfg >> 16) & 0x3) + 1;
 	if (data_pads == 4) {
 		if (!(sta & MX25_STATUS_QE)) {
 			/* Set 'QE' */
 			sta |= MX25_STATUS_QE;
 
-			stfsm_write_status(fsm, FLASH_CMD_WRSR, sta, 1, 1);
+			stfsm_write_status(fsm, SPINOR_OP_WRSR, sta, 1, 1);
 		}
 	} else {
 		if (sta & MX25_STATUS_QE) {
 			/* Clear 'QE' */
 			sta &= ~MX25_STATUS_QE;
 
-			stfsm_write_status(fsm, FLASH_CMD_WRSR, sta, 1, 1);
+			stfsm_write_status(fsm, SPINOR_OP_WRSR, sta, 1, 1);
 		}
 	}
 
@@ -1260,7 +1260,7 @@ static void stfsm_s25fl_write_dyb(struct stfsm *fsm, uint32_t offs, uint8_t dby)
 {
 	struct stfsm_seq seq = {
 		.seq_opc[0] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
-			       SEQ_OPC_OPCODE(FLASH_CMD_WREN) |
+			       SEQ_OPC_OPCODE(SPINOR_OP_WREN) |
 			       SEQ_OPC_CSDEASSERT),
 		.seq_opc[1] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
 			       SEQ_OPC_OPCODE(S25FL_CMD_DYBWR)),
@@ -1300,7 +1300,7 @@ static int stfsm_s25fl_clear_status_reg(struct stfsm *fsm)
 			       SEQ_OPC_CSDEASSERT),
 		.seq_opc[1] = (SEQ_OPC_PADS_1 |
 			       SEQ_OPC_CYCLES(8) |
-			       SEQ_OPC_OPCODE(FLASH_CMD_WRDI) |
+			       SEQ_OPC_OPCODE(SPINOR_OP_WRDI) |
 			       SEQ_OPC_CSDEASSERT),
 		.seq = {
 			STFSM_INST_CMD1,
@@ -1379,7 +1379,7 @@ static int stfsm_s25fl_config(struct stfsm *fsm)
 	}
 
 	/* Check status of 'QE' bit, update if required. */
-	stfsm_read_status(fsm, FLASH_CMD_RDSR2, &cr1, 1);
+	stfsm_read_status(fsm, SPINOR_OP_RDSR2, &cr1, 1);
 	data_pads = ((fsm->stfsm_seq_read.seq_cfg >> 16) & 0x3) + 1;
 	if (data_pads == 4) {
 		if (!(cr1 & STFSM_S25FL_CONFIG_QE)) {
@@ -1397,9 +1397,9 @@ static int stfsm_s25fl_config(struct stfsm *fsm)
 		}
 	}
 	if (update_sr) {
-		stfsm_read_status(fsm, FLASH_CMD_RDSR, &sr1, 1);
+		stfsm_read_status(fsm, SPINOR_OP_RDSR, &sr1, 1);
 		sta_wr = ((uint16_t)cr1  << 8) | sr1;
-		stfsm_write_status(fsm, FLASH_CMD_WRSR, sta_wr, 2, 1);
+		stfsm_write_status(fsm, SPINOR_OP_WRSR, sta_wr, 2, 1);
 	}
 
 	/*
@@ -1424,7 +1424,7 @@ static int stfsm_w25q_config(struct stfsm *fsm)
 		return ret;
 
 	/* Check status of 'QE' bit, update if required. */
-	stfsm_read_status(fsm, FLASH_CMD_RDSR2, &sr2, 1);
+	stfsm_read_status(fsm, SPINOR_OP_RDSR2, &sr2, 1);
 	data_pads = ((fsm->stfsm_seq_read.seq_cfg >> 16) & 0x3) + 1;
 	if (data_pads == 4) {
 		if (!(sr2 & W25Q_STATUS_QE)) {
@@ -1441,9 +1441,9 @@ static int stfsm_w25q_config(struct stfsm *fsm)
 	}
 	if (update_sr) {
 		/* Write status register */
-		stfsm_read_status(fsm, FLASH_CMD_RDSR, &sr1, 1);
+		stfsm_read_status(fsm, SPINOR_OP_RDSR, &sr1, 1);
 		sr_wr = ((uint16_t)sr2 << 8) | sr1;
-		stfsm_write_status(fsm, FLASH_CMD_WRSR, sr_wr, 2, 1);
+		stfsm_write_status(fsm, SPINOR_OP_WRSR, sr_wr, 2, 1);
 	}
 
 	return 0;
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
