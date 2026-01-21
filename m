Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD094DA525
	for <linux-spi@vger.kernel.org>; Wed, 21 Jan 2026 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015139; cv=none; b=d9C/ifmafLsdCQq4cv0GtXSJFaVnJvaIwp7CmJASl5Ca5iehvMC+UR9bWHznCOUkbe207Z9DFZ1IKUeP+9HRpEhjMkIGTKW9LcNYYiNsMif5zQeByXkIKy3TBpR0RpzVR+joWKojoQrQ9mKdf5+G3WGA1gB4ZkW/uIzwjxBmEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015139; c=relaxed/simple;
	bh=7UMMSpTRFRksgUS7dSZabu6uzWVcK75/uzorszirfjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pw2WyTK7Np5XtYWI8kgBTZZSnU+JDqNAxQvau21tp4WwBzmfPLTiFxMnE4b95O9onvOBxTQQA0pOqkRC0Kf5+SqnauKev2oQ/O32yRIzoCkfuXEH6oN04GIMmM2DvG3ghZ714J0g+mAXYVTJAD90+wrzew6Mp3iqxNftamq6vpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JN1wMIae; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JN1wMIae"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2C2241A28FD;
	Wed, 21 Jan 2026 17:05:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0164F6070A;
	Wed, 21 Jan 2026 17:05:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C017119B18D4;
	Wed, 21 Jan 2026 18:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769015135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WIFqPskiDM9IjrZs85Iqodhn/D6pSUk1OJXi0KZ7anY=;
	b=JN1wMIaeDUKDCERcrdVvdA9LjV3So1tTmGvPS6HNjf5KaPDaWm0CaeDoXYXv6SecjnZcyv
	Ht4SZs2EwQATmllbldoBEFLZTaNx+1wHG5odMmYiw5u3pfV0ruv4xUCFowOrzf5nC0mfIk
	UYf8MKXajxdRi0F0u0WD0boGRtOcYYo2N2bq/AFkfmO7sEJRLjZ2/wwztpXrnvRbhuKrg2
	6lGQvGfzD85R5aIt6J8q8+jPZtBUUexLKO4c3kNXrUMBBCT9KNHH8WPdqfjTcwYXKa9AqC
	WNZ1gLRrybHfDAe/b+J1K4udaqMc8cXMMRj4AAoLMtvICWWaoGpxgyrrNHEb1g==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Wed, 21 Jan 2026 18:05:09 +0100
Subject: [PATCH v3 13/17] spi: cadence-qspi: Add a flag for controllers
 without indirect access support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-schneider-6-19-rc1-qspi-v3-13-43e70fab4444@bootlin.com>
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
In-Reply-To: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Renesas RZ/N1 QSPI controllers embed the Cadence IP with some
limitations/simplifications. One of the is that only direct access is
supported, none of the registers related to indirect writes are
populated, so create a flag to avoid these accesses and make sure only
direct accessors are called.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 35379546c3b4..e1ec20684b0a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -47,6 +47,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
+#define CQSPI_NO_INDIRECT_MODE		BIT(11)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -1423,7 +1424,8 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 	if (ret)
 		return ret;
 
-	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
+	if ((cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size)) ||
+	    (cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE))
 		return cqspi_direct_read_execute(f_pdata, buf, from, len);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
@@ -1624,19 +1626,20 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 	/* Disable all interrupts. */
 	writel(0, cqspi->iobase + CQSPI_REG_IRQMASK);
 
-	/* Configure the SRAM split to 1:1 . */
-	writel(cqspi->fifo_depth / 2, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
+	if (!(cqspi->ddata && cqspi->ddata->quirks & CQSPI_NO_INDIRECT_MODE)) {
+		/* Configure the SRAM split to 1:1 . */
+		writel(cqspi->fifo_depth / 2, cqspi->iobase + CQSPI_REG_SRAMPARTITION);
+		/* Load indirect trigger address. */
+		writel(cqspi->trigger_address,
+		       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
 
-	/* Load indirect trigger address. */
-	writel(cqspi->trigger_address,
-	       cqspi->iobase + CQSPI_REG_INDIRECTTRIGGER);
-
-	/* Program read watermark -- 1/2 of the FIFO. */
-	writel(cqspi->fifo_depth * cqspi->fifo_width / 2,
-	       cqspi->iobase + CQSPI_REG_INDIRECTRDWATERMARK);
-	/* Program write watermark -- 1/8 of the FIFO. */
-	writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
-	       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
+		/* Program read watermark -- 1/2 of the FIFO. */
+		writel(cqspi->fifo_depth * cqspi->fifo_width / 2,
+		       cqspi->iobase + CQSPI_REG_INDIRECTRDWATERMARK);
+		/* Program write watermark -- 1/8 of the FIFO. */
+		writel(cqspi->fifo_depth * cqspi->fifo_width / 8,
+		       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
+	}
 
 	/* Disable direct access controller */
 	if (!cqspi->use_direct_mode) {

-- 
2.51.1

