Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0C315D5F
	for <linux-spi@vger.kernel.org>; Thu,  5 Feb 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318438; cv=none; b=lcjqVlR7NiLybgqrTznztjacp9FFeVPH81ml60r3rpUGKYfIFskOOxtI1bDlAffAUMTCzK94DR42KURh1MXMjsNikDl7MWVLlEQCdE1BXFjMrmzvGufv+SCGhPnqNWm+rWQQ9R/Lodz8JVcfxgueF+kgLpDm/Znjtr30seyOxtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318438; c=relaxed/simple;
	bh=y8b4WMelJUB37lemSSU0kVvZc6ACW4vDsXwVaNigLwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l3fpdlCywpIbYZjvEjKRRT4J2RVzSvUXrYj3JStKregA62xmwgihElTnkG5WhFIk648V141thnmYzLo8Qkh5vYt6JcgK+IGQbvZNE88O7ep1Wnv7olz7V2JG8nc5MwAPMQ4LRfKGbwV4+4MCsmwKSUjW+totz/qBA8tkthmivaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rjUwHRu9; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rjUwHRu9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7F19EC243B6;
	Thu,  5 Feb 2026 19:07:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 438C06074D;
	Thu,  5 Feb 2026 19:07:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF3F5119D1700;
	Thu,  5 Feb 2026 20:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770318435; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XDXLiZY8XfAXjeC91sKPVk2e9adP7fRa4aGhrR6KVTY=;
	b=rjUwHRu9Qkn6W14cO/ZKOSolIGLNSKocJm4zDypZWWqeDewMU1T56965ZkP03j+DoH2tBI
	6xdB7q+4xp1bAvm9HnG+gIREmDWdoqTTcBudla5AXh+31r5ZZHzPw/BuvCRY5UHX56xDcx
	J1aHYwjE6/hG2tWCaq3fotlIrPme3f4gPMN6WXoFQR/e6mDuoUv8yEHppczTOctHX07LdL
	g5Tdp28aSUhSC+yH5k+5diRJxghBVR2yeBYv060qEfxouDgAK22ooEWb//1qOq+C1VpPi6
	1JgWE3gJMXQQl8GjqWqVPx0NXJDpFM1g+ZHculSIwFdqR9gV8ZRqtmNdK/DgHg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 05 Feb 2026 20:07:00 +0100
Subject: [PATCH RFC 3/4] mtd: spi-nand: winbond: Enable the DQS pin on
 W35N**JW series
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-winbond-nand-next-phy-tuning-v1-3-5e7d3976f0f1@bootlin.com>
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

These chips have a DQS pin, enable it by default in DTR mode because
there is apparently no issue in setting it for lower frequencies, and
the extra power consumption seems very low compared to the current drawn
by the NAND array itself while operating.

This setting will be required for high speed I/O transfers (with PHY
tuning).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/winbond.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 6dfd0dcc8ee7..7401ee1007c0 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -437,7 +437,7 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
 	else if (!single && !dtr)
 		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_SDR;
 	else if (!single && dtr)
-		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR;
+		io_mode = W35N01JW_VCR_IO_MODE_OCTAL_DDR_DS;
 	else
 		return -EINVAL;
 
@@ -504,7 +504,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
-		     0,
+		     SPINAND_HAS_DQS,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
@@ -515,7 +515,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
-		     0,
+		     SPINAND_HAS_DQS,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
@@ -526,7 +526,7 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
 					      &write_cache_octal_variants,
 					      &update_cache_octal_variants),
-		     0,
+		     SPINAND_HAS_DQS,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
 		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
 		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),

-- 
2.51.1

