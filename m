From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 5/6] mtd: spi-nor: Use the spi_mem_xx() API
Date: Tue,  6 Feb 2018 00:21:19 +0100
Message-ID: <20180205232120.5851-6-boris.brezillon@bootlin.com>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
Cc: Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205232120.5851-1-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

The spi_mem_xxx() API has been introduced to replace the
spi_flash_read() one. Make use of it so we can get rid of
spi_flash_read().

Note that using spi_mem_xx() also simplifies the code because this API
takes care of using the regular spi_sync() interface when the optimized
->mem_ops interface is not implemented by the controller.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/mtd/devices/m25p80.c | 240 ++++++++++++++++---------------------------
 1 file changed, 88 insertions(+), 152 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index a4e18f6aaa33..3b17425d5e6f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -29,7 +29,7 @@
 
 #define	MAX_CMD_SIZE		6
 struct m25p {
-	struct spi_device	*spi;
+	struct spi_mem		*spimem;
 	struct spi_nor		spi_nor;
 	u8			command[MAX_CMD_SIZE];
 };
@@ -37,97 +37,80 @@ struct m25p {
 static int m25p80_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_device *spi = flash->spi;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
+					  SPI_MEM_OP_NO_ADDRS,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(len, val, 1));
 	int ret;
 
-	ret = spi_write_then_read(spi, &code, 1, val, len);
+	ret = spi_mem_exec_op(flash->spimem, &op);
 	if (ret < 0)
-		dev_err(&spi->dev, "error %d reading %x\n", ret, code);
+		dev_err(&flash->spimem->spi->dev, "error %d reading %x\n", ret,
+			code);
 
 	return ret;
 }
 
-static void m25p_addr2cmd(struct spi_nor *nor, unsigned int addr, u8 *cmd)
+static void m25p_offs2addr(struct spi_nor *nor, unsigned int offs, u8 *addrs)
 {
-	/* opcode is in cmd[0] */
-	cmd[1] = addr >> (nor->addr_width * 8 -  8);
-	cmd[2] = addr >> (nor->addr_width * 8 - 16);
-	cmd[3] = addr >> (nor->addr_width * 8 - 24);
-	cmd[4] = addr >> (nor->addr_width * 8 - 32);
-}
-
-static int m25p_cmdsz(struct spi_nor *nor)
-{
-	return 1 + nor->addr_width;
+	addrs[0] = offs >> (nor->addr_width * 8 -  8);
+	addrs[1] = offs >> (nor->addr_width * 8 - 16);
+	addrs[2] = offs >> (nor->addr_width * 8 - 24);
+	addrs[3] = offs >> (nor->addr_width * 8 - 32);
 }
 
 static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_device *spi = flash->spi;
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
+					  SPI_MEM_OP_NO_ADDRS,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(len, buf, 1));
 
-	flash->command[0] = opcode;
-	if (buf)
-		memcpy(&flash->command[1], buf, len);
-
-	return spi_write(spi, flash->command, len + 1);
+	return spi_mem_exec_op(flash->spimem, &op);
 }
 
 static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 			    const u_char *buf)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_device *spi = flash->spi;
-	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
-	struct spi_transfer t[3] = {};
-	struct spi_message m;
-	int cmd_sz = m25p_cmdsz(nor);
-	ssize_t ret;
+	u8 addrs[4];
+	struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
+				   SPI_MEM_OP_ADDRS(nor->addr_width, addrs, 1),
+				   SPI_MEM_OP_DUMMY(0, 1),
+				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+	size_t remaining = len;
+	int ret;
 
 	/* get transfer protocols. */
-	inst_nbits = spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	addr_nbits = spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	data_nbits = spi_nor_get_protocol_data_nbits(nor->write_proto);
-
-	spi_message_init(&m);
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
+	op.dummy.buswidth = op.addr.buswidth;
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
 
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
-		cmd_sz = 1;
-
-	flash->command[0] = nor->program_opcode;
-	m25p_addr2cmd(nor, to, flash->command);
+		op.addr.nbytes = 0;
 
-	t[0].tx_buf = flash->command;
-	t[0].tx_nbits = inst_nbits;
-	t[0].len = cmd_sz;
-	spi_message_add_tail(&t[0], &m);
+	while (remaining) {
+		if (op.addr.nbytes)
+			m25p_offs2addr(nor, to, addrs);
 
-	/* split the op code and address bytes into two transfers if needed. */
-	data_idx = 1;
-	if (addr_nbits != inst_nbits) {
-		t[0].len = 1;
+		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
+		ret = spi_mem_adjust_op_size(flash->spimem, &op);
+		if (ret)
+			return ret;
 
-		t[1].tx_buf = &flash->command[1];
-		t[1].tx_nbits = addr_nbits;
-		t[1].len = cmd_sz - 1;
-		spi_message_add_tail(&t[1], &m);
+		ret = spi_mem_exec_op(flash->spimem, &op);
+		if (ret)
+			return ret;
 
-		data_idx = 2;
+		to += op.data.nbytes;
+		remaining -= op.data.nbytes;
+		op.data.buf.out += op.data.nbytes;
 	}
 
-	t[data_idx].tx_buf = buf;
-	t[data_idx].tx_nbits = data_nbits;
-	t[data_idx].len = len;
-	spi_message_add_tail(&t[data_idx], &m);
-
-	ret = spi_sync(spi, &m);
-	if (ret)
-		return ret;
-
-	ret = m.actual_length - cmd_sz;
-	if (ret < 0)
-		return -EIO;
-	return ret;
+	return len;
 }
 
 /*
@@ -138,92 +121,42 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 			   u_char *buf)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_device *spi = flash->spi;
-	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
-	struct spi_transfer t[3];
-	struct spi_message m;
-	unsigned int dummy = nor->read_dummy;
-	ssize_t ret;
-	int cmd_sz;
+	u8 addrs[4];
+	struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
+				   SPI_MEM_OP_ADDRS(nor->addr_width, addrs, 1),
+				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
+				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+	size_t remaining = len;
+	int ret;
 
 	/* get transfer protocols. */
-	inst_nbits = spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	addr_nbits = spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	data_nbits = spi_nor_get_protocol_data_nbits(nor->read_proto);
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
+	op.dummy.buswidth = op.addr.buswidth;
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
 	/* convert the dummy cycles to the number of bytes */
-	dummy = (dummy * addr_nbits) / 8;
-
-	if (spi_flash_read_supported(spi)) {
-		struct spi_flash_read_message msg;
+	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
-		memset(&msg, 0, sizeof(msg));
+	while (remaining) {
+		m25p_offs2addr(nor, from, addrs);
 
-		msg.buf = buf;
-		msg.from = from;
-		msg.len = len;
-		msg.read_opcode = nor->read_opcode;
-		msg.addr_width = nor->addr_width;
-		msg.dummy_bytes = dummy;
-		msg.opcode_nbits = inst_nbits;
-		msg.addr_nbits = addr_nbits;
-		msg.data_nbits = data_nbits;
-
-		ret = spi_flash_read(spi, &msg);
-		if (ret < 0)
+		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
+		ret = spi_mem_adjust_op_size(flash->spimem, &op);
+		if (ret)
 			return ret;
-		return msg.retlen;
-	}
-
-	spi_message_init(&m);
-	memset(t, 0, (sizeof t));
-
-	flash->command[0] = nor->read_opcode;
-	m25p_addr2cmd(nor, from, flash->command);
-
-	t[0].tx_buf = flash->command;
-	t[0].tx_nbits = inst_nbits;
-	t[0].len = m25p_cmdsz(nor) + dummy;
-	spi_message_add_tail(&t[0], &m);
-
-	/*
-	 * Set all dummy/mode cycle bits to avoid sending some manufacturer
-	 * specific pattern, which might make the memory enter its Continuous
-	 * Read mode by mistake.
-	 * Based on the different mode cycle bit patterns listed and described
-	 * in the JESD216B specification, the 0xff value works for all memories
-	 * and all manufacturers.
-	 */
-	cmd_sz = t[0].len;
-	memset(flash->command + cmd_sz - dummy, 0xff, dummy);
 
-	/* split the op code and address bytes into two transfers if needed. */
-	data_idx = 1;
-	if (addr_nbits != inst_nbits) {
-		t[0].len = 1;
-
-		t[1].tx_buf = &flash->command[1];
-		t[1].tx_nbits = addr_nbits;
-		t[1].len = cmd_sz - 1;
-		spi_message_add_tail(&t[1], &m);
+		ret = spi_mem_exec_op(flash->spimem, &op);
+		if (ret)
+			return ret;
 
-		data_idx = 2;
+		from += op.data.nbytes;
+		remaining -= op.data.nbytes;
+		op.data.buf.in += op.data.nbytes;
 	}
 
-	t[data_idx].rx_buf = buf;
-	t[data_idx].rx_nbits = data_nbits;
-	t[data_idx].len = min3(len, spi_max_transfer_size(spi),
-			       spi_max_message_size(spi) - cmd_sz);
-	spi_message_add_tail(&t[data_idx], &m);
-
-	ret = spi_sync(spi, &m);
-	if (ret)
-		return ret;
-
-	ret = m.actual_length - cmd_sz;
-	if (ret < 0)
-		return -EIO;
-	return ret;
+	return len;
 }
 
 /*
@@ -231,8 +164,9 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
  * matches what the READ command supports, at least until this driver
  * understands FAST_READ (for clocks over 25 MHz).
  */
-static int m25p_probe(struct spi_device *spi)
+static int m25p_probe(struct spi_mem *spimem)
 {
+	struct spi_device *spi = spimem->spi;
 	struct flash_platform_data	*data;
 	struct m25p *flash;
 	struct spi_nor *nor;
@@ -244,9 +178,9 @@ static int m25p_probe(struct spi_device *spi)
 	char *flash_name;
 	int ret;
 
-	data = dev_get_platdata(&spi->dev);
+	data = dev_get_platdata(&spimem->spi->dev);
 
-	flash = devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
+	flash = devm_kzalloc(&spimem->spi->dev, sizeof(*flash), GFP_KERNEL);
 	if (!flash)
 		return -ENOMEM;
 
@@ -258,12 +192,12 @@ static int m25p_probe(struct spi_device *spi)
 	nor->write_reg = m25p80_write_reg;
 	nor->read_reg = m25p80_read_reg;
 
-	nor->dev = &spi->dev;
+	nor->dev = &spimem->spi->dev;
 	spi_nor_set_flash_node(nor, spi->dev.of_node);
 	nor->priv = flash;
 
 	spi_set_drvdata(spi, flash);
-	flash->spi = spi;
+	flash->spimem = spimem;
 
 	if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |= SNOR_HWCAPS_READ_1_1_4;
@@ -303,9 +237,9 @@ static int m25p_probe(struct spi_device *spi)
 }
 
 
-static int m25p_remove(struct spi_device *spi)
+static int m25p_remove(struct spi_mem *spimem)
 {
-	struct m25p	*flash = spi_get_drvdata(spi);
+	struct m25p	*flash = spi_mem_get_drvdata(spimem);
 
 	spi_nor_restore(&flash->spi_nor);
 
@@ -313,9 +247,9 @@ static int m25p_remove(struct spi_device *spi)
 	return mtd_device_unregister(&flash->spi_nor.mtd);
 }
 
-static void m25p_shutdown(struct spi_device *spi)
+static void m25p_shutdown(struct spi_mem *spimem)
 {
-	struct m25p *flash = spi_get_drvdata(spi);
+	struct m25p *flash = spi_mem_get_drvdata(spimem);
 
 	spi_nor_restore(&flash->spi_nor);
 }
@@ -386,12 +320,14 @@ static const struct of_device_id m25p_of_table[] = {
 };
 MODULE_DEVICE_TABLE(of, m25p_of_table);
 
-static struct spi_driver m25p80_driver = {
-	.driver = {
-		.name	= "m25p80",
-		.of_match_table = m25p_of_table,
+static struct spi_mem_driver m25p80_driver = {
+	.spidrv = {
+		.driver = {
+			.name	= "m25p80",
+			.of_match_table = m25p_of_table,
+		},
+		.id_table	= m25p_ids,
 	},
-	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
 	.remove	= m25p_remove,
 	.shutdown	= m25p_shutdown,
@@ -402,7 +338,7 @@ static struct spi_driver m25p80_driver = {
 	 */
 };
 
-module_spi_driver(m25p80_driver);
+module_spi_mem_driver(m25p80_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike Lavender");
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
