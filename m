From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [RFC PATCH 5/6] mtd: spi-nor: Use the spi_mem_xx() API
Date: Mon, 11 Jun 2018 06:25:02 +0000
Message-ID: <DB6PR0402MB28380B10F866F08E0CDC6B6999780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
 <20180205232120.5851-6-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Cc: Vignesh R <vigneshr@ti.com>, Kamal Dasu <kdasu.kdev@gmail.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>,
 Sourav Poddar <sourav.poddar@ti.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>, David Woodhouse
 <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris
 Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut
 <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen
 <cyrille.pitchen@wedev4u.fr>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180205232120.5851-6-boris.brezillon@bootlin.com>
Content-Language: en-US
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

Hi Boris,

Issue which I am getting in spi-fsl-qspi.c regarding write is happening due=
 to the changes been pushed by this patch series.

Comments inline, comments holds true for the final pushed change.

--
Regards
Yogesh Gaur

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com] =

Sent: Tuesday, February 6, 2018 4:51 AM
To: David Woodhouse <dwmw2@infradead.org>; Brian Norris <computersforpeace@=
gmail.com>; Boris Brezillon <boris.brezillon@free-electrons.com>; Marek Vas=
ut <marek.vasut@gmail.com>; Richard Weinberger <richard@nod.at>; Cyrille Pi=
tchen <cyrille.pitchen@wedev4u.fr>; linux-mtd@lists.infradead.org; Mark Bro=
wn <broonie@kernel.org>; linux-spi@vger.kernel.org
Cc: Peter Pan <peterpansjtu@gmail.com>; Frieder Schrempf <frieder.schrempf@=
exceet.de>; Vignesh R <vigneshr@ti.com>; Yogesh Narayan Gaur <yogeshnarayan=
.gaur@nxp.com>; Rafa=B3 Mi=B3ecki <rafal@milecki.pl>; Kamal Dasu <kdasu.kde=
v@gmail.com>; Sourav Poddar <sourav.poddar@ti.com>
Subject: [RFC PATCH 5/6] mtd: spi-nor: Use the spi_mem_xx() API

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The spi_mem_xxx() API has been introduced to replace the
spi_flash_read() one. Make use of it so we can get rid of spi_flash_read().

Note that using spi_mem_xx() also simplifies the code because this API take=
s care of using the regular spi_sync() interface when the optimized
->mem_ops interface is not implemented by the controller.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/devices/m25p80.c | 240 ++++++++++++++++-----------------------=
----
 1 file changed, 88 insertions(+), 152 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c in=
dex a4e18f6aaa33..3b17425d5e6f 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -29,7 +29,7 @@
 =

 #define	MAX_CMD_SIZE		6
 struct m25p {
-	struct spi_device	*spi;
+	struct spi_mem		*spimem;
 	struct spi_nor		spi_nor;
 	u8			command[MAX_CMD_SIZE];
 };
@@ -37,97 +37,80 @@ struct m25p {
 static int m25p80_read_reg(struct spi_nor *nor, u8 code, u8 *val, int len)=
  {
 	struct m25p *flash =3D nor->priv;
-	struct spi_device *spi =3D flash->spi;
+	struct spi_mem_op op =3D SPI_MEM_OP(SPI_MEM_OP_CMD(code, 1),
+					  SPI_MEM_OP_NO_ADDRS,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(len, val, 1));
 	int ret;
 =

-	ret =3D spi_write_then_read(spi, &code, 1, val, len);
+	ret =3D spi_mem_exec_op(flash->spimem, &op);
 	if (ret < 0)
-		dev_err(&spi->dev, "error %d reading %x\n", ret, code);
+		dev_err(&flash->spimem->spi->dev, "error %d reading %x\n", ret,
+			code);
 =

 	return ret;
 }
 =

-static void m25p_addr2cmd(struct spi_nor *nor, unsigned int addr, u8 *cmd)
+static void m25p_offs2addr(struct spi_nor *nor, unsigned int offs, u8 =

+*addrs)
 {
-	/* opcode is in cmd[0] */
-	cmd[1] =3D addr >> (nor->addr_width * 8 -  8);
-	cmd[2] =3D addr >> (nor->addr_width * 8 - 16);
-	cmd[3] =3D addr >> (nor->addr_width * 8 - 24);
-	cmd[4] =3D addr >> (nor->addr_width * 8 - 32);
-}
-
-static int m25p_cmdsz(struct spi_nor *nor) -{
-	return 1 + nor->addr_width;
+	addrs[0] =3D offs >> (nor->addr_width * 8 -  8);
+	addrs[1] =3D offs >> (nor->addr_width * 8 - 16);
+	addrs[2] =3D offs >> (nor->addr_width * 8 - 24);
+	addrs[3] =3D offs >> (nor->addr_width * 8 - 32);
 }
 =

 static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int l=
en)  {
 	struct m25p *flash =3D nor->priv;
-	struct spi_device *spi =3D flash->spi;
+	struct spi_mem_op op =3D SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 1),
+					  SPI_MEM_OP_NO_ADDRS,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(len, buf, 1));
 =

-	flash->command[0] =3D opcode;
-	if (buf)
-		memcpy(&flash->command[1], buf, len);
-
-	return spi_write(spi, flash->command, len + 1);
+	return spi_mem_exec_op(flash->spimem, &op);
 }
 =

 static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 			    const u_char *buf)
 {
 	struct m25p *flash =3D nor->priv;
-	struct spi_device *spi =3D flash->spi;
-	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
-	struct spi_transfer t[3] =3D {};
-	struct spi_message m;
-	int cmd_sz =3D m25p_cmdsz(nor);
-	ssize_t ret;
+	u8 addrs[4];
+	struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
+				   SPI_MEM_OP_ADDRS(nor->addr_width, addrs, 1),
+				   SPI_MEM_OP_DUMMY(0, 1),
+				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+	size_t remaining =3D len;
+	int ret;
 =

 	/* get transfer protocols. */
-	inst_nbits =3D spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	addr_nbits =3D spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	data_nbits =3D spi_nor_get_protocol_data_nbits(nor->write_proto);
-
-	spi_message_init(&m);
+	op.cmd.buswidth =3D spi_nor_get_protocol_inst_nbits(nor->write_proto);
+	op.addr.buswidth =3D spi_nor_get_protocol_addr_nbits(nor->write_proto);
+	op.dummy.buswidth =3D op.addr.buswidth;
+	op.data.buswidth =3D spi_nor_get_protocol_data_nbits(nor->write_proto);
 =

 	if (nor->program_opcode =3D=3D SPINOR_OP_AAI_WP && nor->sst_write_second)
-		cmd_sz =3D 1;
-
-	flash->command[0] =3D nor->program_opcode;
-	m25p_addr2cmd(nor, to, flash->command);
+		op.addr.nbytes =3D 0;
 =

-	t[0].tx_buf =3D flash->command;
-	t[0].tx_nbits =3D inst_nbits;
-	t[0].len =3D cmd_sz;
-	spi_message_add_tail(&t[0], &m);
+	while (remaining) {
+		if (op.addr.nbytes)
+			m25p_offs2addr(nor, to, addrs);
 =

-	/* split the op code and address bytes into two transfers if needed. */
-	data_idx =3D 1;
-	if (addr_nbits !=3D inst_nbits) {
-		t[0].len =3D 1;
+		op.data.nbytes =3D remaining < UINT_MAX ? remaining : UINT_MAX;
+		ret =3D spi_mem_adjust_op_size(flash->spimem, &op);
+		if (ret)
+			return ret;
 =

-		t[1].tx_buf =3D &flash->command[1];
-		t[1].tx_nbits =3D addr_nbits;
-		t[1].len =3D cmd_sz - 1;
-		spi_message_add_tail(&t[1], &m);
+		ret =3D spi_mem_exec_op(flash->spimem, &op);
+		if (ret)
+			return ret;
 =

-		data_idx =3D 2;
+		to +=3D op.data.nbytes;
+		remaining -=3D op.data.nbytes;
+		op.data.buf.out +=3D op.data.nbytes;

For NOR flashes, WRITE command is being send in order as below
Write Enable command
Flash Write command
Status Register command

But for case when Write data size is more than op.data.nbytes then for rema=
ining data size chunk, we are just sending the FLASH WRITE Command and this=
 is the reason I am seeing failure after 64 byte data size.


 	}
 =

-	t[data_idx].tx_buf =3D buf;
-	t[data_idx].tx_nbits =3D data_nbits;
-	t[data_idx].len =3D len;
-	spi_message_add_tail(&t[data_idx], &m);
-
-	ret =3D spi_sync(spi, &m);
-	if (ret)
-		return ret;
-
-	ret =3D m.actual_length - cmd_sz;
-	if (ret < 0)
-		return -EIO;
-	return ret;
+	return len;
 }
 =

 /*
@@ -138,92 +121,42 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_=
t from, size_t len,
 			   u_char *buf)
 {
 	struct m25p *flash =3D nor->priv;
-	struct spi_device *spi =3D flash->spi;
-	unsigned int inst_nbits, addr_nbits, data_nbits, data_idx;
-	struct spi_transfer t[3];
-	struct spi_message m;
-	unsigned int dummy =3D nor->read_dummy;
-	ssize_t ret;
-	int cmd_sz;
+	u8 addrs[4];
+	struct spi_mem_op op =3D
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
+				   SPI_MEM_OP_ADDRS(nor->addr_width, addrs, 1),
+				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
+				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+	size_t remaining =3D len;
+	int ret;
 =

 	/* get transfer protocols. */
-	inst_nbits =3D spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	addr_nbits =3D spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	data_nbits =3D spi_nor_get_protocol_data_nbits(nor->read_proto);
+	op.cmd.buswidth =3D spi_nor_get_protocol_inst_nbits(nor->read_proto);
+	op.addr.buswidth =3D spi_nor_get_protocol_addr_nbits(nor->read_proto);
+	op.dummy.buswidth =3D op.addr.buswidth;
+	op.data.buswidth =3D spi_nor_get_protocol_data_nbits(nor->read_proto);
 =

 	/* convert the dummy cycles to the number of bytes */
-	dummy =3D (dummy * addr_nbits) / 8;
-
-	if (spi_flash_read_supported(spi)) {
-		struct spi_flash_read_message msg;
+	op.dummy.nbytes =3D (nor->read_dummy * op.dummy.buswidth) / 8;
 =

-		memset(&msg, 0, sizeof(msg));
+	while (remaining) {
+		m25p_offs2addr(nor, from, addrs);
 =

-		msg.buf =3D buf;
-		msg.from =3D from;
-		msg.len =3D len;
-		msg.read_opcode =3D nor->read_opcode;
-		msg.addr_width =3D nor->addr_width;
-		msg.dummy_bytes =3D dummy;
-		msg.opcode_nbits =3D inst_nbits;
-		msg.addr_nbits =3D addr_nbits;
-		msg.data_nbits =3D data_nbits;
-
-		ret =3D spi_flash_read(spi, &msg);
-		if (ret < 0)
+		op.data.nbytes =3D remaining < UINT_MAX ? remaining : UINT_MAX;
+		ret =3D spi_mem_adjust_op_size(flash->spimem, &op);
+		if (ret)
 			return ret;
-		return msg.retlen;
-	}
-
-	spi_message_init(&m);
-	memset(t, 0, (sizeof t));
-
-	flash->command[0] =3D nor->read_opcode;
-	m25p_addr2cmd(nor, from, flash->command);
-
-	t[0].tx_buf =3D flash->command;
-	t[0].tx_nbits =3D inst_nbits;
-	t[0].len =3D m25p_cmdsz(nor) + dummy;
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
-	cmd_sz =3D t[0].len;
-	memset(flash->command + cmd_sz - dummy, 0xff, dummy);
 =

-	/* split the op code and address bytes into two transfers if needed. */
-	data_idx =3D 1;
-	if (addr_nbits !=3D inst_nbits) {
-		t[0].len =3D 1;
-
-		t[1].tx_buf =3D &flash->command[1];
-		t[1].tx_nbits =3D addr_nbits;
-		t[1].len =3D cmd_sz - 1;
-		spi_message_add_tail(&t[1], &m);
+		ret =3D spi_mem_exec_op(flash->spimem, &op);
+		if (ret)
+			return ret;
 =

-		data_idx =3D 2;
+		from +=3D op.data.nbytes;
+		remaining -=3D op.data.nbytes;
+		op.data.buf.in +=3D op.data.nbytes;
 	}
 =

-	t[data_idx].rx_buf =3D buf;
-	t[data_idx].rx_nbits =3D data_nbits;
-	t[data_idx].len =3D min3(len, spi_max_transfer_size(spi),
-			       spi_max_message_size(spi) - cmd_sz);
-	spi_message_add_tail(&t[data_idx], &m);
-
-	ret =3D spi_sync(spi, &m);
-	if (ret)
-		return ret;
-
-	ret =3D m.actual_length - cmd_sz;
-	if (ret < 0)
-		return -EIO;
-	return ret;
+	return len;
 }
 =

 /*
@@ -231,8 +164,9 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t =
from, size_t len,
  * matches what the READ command supports, at least until this driver
  * understands FAST_READ (for clocks over 25 MHz).
  */
-static int m25p_probe(struct spi_device *spi)
+static int m25p_probe(struct spi_mem *spimem)
 {
+	struct spi_device *spi =3D spimem->spi;
 	struct flash_platform_data	*data;
 	struct m25p *flash;
 	struct spi_nor *nor;
@@ -244,9 +178,9 @@ static int m25p_probe(struct spi_device *spi)
 	char *flash_name;
 	int ret;
 =

-	data =3D dev_get_platdata(&spi->dev);
+	data =3D dev_get_platdata(&spimem->spi->dev);
 =

-	flash =3D devm_kzalloc(&spi->dev, sizeof(*flash), GFP_KERNEL);
+	flash =3D devm_kzalloc(&spimem->spi->dev, sizeof(*flash), GFP_KERNEL);
 	if (!flash)
 		return -ENOMEM;
 =

@@ -258,12 +192,12 @@ static int m25p_probe(struct spi_device *spi)
 	nor->write_reg =3D m25p80_write_reg;
 	nor->read_reg =3D m25p80_read_reg;
 =

-	nor->dev =3D &spi->dev;
+	nor->dev =3D &spimem->spi->dev;
 	spi_nor_set_flash_node(nor, spi->dev.of_node);
 	nor->priv =3D flash;
 =

 	spi_set_drvdata(spi, flash);
-	flash->spi =3D spi;
+	flash->spimem =3D spimem;
 =

 	if (spi->mode & SPI_RX_QUAD) {
 		hwcaps.mask |=3D SNOR_HWCAPS_READ_1_1_4; @@ -303,9 +237,9 @@ static int =
m25p_probe(struct spi_device *spi)  }
 =

 =

-static int m25p_remove(struct spi_device *spi)
+static int m25p_remove(struct spi_mem *spimem)
 {
-	struct m25p	*flash =3D spi_get_drvdata(spi);
+	struct m25p	*flash =3D spi_mem_get_drvdata(spimem);
 =

 	spi_nor_restore(&flash->spi_nor);
 =

@@ -313,9 +247,9 @@ static int m25p_remove(struct spi_device *spi)
 	return mtd_device_unregister(&flash->spi_nor.mtd);
 }
 =

-static void m25p_shutdown(struct spi_device *spi)
+static void m25p_shutdown(struct spi_mem *spimem)
 {
-	struct m25p *flash =3D spi_get_drvdata(spi);
+	struct m25p *flash =3D spi_mem_get_drvdata(spimem);
 =

 	spi_nor_restore(&flash->spi_nor);
 }
@@ -386,12 +320,14 @@ static const struct of_device_id m25p_of_table[] =3D =
{  };  MODULE_DEVICE_TABLE(of, m25p_of_table);
 =

-static struct spi_driver m25p80_driver =3D {
-	.driver =3D {
-		.name	=3D "m25p80",
-		.of_match_table =3D m25p_of_table,
+static struct spi_mem_driver m25p80_driver =3D {
+	.spidrv =3D {
+		.driver =3D {
+			.name	=3D "m25p80",
+			.of_match_table =3D m25p_of_table,
+		},
+		.id_table	=3D m25p_ids,
 	},
-	.id_table	=3D m25p_ids,
 	.probe	=3D m25p_probe,
 	.remove	=3D m25p_remove,
 	.shutdown	=3D m25p_shutdown,
@@ -402,7 +338,7 @@ static struct spi_driver m25p80_driver =3D {
 	 */
 };
 =

-module_spi_driver(m25p80_driver);
+module_spi_mem_driver(m25p80_driver);
 =

 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mike Lavender");
--
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
