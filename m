Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C79406834
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374680; cv=none; b=TZvWJtn2XqjuAw26EphSpFvtZpJ68de0BmDkuHssNc2/Er6gWQSxskMYIf0sX6TpSIRjptY+1Svr2w/XbNtAtxf2Iq8CKxizjUSHhXvxhvNw4winiDUl4lmcSBj7XZ6eaZ8JAsZTAYkkfqLPDtIG2vJrHSZ4BF8lA6vI+MS799o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374680; c=relaxed/simple;
	bh=FcAC1w42S72T056CyzppaOWO2H02Mr/JVvvgm0ABlsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYRgzeM8iBrr56qUpmce+enj33gNi5KiKddHXUb2nKGZZVGK+Hk/sxMw2EHTiC5F7O9XOlle3JnfaWUS0IU5bc0M2zOi1EeF7KZE5mI50P981ICPcia1EpRw+Ej5wQblvgXI5unnKgMbBmUzKHTgtXu22l50tpPd7cWgPcEQCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qj4Q31l2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qj4Q31l2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8BC734E410F4;
	Mon, 10 Aug 2026 15:11:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 60ED56033B;
	Mon, 10 Aug 2026 15:11:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8916A11C4A9EE;
	Mon, 10 Aug 2026 17:11:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786374671; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CK2WRSq1MK+3g+V6+eHAiSzDyRizcyKiOdPn4mxRHrQ=;
	b=qj4Q31l2ntJSzOXcHUdWoRM7u96lrdcuozFS2fmbat/81N6n9PCOPldw1W0fbsToWVnB76
	xWuI+b2khf8gTTQgGJKjKIsnxWKcEMsJXF3ERUTa+hx2xOrIvbJxi2qATvqhA8Aph82CoI
	2reKKooyNgvEQhV5qSA+NOB/9j/IW0ZTWvy4O0iMl6Yfr/WrstY32tvyKhiuNzK25CCBUL
	FrIATjqOvEcVNPGp0BCRLmM1ZqQ6ImbsNr43f85XTxXtK2bZp/4X6eEJXpHLMWI6YpB/35
	tmymEZCyj7a14f131hzn6ZNDEohwsyGF2i6cKP0kRW8Jkd3TdL4s7R2qpIrosA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Mon, 10 Aug 2026 17:10:43 +0200
Subject: [PATCH v3 2/3] mtd: spi-nand: Set the DQS spi-mem capability if
 available
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-winbond-nand-next-phy-tuning-v3-2-a97c3a61e675@bootlin.com>
References: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
In-Reply-To: <20260810-winbond-nand-next-phy-tuning-v3-0-a97c3a61e675@bootlin.com>
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
index 74bb5ee83b31..b54f7a1dae85 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -2050,6 +2050,10 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	/* Assume manufacturer drivers will enable the DQS pin if it is available */
+	if (spinand->flags & SPINAND_HAS_DQS)
+		spi_mem_set_dqs(mem);
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
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

