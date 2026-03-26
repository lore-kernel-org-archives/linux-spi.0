Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215E41C2FE;
	Thu, 26 Mar 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543657; cv=none; b=SEkmn0O9U7deh2vIvRMLChG/QYxy6RYjQhKNtYWEtjizRgjXJdufFrVQ0ktR0AD52H4Gz5wQrNHZxKYnwnCXW4I+9foUf4hR0qxjrV2J5r8fp9jYPupkfhkCdBB+/fwqn4FPdIaQLgiTFQ691/shhiaXwXpvymdPQuhfTEOXIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543657; c=relaxed/simple;
	bh=u1c7v30nJY0THy0bUDwZrS72xzO7sbqr8em752qHETs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zygxv5K83U/FdBsIx4ZJ4E1gxymg07xhVbB9s9n3KBuN+1gdDssmWht4m3NToOy3vEzAhz847Yy8W11ds5r+rJknIXkAzDnFdxgUfqre4HumzImQBwaGC3hy9p+4h3D95Mu1xjn3vA8ZXdnLhKNc7zaVLE9TxHNxOWSkQyCOrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bQOKsQ6Q; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bQOKsQ6Q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8C5D7C5506D;
	Thu, 26 Mar 2026 16:48:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 486C5601FA;
	Thu, 26 Mar 2026 16:47:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D17110450CD5;
	Thu, 26 Mar 2026 17:47:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774543651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MfQsMH01sC5rcQAhuynCASMmcusHRJHKOUkM0tEs7+Q=;
	b=bQOKsQ6QTW6zY4tZTrGpyVQNdfcQexSG6TnhZ+zsTd6oLFowicJL6Uc9KJPg2OPWnH8XDK
	0bd8kf+aW3ynhcZE04MNOjmEr1j5A2OfDRDtZAJ9ychAiaNivK3EHHkEC0OMlhCAbC1hK2
	GlKJ1VaPvFIelUPP0Z8rsC0WKXOzwPj8QkBtnUwyB5XZL9xsWTG/C1UPWZ0s2QyXxLJYUT
	8aasrM3+sL3r0eIUBpYxts+66K98YnpxC5Qb52/wDjnec4U7cxNn+osSAysBYnGWQBQWY5
	LdQkBVFRRdDvtt6RXhXh/jDmEnpbJcmbD8TJaZfN+GyjM55kXDog9oBwXCXlIA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:47:16 +0100
Subject: [PATCH 2/4] mtd: spinand: Make sure continuous read is always
 disabled during probe
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-2-0d626e1dfb2b@bootlin.com>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
In-Reply-To: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Steam Lin <STLin2@winbond.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Recent changes made sure whenever we were using continuous reads, we
would first start by disabling the feature to ensure a well proven and
stable probe sequence. For development purposes, it might also matter to
make sure we always disable continuous reads at first, in case the ECC
configuration would change. Doing this "automatically" will become even
more relevant when we add extra controller flags to prevent continuous
reads at all.

Ensure we disable continuous reads if the feature is available on the
chip, regardless of whether it will be used or not.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 45c3afb9cceb..dbe2c463fe01 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -953,11 +953,7 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 	enum nand_ecc_engine_type engine_type = nand->ecc.ctx.conf.engine_type;
 
 	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
-	if (spinand->set_cont_read &&
-	    (engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE ||
-	     engine_type == NAND_ECC_ENGINE_TYPE_NONE)) {
-		spinand->cont_read_possible = true;
-
+	if (spinand->set_cont_read) {
 		/*
 		 * Ensure continuous read is disabled on probe.
 		 * Some devices retain this state across soft reset,
@@ -965,6 +961,10 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 		 * in false positive returns from spinand_isbad().
 		 */
 		spinand_cont_read_enable(spinand, false);
+
+		if (engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE ||
+		    engine_type == NAND_ECC_ENGINE_TYPE_NONE)
+			spinand->cont_read_possible = true;
 	}
 }
 

-- 
2.51.1

