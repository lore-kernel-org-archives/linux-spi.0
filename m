Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629201;
	b=FtbSoASnoKUo+Fj+3G4s5GPRke5JJ3vsm1bN/s5yZJ9Vu5DQtuwpmi7RJOmOq/Eey7uf
	 BHIcDZ3DswJ7Jp7MC7TbOgnChR5TKNzPCO2TtEgtB5jD9UHhiwI24BJKBvk4Gnsineg0t
	 8Dh9a8Z+LBeNRKFmRfnKlIQ/Dms4kj6Z2Zi+YVofn9Zk4QCP4nDQ/0OJwfSnz3d9TSy/8
	 Xa1CBwonWtZmTsnkkscdlZz4lJA4EbHbOiZe62rygUY5bDGlL7NfPT2Gci+iSlKEhmWgj
	 SfD8gDHapJSErledUW7lBGOr/U8jC5yWHbiwMFAq+Ki7lp7X+pBVV1PfchLjSxDO6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629201;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=voL9T1Z3XGsgqOOZRJCgMdwANraTsa7bt67oUn9zWHQ=;
	b=4E4D1f3L1ZazCSaIZWE1ofm0vsnDNv0lFyB2iatdVfT7Lz1IWTOIUwP/BBWSmxxUO6C9
	 B7nFsyzBpu3FH0M4iaonSWcL0Q52NRnsRQXXynfvyGOPx278IOQhg6dQ/HDaWrB6VOqiy
	 +u6XM8CM18nfpOT7hHn/g/zcLBSETxy54Y0z+ROZ/XLecoa/dGwO7A9omtdLRIFZL4nYM
	 2INGzHv5xa5KWHa66AI5rEKyRrMYxWG6WO4yRrQtg9y0tY0hZsCEnToszC9vmURgmOqnH
	 AJj8oD9MDW4yFutJnHUGm/ulCBj1fDIHNYrLNfuSZK0JP+stRTZNpdQLS0y3I76Y/7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=euK18Za8;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82A60A261C;
	Wed, 25 Nov 2026 17:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D82A60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=euK18Za8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3F8E04E4178B;
	Wed, 25 Nov 2026 17:53:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11F2C60480;
	Wed, 25 Nov 2026 17:53:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3407811E6B0CB;
	Wed, 25 Nov 2026 18:53:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629192; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=voL9T1Z3XGsgqOOZRJCgMdwANraTsa7bt67oUn9zWHQ=;
	b=euK18Za8g+jR4jPPzVdC9Sb8FWmROFOxXu1Vue+OinDIz92TekRJynKuIYn2tedgMIcrnI
	7PFZfnGPbaXMpRb10YjGK/VpP0FW8l6K9lS5/rchszGPcrzK1m1kAvEVIAUJx68cqrKGPp
	oMvIwp8C+AmLH3JOuXmkv/MpctDiFscOEOInMDLrvg0jrFSBt9Y4KGy+p7ueS4LC+C6DY8
	2VSSeZlaP9ToNrDeDmmPG50G+V41hSNVuRPLKu/ip+tHRJZQkbr81UPGjTrC7tq1kjL08B
	0F4W8Ox0F4cN9gfQziGW8GcmZlDvGqoDN02vgdHkIi+PxFumAYy/NTlnKewLsw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:30 +0100
Subject: [PATCH RFC 16/16] mtd: spi-nor: Express the dummy phase in cycles
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-16-fd036402fd37@bootlin.com>
References: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
In-Reply-To: <20261125-macronix-upstreaming-spi-mem-cycles-v1-0-fd036402fd37@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Han Xu <han.xu@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Valentina Fernandez <valentina.fernandezalanis@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jyan Chou <jyanchou@realtek.com>, 
 Yu-Chun Lin <eleanor.lin@realtek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 imx@lists.linux.dev, linux-riscv@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

SFDP tables and datasheets provide the number of dummy cycles, not the
number of dummy bytes. Set dummy.ncycles directly instead of converting
it to dummy.nbytes. Depending on controller capabilities, this may help
supporting more use cases (typically Macronix 1S-8S-8S 20 dummy cycles)
while performing less useless maths in the core.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/spi-nor/core.c      | 36 ++++++++++--------------------------
 drivers/mtd/spi-nor/core.h      |  8 ++++----
 drivers/mtd/spi-nor/micron-st.c |  2 +-
 drivers/mtd/spi-nor/spansion.c  |  6 +++---
 4 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a04d22d2e2e1..dcc36f532aaa 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -91,7 +91,7 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 	if (op->addr.nbytes)
 		op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
-	if (op->dummy.nbytes)
+	if (op->dummy.nbytes || op->dummy.ncycles)
 		op->dummy.buswidth = spi_nor_get_protocol_addr_nbits(proto);
 
 	if (op->data.nbytes)
@@ -109,9 +109,6 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->dummy.dtr = true;
 		op->data.dtr = true;
 
-		/* 2 bytes per clock cycle in DTR mode. */
-		op->dummy.nbytes *= 2;
-
 		ext = spi_nor_get_cmd_ext(nor, op);
 		op->cmd.opcode = (op->cmd.opcode << 8) | ext;
 		op->cmd.nbytes = 2;
@@ -205,7 +202,7 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 	struct spi_mem_op op =
 		SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
 			   SPI_MEM_OP_ADDR(nor->addr_nbytes, from, 0),
-			   SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+			   SPI_MEM_OP_DUMMY_CYCLES(nor->read_dummy, 0),
 			   SPI_MEM_OP_DATA_IN(len, buf, 0));
 	bool usebouncebuf;
 	ssize_t nbytes;
@@ -213,11 +210,6 @@ static ssize_t spi_nor_spimem_read_data(struct spi_nor *nor, loff_t from,
 
 	spi_nor_spimem_setup_op(nor, &op, nor->read_proto);
 
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op.dummy.nbytes *= 2;
-
 	usebouncebuf = spi_nor_spimem_bounce(nor, &op);
 
 	if (nor->dirmap.rdesc) {
@@ -418,22 +410,23 @@ int spi_nor_write_disable(struct spi_nor *nor)
  * @nor:	pointer to 'struct spi_nor'.
  * @naddr:	number of address bytes to send. Can be zero if the operation
  *		does not need to send an address.
- * @ndummy:	number of dummy bytes to send after an opcode or address. Can
- *		be zero if the operation does not require dummy bytes.
+ * @ncycles:	number of dummy clock cycles to insert after an opcode or
+ *		address. Can be zero if the operation does not require dummy
+ *		cycles.
  * @id:		pointer to a DMA-able buffer where the value of the JEDEC ID
  *		will be written.
  * @proto:	the SPI protocol for register operation.
  *
  * Return: 0 on success, -errno otherwise.
  */
-int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
+int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ncycles, u8 *id,
 		    enum spi_nor_protocol proto)
 {
 	int ret;
 
 	if (nor->spimem) {
 		struct spi_mem_op op =
-			SPI_NOR_READID_OP(naddr, ndummy, id, SPI_NOR_MAX_ID_LEN);
+			SPI_NOR_READID_OP(naddr, ncycles, id, SPI_NOR_MAX_ID_LEN);
 
 		spi_nor_spimem_setup_op(nor, &op, proto);
 		ret = spi_mem_exec_op(nor->spimem, &op);
@@ -741,7 +734,7 @@ int spi_nor_read_sr_ll(struct spi_nor *nor, u8 opcode, u8 *sr,
 
 		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
-			op.dummy.nbytes = nor->params->rdsr_dummy;
+			op.dummy.ncycles = nor->params->rdsr_dummy;
 			/*
 			 * We don't want to read only one byte in DTR mode. So,
 			 * read 2 and then discard the second byte.
@@ -2247,11 +2240,7 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 
 	spi_nor_spimem_setup_op(nor, &op, read->proto);
 
-	/* convert the dummy cycles to the number of bytes */
-	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
-			  op.dummy.buswidth / 8;
-	if (spi_nor_protocol_is_dtr(read->proto))
-		op.dummy.nbytes *= 2;
+	op.dummy.ncycles = read->num_mode_clocks + read->num_wait_states;
 
 	return spi_nor_spimem_check_read_pp_op(nor, &op);
 }
@@ -3492,7 +3481,7 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 		.op_tmpl = &info.primary_op_tmpl,
 		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
 					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+					      SPI_MEM_OP_DUMMY_CYCLES(nor->read_dummy, 0),
 					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->params->size,
@@ -3501,11 +3490,6 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 
 	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
 
-	/* convert the dummy cycles to the number of bytes */
-	op->dummy.nbytes = (nor->read_dummy * op->dummy.buswidth) / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
-		op->dummy.nbytes *= 2;
-
 	/*
 	 * Since spi_nor_spimem_setup_op() only sets buswidth when the number
 	 * of data bytes is non-zero, the data buswidth won't be set here. So,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 670182b3c2ad..11817280f650 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -19,10 +19,10 @@
 #define SPI_NOR_DEFAULT_SECTOR_SIZE SZ_64K
 
 /* Standard SPI NOR flash operations. */
-#define SPI_NOR_READID_OP(naddr, ndummy, buf, len)			\
+#define SPI_NOR_READID_OP(naddr, ncycles, buf, len)			\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 0),			\
 		   SPI_MEM_OP_ADDR(naddr, 0, 0),			\
-		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
+		   SPI_MEM_OP_DUMMY_CYCLES(ncycles, 0),			\
 		   SPI_MEM_OP_DATA_IN(len, buf, 0))
 
 #define SPI_NOR_WREN_OP							\
@@ -82,7 +82,7 @@
 #define SPI_NOR_READ_OP(opcode)						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
 		   SPI_MEM_OP_ADDR(3, 0, 0),				\
-		   SPI_MEM_OP_DUMMY(1, 0),				\
+		   SPI_MEM_OP_DUMMY_CYCLES(1, 0),			\
 		   SPI_MEM_OP_DATA_IN(2, NULL, 0))
 
 #define SPI_NOR_PP_OP(opcode)						\
@@ -652,7 +652,7 @@ int spi_nor_wait_till_ready(struct spi_nor *nor);
 int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_prep_and_lock(struct spi_nor *nor);
 void spi_nor_unlock_and_unprep(struct spi_nor *nor);
-int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ndummy, u8 *id,
+int spi_nor_read_id(struct spi_nor *nor, u8 naddr, u8 ncycles, u8 *id,
 		    enum spi_nor_protocol reg_proto);
 int spi_nor_sr_ready(struct spi_nor *nor);
 int spi_nor_read_sr_ll(struct spi_nor *nor, u8 opcode, u8 *sr,
diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index f97f2dead8c2..34eb15c7d3b3 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -525,7 +525,7 @@ static int micron_st_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 
 		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
-			op.dummy.nbytes = nor->params->rdsr_dummy;
+			op.dummy.ncycles = nor->params->rdsr_dummy;
 			/*
 			 * We don't want to read only one byte in DTR mode. So,
 			 * read 2 and then discard the second byte.
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index b1b14ed0fd46..72cc11d3f1d3 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -53,10 +53,10 @@
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
 
-#define CYPRESS_NOR_RD_ANY_REG_OP(naddr, addr, ndummy, buf)		\
+#define CYPRESS_NOR_RD_ANY_REG_OP(naddr, addr, ncycles, buf)		\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 0),		\
 		   SPI_MEM_OP_ADDR(naddr, addr, 0),			\
-		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
+		   SPI_MEM_OP_DUMMY_CYCLES(ncycles, 0),			\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
 #define CYPRESS_NOR_EN4B_EX4B_OP(enable)				\
@@ -115,7 +115,7 @@ static int cypress_nor_sr_ready_and_clear_reg(struct spi_nor *nor, u64 addr)
 
 	if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
 		op.addr.nbytes = nor->addr_nbytes;
-		op.dummy.nbytes = params->rdsr_dummy;
+		op.dummy.ncycles = params->rdsr_dummy;
 		op.data.nbytes = 2;
 	}
 

-- 
2.56.0

