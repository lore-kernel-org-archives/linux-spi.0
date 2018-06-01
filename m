From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [RFC PATCH 2/2] mtd: m25p80: Use the SPI mem direct API to possibly
 improve performances
Date: Fri,  1 Jun 2018 16:36:03 +0200
Message-ID: <20180601143603.4047-3-boris.brezillon@bootlin.com>
References: <20180601143603.4047-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 Vignesh R <vigneshr@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180601143603.4047-1-boris.brezillon@bootlin.com>
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

Make use of the SPI mem direct mapping API.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/devices/m25p80.c | 149 ++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 60 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 1dd5f0420b5a..285fc94118ae 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -31,6 +31,10 @@
 struct m25p {
 	struct spi_mem		*spimem;
 	struct spi_nor		spi_nor;
+	struct {
+		struct spi_mem_dirmap_desc *write;
+		struct spi_mem_dirmap_desc *read;
+	} dirmap;
 };
 
 static int m25p80_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
@@ -65,38 +69,8 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 			    const u_char *buf)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
-				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
-	size_t remaining = len;
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
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
 
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.out += op.data.nbytes;
-	}
-
-	return len;
+	return spi_mem_dirmap_write(flash->dirmap.write, to, len, buf);
 }
 
 /*
@@ -107,39 +81,66 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 			   u_char *buf)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
-				   SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
-				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
-				   SPI_MEM_OP_DATA_IN(len, buf, 1));
-	size_t remaining = len;
-	int ret;
+
+	return spi_mem_dirmap_read(flash->dirmap.read, from, len, buf);
+}
+
+static int m25p_create_write_dirmap(struct m25p *flash)
+{
+	struct spi_nor *nor = &flash->spi_nor;
+	struct spi_mem_dirmap_info info = {
+		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
+				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 1),
+				      SPI_MEM_OP_NO_DUMMY,
+				      SPI_MEM_OP_DATA_OUT(0, NULL, 1)),
+		.offset = 0,
+		.length = flash->spi_nor.mtd.size,
+	};
+	struct spi_mem_op *op = &info.op_tmpl;
 
 	/* get transfer protocols. */
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	op.dummy.buswidth = op.addr.buswidth;
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
+	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
+	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
+	op->dummy.buswidth = op->addr.buswidth;
+	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
 
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
+	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
+		op->addr.nbytes = 0;
 
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
+	flash->dirmap.write = spi_mem_dirmap_create(flash->spimem, &info);
+	if (IS_ERR(flash->dirmap.write))
+		return PTR_ERR(flash->dirmap.write);
 
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
+	return 0;
+}
 
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.in += op.data.nbytes;
-	}
+static int m25p_create_read_dirmap(struct m25p *flash)
+{
+	struct spi_nor *nor = &flash->spi_nor;
+	struct spi_mem_dirmap_info info = {
+		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
+				      SPI_MEM_OP_ADDR(nor->addr_width, 0, 1),
+				      SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
+				      SPI_MEM_OP_DATA_IN(0, NULL, 1)),
+		.offset = 0,
+		.length = flash->spi_nor.mtd.size,
+	};
+	struct spi_mem_op *op = &info.op_tmpl;
 
-	return len;
+	/* get transfer protocols. */
+	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
+	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
+	op->dummy.buswidth = op->addr.buswidth;
+	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
+
+	/* convert the dummy cycles to the number of bytes */
+	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
+
+	flash->dirmap.read = spi_mem_dirmap_create(flash->spimem, &info);
+	if (IS_ERR(flash->dirmap.read))
+		return PTR_ERR(flash->dirmap.read);
+
+	return 0;
 }
 
 /*
@@ -215,19 +216,47 @@ static int m25p_probe(struct spi_mem *spimem)
 	if (ret)
 		return ret;
 
-	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
-				   data ? data->nr_parts : 0);
+	ret = m25p_create_write_dirmap(flash);
+	if (ret)
+		return ret;
+
+	ret = m25p_create_read_dirmap(flash);
+	if (ret)
+		goto err_destroy_write_dirmap;
+
+	ret = mtd_device_register(&nor->mtd, data ? data->parts : NULL,
+				  data ? data->nr_parts : 0);
+	if (ret)
+		goto err_destroy_read_dirmap;
+
+	return 0;
+
+err_destroy_read_dirmap:
+	spi_mem_dirmap_destroy(flash->dirmap.read);
+
+err_destroy_write_dirmap:
+	spi_mem_dirmap_destroy(flash->dirmap.write);
+
+	return ret;
 }
 
 
 static int m25p_remove(struct spi_mem *spimem)
 {
 	struct m25p	*flash = spi_mem_get_drvdata(spimem);
+	int ret;
 
 	spi_nor_restore(&flash->spi_nor);
 
 	/* Clean up MTD stuff. */
-	return mtd_device_unregister(&flash->spi_nor.mtd);
+	ret = mtd_device_unregister(&flash->spi_nor.mtd);
+	if (ret)
+		return ret;
+
+	spi_mem_dirmap_destroy(flash->dirmap.read);
+	spi_mem_dirmap_destroy(flash->dirmap.write);
+
+	return 0;
 }
 
 static void m25p_shutdown(struct spi_mem *spimem)
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
