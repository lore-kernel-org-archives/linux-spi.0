Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4040FDAE;
	Thu, 26 Mar 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542379; cv=none; b=R+v7WhmGgPGlXosdDUw13zDHDV7xa5EXZykvRo9apReQj7XwVjmzXhBm5CCx7rnpe+CQfDv4ZUiR3fRwWP4OHZcXqAcmpFVD5Y9zvpsrz5d/zoSd/LF9PNCijlysGraPkoTut+bUrS0bjb4t7bLihUYzb2+CH5JNVKEIbHG8gvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542379; c=relaxed/simple;
	bh=Grm0KcDW/hQfrvEz2RQvA5lbZXv8oM4hPqNEBK0bOiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVxWYXfAu60TXN835ccxwHqMwHyG0GDO8keZErri5fVNaUEVfxLsybpH8lnup1NERHVjyQyZ4YC+Nliq+H9qShlzj/94PIaZnkZim6iJJDcyzfSwmUlodELB9zlYhxEzrQVYACGrtYTKauqfrA+QXhu3MiCSzcJMakCKEDj6LHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x66BYHyk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x66BYHyk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ABB711A3007;
	Thu, 26 Mar 2026 16:26:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8323C601FA;
	Thu, 26 Mar 2026 16:26:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD72110450C99;
	Thu, 26 Mar 2026 17:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774542375; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nEL/yI+e8WdFT08VKvUrxQ/al4bbADvOFCoIasm5Z3s=;
	b=x66BYHykGGaeaMJDbt6p+YMwsMgZLR/cujhiEC211mF0PgQ2BEuWIvAGjpAr3Ug9ZMUUfe
	LEm+BQTS8wur+F88ZZOjXviBIuwo91NWW0Doe6yiZz+zjJVe5Wm7ji3KMtstmwudNXPSGN
	yWeFcwCetCJqXQ6/SzISqMajg571JmkKIlpmwc49a0ov9bCLUUBP6g3fL9wTG0OXx14jXK
	EjSXd4Qj7cNMW4EhJmHnH+QdBOdE4gKrfk3i3uKM/kcydhmZvwfcRMsTlUAWiXCJ2gzRIu
	mqxUsl0oCuW1YMFa3Xms7nzVec4Wu4xKM28k6LjLvEyJhBiKKTsRa+iOIVSBeQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:25:54 +0100
Subject: [PATCH v2 07/11] mtd: spinand: winbond: Ensure chips are ordered
 by density
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v6-18-rc1-cont-read-v2-7-643de97a68a3@bootlin.com>
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

All W35N0xJW chips have been added in a row, move the definition of the
2 and 4 Gb variants so their respective locations in the table.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index ad22774096e6..f4d4ffaa1f62 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -511,28 +511,6 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
-	SPINAND_INFO("W35N02JW", /* 1.8V */
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
-		     0,
-		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
-	SPINAND_INFO("W35N04JW", /* 1.8V */
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
-		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
-		     0,
-		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),
@@ -573,6 +551,17 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N02JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 	/* 4G-bit densities */
 	SPINAND_INFO("W25N04KV", /* 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
@@ -592,6 +581,17 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W35N04JW", /* 1.8V */
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
+		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
+					      &write_cache_octal_variants,
+					      &update_cache_octal_variants),
+		     0,
+		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)

-- 
2.51.1

