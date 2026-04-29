Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7441B346
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485470; cv=none; b=WLwCUR+tVwaiU2NzUzko29yN/W1DY+3KXl+UFILbpbDj4I7TNjNT8/lOOnuYHHQ7KPAqX4yqZagknuWxXNQb8KQb2ZE935B51IiY9RD8jNDl22hFJkXFVgkM+Qb4vRUzsZVk37o6Vu77gFX8tFbDMAlXod7XboPcRfRfBfF795Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485470; c=relaxed/simple;
	bh=IlghUJ8CQ3gN7V/4c+I/BhZ/fG/rm5O/I49orTe7xSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lj2O1PinsH5I20lw0CsBPilUKDJgXil7RxDbYq6Xw2ID6NeDbcdwW6Yf0bay5+vOzyhCTncM/2q9YtNLTqu1eLFnEoHkwhYB3A4Z4btLx0IMireGqdN0TwCIdcg0mSM14OfjFcJto1jIXgdmt1Xdy3xccVG9ug5QXsdKshi/caE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uDsKwvQO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uDsKwvQO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ED9F7C5CD5D;
	Wed, 29 Apr 2026 17:58:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BABB15FD43;
	Wed, 29 Apr 2026 17:57:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C966E1072B171;
	Wed, 29 Apr 2026 19:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485465; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QdHHmy5KibUj7IOUfvRAtvrskjTvNN+KNx7nY11cePM=;
	b=uDsKwvQOEhv6WrNXDMP9ss0SW/69JMJHgvqRB8tshJUyUYKiLRCiM6vONo8b0Y8rcmqBd2
	BEABK7qva7LRm2ch44uFcuvG8mx9hdH2X0tMsCNHyRze3nTQMetp+I0I/QJ1rfejdggIGn
	X7Xzyl0AgBsSQxWeM+jW9LzsFGHgo6auF20jWVlet49Oi87WBUUHrFYCqb5wVjUTTO6+yA
	+bQzEtHGMLjcg6DzVm6/oVnNpjZlHFj0tm5qYGe1o5kqgg46w9Ku3um13/qpvofCq3I6Fj
	5YbuqF48vQSXbuDiBZE7f2ssG/IeOKERTDFuPuNGrlmT8oGKR7YlaxyAhJQT3Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:40 +0200
Subject: [PATCH v3 03/11] mtd: spinand: Drop ECC dirmaps
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-3-0f38b3c229ad@bootlin.com>
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

Direct mappings are very static concepts, which allow us to reuse a
template to perform reads or writes in a very efficient manner after a
single initialization. With the introduction of pipelined ECC engines
for SPI controllers, the need to differentiate between an operation with
and without correction has arised. The chosen solution at that time has
been to create new direct mappings for these operations, jumping from 2
to 4 dirmaps per target. Enabling ECC was done by choosing the correct
dirmap.

Today, we need to further parametrize dirmaps. With the goal to enable
continuous reads on a wider range of devices, we will need more
flexibility regarding the read from cache operation template to pick at
run time, for instance to use shorter "continuous read from cache"
variants.

We could create other direct mappings, but it would increase the matrix
by a power of two, bringing the theoretical number of dirmaps to
8 (read/write, ecc, shorter read variants) per target. This grow is not
sustainable, so let's change how dirmaps work - a little bit.

Operations already carry an ECC parameter, use it to indicate whether
error correction is required or not. In practice this change happens
only at the core level, SPI controller drivers do not care about the
direct mapping structure in this case, they just pick whatever is in the
template as a base. As a result, we allow the core to dynamically change
the content of the templates.

He who can do more can do less, so during the checking steps, make sure
to enable the ECC requirement just for the time of the checks.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 52 +++++++++++++++++----------------------------
 include/linux/mtd/spinand.h |  2 --
 2 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 1c3ac9ad650e..663f5d6a6bd7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -487,10 +487,13 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 		}
 	}
 
-	if (req->mode == MTD_OPS_RAW)
-		rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
+
+	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
+	    req->mode != MTD_OPS_RAW)
+		rdesc->info.op_tmpl.data.ecc = true;
 	else
-		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
+		rdesc->info.op_tmpl.data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -579,10 +582,13 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 			       req->ooblen);
 	}
 
-	if (req->mode == MTD_OPS_RAW)
-		wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
+
+	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED &&
+	    req->mode != MTD_OPS_RAW)
+		wdesc->info.op_tmpl.data.ecc = true;
 	else
-		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
+		wdesc->info.op_tmpl.data.ecc = false;
 
 	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
 		column |= req->pos.plane << fls(nanddev_page_size(nand));
@@ -1231,12 +1237,17 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	struct nand_device *nand = spinand_to_nand(spinand);
 	struct spi_mem_dirmap_info info = { 0 };
 	struct spi_mem_dirmap_desc *desc;
+	bool enable_ecc = false;
+
+	if (nand->ecc.engine->integration == NAND_ECC_ENGINE_INTEGRATION_PIPELINED)
+		enable_ecc = true;
 
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
+	/* Write descriptor */
 	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates->update_cache;
+	info.op_tmpl.data.ecc = enable_ecc;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
 	if (IS_ERR(desc))
@@ -1244,38 +1255,15 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	/* Read descriptor */
 	info.op_tmpl = *spinand->op_templates->read_cache;
+	info.op_tmpl.data.ecc = enable_ecc;
 	desc = spinand_create_rdesc(spinand, &info);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
 	spinand->dirmaps[plane].rdesc = desc;
 
-	if (nand->ecc.engine->integration != NAND_ECC_ENGINE_INTEGRATION_PIPELINED) {
-		spinand->dirmaps[plane].wdesc_ecc = spinand->dirmaps[plane].wdesc;
-		spinand->dirmaps[plane].rdesc_ecc = spinand->dirmaps[plane].rdesc;
-
-		return 0;
-	}
-
-	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
-	info.op_tmpl = *spinand->op_templates->update_cache;
-	info.op_tmpl.data.ecc = true;
-	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-					  spinand->spimem, &info);
-	if (IS_ERR(desc))
-		return PTR_ERR(desc);
-
-	spinand->dirmaps[plane].wdesc_ecc = desc;
-
-	info.op_tmpl = *spinand->op_templates->read_cache;
-	info.op_tmpl.data.ecc = true;
-	desc = spinand_create_rdesc(spinand, &info);
-	if (IS_ERR(desc))
-		return PTR_ERR(desc);
-
-	spinand->dirmaps[plane].rdesc_ecc = desc;
-
 	return 0;
 }
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index e1f19664bb25..896e9b5de0c4 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -684,8 +684,6 @@ struct spinand_info {
 struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *wdesc;
 	struct spi_mem_dirmap_desc *rdesc;
-	struct spi_mem_dirmap_desc *wdesc_ecc;
-	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
 /**

-- 
2.53.0

