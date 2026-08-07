Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E92385D86;
	Fri,  7 Aug 2026 14:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114027; cv=none; b=TO9PuP6xrZhCJR6FHu+Hih/ZrR8nLWiPruezo69pD1+ofrsrJRIOgzTkstkyQsbVvORDTAeYpUEnPHEMKCtA5cCdaJacmVkeqcJdyeSpnaroH6s8O1KgIJPJsxKTQ7761tUhI2PKWTTW2XpPa14nIhWMv5wDf1WyMIrAEsD0VCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114027; c=relaxed/simple;
	bh=34nP8aEvvy9g2UnYWqAitpMbHLwDw6SMjBwedXE/qzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyWgvEzkoX/kSkzBgA8wuuEDHbdSeBfPcy9AmLYsEeMp3U5DwyDgSBs8K+DGW8FKoXhEzG69jhuWSHWDrDGgsei8NIqrs3YIa1GB/O7vWaJRSnAWeDk7rLfVzhVX7y93XdZH95GDL3zOUgC45ySdfg9JR+bZkmg9MDVNRoB6o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dbn8EtWf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dbn8EtWf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D318C1A14B2;
	Fri,  7 Aug 2026 14:47:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A9437603F0;
	Fri,  7 Aug 2026 14:47:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A104B11C37A59;
	Fri,  7 Aug 2026 16:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786114016; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M+D8sTjzVeFMznbG6m+gAmQtgf1q7jLi1PF5q/MQlyA=;
	b=dbn8EtWfYv/MAAIJ3KDIGu2iZLV/pM0le0UcoLRVTdzkM5z1P5T7D1MWEAkvN9iDwkujfb
	ujsHB1D55R92/EVoLf/nC3QEXpDteFqE7rvR0Ps/FiEbPyHc3I+pkO/0mDOrrPGb+TrpUF
	Fuo7llqRrXHju0neRccFhOR5JeDuh3oEaU3e4pOBpDYB42vYaILTvOgKRq6bWrcSxNUO39
	cwyOP+ZvIzfuHcATZh5BRGagicZ/P9AqfjwxSKgZQJ2QahH0gvbBEEGmhpNdPh723isM0V
	ia624UYu0fsqTfrPran4scan5IAre5OTXtZ4oFkfEjwr0iUS38qoizsUI3cqKQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 07 Aug 2026 16:46:48 +0200
Subject: [PATCH v2 2/3] mtd: spi-nand: Set the DQS spi-mem capability if
 available
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-winbond-nand-next-phy-tuning-v2-2-73595e89d6e3@bootlin.com>
References: <20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com>
In-Reply-To: <20260807-winbond-nand-next-phy-tuning-v2-0-73595e89d6e3@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Check whether the NAND is capable of generating a DQS signal and set the
flag accordingly.

Not wiring the DQS signal on a DQS capable chip that will be used at
frequency requiring this signal may be considered a hardware bug, so
let's assume this line will be routed "in most cases". If/when we get
issues with this assumption, a DT property describing the lacking line
in the routing can be created.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 4 ++++
 include/linux/mtd/spinand.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 72a630b266f8..6ffd0f1b9c26 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -2057,6 +2057,10 @@ static int spinand_probe(struct spi_mem *mem)
 	read_op = *spinand->op_templates->read_cache;
 	write_op = *spinand->op_templates->write_cache;
 
+	/* Assume manufacturer drivers will enable the DQS pin if it is available */
+	if (spinand->flags & SPINAND_HAS_DQS)
+		spi_mem_set_dqs(mem);
+
 	ret = spi_mem_execute_tuning(mem, &read_op, &write_op);
 	if (ret && ret != -EOPNOTSUPP) {
 		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index ec6efcfeef83..fe05b477afef 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -490,6 +490,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
 #define SPINAND_NO_RAW_ACCESS				BIT(4)
 #define SPINAND_ODTR_PACKED_PAGE_READ			BIT(5)
+#define SPINAND_HAS_DQS					BIT(6)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure

-- 
2.54.0

