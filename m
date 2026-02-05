Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641B314D2B
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318436; cv=none; b=i61tL0R63kxFSrXkwA6jD32to5/j82pAyulCzydIKvFMTWxg2CaIlEHq+ZUISaeJUvn6BdzNB4VZvz8pohsCgHOCTnBkLfuRVk6h+eDEKjyU7MAGlJlQSJfvJnH0GtITuBXxykpuJaKLsCTP9wZgKhtatkMjZMYUyzAluBIn4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318436; c=relaxed/simple;
	bh=gL0MO5i4yl4cd8Ysu3IS9ZJCBbFeLpuuqhGpzKERqpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fmo9fcls71cr8TrWpfE4LiWmcLrdv07OWxs0NI26Igkk3156YCPhcpu+3lYFeyP7UUX9oT6xE+7CeOpFPZwHuL1uemidx0QOyJoZM26vflPmPnDEN5JGL76/O3Vksvn+W/q0+DTFe46s/EelLZ2qlrUM582uggjrXmTdsD8PoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IKjNbScy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IKjNbScy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4269E4E4242A;
	Thu,  5 Feb 2026 19:07:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18ACA6074D;
	Thu,  5 Feb 2026 19:07:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F7EE119D1750;
	Thu,  5 Feb 2026 20:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770318433; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BpN8z+kIDrZwG5aYIIQwAbhujY/X57BjDOA4OXNNt5U=;
	b=IKjNbScyxiCWSy2AsHFNMEJUi48XhsOcZqxIPvPwn1COX5iJ1z9G5/O5BygSEOUlUC5puN
	ShRwiOqUNxajOf/8BsVnL6rnvbMJksMlGYGS5/2z6zTN1rp/uzYfRBkS2IGDuESKEsc6XM
	dhSz6PiqGjZPNAxSrYzkDYFYMFcNUw80rEK1bHqBXdqEwmPgBVoc6Y2nzTYjW80FIaMWsl
	4f8hC9lTitTbFQ2Thvcb9vGXt0osF5+DRc8uXv1rI8lvcKdi+c52X/7HaZIEQY8sFJRo9n
	+yDyfLk2mMivtIi3EibJ1jTNVF8cfV8J/PasDJXJdKh/sxL8F7Z1NdtKpsVmRg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Feb 2026 20:06:59 +0100
Subject: [PATCH RFC 2/4] mtd: spi-nand: Set the DQS spi-mem capability if
 available
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-winbond-nand-next-phy-tuning-v1-2-5e7d3976f0f1@bootlin.com>
References: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
In-Reply-To: <20260205-winbond-nand-next-phy-tuning-v1-0-5e7d3976f0f1@bootlin.com>
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
index 95df4dd5330d..67270e49c179 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1974,6 +1974,10 @@ static int spinand_probe(struct spi_mem *mem)
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
index 58abd306ebe3..72babba69c7a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -483,6 +483,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT		BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
 #define SPINAND_NO_RAW_ACCESS				BIT(4)
+#define SPINAND_HAS_DQS					BIT(5)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure

-- 
2.51.1

