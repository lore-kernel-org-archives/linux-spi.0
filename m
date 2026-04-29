Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2F241B349;
	Wed, 29 Apr 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485475; cv=none; b=m0HmT8QO75QnEMOZSLqDZqKPtJIuxgXqdIjx2efGm07qwVO/wEv49PiuIe5CSTYUA9Zd4gH6uWiGaz+vRkM6u9gFoijE13LNLO/6rgPnT3InpJVufwPyfPzY4yftPb33XWpQ0xFk3tEqc3IW0DYB5Ea3oVaONK/ys0bQJNh0WkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485475; c=relaxed/simple;
	bh=BOWkmd0zvsP4UHnJCCxkVdfwlM3xM1hOl21UD6l/NMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z8Jl2cUIllaOG8NBWHHR8ZdWlbGYX6ynMFKWKIUmuco+SOYPq0R0/DllYR/gMrnfyQbr/VIojjbsYbUDDGvX5pOdKYau4Afy4t7VVoD3a+xS8QXPNbw/XQqrzPintT+gHqLLBV5dlowjK4gRHlUs2H8A+cKLKn9GU0GFPMRE11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zNm+Ffi/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zNm+Ffi/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1DE281A3445;
	Wed, 29 Apr 2026 17:57:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6A625FD43;
	Wed, 29 Apr 2026 17:57:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17C121072B158;
	Wed, 29 Apr 2026 19:57:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485469; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yFQWpGXRfJAmrHLeBgm6kc2xglR3Fv5EghBUWQsY1Nk=;
	b=zNm+Ffi/6ezZMy6DwTh151pKgiOVgPBisspcIGedvwWOvv7SemEzu8DBkPpUArxO8wmQoy
	ZqQbAdOmWkEicjB0O1pVZPCJQXWlMQ8/xJvhZ+7n19dEqoazFbxftEv4yRMx5aNzKEnMPX
	KylWMWcXOPO18qPUgkMbG9Z5FOckORYvQSAZgaXr0O80NSWv786732KYJZcEDVIjlAgWVD
	Tb9SOVKOb7XC5m/pXCSKWz/+m4FlhTrIctcz/xTam0fS9fpRZ2A6BJNhZVnJC1SpNmNo1v
	8q9/YkjqOuh68v+E6lLH1hb2/aA2czHcWoLZTevUILsrN/I/gV9v76M/7Fbu2w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:41 +0200
Subject: [PATCH v3 04/11] spi: spi-mem: Transform the read operation
 template
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-4-0f38b3c229ad@bootlin.com>
References: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
In-Reply-To: <20260429-winbond-v6-18-rc1-cont-read-v3-0-0f38b3c229ad@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

As of now, we only use a single operation template when creating SPI
memory direct mappings. With the idea to extend this possibility to 2,
rename the template to reflect that we are currently setting the
"primary" operation, and create a pointer in the same structure to point
to it.

From a user point of view, the op_tmpl name remains but becomes a
pointer, leading to minor changes in both the SPI NAND and SPI NOR
cores.

There is no functional change.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c   | 15 ++++++++-------
 drivers/mtd/spi-nor/core.c    | 22 ++++++++++++----------
 drivers/spi/spi-airoha-snfi.c |  6 +++---
 drivers/spi/spi-aspeed-smc.c  |  4 ++--
 drivers/spi/spi-intel.c       |  6 +++---
 drivers/spi/spi-mem.c         | 15 ++++++++-------
 drivers/spi/spi-mxic.c        | 18 +++++++++---------
 drivers/spi/spi-npcm-fiu.c    | 16 ++++++++--------
 drivers/spi/spi-rpc-if.c      |  8 ++++----
 drivers/spi/spi-stm32-ospi.c  |  6 +++---
 drivers/spi/spi-stm32-qspi.c  |  6 +++---
 drivers/spi/spi-wpcm-fiu.c    |  2 +-
 include/linux/spi/spi-mem.h   |  3 ++-
 13 files changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 663f5d6a6bd7..a66510747b31 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -491,9 +491,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
 	    req->mode != MTD_OPS_RAW)
-		rdesc->info.op_tmpl.data.ecc = true;
+		rdesc->info.op_tmpl->data.ecc = true;
 	else
-		rdesc->info.op_tmpl.data.ecc = false;
+		rdesc->info.op_tmpl->data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -586,9 +586,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 
 	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
 	    req->mode != MTD_OPS_RAW)
-		wdesc->info.op_tmpl.data.ecc = true;
+		wdesc->info.op_tmpl->data.ecc = true;
 	else
-		wdesc->info.op_tmpl.data.ecc = false;
+		wdesc->info.op_tmpl->data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -1247,7 +1247,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	/* Write descriptor */
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl = *spinand->op_templates->update_cache;
+	info.primary_op_tmpl.data.ecc = enable_ecc;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1256,8 +1257,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	spinand->dirmaps[plane].wdesc = desc;
 
 	/* Read descriptor */
-	info.op_tmpl = *spinand->op_templates->read_cache;
-	info.op_tmpl.data.ecc = enable_ecc;
+	info.primary_op_tmpl = *spinand->op_templates->read_cache;
+	info.primary_op_tmpl.data.ecc = enable_ecc;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5dd0b3cb5250..a7bc458edc5c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3641,14 +3641,15 @@ EXPORT_SYMBOL_GPL(spi_nor_scan);
 static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-				      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
-				      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
+		.op_tmpl = &info.primary_op_tmpl,
+		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 0),
+					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+					      SPI_MEM_OP_DUMMY(nor->read_dummy, 0),
+					      SPI_MEM_OP_DATA_IN(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
+	struct spi_mem_op *op = info.op_tmpl;
 
 	spi_nor_spimem_setup_op(nor, op, nor->read_proto);
 
@@ -3672,14 +3673,15 @@ static int spi_nor_create_read_dirmap(struct spi_nor *nor)
 static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 {
 	struct spi_mem_dirmap_info info = {
-		.op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
-				      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
-				      SPI_MEM_OP_NO_DUMMY,
-				      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
+		.op_tmpl = &info.primary_op_tmpl,
+		.primary_op_tmpl = SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 0),
+					      SPI_MEM_OP_ADDR(nor->addr_nbytes, 0, 0),
+					      SPI_MEM_OP_NO_DUMMY,
+					      SPI_MEM_OP_DATA_OUT(0, NULL, 0)),
 		.offset = 0,
 		.length = nor->params->size,
 	};
-	struct spi_mem_op *op = &info.op_tmpl;
+	struct spi_mem_op *op = info.op_tmpl;
 
 	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
 		op->addr.nbytes = 0;
diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 7b6c09f91fef..95bfde7c8e7f 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -546,7 +546,7 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.length > SPI_NAND_CACHE_SIZE)
 		return -E2BIG;
 
-	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
+	if (!airoha_snand_supports_op(desc->mem, desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -572,7 +572,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
 	 */
-	opcode = desc->info.op_tmpl.cmd.opcode;
+	opcode = desc->info.op_tmpl->cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
 	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
@@ -761,7 +761,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	/* minimum oob size is 64 */
 	bytes = round_up(offs + len, 64);
 
-	opcode = desc->info.op_tmpl.cmd.opcode;
+	opcode = desc->info.op_tmpl->cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
 	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index c21323e07d3c..c20a33734f5c 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -697,7 +697,7 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->controller);
 	struct aspeed_spi_chip *chip = &aspi->chips[spi_get_chipselect(desc->mem->spi, 0)];
-	struct spi_mem_op *op = &desc->info.op_tmpl;
+	struct spi_mem_op *op = desc->info.op_tmpl;
 	u32 ctl_val;
 	int ret = 0;
 
@@ -769,7 +769,7 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (chip->ahb_window_size < offset + len || chip->force_user_mode) {
 		int ret;
 
-		ret = aspeed_spi_read_user(chip, &desc->info.op_tmpl, offset, len, buf);
+		ret = aspeed_spi_read_user(chip, desc->info.op_tmpl, offset, len, buf);
 		if (ret < 0)
 			return ret;
 	} else {
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 1775ad39e633..7494b921a743 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -814,7 +814,7 @@ static int intel_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	struct intel_spi *ispi = spi_controller_get_devdata(desc->mem->spi->controller);
 	const struct intel_spi_mem_op *iop;
 
-	iop = intel_spi_match_mem_op(ispi, &desc->info.op_tmpl);
+	iop = intel_spi_match_mem_op(ispi, desc->info.op_tmpl);
 	if (!iop)
 		return -EOPNOTSUPP;
 
@@ -827,7 +827,7 @@ static ssize_t intel_spi_dirmap_read(struct spi_mem_dirmap_desc *desc, u64 offs,
 {
 	struct intel_spi *ispi = spi_controller_get_devdata(desc->mem->spi->controller);
 	const struct intel_spi_mem_op *iop = desc->priv;
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	/* Fill in the gaps */
@@ -844,7 +844,7 @@ static ssize_t intel_spi_dirmap_write(struct spi_mem_dirmap_desc *desc, u64 offs
 {
 	struct intel_spi *ispi = spi_controller_get_devdata(desc->mem->spi->controller);
 	const struct intel_spi_mem_op *iop = desc->priv;
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = offs;
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a09371a075d2..e2eaa1ba4ff6 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(spi_mem_calc_op_duration);
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = desc->info.offset + offs;
@@ -667,7 +667,7 @@ static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
 				       u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op op = desc->info.op_tmpl;
+	struct spi_mem_op op = *desc->info.op_tmpl;
 	int ret;
 
 	op.addr.val = desc->info.offset + offs;
@@ -706,11 +706,11 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 	int ret = -ENOTSUPP;
 
 	/* Make sure the number of address cycles is between 1 and 8 bytes. */
-	if (!info->op_tmpl.addr.nbytes || info->op_tmpl.addr.nbytes > 8)
+	if (!info->primary_op_tmpl.addr.nbytes || info->primary_op_tmpl.addr.nbytes > 8)
 		return ERR_PTR(-EINVAL);
 
 	/* data.dir should either be SPI_MEM_DATA_IN or SPI_MEM_DATA_OUT. */
-	if (info->op_tmpl.data.dir == SPI_MEM_NO_DATA)
+	if (info->primary_op_tmpl.data.dir == SPI_MEM_NO_DATA)
 		return ERR_PTR(-EINVAL);
 
 	desc = kzalloc_obj(*desc);
@@ -719,6 +719,7 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 
 	desc->mem = mem;
 	desc->info = *info;
+	desc->info.op_tmpl = &desc->info.primary_op_tmpl;
 	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create) {
 		ret = spi_mem_access_start(mem);
 		if (ret) {
@@ -733,7 +734,7 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 
 	if (ret) {
 		desc->nodirmap = true;
-		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		if (!spi_mem_supports_op(desc->mem, &desc->info.primary_op_tmpl))
 			ret = -EOPNOTSUPP;
 		else
 			ret = 0;
@@ -857,7 +858,7 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	struct spi_controller *ctlr = desc->mem->spi->controller;
 	ssize_t ret;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_IN)
 		return -EINVAL;
 
 	if (!len)
@@ -903,7 +904,7 @@ ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct spi_controller *ctlr = desc->mem->spi->controller;
 	ssize_t ret;
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_OUT)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_OUT)
 		return -EINVAL;
 
 	if (!len)
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index b0e7fc828a50..83b688e65284 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -403,20 +403,20 @@ static ssize_t mxic_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
 		return -EINVAL;
 
-	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, desc->info.op_tmpl.data.swap16),
+	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, desc->info.op_tmpl->data.swap16),
 	       mxic->regs + HC_CFG);
 
-	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
+	writel(mxic_spi_mem_prep_op_cfg(desc->info.op_tmpl, len),
 	       mxic->regs + LRD_CFG);
 	writel(desc->info.offset + offs, mxic->regs + LRD_ADDR);
 	len = min_t(size_t, len, mxic->linear.size);
 	writel(len, mxic->regs + LRD_RANGE);
-	writel(LMODE_CMD0(desc->info.op_tmpl.cmd.opcode) |
+	writel(LMODE_CMD0(desc->info.op_tmpl->cmd.opcode) |
 	       LMODE_SLV_ACT(spi_get_chipselect(desc->mem->spi, 0)) |
 	       LMODE_EN,
 	       mxic->regs + LRD_CTRL);
 
-	if (mxic->ecc.use_pipelined_conf && desc->info.op_tmpl.data.ecc) {
+	if (mxic->ecc.use_pipelined_conf && desc->info.op_tmpl->data.ecc) {
 		ret = mxic_ecc_process_data_pipelined(mxic->ecc.pipelined_engine,
 						      NAND_PAGE_READ,
 						      mxic->linear.dma + offs);
@@ -448,20 +448,20 @@ static ssize_t mxic_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
 		return -EINVAL;
 
-	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, desc->info.op_tmpl.data.swap16),
+	writel(mxic_spi_prep_hc_cfg(desc->mem->spi, 0, desc->info.op_tmpl->data.swap16),
 	       mxic->regs + HC_CFG);
 
-	writel(mxic_spi_mem_prep_op_cfg(&desc->info.op_tmpl, len),
+	writel(mxic_spi_mem_prep_op_cfg(desc->info.op_tmpl, len),
 	       mxic->regs + LWR_CFG);
 	writel(desc->info.offset + offs, mxic->regs + LWR_ADDR);
 	len = min_t(size_t, len, mxic->linear.size);
 	writel(len, mxic->regs + LWR_RANGE);
-	writel(LMODE_CMD0(desc->info.op_tmpl.cmd.opcode) |
+	writel(LMODE_CMD0(desc->info.op_tmpl->cmd.opcode) |
 	       LMODE_SLV_ACT(spi_get_chipselect(desc->mem->spi, 0)) |
 	       LMODE_EN,
 	       mxic->regs + LWR_CTRL);
 
-	if (mxic->ecc.use_pipelined_conf && desc->info.op_tmpl.data.ecc) {
+	if (mxic->ecc.use_pipelined_conf && desc->info.op_tmpl->data.ecc) {
 		ret = mxic_ecc_process_data_pipelined(mxic->ecc.pipelined_engine,
 						      NAND_PAGE_WRITE,
 						      mxic->linear.dma + offs);
@@ -509,7 +509,7 @@ static int mxic_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
-	if (!mxic_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+	if (!mxic_spi_mem_supports_op(desc->mem, desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 6617751009c3..4b825044038b 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -299,11 +299,11 @@ static ssize_t npcm_fiu_direct_read(struct spi_mem_dirmap_desc *desc,
 		for (i = 0 ; i < len ; i++)
 			*(buf_rx + i) = ioread8(src + i);
 	} else {
-		if (desc->info.op_tmpl.addr.buswidth != fiu->drd_op.addr.buswidth ||
-		    desc->info.op_tmpl.dummy.nbytes != fiu->drd_op.dummy.nbytes ||
-		    desc->info.op_tmpl.cmd.opcode != fiu->drd_op.cmd.opcode ||
-		    desc->info.op_tmpl.addr.nbytes != fiu->drd_op.addr.nbytes)
-			npcm_fiu_set_drd(fiu, &desc->info.op_tmpl);
+		if (desc->info.op_tmpl->addr.buswidth != fiu->drd_op.addr.buswidth ||
+		    desc->info.op_tmpl->dummy.nbytes != fiu->drd_op.dummy.nbytes ||
+		    desc->info.op_tmpl->cmd.opcode != fiu->drd_op.cmd.opcode ||
+		    desc->info.op_tmpl->addr.nbytes != fiu->drd_op.addr.nbytes)
+			npcm_fiu_set_drd(fiu, desc->info.op_tmpl);
 
 		memcpy_fromio(buf_rx, src, len);
 	}
@@ -609,7 +609,7 @@ static int npcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	}
 
 	if (!fiu->spix_mode &&
-	    desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT) {
+	    desc->info.op_tmpl->data.dir == SPI_MEM_DATA_OUT) {
 		desc->nodirmap = true;
 		return 0;
 	}
@@ -644,9 +644,9 @@ static int npcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 				   NPCM_FIU_CFG_FIU_FIX);
 	}
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN) {
+	if (desc->info.op_tmpl->data.dir == SPI_MEM_DATA_IN) {
 		if (!fiu->spix_mode)
-			npcm_fiu_set_drd(fiu, &desc->info.op_tmpl);
+			npcm_fiu_set_drd(fiu, desc->info.op_tmpl);
 		else
 			npcm_fiux_set_direct_rd(fiu);
 
diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 6edc0c4db854..1ef7bd91b3b3 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -83,7 +83,7 @@ static ssize_t xspi_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (offs + desc->info.offset + len > U32_MAX)
 		return -EINVAL;
 
-	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
+	rpcif_spi_mem_prepare(desc->mem->spi, desc->info.op_tmpl, &offs, &len);
 
 	return xspi_dirmap_write(rpc->dev, offs, len, buf);
 }
@@ -97,7 +97,7 @@ static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (offs + desc->info.offset + len > U32_MAX)
 		return -EINVAL;
 
-	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
+	rpcif_spi_mem_prepare(desc->mem->spi, desc->info.op_tmpl, &offs, &len);
 
 	return rpcif_dirmap_read(rpc->dev, offs, len, buf);
 }
@@ -110,13 +110,13 @@ static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
-	if (!rpcif_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+	if (!rpcif_spi_mem_supports_op(desc->mem, desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
 	if (!rpc->dirmap)
 		return -EOPNOTSUPP;
 
-	if (!rpc->xspi && desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+	if (!rpc->xspi && desc->info.op_tmpl->data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
 	return 0;
diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 4461c6e24b9e..5f5b3cd5d725 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -602,11 +602,11 @@ static int stm32_ospi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct stm32_ospi *ospi = spi_controller_get_devdata(desc->mem->spi->controller);
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+	if (desc->info.op_tmpl->data.dir == SPI_MEM_DATA_OUT)
 		return -EOPNOTSUPP;
 
 	/* Should never happen, as mm_base == null is an error probe exit condition */
-	if (!ospi->mm_base && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+	if (!ospi->mm_base && desc->info.op_tmpl->data.dir == SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
 	if (!ospi->mm_size)
@@ -633,7 +633,7 @@ static ssize_t stm32_ospi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * spi_mem_op template with offs, len and *buf in  order to get
 	 * all needed transfer information into struct spi_mem_op
 	 */
-	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
+	memcpy(&op, desc->info.op_tmpl, sizeof(struct spi_mem_op));
 	dev_dbg(ospi->dev, "%s len = 0x%zx offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
 
 	op.data.nbytes = len;
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index df1bbacec90a..e2a6a6eaf9b2 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -506,11 +506,11 @@ static int stm32_qspi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct stm32_qspi *qspi = spi_controller_get_devdata(desc->mem->spi->controller);
 
-	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+	if (desc->info.op_tmpl->data.dir == SPI_MEM_DATA_OUT)
 		return -EOPNOTSUPP;
 
 	/* should never happen, as mm_base == null is an error probe exit condition */
-	if (!qspi->mm_base && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+	if (!qspi->mm_base && desc->info.op_tmpl->data.dir == SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
 	if (!qspi->mm_size)
@@ -536,7 +536,7 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * spi_mem_op template with offs, len and *buf in  order to get
 	 * all needed transfer information into struct spi_mem_op
 	 */
-	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
+	memcpy(&op, desc->info.op_tmpl, sizeof(struct spi_mem_op));
 	dev_dbg(qspi->dev, "%s len = 0x%zx offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
 
 	op.data.nbytes = len;
diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 0e26ff178505..cd78e927953d 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -377,7 +377,7 @@ static int wpcm_fiu_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	struct wpcm_fiu_spi *fiu = spi_controller_get_devdata(desc->mem->spi->controller);
 	int cs = spi_get_chipselect(desc->mem->spi, 0);
 
-	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+	if (desc->info.op_tmpl->data.dir != SPI_MEM_DATA_IN)
 		return -EOPNOTSUPP;
 
 	/*
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index c8e207522223..9a96ddace3eb 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -237,7 +237,8 @@ struct spi_mem_op {
  * direction is directly encoded in the ->op_tmpl.data.dir field.
  */
 struct spi_mem_dirmap_info {
-	struct spi_mem_op op_tmpl;
+	struct spi_mem_op *op_tmpl;
+	struct spi_mem_op primary_op_tmpl;
 	u64 offset;
 	u64 length;
 };

-- 
2.53.0

