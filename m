Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB741C2FC;
	Thu, 26 Mar 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543657; cv=none; b=nLat2B8Y1pKWjOTaOY1TzVfucHqA/djBwGSuio3buEYcdpvTz5zu91cjBwyyb4eYBGoXNAeBZTR+Sj3XyQ57PfSKMpNborau7JmYa2IkRxn5bN8UaKjqnDpNr+YSQX1+Wm1ZwiQPVJ490h+ZsAhOhFfZdraLcEAOSWBYq+3rcDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543657; c=relaxed/simple;
	bh=hJtlpYnuer3mYzJtb+Wz4CZbATTfoogGbECTCwLdIrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHYC1yZdfoa05r1Q56NULNHGRufEvHoqggmYGPnCJoNogXrA6OzBgaTSkLGmTd5JjQvFNukuaXA+lqXj08/y+AtMxNWS09lIcxhqUlImJ9BLgj+g9Mt/lS3DXVHOUyZ2J4Em7SBt9yhMUAzmKeHAruseT+gQjPzNTYyQZQOODVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EZLRM5cE; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EZLRM5cE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 494CD1A3008;
	Thu, 26 Mar 2026 16:47:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1F771601FA;
	Thu, 26 Mar 2026 16:47:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C8D0710450015;
	Thu, 26 Mar 2026 17:47:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774543653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=teX1nj50p7T/nQpS+gQuoF7Rys4YzHubJDIitOgqOXM=;
	b=EZLRM5cEiOd+snGueB87q1ZnE9nd5QmVHSiERyZYLBStCh1LN8Q9RZO6BNIWXTU3AYmkTM
	niE3Ny/oV3lX+qZ87kSFXoxluVQYbo9j+JjWeegtV1nXtJkzDGSEWGrmeyiQU/n0w0rHjc
	4Xnyq4B8yMEpOUfN2wj36ZpXF9iznaMjFzh3Q4F8cWvFIf83SzI3UIzCtKdTmwDYsFFgoO
	sykLNxdAbs83NajR0HIF7OszH1EMTxvvTf67tLSQjSN0wqozGxYYCVSFarz278IuuPJFi2
	WwE7tT+nEkg7dq7IVaxaMqhZVNinvAaamU5ZJ0gog77RHQtEdnvzK46D7etD+A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:47:17 +0100
Subject: [PATCH 3/4] mtd: spinand: Prevent continuous reads on some
 controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-3-0d626e1dfb2b@bootlin.com>
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

Some controllers do not have full control over the CS line state and may
deassert it under certain conditions in the middle of a (long)
transfer.

Continuous reads are stopped with a CS deassert, hence both features
cannot live together.

Whenever a controller flags that it cannot maintain the CS state
reliably, disable continuous reads entirely.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
SPI NOR reads are not affected, hence only a solution in SPI NAND is
needed.
---
 drivers/mtd/nand/spi/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index dbe2c463fe01..82f4dd441541 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -951,6 +951,7 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	enum nand_ecc_engine_type engine_type = nand->ecc.ctx.conf.engine_type;
+	struct spi_controller *ctlr = spinand->spimem->spi->controller;
 
 	/* OOBs cannot be retrieved so external/on-host ECC engine won't work */
 	if (spinand->set_cont_read) {
@@ -962,8 +963,9 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 		 */
 		spinand_cont_read_enable(spinand, false);
 
-		if (engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE ||
-		    engine_type == NAND_ECC_ENGINE_TYPE_NONE)
+		if ((engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE ||
+		     engine_type == NAND_ECC_ENGINE_TYPE_NONE) &&
+		    !spi_mem_controller_is_capable(ctlr, no_cs_assertion))
 			spinand->cont_read_possible = true;
 	}
 }

-- 
2.51.1

