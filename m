Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E83378D94;
	Thu, 22 Jan 2026 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094846; cv=none; b=Yfo41+d1zY2eVkg8FHP7i5WCM1e9n+bpZDKxuQIzPKZiigDdilCaL2FndI/vfSdnrmZay9FqiMxMDW9nrorm8vufPI2vi6xaiDP6UTJw3hnVRQcY0/tzWGd1feSJfIjl1RMJ2cUK9u4TDwJP4Fc1cXHBRKqPKJ4PCAhV0dQiql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094846; c=relaxed/simple;
	bh=JD9J15FD3+7Fo755XEIaI+M7RJcrkXyMm5ZCiSP5OnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8cwE+zjOGxnbelSGQ8DjcoB71ydSoi8FMHaQ6IXgAbShdPMMYoAvBjZGaPzkFRKKiMvhTD4bNpE59gaILcRc4YeLnh2Yw+gGbUU7JeDC9Qc5F6w7e6ErRBhFs5QTCc+jmWoFCpJn01ttSIzmfR7nlxTPCsC2q1KJANGjSb3QkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w0SnOLTR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w0SnOLTR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 565AB4E421F2;
	Thu, 22 Jan 2026 15:14:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C40F606B6;
	Thu, 22 Jan 2026 15:14:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 420A0119B82C1;
	Thu, 22 Jan 2026 16:13:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094841; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+kIY2+d5nqykmYBPmHAWFbCHhJxDmjtvUjwEBEl1LRg=;
	b=w0SnOLTRxT0OH53Rq8wTI/+GZs5AEISLfobmHtrkNHxDziP8uyWrftxs2upQcukBeIfLCa
	pRurbmrLk4e7AWrD4ioOwpHQOLV6u8MqFlTbYumGVvBusbk0w2SHr5vSSWs3V7vM4dIudl
	wilPtl22x2bnUAh/P7x4l2iMjkJtJm+3i1BrfKMZTFk0zCoFxwyVqyzmQCHc2sNw/sAj2i
	81t3bsbPk7Mn4oPYHBNGog36mio4+t49cimwm72PQCzSSOcMKMPX17IjoYw3nlt41Rmlxc
	bAyRFzyt1v9CCb3aGnKxWnI0Z6Tol6XbCIoP6a2qvJZ4GfEF91srbLDHfMEiUg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:29 +0100
Subject: [PATCH v4 04/15] spi: cadence-qspi: Fix style and improve
 readability
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-4-f9c21419a3e6@bootlin.com>
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
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

It took me several seconds to correctly understand this block. I
understand the goal: showing that we are in the if, or in one of the two
other cases. Improve the organization of the code to both improve
readability and fix the style.

Suggested-by: Pratyush Yadav <pratyush@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index cc28da7fc686..c0a507953c58 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -374,17 +374,12 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 	/* Clear interrupt */
 	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
 
-	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
-		if (ddata->get_dma_status(cqspi)) {
-			complete(&cqspi->transfer_complete);
-			return IRQ_HANDLED;
-		}
-	}
-
-	else if (!cqspi->slow_sram)
-		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
-	else
+	if (cqspi->use_dma_read && ddata && ddata->get_dma_status)
+		irq_status = ddata->get_dma_status(cqspi);
+	else if (cqspi->slow_sram)
 		irq_status &= CQSPI_IRQ_MASK_RD_SLOW_SRAM | CQSPI_IRQ_MASK_WR;
+	else
+		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
 
 	if (irq_status)
 		complete(&cqspi->transfer_complete);

-- 
2.51.1

