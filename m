Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7738E3A1E7B;
	Thu, 26 Mar 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542372; cv=none; b=V58p1EYxredgHztUfpb+R45VX51ejd/G8d+tV6uqh7r7OmcTEBps59jacx0CZEQj1QlSHotxdQPBWdSa04YvPDdm92V4kuY+ZJLlzxhW2OmrpzzuHSwEuNZzers/BbBjYpz3GdkguAa+FQl9JYSMmE5bJK2BkfURR3+Am0ufpKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542372; c=relaxed/simple;
	bh=bCLryakrulMqkUe87l2Z2KjmcWbzIqTOOUOh3rjsiTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FkaFnvMZxz7F/zlxPGD/ADgi26l47xYfhA+pTwOQdTtb6nj7FfBNez/UPc3DlxZleRhCu3o0rwuwCxyl1ISJAb2PD4hipFqXI/z+xNJch+KBaA1qTlOcBt8xMmc7d7NL6SCHlapunbjCwog3pKtskvwcH7H47LCHc+JCpQQG8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IXFbR8p6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IXFbR8p6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C2EBC4E4280D;
	Thu, 26 Mar 2026 16:26:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 98B90601FA;
	Thu, 26 Mar 2026 16:26:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF69910450C89;
	Thu, 26 Mar 2026 17:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QHp/XpnDc6VCjq7Z0fA22iB0i5XtlmN2AieaCNd4Ovs=;
	b=IXFbR8p6lsJT/2f6E3hDXOp7rvLkQdRT63ruqh/UP9hGiIBruK7rTY1bsyi2UK9A2zAFQX
	iEFYEOrDZ2e4P9wAal/136ejBloxyx5cQXlp62khWj6gyOhNl6ef0tbxVYA/b97P4RtHFc
	omhzZZVanMUzBeeruhIhKZzHe5dQHZjrC0WMgolWSXV7Buu9oWraSlmHm6TYXijPraaPTz
	MC/ao3fMtnzduuP9HU7aAJW+ot4v4mgTyk52f056ttWYMYng6ITUx60PFyDnU3z7TJGmv2
	Wa7bj+Iu9QOiBEpXDilMLrb8FkQNOMe//So9L8wMcVqkABE7UQKiYrMagH17Kw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:25:48 +0100
Subject: [PATCH v2 01/11] mtd: spinand: Drop a too strong limitation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-1-643de97a68a3@bootlin.com>
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

Since continuous reads may sometimes not be able to go past an erase
block boundary, it has been decided not to attempt longer reads and if
the user request is bigger, it will be split across eraseblocks.

As these request will anyway be handled correctly, there is no reason to
filter out cases where we would go over a target or a die, so drop this
limitation which had a side effect: any request to read more than the
content of an eraseblock would simply not benefit from the continuous
read feature.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 66c90419f6d5..fba3cc213c88 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -878,6 +878,12 @@ static int spinand_mtd_continuous_page_read(struct mtd_info *mtd, loff_t from,
 	 * Each data read must be a multiple of 4-bytes and full pages should be read;
 	 * otherwise, the data output might get out of sequence from one read command
 	 * to another.
+	 *
+	 * Continuous reads never cross LUN boundaries. Some devices don't
+	 * support crossing planes boundaries. Some devices don't even support
+	 * crossing blocks boundaries. The common case being to read through UBI,
+	 * we will very rarely read two consequent blocks or more, so let's only enable
+	 * continuous reads when reading within the same erase block.
 	 */
 	nanddev_io_for_each_block(nand, NAND_PAGE_READ, from, ops, &iter) {
 		ret = spinand_select_target(spinand, iter.req.pos.target);
@@ -968,19 +974,6 @@ static bool spinand_use_cont_read(struct mtd_info *mtd, loff_t from,
 	nanddev_offs_to_pos(nand, from, &start_pos);
 	nanddev_offs_to_pos(nand, from + ops->len - 1, &end_pos);
 
-	/*
-	 * Continuous reads never cross LUN boundaries. Some devices don't
-	 * support crossing planes boundaries. Some devices don't even support
-	 * crossing blocks boundaries. The common case being to read through UBI,
-	 * we will very rarely read two consequent blocks or more, so it is safer
-	 * and easier (can be improved) to only enable continuous reads when
-	 * reading within the same erase block.
-	 */
-	if (start_pos.target != end_pos.target ||
-	    start_pos.plane != end_pos.plane ||
-	    start_pos.eraseblock != end_pos.eraseblock)
-		return false;
-
 	return start_pos.page < end_pos.page;
 }
 

-- 
2.51.1

