Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F747F2D8
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538529; cv=none; b=CR9q4QvgZtFoeeHpYn9LC4INAGFqHZSEA4+YWMIyHdYY1Jfz6F4gh6WYVIsUa9e0vhZ6RRhipRPKVkGQHFHCvd4DqeNkarZzftBCRPXOyOApALj4Y01wIFE1zr1uR/U2KpJBylAPfKmca+5U5iuyfIXlKw7G625GMVRxj3KzW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538529; c=relaxed/simple;
	bh=APtoFyzTyhZ52EVQzRs8ocjOQ5XXqng6P+8bPR0yUDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pH9czXYz5WyzVNmnwVIBBgwKg84cypym/SEicfMobj3DrjSG/PHSso42n1ocSCnL7PE5Jfnzowsx1h2hy2ePFPOFV9sduQjFLn1/yLz3VGds4SvsFb2sGTFiqTB7uyg+qC7U+j35m7kMvUuAKcilMSsvtVNbcgQ8T97o9eGNils=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H0Vk1qXV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H0Vk1qXV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1C46B1A19AD;
	Fri,  4 Sep 2026 16:15:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6C3F6057F;
	Fri,  4 Sep 2026 16:15:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A86DF11C798EA;
	Fri,  4 Sep 2026 18:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788538521; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kG8qOJf7J4aEU/n1neCfbmEvJTcve4JDlz0x4pKitok=;
	b=H0Vk1qXVoRRry0l7BegGRBAY/sT20QUCYlyAyoNT4ts5Dwmjj2mSlx5TKSmTtqTBxfN3Tj
	Lnmc37/LqEIhCMEISd2Fm6p1WL4yOKEbRoDlhzgj6KLyidKcNLhOxHMGxf6IYzAii+pRcu
	goPFNPWSeAV7QKqTx/pdeTyGKDyhNseLwG7KfSBUZn1K4v9jWBOHL9ozcArcG8wqwKkU4K
	UtE/OkFp1ZZsIa29e+Z1Q2AIoCsoGXjgAMTM3Nvy1b5iw3MTZ8/QiO40+ZH5/W/JoOaiNA
	u7+p3XELRfjd6H+EDc6THH5bU/GuRvn1SXifYLjBOcTwO3KVw8rorhZOsIE1+w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 04 Sep 2026 18:15:10 +0200
Subject: [PATCH 1/2] spi: spi-mem: Enable DTR transfers using the standard
 API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-perso-ma35d1-master-v1-1-b6936e8c6fa1@bootlin.com>
References: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
In-Reply-To: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Most spi-mem operations today go through controllers implementing the
spi-mem API. But it is also totally possible to use any standard SPI
controller to operate these memories. If the controllers support DTR,
there is no reason to prevent this feature from being used.

Extend spi_mem_exec_op()'s fallback to the standard SPI API, by filling
the transfer DTR information. Doing so also requires checking the
dtr_caps flag, of course.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-mem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5f973ebfb8b6..94d122be1c93 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -172,7 +172,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
 
 	if (op_is_dtr) {
-		if (!spi_mem_controller_is_capable(ctlr, dtr))
+		if (!spi_mem_controller_is_capable(ctlr, dtr) && !ctlr->dtr_caps)
 			return false;
 
 		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
@@ -461,6 +461,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	xfers[xferpos].len = op->cmd.nbytes;
 	xfers[xferpos].tx_nbits = op->cmd.buswidth;
 	xfers[xferpos].speed_hz = op->max_freq;
+	xfers[xferpos].dtr_mode = op->cmd.dtr;
 	spi_message_add_tail(&xfers[xferpos], &msg);
 	xferpos++;
 	totalxferlen++;
@@ -476,6 +477,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].len = op->addr.nbytes;
 		xfers[xferpos].tx_nbits = op->addr.buswidth;
 		xfers[xferpos].speed_hz = op->max_freq;
+		xfers[xferpos].dtr_mode = op->addr.dtr;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->addr.nbytes;
@@ -488,6 +490,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].tx_nbits = op->dummy.buswidth;
 		xfers[xferpos].dummy_data = 1;
 		xfers[xferpos].speed_hz = op->max_freq;
+		xfers[xferpos].dtr_mode = op->dummy.dtr;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->dummy.nbytes;
@@ -504,6 +507,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 		xfers[xferpos].len = op->data.nbytes;
 		xfers[xferpos].speed_hz = op->max_freq;
+		xfers[xferpos].dtr_mode = op->data.dtr;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->data.nbytes;

-- 
2.54.0

