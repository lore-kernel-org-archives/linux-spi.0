Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4B41B352;
	Wed, 29 Apr 2026 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485483; cv=none; b=UHUBfeaXkPym6q4b6mtc1hbXur7D6j47PwhtNDCVKAOqJCnjiQqP6Yxl34BitCmx7ZIHqkb/UEznsQlicajndMKfE0jwkvjEHR+dvQM652zn0CcVVsSjUDDTgZ090DT5nDMYRC/tKCjKCpzgqfpiaRpQje2CsF03hSECpp9CIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485483; c=relaxed/simple;
	bh=adXdJ+I+WcixMjrUXc6N5cC5ru4yXVEX+wE2UFbNaqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBT5rw1t15Na/bswOgbIyTgcLhpTQ76mNPRZUFGPY89S+yc7jxeVpZizu+xc4Vl9pvfzSQN5cCmWplrWLMUvzAJUaC7K2vPuUqkLhEi24VuQT2NH5TPDP2ewjVNDhBKlF6LMJ9+nSRacJUu5RZ+JujU3WvZDR1oqm0itEkYXXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ufpsxmOn; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ufpsxmOn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C45C11A3452;
	Wed, 29 Apr 2026 17:58:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FE375FD43;
	Wed, 29 Apr 2026 17:58:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6862E1072B175;
	Wed, 29 Apr 2026 19:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5kdA1IC/RYXviplmXjfBx2K4qGRHF5L/z4JMU8G7heo=;
	b=ufpsxmOnbM4aWlTqONbvM/hU0uS6dcXEqlxSHSr1HWYBIfGT90YPkgaK0cuFSbVDO2ePk8
	pWi3bwyR8ypZOab+t1cJA74MjXfz7fLvozJ6V7qmbhj3f34ty/OOJYwRbTAzFsAix386Ly
	D1FsPPSsy7tCoNaMLBxBDPlrFb/XK+/uCgMaGjsQ2R+B/RuAlAGmsUx5DuKH7qOrDHX7rD
	xayotK3EyInONV8I9cHKvaHPdCz3+n8OX+quL0wUzfkGZxlSYM7f+O8L+6M140LefKPS6/
	+pSdGDvUfdVqb0jYh6gv0v4c1CPJTYtO1hzRdfUdURt2Ao08UPOejiDAM7KKqQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:43 +0200
Subject: [PATCH v3 06/11] mtd: spinand: Use secondary ops for continuous
 reads
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-6-0f38b3c229ad@bootlin.com>
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

In case a chip supports continuous reads, but uses a slightly different
cache operation for these, it may provide a secondary operation template
which will be used only during continuous cache read operations.

From a vendor driver point of view, enabling this feature implies
providing a new set of templates for these continuous read
operations. The core will automatically pick the fastest variant,
depending on the hardware capabilities.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spinand.h | 12 +++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index a66510747b31..45c3afb9cceb 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -489,6 +489,11 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 
 	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
 
+	if (spinand->op_templates->cont_read_cache && req->continuous)
+		rdesc->info.op_tmpl = &rdesc->info.secondary_op_tmpl;
+	else
+		rdesc->info.op_tmpl = &rdesc->info.primary_op_tmpl;
+
 	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
 	    req->mode != MTD_OPS_RAW)
 		rdesc->info.op_tmpl->data.ecc = true;
@@ -1221,6 +1226,7 @@ static struct spi_mem_dirmap_desc *spinand_create_rdesc(
 		 * its spi controller, use regular reading
 		 */
 		spinand->cont_read_possible = false;
+		memset(&info->secondary_op_tmpl, 0, sizeof(info->secondary_op_tmpl));
 
 		info->length = nanddev_page_size(nand) +
 			       nanddev_per_page_oobsize(nand);
@@ -1237,11 +1243,24 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
-	bool enable_ecc = false;
+	bool enable_ecc = false, secondary_op = false;
 
 	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED)
 		enable_ecc = true;
 
+	if (spinand->cont_read_possible && spinand->op_templates->cont_read_cache)
+		secondary_op = true;
+
+	/*
+	 * Continuous read implies that only the main data is retrieved, backed
+	 * by an on-die ECC engine. It is not possible to use a pipelind ECC
+	 * engine with continuous read.
+	 */
+	if (enable_ecc && secondary_op) {
+		secondary_op = false;
+		spinand->cont_read_possible = false;
+	}
+
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1259,6 +1278,10 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	/* Read descriptor */
 	info.primary_op_tmpl = *spinand->op_templates->read_cache;
 	info.primary_op_tmpl.data.ecc = enable_ecc;
+	if (secondary_op) {
+		info.secondary_op_tmpl = *spinand->op_templates->cont_read_cache;
+		info.secondary_op_tmpl.data.ecc = enable_ecc;
+	}
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
@@ -1607,6 +1630,33 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		if (ret)
 			return ret;
 
+		if (info->op_variants.cont_read_cache) {
+			op = spinand_select_op_variant(spinand, SSDR,
+						       info->op_variants.cont_read_cache);
+			if (op) {
+				const struct spi_mem_op *read_op;
+
+				read_op = spinand->ssdr_op_templates.read_cache;
+
+				/*
+				 * Sometimes the fastest continuous read variant may not
+				 * be supported. In this case, prefer to use the fastest
+				 * read from cache variant and disable continuous reads.
+				 */
+				if (read_op->cmd.buswidth > op->cmd.buswidth ||
+				    (read_op->cmd.dtr && !op->cmd.dtr) ||
+				    read_op->addr.buswidth > op->addr.buswidth ||
+				    (read_op->addr.dtr && !op->addr.dtr) ||
+				    read_op->data.buswidth > op->data.buswidth ||
+				    (read_op->data.dtr && !op->data.dtr))
+					spinand->cont_read_possible = false;
+				else
+					spinand->ssdr_op_templates.cont_read_cache = op;
+			} else {
+				spinand->cont_read_possible = false;
+			}
+		}
+
 		/* I/O variants selection with octo-spi DDR commands (optional) */
 
 		ret = spinand_init_odtr_instruction_set(spinand);
@@ -1629,6 +1679,15 @@ int spinand_match_and_init(struct spinand_device *spinand,
 					       info->op_variants.update_cache);
 		spinand->odtr_op_templates.update_cache = op;
 
+		if (info->op_variants.cont_read_cache) {
+			op = spinand_select_op_variant(spinand, ODTR,
+						       info->op_variants.cont_read_cache);
+			if (op)
+				spinand->odtr_op_templates.cont_read_cache = op;
+			else
+				spinand->cont_read_possible = false;
+		}
+
 		return 0;
 	}
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 896e9b5de0c4..4ff3f3383d46 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -576,6 +576,7 @@ enum spinand_bus_interface {
  * @op_variants.read_cache: variants of the read-cache operation
  * @op_variants.write_cache: variants of the write-cache operation
  * @op_variants.update_cache: variants of the update-cache operation
+ * @op_variants.cont_read_cache: variants of the continuous read-cache operation
  * @vendor_ops: vendor specific operations
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
@@ -600,6 +601,7 @@ struct spinand_info {
 		const struct spinand_op_variants *read_cache;
 		const struct spinand_op_variants *write_cache;
 		const struct spinand_op_variants *update_cache;
+		const struct spinand_op_variants *cont_read_cache;
 	} op_variants;
 	const struct spinand_op_variants *vendor_ops;
 	int (*select_target)(struct spinand_device *spinand,
@@ -629,6 +631,14 @@ struct spinand_info {
 		.update_cache = __update,				\
 	}
 
+#define SPINAND_INFO_OP_VARIANTS_WITH_CONT(__read, __write, __update, __cont_read) \
+	{								\
+		.read_cache = __read,					\
+		.write_cache = __write,					\
+		.update_cache = __update,				\
+		.cont_read_cache = __cont_read,				\
+	}
+
 #define SPINAND_INFO_VENDOR_OPS(__ops)					\
 	.vendor_ops = __ops
 
@@ -700,6 +710,7 @@ struct spinand_dirmap {
  * @read_cache: read cache op template
  * @write_cache: write cache op template
  * @update_cache: update cache op template
+ * @cont_read_cache: continuous read cache op template (optional)
  */
 struct spinand_mem_ops {
 	struct spi_mem_op reset;
@@ -714,6 +725,7 @@ struct spinand_mem_ops {
 	const struct spi_mem_op *read_cache;
 	const struct spi_mem_op *write_cache;
 	const struct spi_mem_op *update_cache;
+	const struct spi_mem_op *cont_read_cache;
 };
 
 /**

-- 
2.53.0

