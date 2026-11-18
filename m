Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010112;
	b=y7lhLjAy70IimleYhegU3rmORoXhzJwsPQvrWl8l3jjGuJaKoSZSLUt3ns2rCCF66nNI
	 JzOZkccZhzCsulxsTbgIRIiaobYvcJEMIU3zP/S0zse1wyIkvtM2erftRSlMsHqIt2LN9
	 djJUGO7rMFoHo3VxmocoXo/YgB6JbJxfkRKvPRxH23I0XKFzlAEQ771d5IZs3x5jVZ1OR
	 1QV4rUXaHFTB92cexdOTwlEREVNK8q0SfU+lbzDjdJt8xh1rZhyKti7pD4tlJzaCPdjBR
	 0LbHp8q0GML5ZEoUG0Bjd471Rdm1v62BCEruPkPw0ZK/FnMhSYQMuaaYoZ7NQjnXWGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010112;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=N9Jw7QFfNNzbfMawOXRrxxwq0c/fDBFUSCmAzFzlE/M=;
	b=ToiibFvKn96MB30tc1mp719oY12N5diRkdQtVk7Reg4xPbLJmfU14FH2BfWKLXK34Y3Y
	 +K34nVoGXq5Xk2eE4LJfSZWi5ORm2DWvEqHRMKPkLSZXiCX1fH756PXV09aKKx2VBgpO8
	 W0VAkdvFo9IQy2hS/bcmEZdxCzYgA7xvzxchbT9auA+0wRJZPqAegXMC15VJIxx3XXtHc
	 Eb8hrRC7hmTg/SUFN4FuvPDeKGd0iCQPoQtFCW7PZQ8Z4KVwQ/W6+528reSFRyEomJgBC
	 2R7jOo2dSFp7b3U/hZeB4RUHFDy5fiuQU1Uaws1L+FBmuo70XPJeOC3dATo2/C91pOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dgz+ldy8;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D40E606A335
	for <linux-spi@vger.kernel.org>; Wed, 18 Nov 2026 13:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D40E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dgz+ldy8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 830F74E4162B;
	Wed, 18 Nov 2026 13:55:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C2085FE9B;
	Wed, 18 Nov 2026 13:55:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8955211BC2115;
	Wed, 18 Nov 2026 14:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795010105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N9Jw7QFfNNzbfMawOXRrxxwq0c/fDBFUSCmAzFzlE/M=;
	b=dgz+ldy8nUz2LlSkOPJ0hVaotuQRRGW0T97xe8ymKyUtx1t0RZ7y1W2EFvkRz77eJnc5YP
	m/5/xi6jGLJTYTdiHzaFPUicr8vP7CkWLrXwxsu+HkRFEO8kj3v24ByI/qQd63s/otSB5v
	I28KY4m5YIBFVk3kzVhO8nAhbMzHX3IU9SQMwr5nL6vVMjrGobF4OCZJ0PqfFPyfAFHuAm
	aOnPi8uLvPKGokWiURxq3DPkY3a8FemPJVXTLD4PTw+KiQvQZP7GUhEC5BCXl0Z2HsqWvx
	l2H9LA1HF7/m3EiwxZQPgrujd3viE48JPeroQoILANDkw4FIbI2qjirEkF+GEw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 14:54:55 +0100
Subject: [PATCH 1/3] spi: ma35d1-qspi: Drop a pure software limitation
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-1-e5066ad2efe3@bootlin.com>
References: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
In-Reply-To: <20261118-winbond-upstreaming-ma35d1-qspi-cont-read-fix-v1-0-e5066ad2efe3@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <stlin2@winbond.com>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller has no documented limit when it comes to the amount of
data it can read in a single operation. The current limit is purely
software and prevents continuous reads. Some of the limits may be kept
for use with the normal SPI API, but do not make any sense in the
context of an optimized implementation for use with SPI memories.

To make sure there was no problem with my approach, I wrote a test tool
(link below) and ran a hundred tests over dozens of blocks.

Link: https://lore.kernel.org/linux-mtd/20261030144108.2211604-1-miquel.raynal@bootlin.com/T/#u
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 0644bb2990b8..1ec631afa403 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -295,9 +295,6 @@ static int nuvoton_qspi_txrx(struct nuvoton_qspi *qspi, const void *txbuf,
 	if (!len)
 		return 0;
 
-	if (len > NUVOTON_QSPI_MAX_TRANSFER_SIZE)
-		return -EMSGSIZE;
-
 	ret = nuvoton_qspi_reset_fifo(qspi);
 	if (ret) {
 		dev_err(qspi->dev, "FIFO reset timed out\n");
@@ -386,15 +383,6 @@ static size_t nuvoton_qspi_max_message_size(struct spi_device *spi)
 	return NUVOTON_QSPI_MAX_MESSAGE_SIZE;
 }
 
-static int nuvoton_qspi_mem_adjust_op_size(struct spi_mem *mem,
-					   struct spi_mem_op *op)
-{
-	if (op->data.nbytes > NUVOTON_QSPI_MAX_TRANSFER_SIZE)
-		op->data.nbytes = NUVOTON_QSPI_MAX_TRANSFER_SIZE;
-
-	return 0;
-}
-
 static bool nuvoton_qspi_mem_supports_op(struct spi_mem *mem,
 					 const struct spi_mem_op *op)
 {
@@ -560,7 +548,6 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 }
 
 static const struct spi_controller_mem_ops nuvoton_qspi_mem_ops = {
-	.adjust_op_size = nuvoton_qspi_mem_adjust_op_size,
 	.supports_op = nuvoton_qspi_mem_supports_op,
 	.exec_op = nuvoton_qspi_mem_exec_op,
 };

-- 
2.56.0

