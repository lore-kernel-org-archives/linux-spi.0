Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369B4EA39A;
	Tue,  3 Mar 2026 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555832; cv=none; b=RvuwCGEPtgoAfTQdsZWiX2A5rXJrEcKtpsrjVE7OsczYyndeUH+Qaqf4MSdtAPJTnTSnHd7Ugse0HmGxmzRNFHKhaW6vW6aNFgjArt1PSXUpGdw5Z8Zz/sC/Xd8rFPFrKQGmoh+P3r8v74for1Z3MLQ9KWi7TaCD1mn38rTivOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555832; c=relaxed/simple;
	bh=j4nNwMuSYM3rlSzI3HUw1M8Wo+a+90ViCYEEsEfbue0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLDK0sflGuw4xvHRVUwWtymh1MyP5dCJ3c6iIvWpuI2ln9ZTnW/dHG5zEvXfnBPTKUrfqa1yL8rDu7qemG9vbLP7+RUL/zPWF+LKhQJ6ygJM+tra2uTpZSLg7xzVO/A8qgHo4cpGsd4j4nnxBuujervPnFlmGy3qOG7cepydC2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=iogRgar7; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="iogRgar7"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1772555397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHCcxgpay9q2fQOrVBGP3YNnaqk0n6N/P64jHvnyofU=;
	b=iogRgar7uYnzR+8yuvbkV8DUafaYRQNvYxN+zNlkjQ3TPx8eqQJFCMXCdMCYC/XoXFoaE9
	xb5mjVj+s4g6TUia8H60bSjERiWF/W1QW1jmboQOFkqkvSsTUZtFmLV//q3r3kT7yEzKxr
	pIB9Cm19dIjCo0sKuNPK94ngayx04bn0IYug5oz9vAQ1be1ophIOEFrhVJcr7Nf3d8AufR
	lz9HlLvSrnCx7iDNH198HHxL2rL1io3gobl1zyl2TrOF0WpDyXRJNWXEx49AHNydhVqHyY
	soEUIZYdho4rZHPgYUmhkWWwcRvao2MyTkFeaBwImtf+A1RcmOKQZe04AgY1+g==
Date: Tue, 03 Mar 2026 17:29:23 +0100
Subject: [PATCH RFC 2/7] mtd: spinand: Add support for clock to RX delay
 setting
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-fsl-qspi-rx-sampling-delay-v1-2-9326bbc492d6@kontron.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=aPAds6dnQdXTjjQL53ALn43JPMhWJpGj9MuI9SkzCsc=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIXM5T9Pk3NsnP/6KlLPaWSkf85rzh4DYrLz4zsJf+3PFm
 PsT5/p1lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATOSuJCPDeacbgeJCr6uWmpQe
 nXZ7R+0TM/MDq+bwvDy190jwz2wVd0aG2RuXm7UH2HeJ/7Lecld28gytuEt8J20rrjaZ/45bmNb
 NAQA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Eberhard Stoll <eberhard.stoll@kontron.de>

Add the configuration parameter to set the SPI clock to receive
data delay parameter for SPI NAND devices.

This parameter is often referenced as tCLQV in SPI NAND device
data sheets.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 1 +
 include/linux/mtd/spinand.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8aa3753aaaa1d..782a605018bc3 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1594,6 +1594,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->user_otp = &table[i].user_otp;
 		spinand->read_retries = table[i].read_retries;
 		spinand->set_read_retry = table[i].set_read_retry;
+		spinand->spimem->spi->rx_sampling_delay_ns = table[i].rx_sampling_delay_ns;
 
 		/* I/O variants selection with single-spi SDR commands */
 
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6a024cf1c53ac..b76aaf0747962 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -568,6 +568,7 @@ enum spinand_bus_interface {
  * @model: model name
  * @devid: device ID
  * @flags: OR-ing of the SPINAND_XXX flags
+ * @rx_sampling_delay_ns: clock to rx data delay timing (tCLQV)
  * @memorg: memory organization
  * @eccreq: ECC requirements
  * @eccinfo: on-die ECC info
@@ -592,6 +593,7 @@ struct spinand_info {
 	const char *model;
 	struct spinand_devid devid;
 	u32 flags;
+	u32 rx_sampling_delay_ns;
 	struct nand_memory_organization memorg;
 	struct nand_ecc_props eccreq;
 	struct spinand_ecc_info eccinfo;
@@ -643,6 +645,9 @@ struct spinand_info {
 #define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
 	.configure_chip = __configure_chip
 
+#define SPINAND_RX_SAMPLING_DELAY(__delay)				\
+	.rx_sampling_delay_ns = __delay
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read
 

-- 
2.53.0

