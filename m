Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230EB41B34A
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485466; cv=none; b=lmNfitrTooyWDvcF1gx83SfS8IcgFK8MYpHeo8jRJrTodsFV1ESO3dQPTAbWBnx1cF2f56CYtvah4cinokdEHfHWf7aR6J9nL+PAuPaAh1BMwcMPS7em3pLHeKHRkLRfqpTVqVoVsjQiv8LMGIxrOVk/SAVdTNJ37XzcllcUpqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485466; c=relaxed/simple;
	bh=ckoJb0d1ziC0/OuZ8F+o7Rmk0By4kSHF2fy5sQ8Tyj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOzC3k3TaGENMJJrFKRP2eqnEamAxrVI2Q7jw+hC7AemSzv/oqLbdWHK5eLIdhxp9Z54Evx0FowuouRtl73oPHrCktZi4lRLJmy/omTJOwnlLbbXoY4cAKK7zALmzcbLgCNtYkviZlV1pxtqLBE0W/AC/5pC3SvugPGMuqDd1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NXWUJIFz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NXWUJIFz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D53F14E42B69;
	Wed, 29 Apr 2026 17:57:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A25475FD43;
	Wed, 29 Apr 2026 17:57:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 811921072B16D;
	Wed, 29 Apr 2026 19:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777485461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pRtlUGFfk1AjNaQYKbHs4RmZNZ5DHT9f7bq1vbOMB34=;
	b=NXWUJIFzygDfQ7zjIeyD37p2jDhewvoKDSntinFms7jvk9dOXJLWtQHw+UkFYO0NhJeIjM
	STfpzdg2sYIjGY6C7+Fzr4WXsn+KBSuIu5UyfYzZlD/U1c7XLIx37jF1O1AhcTxI21N33E
	DQmxcpFD41RJYWNdmP5qpl3rNVUo2uPxARHR+n5Z8u599+GT+0ka1catIfl/VshOMoAu0W
	fsSlRi+NTvVI+VHtDf4qZIFZMj6xPiJCYPTqUPkB2Nns0fWL31gmeq1mdv9+6WcM7lGBeO
	JbHctYaj9m9K68JL+5ZH58LGrBE1dl+Luq9ZVrU4Z8dxJGq188aCiwAdf5nSSA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 29 Apr 2026 19:56:39 +0200
Subject: [PATCH v3 02/11] mtd: spinand: Expose spinand_op_is_odtr()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-winbond-v6-18-rc1-cont-read-v3-2-0f38b3c229ad@bootlin.com>
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
index 58abd306ebe3..e1f19664bb25 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -862,6 +862,8 @@ static inline void spinand_set_of_node(struct spinand_device *spinand,
 	nanddev_set_of_node(&spinand->base, np);
 }
 
+bool spinand_op_is_odtr(const struct spi_mem_op *op);
+
 int spinand_match_and_init(struct spinand_device *spinand,
 			   const struct spinand_info *table,
 			   unsigned int table_size,

-- 
2.53.0

