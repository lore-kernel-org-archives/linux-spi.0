Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2B34014AD;
	Thu, 26 Mar 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542373; cv=none; b=LWHu9lkdZsGFUDMVqXT5BuCdLTkAlLyJtQWlPiy4zbcB2tgXXqNctN7DAforAjHhR+gPDUYW2Uj84gHAb6W/Yt+CmNXF/hJ6FQx5T7nfch1NaBawrOZtjTak9WUbpt7Cj23qSW/AJHXyXBD1gyWjYXENO5sOYNxkeSBXSk1tzeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542373; c=relaxed/simple;
	bh=1qAwgYBYxcVwcDIE2uE5OIZ8/YPcuSRMYTt2Fey1oDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NAwnUg+524lL6Q+M6U+C1xv7I7IVKlIwpI1zQYCO2dwKWAT02w7z0blW3MJr/OryZ86lgcosHwbyGJNF4AzNWBnGN2tkujgNAZg4Zlgh6Y9nidODOH8+QuKBQnbAkoJ6BFTY76ncJDChnPr/XbAB7VuB/o/NZFuBAfGWyofJi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rQsdjbtr; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rQsdjbtr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B3C01C566BF;
	Thu, 26 Mar 2026 16:26:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 689C9601FA;
	Thu, 26 Mar 2026 16:26:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A2DF10450C96;
	Thu, 26 Mar 2026 17:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542369; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=DPHFbgTjzei/1jBDgO0a2BCQqxzdoh8f4pF7F/hFt2Y=;
	b=rQsdjbtrg89dCgLudpF3emrB1tcz8lpYZ8tbtHlMK9iSNj7HxqMCYAF6OI+JGDpv//MhtV
	PYHiG8rZR28gVgX2VjRD/dt0Ykgcdvjsm6EHqP66CaEQpAHvON1XT3HjEZjRdQwSbvCaR3
	dcO249WK0IGH9sZRYSVTOAPSKzYWOArpY2i9CZecfpb++aQyP3PgPLLolW88SkJRy3wewU
	v7pJuIpKQatvr9g9LQqVBsRfpV7W29oObOSACAFvhtb2eVsUU+PLisEn9645ExS+xTAMsz
	oKNhpTSY/QLCgdhARX3lEZO8+fyQr7UAg89HIN9+gEfCdaFnL753QDPG1fKoVQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:25:49 +0100
Subject: [PATCH v2 02/11] mtd: spinand: Expose spinand_op_is_odtr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-2-643de97a68a3@bootlin.com>
References: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
In-Reply-To: <20260326-winbond-v6-18-rc1-cont-read-v2-0-643de97a68a3@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

This helper is going to be needed in a vendor driver, so expose it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 2 +-
 include/linux/mtd/spinand.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index fba3cc213c88..1c3ac9ad650e 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1400,7 +1400,7 @@ static void spinand_manufacturer_cleanup(struct spinand_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
 
-static bool spinand_op_is_odtr(const struct spi_mem_op *op)
+bool spinand_op_is_odtr(const struct spi_mem_op *op)
 {
 	return op->cmd.dtr && op->cmd.buswidth == 8;
 }
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6a024cf1c53a..29ce5827032a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -861,6 +861,8 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
 	nanddev_set_of_node(&spinand->base, np);
 }
 
+bool spinand_op_is_odtr(const struct spi_mem_op *op);
+
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
 			   unsigned int table_size,

-- 
2.51.1

