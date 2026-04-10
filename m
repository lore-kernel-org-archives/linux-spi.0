Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE83E3C51
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842883; cv=none; b=F+m+ZKR+KSdTRJHl4k6rScWmOrTf/Q1QVz09z5s6McY5Ep8LqVzELKZE3WWtIo8xvfHByZ0goNrB5n5x7yVbVVO4Fceh35JK3jtl9aZXwXVvU4Zkw5DB6mN+BSU/rU3KR1i3hFOQXG08LnWENZSVkoK8aBZ6KQYK/saNSvMvB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842883; c=relaxed/simple;
	bh=w5j83Yxg1BUvrGYayXPEbnuDSb8c7L/2/ix+FqlhFYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+0V+Vf5Y4s3AT/Eb3EHbVK227Oq9k19z9jB/aK9+9/1evZUKw63EvxzUaGHTZfC4yDQM7ys6OABgYQdqfe7yDPxV/5ubOFEDXJqxkBRUbrLYkoPJ3aUtWPXvFTGkJud0ytTNydX+T5ndeF3P+y5UViNXgihEQI3aiWOu4fQM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RfbMYEke; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RfbMYEke"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1D69D4E429B6;
	Fri, 10 Apr 2026 17:41:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8A51603F0;
	Fri, 10 Apr 2026 17:41:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 226AD10450081;
	Fri, 10 Apr 2026 19:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775842880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bAVqa4MQXm7GdlPrbv7BpQQFj39D/pUUubDLu72NyMI=;
	b=RfbMYEke9rGFR7c6cTZKWElMdomfmM05zlbY+k17DJCJH7/CHnvw4PBCpRfKwCjg923VFT
	7FmYoYGOKFpc9xwdIhQbJjA3Rn4FqyZ/n5JCp8fwB4nDc+4qtKkNNL/NAhb7+WXmXWxzvu
	Wr4hcn1mUK+xklrhfwEBHdRpwA9uVMqo9RaW8kIL+Mv42JiKef4fCnn7YUCed/gALp+hPX
	wSpXuoPvjGIl8VOkYcdXbNvRnjJb3IgUlNDWf28HiPfqDnvyuXOVm/KddBhMFC2EO3OVTR
	rtiXEC2anYAt9mQkaXRZws/AjqFNJ5SsxdGzf9lNcj7oynpsgVQ6/z8d6LVXfg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Apr 2026 19:41:04 +0200
Subject: [PATCH 4/5] mtd: spinand: winbond: Set the packed page read flag
 to W35N02/04JW
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-winbond-6-19-rc1-oddr-v1-4-2ac4827a3868@bootlin.com>
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

Both W35N02JW and W35N04JW diverge from W35N01JW when it comes to the
"data read" operation in ODTR mode. In order to stuff more address
bits (up to 18), the second command byte is replaced by the most
significant address bits, keeping the number of address bytes to 2.

Fixes: 44a2f49b9bdc ("mtd: spinand: winbond: W35N octal DTR support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 6dfd0dcc8ee7..a3fca8a1cff1 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -515,7 +515,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
-		     0,
+		     SPINAND_ODTR_PACKED_PAGE_READ,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
@@ -526,7 +526,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
-		     0,
+		     SPINAND_ODTR_PACKED_PAGE_READ,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),

-- 
2.53.0

