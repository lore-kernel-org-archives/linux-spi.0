Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176008;
	b=U/Ejdb0am0Uy4fJHd2wx/ei+cGnR9PJTEgp379/lsoasP4vWd3KAXSsSwbr7axIzRHM0
	 sYQ4KQ8mSL0SMiXWT/snMcfEIbUk0FL1aCXLkfb5SB4tyoQqwIQ0UDV88kit0SV5M4NPr
	 VFFV0IiUYTpD/meeDrHbw/j5e76D5JRT5i76qUuXS4B4N7PCYirfkZJ4iw4gUW/Qrn8fG
	 sFpRZsSmELukwrvCRJ+pKm7fkoPa83iZYkWZaOSIWLJYl0zht6Hiu+rJlrtgBBhBoEgjk
	 NFoLoz8FXR+flZSw1lHqHkyN6d2Nl+V70sWOngiwqxurQ+MV04Uq4sBb0tIjW5CdKrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176008;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=py7QFooGqAuWcg2o/e52luSIV1oKyeZ6b+xRNq9sn8s=;
	b=nCoQ7fKu6aHwKylpF0XuJt4C1MGQkxb94urAj9aGJIPZXP6SNsWLJuMaxNXEe69Qb8D7
	 ZkUp1Gc2YMGpECrdBH7AvUVVegnci6MPG1dytgIopxcE5AYvnAlRIKwQ3uH24R6Kp+2JT
	 geNJ7emy9djRrviBwChzJrT32uAT6SgM0twLzo0MudTdghqnMTRROG8wSUeeQIMTO9xyB
	 Vl/rrBiQ2N8nNYpJEc1+GeKpjOTr/7z5dXb3+RARCk12Zs27VZrTE/thc235J7qcls4zP
	 L5xvb6NdCsmJh/4EtonWS7GwP1yQamT98Ud78Yw25AcWY1c0J81X6F+E/OyxIi5awbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="oi0D8/qr";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510C606A32A
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 12:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D510C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oi0D8/qr
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 04838C6221C;
	Fri, 20 Nov 2026 12:00:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 535066017D;
	Fri, 20 Nov 2026 12:00:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D4AC11BC0070;
	Fri, 20 Nov 2026 13:00:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795176004; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=py7QFooGqAuWcg2o/e52luSIV1oKyeZ6b+xRNq9sn8s=;
	b=oi0D8/qrYk1e4pXv9HTYQGaKXqDa/77/Nf30ifhWbnx4A0D3txfpWDy/okYof7xYZCRLl8
	OjpeRcZQ0wYlU7G1Y2kifPpot+PQiqKVUYj8QnBGo+pusPMOGvbXzG+WPxtgy2Q5cb3Fg2
	6sKVfB+mY0f7zkXbWuN/kZtAA68rPB4ziSl0NnAQQUyyQLhhiJNj34CZjUsuBXtnVT0rWX
	LSK6vB+uB28A5zH7I2227yyf2DpYEqe4pkBwfR5STIYU6r0O25E9w1MqSoVa2rvoFsuCCw
	2GDqXefJRFayl3Y6j8poG9+zTveU5uQeZnfw2P63Cw45x7CJwCOMjX0Ebk2hTA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	George Cherian <gcherian@marvell.com>,
	Witold Sadowski <wsadowski@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v5 5/7] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
Date: Fri, 20 Nov 2026 12:59:23 +0100
Message-ID: <20261120115925.173568-6-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120115925.173568-1-paul.cercueil@bootlin.com>
References: <20261120115925.173568-1-paul.cercueil@bootlin.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Tanmay Jagdale <tanmay@marvell.com>

Make the code simpler by just passing down a 'cs' variable as argument
to the cdns_xspi_send_stig_command() function.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2-v5: No change
---
 drivers/spi/spi-cadence-xspi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 7c7a604f4c62..c752328bf267 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -335,7 +335,6 @@ struct cdns_xspi_dev {
 	void __iomem *xferbase;
 
 	int irq;
-	int cur_cs;
 	unsigned int sdmasize;
 	unsigned int sdma_xfer_len;
 	struct dma_chan *dma_chan;
@@ -672,7 +671,7 @@ static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
-				       bool data_phase)
+				       int cs, bool data_phase)
 {
 	u32 cmd_regs[6];
 	u32 cmd_status;
@@ -697,8 +696,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	} else {
 		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 0);
 	}
-	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
-						       cdns_xspi->cur_cs);
+	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, cs);
 
 	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
@@ -707,8 +705,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op);
 		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
 		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes);
-		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
-							   cdns_xspi->cur_cs);
+		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, cs);
 
 		cdns_xspi->in_buffer = op->data.buf.in;
 		cdns_xspi->out_buffer = op->data.buf.out;
@@ -743,11 +740,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 			    const struct spi_mem_op *op)
 {
 	enum spi_mem_data_dir dir = op->data.dir;
+	int cs = spi_get_chipselect(mem->spi, 0);
 
-	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
-		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
-
-	return cdns_xspi_send_stig_command(cdns_xspi, op,
+	return cdns_xspi_send_stig_command(cdns_xspi, op, cs,
 					   (dir != SPI_MEM_NO_DATA));
 }
 
@@ -1411,7 +1406,6 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	cdns_xspi->pdev = pdev;
 	cdns_xspi->host = host;
 	cdns_xspi->dev = &pdev->dev;
-	cdns_xspi->cur_cs = 0;
 
 	init_completion(&cdns_xspi->cmd_complete);
 	init_completion(&cdns_xspi->auto_cmd_complete);
-- 
2.47.3

