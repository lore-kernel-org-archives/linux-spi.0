Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629123;
	b=lXRLxfKuiYE8DuOgXRjUYYVnH4KdRLqVHL3n2Q9fGjgSXTIWUU5w4ezEd1g73JJ5sFlj
	 t7g/aqpdCsfWq+z2fnwCnMiBVOh5Qty1HwozspMPFyIChjLj+szb5DeryA4SWxBW/Uzro
	 bHEvLGk5YWtecmPbwBgsXmuVvqT9v5fk1YrfNOVqS/tGS5A6+gv1yz1egSFuUz3zVxJRS
	 G4+XjaDY3Gyj/FDtXiu9bfEv3Yof1PX5jEHQX6ZUzodLMIBjgmC0aAFxbZpyAch7raN98
	 Fx32VzNLSMKRJ9m8A52JGv+H52dOXMD0/OmST8RkTqVuKjaEhGrz4DHWiZf8X+/qZ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629123;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=GQD0KqPLEg59WKn9NwM4ZR/XsyWWKF9wI7wGZv4tHyY=;
	b=b/CKbgjjUpXGYqPm1/i3abX4JcIFuSs3rL8CVkG4hUqCIfgeh4V13FlJP+scVFU+xP5e
	 UT+fW8dGy6jqBgUHEW7paeAcX8NcYrPcULrNWvpraaIgl4QpBHojiM0SEnVM8AzWBWyfV
	 vuks1uMK6vw46QsYYYbSaP8s/h14uWu8Ooi5jICKG2ALwgIwSfQBGG7+FVQrCPTLMb//Z
	 NxIxMGUmP++sx4q2aDFaOAxFE832xHGX2JiuNj0m4GqAOOM0fOyHvEnha/48py5ZEfur6
	 6SZaMNn0dayMi3cCteu1uZ129oVNrUWdlJdLPEEP/X+STCdRvqWmGuXin0X2aOsG70Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gHui8AAD;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6769A606A339
	for <linux-spi@vger.kernel.org>; Wed, 25 Nov 2026 17:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6769A606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gHui8AAD
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 229674E41786;
	Wed, 25 Nov 2026 17:52:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EABC460480;
	Wed, 25 Nov 2026 17:52:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7BC711E6B0CB;
	Wed, 25 Nov 2026 18:51:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795629117; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=GQD0KqPLEg59WKn9NwM4ZR/XsyWWKF9wI7wGZv4tHyY=;
	b=gHui8AADsI8ARDYup1GN6KblrE2NtWjBrQ8GEoxbqrtqq+MuqcukYnuZ7VCgQ3vpOdXGom
	5T506AMMHVfokajjn+pLuvcm/Pq5EE2N98p765VQP2Pvrq/RMF9ZFxFcR7L5ZJpJRywDa1
	BMoDyxmOcOEoE5IkIyuernv4Av1bHkIctbEsvl1U4R3uAPchw2OvNKyb5AuZasZ0CRDihj
	qQPp1+eRPRc77jdQuJ4Q9B5DrEyo20QY2/CbEKTTlkeymozjJL5YEtf/gTklhLohJ9VQW8
	DW46IXCL+5ZWBlU7afH2IiSRP8NVudj2577BY5fPszjE/OuklHOmPVfsgm8bYg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 25 Nov 2026 18:51:17 +0100
Subject: [PATCH RFC 03/16] spi: spi-mem: Add support for dummy cycles
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
Message-Id: <20261125-macronix-upstreaming-spi-mem-cycles-v1-3-fd036402fd37@bootlin.com>
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

The dummy phase is a number of clock cycles, not a number of bytes. SPI
NOR flashes commonly require a number of dummy cycles that is not a
multiple of 8, and the byte-based representation cannot express it.

Add a dummy.ncycles field and make it the primary representation. Keep
dummy.nbytes for the legacy byte-oriented controllers and users. The two
fields are mutually exclusive and spi_mem_check_op() enforces that rule.

Controllers that can program an arbitrary number of cycles advertise the
dummy_cycles capability and consume dummy.ncycles directly. The core
converts the legacy dummy.nbytes to cycles for them, so the users that
still describe the dummy phase in bytes keep working. If the byte count
cannot be expressed as a whole number of cycles, the operation is
rejected.

For the other controllers the core converts dummy.ncycles to the legacy
dummy.nbytes representation using the usual maths. If the cycle count
cannot be represented exactly, the operation is rejected instead of
being silently truncated.

Link: https://lore.kernel.org/all/20220911174551.653599-1-sergiu.moga@microchip.com/
Link: https://lore.kernel.org/all/20250115134158.19908-1-pratyush@kernel.org/

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c       | 181 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/spi/spi-mem.h |  36 ++++++++-
 2 files changed, 205 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9b8b8f2b3387..7f5849bf1a0d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -224,6 +224,134 @@ static bool spi_mem_buswidth_is_valid(u8 buswidth)
 	return true;
 }
 
+/**
+ * spi_mem_dummy_cycles_to_bytes() - Convert the dummy phase cycles to bytes
+ * @op: the SPI memory operation
+ *
+ * Return: the number of dummy bytes on success, a negative error code if the
+ *	   dummy phase cannot be represented as a whole number of bytes.
+ *	   If @op->dummy.ncycles is zero, @op->dummy.nbytes is returned.
+ *
+ * This helper can be used to convert dummy cycles into dummy bytes for
+ * controllers that can only insert a whole number of dummy bytes.
+ */
+static int spi_mem_dummy_cycles_to_bytes(const struct spi_mem_op *op)
+{
+	u32 bits;
+
+	if (!op->dummy.ncycles)
+		return op->dummy.nbytes;
+
+	if (!op->dummy.buswidth)
+		return -EOPNOTSUPP;
+
+	bits = (u32)op->dummy.ncycles * op->dummy.buswidth;
+	if (op->dummy.dtr)
+		bits *= 2;
+
+	if (bits % 8 || bits / 8 > U8_MAX)
+		return -EOPNOTSUPP;
+
+	return bits / 8;
+}
+
+/**
+ * spi_mem_get_lossy_dummy_bytes() - Give a rounded number of dummy bytes
+ * @op: the SPI memory operation
+ *
+ * Return: an upper rounded amount of dummy bytes without touching the @op.
+ */
+static unsigned int spi_mem_get_lossy_dummy_bytes(const struct spi_mem_op *op)
+{
+	u32 bits;
+
+	if (!op->dummy.ncycles)
+		return op->dummy.nbytes;
+
+	if (!op->dummy.buswidth)
+		return 0;
+
+	bits = (u32)op->dummy.ncycles * op->dummy.buswidth;
+	if (op->dummy.dtr)
+		bits *= 2;
+
+	return DIV_ROUND_UP(bits, 8);
+}
+
+/**
+ * spi_mem_dummy_bytes_to_cycles() - Convert the dummy phase bytes to cycles
+ * @op: the SPI memory operation
+ *
+ * Return: the number of dummy clock cycles on success, a negative error code
+ *	   if the dummy phase cannot be represented as a whole number of clock
+ *	   cycles. If @op->dummy.nbytes is zero, @op->dummy.ncycles is returned.
+ *
+ * This helper can be used to convert inlet operations using dummy bytes
+ * into operations using dummy cycles.
+ */
+static int spi_mem_dummy_bytes_to_cycles(const struct spi_mem_op *op)
+{
+	u32 bits, bits_per_cycle;
+
+	if (!op->dummy.nbytes)
+		return op->dummy.ncycles;
+
+	bits_per_cycle = op->dummy.buswidth;
+	if (op->dummy.dtr)
+		bits_per_cycle *= 2;
+	if (!bits_per_cycle)
+		return -EOPNOTSUPP;
+
+	bits = (u32)op->dummy.nbytes * 8;
+	if (bits % bits_per_cycle)
+		return -EOPNOTSUPP;
+
+	bits /= bits_per_cycle;
+	if (bits > U8_MAX)
+		return -EOPNOTSUPP;
+
+	return bits;
+}
+
+/*
+ * Controllers either program the dummy phase in clock cycles or in whole
+ * bytes. Convert the representation used by the operation to the one the
+ * controller expects.
+ *
+ * Return: 0 if the operation is lossless, -EOPNOTSUPP otherwise.
+ */
+static int spi_mem_convert_dummy(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	int n;
+
+	if (op->dummy.ncycles) {
+		if (spi_mem_controller_is_capable(ctlr, dummy_cycles))
+			return 0;
+
+		n = spi_mem_dummy_cycles_to_bytes(op);
+		if (n < 0)
+			return n;
+
+		op->dummy.nbytes = n;
+		op->dummy.ncycles = 0;
+	} else if (op->dummy.nbytes) {
+		if (!spi_mem_controller_is_capable(ctlr, dummy_cycles))
+			return 0;
+
+		n = spi_mem_dummy_bytes_to_cycles(op);
+		if (n < 0)
+			return n;
+
+		op->dummy.ncycles = n;
+		op->dummy.nbytes = 0;
+
+		return 0;
+	}
+
+	return 0;
+}
+
 static int spi_mem_check_op(const struct spi_mem_op *op)
 {
 	if (!op->cmd.buswidth || !op->cmd.nbytes)
@@ -231,9 +359,13 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 
 	if ((op->addr.nbytes && !op->addr.buswidth) ||
 	    (op->dummy.nbytes && !op->dummy.buswidth) ||
+	    (op->dummy.ncycles && !op->dummy.buswidth) ||
 	    (op->data.nbytes && !op->data.buswidth))
 		return -EINVAL;
 
+	if (op->dummy.nbytes && op->dummy.ncycles)
+		return -EINVAL;
+
 	if (!spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
 	    !spi_mem_buswidth_is_valid(op->addr.buswidth) ||
 	    !spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
@@ -290,6 +422,9 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 */
 	spi_mem_adjust_op_freq(mem, &eval_op);
 
+	if (spi_mem_convert_dummy(mem, &eval_op))
+		return false;
+
 	if (spi_mem_check_op(&eval_op))
 		return false;
 
@@ -338,6 +473,7 @@ static void spi_mem_access_end(struct spi_mem *mem)
 static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
 				 const struct spi_mem_op *op, int exec_op_ret)
 {
+	int dummy_nbytes = spi_mem_get_lossy_dummy_bytes(op);
 	struct spi_statistics *stats;
 	u64 len, l2len;
 
@@ -354,7 +490,7 @@ static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
 
 	/* Use the sum of all lengths as bytes count and histogram value. */
 	len = op->cmd.nbytes + op->addr.nbytes;
-	len += op->dummy.nbytes + op->data.nbytes;
+	len += dummy_nbytes + op->data.nbytes;
 	u64_stats_add(&stats->bytes, len);
 	l2len = min(fls(len), SPI_STATISTICS_HISTO_SIZE) - 1;
 	u64_stats_inc(&stats->transfer_bytes_histo[l2len]);
@@ -381,7 +517,7 @@ static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
- * @op: the memory operation to execute
+ * @ro_op: the memory operation to execute (shall not be edited)
  *
  * Executes a memory operation.
  *
@@ -390,22 +526,28 @@ static void spi_mem_add_op_stats(struct spi_statistics __percpu *pcpu_stats,
  *
  * Return: 0 in case of success, a negative error code otherwise.
  */
-int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *ro_op)
 {
 	unsigned int tmpbufsize, xferpos = 0, totalxferlen = 0;
 	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_op wr_op = *ro_op, *op = &wr_op;
 	struct spi_transfer xfers[4] = { };
 	struct spi_message msg;
 	u8 *tmpbuf;
 	int ret;
 
 	/* Make sure the operation frequency is correct before going futher */
-	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
+	spi_mem_adjust_op_freq(mem, op);
+
+	/* Also make sure the dummy phase can be consumed by the controller */
+	ret = spi_mem_convert_dummy(mem, op);
+	if (ret)
+		return ret;
 
 	dev_vdbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%2dB dummy][%4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",
 		 op->cmd.opcode,
 		 op->addr.nbytes, (op->addr.nbytes ? op->addr.val : 0),
-		 op->dummy.nbytes,
+		 spi_mem_get_lossy_dummy_bytes(op),
 		 op->data.nbytes, (op->data.nbytes ? (op->data.dir == SPI_MEM_DATA_IN ? " read" : "write") : "     "),
 		 op->cmd.buswidth, op->cmd.dtr ? 'D' : 'S',
 		 op->addr.buswidth, op->addr.dtr ? 'D' : 'S',
@@ -597,6 +739,11 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
 	size_t len;
+	int ret;
+
+	ret = spi_mem_convert_dummy(mem, op);
+	if (ret)
+		return ret;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
@@ -673,9 +820,12 @@ u64 spi_mem_calc_op_duration(struct spi_mem *mem, struct spi_mem_op *op)
 	ncycles += ((op->cmd.nbytes * 8) / op->cmd.buswidth) / (op->cmd.dtr ? 2 : 1);
 	ncycles += ((op->addr.nbytes * 8) / op->addr.buswidth) / (op->addr.dtr ? 2 : 1);
 
-	/* Dummy bytes are optional for some SPI flash memory operations */
-	if (op->dummy.nbytes)
-		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) / (op->dummy.dtr ? 2 : 1);
+	/* Dummy cycles are optional for some SPI flash memory operations */
+	if (op->dummy.ncycles)
+		ncycles += op->dummy.ncycles;
+	else if (op->dummy.nbytes)
+		ncycles += ((op->dummy.nbytes * 8) / op->dummy.buswidth) /
+			   (op->dummy.dtr ? 2 : 1);
 
 	ncycles += ((op->data.nbytes * 8) / op->data.buswidth) / (op->data.dtr ? 2 : 1);
 
@@ -781,6 +931,21 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 	desc->mem = mem;
 	desc->info = *info;
 	desc->info.op_tmpl = &desc->info.primary_op_tmpl;
+
+	ret = spi_mem_convert_dummy(mem, &desc->info.primary_op_tmpl);
+	if (ret) {
+		kfree(desc);
+		return ERR_PTR(ret);
+	}
+
+	if (desc->info.secondary_op_tmpl.cmd.opcode) {
+		ret = spi_mem_convert_dummy(mem, &desc->info.secondary_op_tmpl);
+		if (ret) {
+			kfree(desc);
+			return ERR_PTR(ret);
+		}
+	}
+
 	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create) {
 		ret = spi_mem_access_start(mem);
 		if (ret) {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 0cce6b57242a..adc7f53b8474 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -75,6 +75,12 @@
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_OP_DUMMY_CYCLES(__ncycles, __buswidth)		\
+	{							\
+		.ncycles = __ncycles,				\
+		.buswidth = __buswidth,				\
+	}
+
 #define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\
@@ -82,6 +88,13 @@
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY_CYCLES(__ncycles, __buswidth)	\
+	{							\
+		.ncycles = __ncycles,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
@@ -154,10 +167,18 @@ enum spi_mem_data_dir {
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
  * @dummy: data for dummy operation
- * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
- *		  be zero if the operation does not require dummy bytes
- * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
- * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
+ * @dummy.ncycles: number of dummy clock cycles to insert after an opcode or
+ *		   address. Can be zero if the operation does not require
+ *		   dummy cycles. Mutually exclusive with @dummy.nbytes.
+ * @dummy.nbytes: legacy number of dummy bytes to send after an opcode or
+ *		  address. Can be zero if the operation does not require dummy
+ *		  bytes. Mutually exclusive with @dummy.ncycles.
+ * @dummy.buswidth: number of IO lanes used during the dummy phase. It is
+ *		    also used to convert @dummy.ncycles to bytes for controllers
+ *		    that can only insert a whole number of dummy bytes.
+ * @dummy.dtr: whether the dummy phase is clocked in DTR mode. This only
+ *	       describes the pin state and does not change the number of
+ *	       clock cycles.
  * @data: the data attributes
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
@@ -191,6 +212,7 @@ struct spi_mem_op {
 	} addr;
 
 	struct {
+		u8 ncycles;
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
@@ -392,6 +414,11 @@ struct spi_controller_mem_ops {
  *                   is a pause in the transfer (eg. internal bus contention or
  *                   DMA arbitration on an interconnect). Features such as NAND
  *                   continuous reads shall not be leveraged.
+ * @dummy_cycles: Supports programming the exact number of dummy clock cycles.
+ *                When set, the core converts the legacy @dummy.nbytes to clock
+ *                cycles. When unset, the core converts @dummy.ncycles to whole
+ *                dummy bytes for the controller and rejects operations that
+ *                cannot be converted exactly.
  */
 struct spi_controller_mem_caps {
 	bool dtr;
@@ -400,6 +427,7 @@ struct spi_controller_mem_caps {
 	bool per_op_freq;
 	bool secondary_op_tmpl;
 	bool no_cs_assertion;
+	bool dummy_cycles;
 };
 
 #define spi_mem_controller_is_capable(ctlr, cap)	\

-- 
2.56.0

