Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80855401485;
	Thu, 26 Mar 2026 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542382; cv=none; b=HlGicK2OJJOzkAKnH2G39NYBbs2YQZkXOl6SyPxMrhcommDirzBBWSMQSH32fz7v7XMtzloXQAErYaqRGO7rNW4vbBsxkcVkAbc6qpOAsHr/CL55+aRF2PeqylHpRX6ztaC6MBj3RpTQb+H5LtoKXLaBgFcE6/NL4EpPuAyygSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542382; c=relaxed/simple;
	bh=2g7luQ8WyYG84yO4kuKurLDAbZpyWfXDWPQGiMCYGfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nuEs2vIKjUiSoAPT76mKrdp0tEA00FyCJHQ8VGwk3nDkU0asx0SF3tOuJf3wumbzDY1FvU1rseW1Gh2IuiPgdFOwcr94mQAZYteL7qFx9r1+tW2Qq8hI7XuRbbqyMMzHWS2JZmzZ0HzD4956mcfEA9mfDxr4AVaZ9BBW+LWJun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=etKO1z83; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="etKO1z83"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 80937C5505C;
	Thu, 26 Mar 2026 16:26:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3DC75601FA;
	Thu, 26 Mar 2026 16:26:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D8C610450A93;
	Thu, 26 Mar 2026 17:26:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TkcWUC0TtSzdMpvi2JDSmyuOip9Q86RjX9UadZNkZZw=;
	b=etKO1z83O24QvsAEPlHabgdI9VwxmeiZBfLLuPWSRVyIj2setEbXdQoLPOf6zIY+Ca96yM
	weGeBCIcwnyhaxeuV0/zSiliLu74YIACRZNvhw3Nc7HQojJOp4QrIbQHIVu2G1hZ+rPHod
	RQYraShXfrtjNCzrN6CCR5tGA7eMGbflcyY5SrACfaJkjWpWK/dV6GqLZ67YKEKZTUxGaD
	jAY7HXDNu1kl7ERMH4SwuXenemK0+SjJo+3o6hlPqf/ZG35ONbMxJo9YICwEE3IhH4iB4D
	SeFSmb1qhw+3vdtyJzsd/5xfCPFVY3S3L4DrFI7XOfJJrV/r1uJkXWWm89+CVQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:25:56 +0100
Subject: [PATCH v2 09/11] mtd: spinand: winbond: Create a helper to write
 the HS bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-9-643de97a68a3@bootlin.com>
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

Updating the HS bit is not complex but implies reading, setting/clearing
a bit and writing. Clean a bit this section by moving this logic in its
own helper.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 6c11f59a9f8d..b30a343a6672 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -404,13 +404,28 @@ static int w25w35nxxjw_ecc_get_status(struct spinand_device *spinand, u8 status)
 	return -EINVAL;
 }
 
+static int w25n0xjw_set_sr4_hs(struct spinand_device *spinand, bool enable)
+{
+	int ret;
+	u8 sr4;
+
+	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
+	if (ret)
+		return ret;
+
+	if (enable)
+		sr4 |= W25N0XJW_SR4_HS;
+	else
+		sr4 &= ~W25N0XJW_SR4_HS;
+
+	return spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
+}
+
 static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 			   enum spinand_bus_interface iface)
 {
 	const struct spi_mem_op *op;
 	bool hs;
-	u8 sr4;
-	int ret;
 
 	if (iface != SSDR)
 		return -EOPNOTSUPP;
@@ -429,20 +444,7 @@ static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 	else
 		hs = true;
 
-	ret = spinand_read_reg_op(spinand, W25N0XJW_SR4, &sr4);
-	if (ret)
-		return ret;
-
-	if (hs)
-		sr4 |= W25N0XJW_SR4_HS;
-	else
-		sr4 &= ~W25N0XJW_SR4_HS;
-
-	ret = spinand_write_reg_op(spinand, W25N0XJW_SR4, sr4);
-	if (ret)
-		return ret;
-
-	return 0;
+	return w25n0xjw_set_sr4_hs(spinand, hs);
 }
 
 static int w35n0xjw_write_vcr(struct spinand_device *spinand, u8 reg, u8 val)

-- 
2.51.1

