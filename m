Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332B4F796D;
	Tue,  3 Mar 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555833; cv=none; b=Mb6C5PfRmP1X57CuUrxYXSIzX5bkYcbQksn+7MnQKFUgKLA8B6KkCRwj8k+LygIdihuHd4p6jvuBjqXkSfTquUs6BgEyo9rdPrZtyqz47r69x5V0IgoEEdxrSf/JcrXBnA8sw7FVDkY0tZ3ebovYL++PZKGWhBOZOSm5FjmEJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555833; c=relaxed/simple;
	bh=u/mj6enjZVhQTntyAzChX6YGjn8caASUn1GrbNlmsRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWUb6LhI9LxAxbzUVPMLvxDbm4pRSQlDoKhFWkHBwYB5XlyOGdHlWI9UtEircwXuWpd8ptaFbpvNjsLBT7peWGPWfy/LHHKRgcDDNNM0nirfQXSLtaqtR4Ga95BVme48d9TQ+ZJXCtccfomdlEaFlxwxxW+z77sL60jhY0RkL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=Pr5md9R9; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="Pr5md9R9"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1772555397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4V326l6j+UN/QUc6C6H7//EMmn8uimk+2KtK4YoNFE=;
	b=Pr5md9R9pPJa1rWI6bCDoa9yT9iO6BLgDEl6wtN5sjCoQ7OLktynCTxAUCIktNmBpgNor7
	i+TCleRAdZL7RW2bTcXgs8AHpK5Kd3oW19FtJ4XfqzNXL/dSkPAMjRs6oeH4Lrp6FTqK1a
	dyBlxXfF8bfrPff26q+heIpY+BBhTmzq8kWv9tNyA6EsikQa7FlRZVuHCjpyB+ZqPWVH+S
	te15eCRncYbcisgU9Byr4U6t4auQo/m2SNpEyE3InOQGdeEcO1gHwEueU4Da/aNPpXTQ+6
	4lFO+jYgGDqJ+euBpvKEQ6TyscBA2p6XFY6QQumVoMlPo3YYUtl5pD/Ld9EYXQ==
Date: Tue, 03 Mar 2026 17:29:25 +0100
Subject: [PATCH RFC 4/7] mtd: spinand: toshiba: Add RX sampling delay
 values
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-fsl-qspi-rx-sampling-delay-v1-4-9326bbc492d6@kontron.de>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
In-Reply-To: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
To: Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Han Xu <han.xu@nxp.com>
Cc: Eberhard Stoll <eberhard.stoll@kontron.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, imx@lists.linux.dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8132;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=YS9m+8/VwL0xEzMaavaBPStGEta14s9GR3DcIa/S2T4=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIXM5T9NcLc6rK749PvtjZb989Iwvn8Qi3Is/T3yWyniqQ
 qiYR0Wto5SFQYyLQVZMkUWK3+K1rVmsj/yx6iiYOaxMIEMYuDgFYCJxNYwMJ9dMmLr/6m49VjXb
 h5senFN68zVswfXjGXPeuhU53zzq38TwP/fnogvK9kcnRx5w1RARLT3k/5WzVu3nmuDLvInmjm+
 u8wEA
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add tCLQV (Clock Low to Output Valid) parameter from datasheets
for Toshiba/Kioxia SPI NAND chips. This allows to let the drivers
properly handle high sampling delays at high clock speeds.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/toshiba.c | 48 +++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
index ef649162ee680..7679f3acbae07 100644
--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -118,7 +118,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 3.3V 2Gb (1st generation) */
 	SPINAND_INFO("TC58CVG1S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCB),
@@ -129,7 +130,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(8)),
 	/* 3.3V 4Gb (1st generation) */
 	SPINAND_INFO("TC58CVG2S0HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xCD),
@@ -140,7 +142,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(8)),
 	/* 1.8V 1Gb (1st generation) */
 	SPINAND_INFO("TC58CYG0S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xB2),
@@ -151,7 +154,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(8)),
 	/* 1.8V 2Gb (1st generation) */
 	SPINAND_INFO("TC58CYG1S3HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBB),
@@ -162,7 +166,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(8)),
 	/* 1.8V 4Gb (1st generation) */
 	SPINAND_INFO("TC58CYG2S0HRAIG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xBD),
@@ -173,7 +178,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(8)),
 
 	/*
 	 * 2nd generation serial nand has HOLD_D which is equivalent to
@@ -189,7 +195,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 3.3V 2Gb (2nd generation) */
 	SPINAND_INFO("TC58CVG1S3HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xEB),
@@ -200,7 +207,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 3.3V 4Gb (2nd generation) */
 	SPINAND_INFO("TC58CVG2S0HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xED),
@@ -211,7 +219,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 3.3V 8Gb (2nd generation) */
 	SPINAND_INFO("TH58CVG3S0HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xE4),
@@ -222,7 +231,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 1.8V 1Gb (2nd generation) */
 	SPINAND_INFO("TC58CYG0S3HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD2),
@@ -233,7 +243,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 1.8V 2Gb (2nd generation) */
 	SPINAND_INFO("TC58CYG1S3HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xDB),
@@ -244,7 +255,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 1.8V 4Gb (2nd generation) */
 	SPINAND_INFO("TC58CYG2S0HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xDD),
@@ -255,7 +267,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 1.8V 8Gb (2nd generation) */
 	SPINAND_INFO("TH58CYG3S0HRAIJ",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xD4),
@@ -266,7 +279,8 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
+		     SPINAND_RX_SAMPLING_DELAY(6)),
 	/* 1.8V 1Gb (1st generation) */
 	SPINAND_INFO("TC58NYG0S3HBAI4",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA1),
@@ -277,7 +291,7 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
 	/* 1.8V 4Gb (1st generation) */
 	SPINAND_INFO("TH58NYG2S3HBAI4",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xAC),
@@ -288,7 +302,7 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
 	/* 1.8V 8Gb (1st generation) */
 	SPINAND_INFO("TH58NYG3S0HBAI6",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xA3),
@@ -299,7 +313,7 @@ static const struct spinand_info toshiba_spinand_table[] = {
 					      &update_cache_x4_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&tx58cxgxsxraix_ooblayout,
-				     tx58cxgxsxraix_ecc_get_status)),
+				     tx58cxgxsxraix_ecc_get_status),
 };
 
 static const struct spinand_manufacturer_ops toshiba_spinand_manuf_ops = {

-- 
2.53.0

