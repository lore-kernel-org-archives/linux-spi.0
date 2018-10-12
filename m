From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH RFC 15/18] mtd: spi-nor: Add DTR support to the spi-mem logic
Date: Fri, 12 Oct 2018 10:48:22 +0200
Message-ID: <20181012084825.23697-16-boris.brezillon@bootlin.com>
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

Make sure op->xxx.dtr fields are properly filled and unmask DTR modes
in spi_nor_spimem_adjust_hwcaps() so that DTR support detection is done
through spi_mem_supports_op().

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 98dab7f6938e..9ff957dc351c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -280,12 +280,18 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t ofs,
 
 	/* get transfer protocols. */
 	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
+	op.cmd.dtr = spi_nor_protocol_inst_is_dtr(nor->read_proto);
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
+	op.addr.dtr = spi_nor_protocol_addr_is_dtr(nor->read_proto);
 	op.dummy.buswidth = op.addr.buswidth;
+	op.dummy.dtr = op.addr.dtr;
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
+	op.data.dtr = spi_nor_protocol_data_is_dtr(nor->read_proto);
 
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (op.dummy.dtr)
+		op.dummy.nbytes *= 2;
 
 	if (nor->read_proto & SNOR_PROTO_INST_2BYTE)
 		op.cmd.nbytes = 2;
@@ -345,8 +351,11 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t ofs,
 
 	/* get transfer protocols. */
 	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
+	op.cmd.dtr = spi_nor_protocol_inst_is_dtr(nor->write_proto);
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
+	op.addr.dtr = spi_nor_protocol_addr_is_dtr(nor->write_proto);
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
+	op.data.dtr = spi_nor_protocol_data_is_dtr(nor->write_proto);
 
 	if (nor->write_proto & SNOR_PROTO_INST_2BYTE)
 		op.cmd.nbytes = 2;
@@ -3043,11 +3052,17 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
 
 	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(read->proto);
+	op.cmd.dtr = spi_nor_protocol_inst_is_dtr(read->proto);
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(read->proto);
+	op.addr.dtr = spi_nor_protocol_addr_is_dtr(read->proto);
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(read->proto);
+	op.data.dtr = spi_nor_protocol_addr_is_dtr(read->proto);
 	op.dummy.buswidth = op.addr.buswidth;
+	op.dummy.dtr = op.addr.dtr;
 	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
 			  op.dummy.buswidth / 8;
+	if (op.dummy.dtr)
+		op.dummy.nbytes *= 2;
 
 	if (read->proto & SNOR_PROTO_INST_2BYTE)
 		op.cmd.nbytes = 2;
@@ -3077,8 +3092,11 @@ static int spi_nor_spimem_check_progop(struct spi_nor *nor,
 					  SPI_MEM_OP_DATA_OUT(0, NULL, 1));
 
 	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(pp->proto);
+	op.cmd.dtr = spi_nor_protocol_inst_is_dtr(pp->proto);
 	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(pp->proto);
+	op.addr.dtr = spi_nor_protocol_addr_is_dtr(pp->proto);
 	op.data.buswidth = spi_nor_get_protocol_data_nbits(pp->proto);
+	op.data.dtr = spi_nor_protocol_addr_is_dtr(pp->proto);
 
 	if (pp->proto & SNOR_PROTO_INST_2BYTE)
 		op.cmd.nbytes = 2;
@@ -3106,9 +3124,6 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor,
 {
 	unsigned int cap;
 
-	/* DTR modes are not supported yet, mask them all. */
-	*hwcaps &= ~SNOR_HWCAPS_DTR;
-
 	/* Start with read commands. */
 	for (cap = 0; cap < 32; cap++) {
 		int idx;
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
