Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F03E3C71
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842884; cv=none; b=ZsarlnGrpIUM89hjHpgZ7fdNGtPn/5xeIQNoLZ/5ZsCSfPgSZ7603vi0nkwDJ+CPKKuaSD9gSRWNWYEU1x6lLbyEu3i3Y39HDpRDvgWZMBlViQY4Dpy2le0L1c6XuMpIZmDMfwTSFmKPIhR/hHle8ycUe1gjdSbmHtx0uNZDRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842884; c=relaxed/simple;
	bh=DJbex3xS/bQ4FcMq9cHTcUH6TP2zJFTZIIzzT/4C8L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a6kj5pCMM1VCWVz5W7WunwcbNFANMQjaF3j+fugua8RMT0ANKnVBA92sZNDLKA5AHGuePnI6A7gDoeU5mZOnQCtNsAsl5r2LOFeZd1hBQInaYWpZ1pGyVrwIDixofrnHPGVOsJLt8LmsFwgiaWEZ4bvNSHKTnhkViEDsLJcRZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ep5+M9HS; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ep5+M9HS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4EBEFC5C1A9;
	Fri, 10 Apr 2026 17:41:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11EE7603F0;
	Fri, 10 Apr 2026 17:41:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E68C10450082;
	Fri, 10 Apr 2026 19:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775842881; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6cCsRdWer/xoQr7FKNryl+BMiMzpUL7o1CHo+cPuu2k=;
	b=Ep5+M9HSLHRDyXiart+fWuti+USarJuRC0e2PDVSq+djwVJ6Oh+zRrsL0e5uwaGwE239dD
	bOK4GJnkoif2eeCOt6hVLaEYEn/9peMDHTJsqxi0ln/DzLdPKkygB46wM+NnJvxu3LlHWy
	AHRsosfbC0a+zgPP4eocSgaDMwJT9Pc0ovX/3QiP83dsmNdrn2l4X8dVJ6VUZxXK0EnOV1
	VmeZKLrYauSeHDu/6I7R5/IabzaOu6gNfLZJIlFE9lUHM2lx6Bth2k5Yvkvt2j31M04oVv
	xOqO73DY8Dtm+YloPGf5w5EpES9vWbMbNksoBu9PirNe16o4Ci7Nx7XhQoKCxQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Apr 2026 19:41:05 +0200
Subject: [PATCH 5/5] mtd: spinand: winbond: Fix ODTR write VCR on W35NxxJW
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-winbond-6-19-rc1-oddr-v1-5-2ac4827a3868@bootlin.com>
References: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
In-Reply-To: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In most scenarios this variant is actually unused (VCR is written in
SSDR mode), but we need to provide an octal variant. The address is 24
bits but is sent over 4 bytes MSB first. This means we need to shift the
register address by one extra byte for the address to be correct.

I didn't catch this initially because the volatile register region is
256 bytes wide, so the write-then-read procedure did work with the small
register addresses I was using at that time: 0 and 1.

Fixes: 44a2f49b9bdc ("mtd: spinand: winbond: W35N octal DTR support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a3fca8a1cff1..269fc587c5fe 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -99,7 +99,7 @@ static SPINAND_OP_VARIANTS(update_cache_variants,
 
 #define SPINAND_WINBOND_WRITE_VCR_8D_8D_8D(reg, buf)			\
 	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x81, 8),			\
-		   SPI_MEM_DTR_OP_ADDR(4, reg, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(4, reg << 8, 8),			\
 		   SPI_MEM_OP_NO_DUMMY,					\
 		   SPI_MEM_DTR_OP_DATA_OUT(2, buf, 8))
 

-- 
2.53.0

