From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 11/18] mtd: spi-nor: Prepare things for 2byte opcodes
Date: Fri, 12 Oct 2018 10:48:18 +0200
Message-ID: <20181012084825.23697-12-boris.brezillon@bootlin.com>
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

When operating in octo mode we might have to use 2byte opcodes. Patch
struct spi_nor_{read,pp}_command to take that into account.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 26 ++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 33a07d9eb7a8..86625f1e25b3 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -200,6 +200,9 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
+	if (nor->read_proto & SNOR_PROTO_INST_2BYTE)
+		op.cmd.nbytes = 2;
+
 	spi_nor_adjust_op(nor, &op);
 
 	while (remaining) {
@@ -258,6 +261,9 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t ofs,
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
 
+	if (nor->write_proto & SNOR_PROTO_INST_2BYTE)
+		op.cmd.nbytes = 2;
+
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op.addr.nbytes = 0;
 
@@ -2433,13 +2439,13 @@ static int s3an_nor_scan(const struct flash_info *info, struct spi_nor *nor)
 struct spi_nor_read_command {
 	u8			num_mode_clocks;
 	u8			num_wait_states;
-	u8			opcode;
-	enum spi_nor_protocol	proto;
+	u16			opcode;
+	u32			proto;
 };
 
 struct spi_nor_pp_command {
-	u8			opcode;
-	enum spi_nor_protocol	proto;
+	u16			opcode;
+	u32			proto;
 };
 
 enum spi_nor_read_command_index {
@@ -2499,8 +2505,7 @@ static void
 spi_nor_set_read_settings(struct spi_nor_read_command *read,
 			  u8 num_mode_clocks,
 			  u8 num_wait_states,
-			  u8 opcode,
-			  enum spi_nor_protocol proto)
+			  u16 opcode, u32 proto)
 {
 	read->num_mode_clocks = num_mode_clocks;
 	read->num_wait_states = num_wait_states;
@@ -2510,8 +2515,7 @@ spi_nor_set_read_settings(struct spi_nor_read_command *read,
 
 static void
 spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
-			u8 opcode,
-			enum spi_nor_protocol proto)
+			u16 opcode, u32 proto)
 {
 	pp->opcode = opcode;
 	pp->proto = proto;
@@ -2887,6 +2891,9 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
 			  op.dummy.buswidth / 8;
 
+	if (read->proto & SNOR_PROTO_INST_2BYTE)
+		op.cmd.nbytes = 2;
+
 	/*
 	 * First test with 3 address bytes. The opcode itself might already
 	 * be a 4B addressing opcode but we don't care, because SPI controller
@@ -2915,6 +2922,9 @@ static int spi_nor_spimem_check_progop(struct spi_nor *nor,
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(pp->proto);
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(pp->proto);
 
+	if (pp->proto & SNOR_PROTO_INST_2BYTE)
+		op.cmd.nbytes = 2;
+
 	/*
 	 * First test with 3 address bytes. The opcode itself might already
 	 * be a 4B addressing opcode but we don't care, because SPI controller
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f80aba464eb2..5b0045720049 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -166,6 +166,8 @@
 
 #define SNOR_PROTO_IS_DTR	BIT(24)	/* Double Transfer Rate */
 
+#define SNOR_PROTO_INST_2BYTE	BIT(31)
+
 #define SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits)	\
 	(SNOR_PROTO_INST(_inst_nbits) |				\
 	 SNOR_PROTO_ADDR(_addr_nbits) |				\
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
