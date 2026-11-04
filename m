Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786864;
	b=nrks1QAnKhyKE9wPszXr7DcEPvAigUl+W0C/8ZlRmqQziS8+vjQ/eV5psqDY3l3WayiA
	 xaVWBrvTI3tACV8+UBsxbw4dUcWftAKaOF8G/8790kGv7VR21jfqBzAuffq9zxwDHxi8q
	 +EGbxU6opm/aKktfoT9jT1GUHKsBMHkg/S3v8khxSXDe0zqjP50E9zHF8bTgyxOUSLKts
	 F37VbJ1ZLeWVLPZmgZ0RdTUIRJZ6yxl8/qfgs2FrQQqzMKtS4kyebjoMZUlo60NbTabb+
	 BjPFrvj2EATOsc9Pv9XoBc9zDTYKtOdTpqiUgXT3p9vv/3KVuDSltBEYDkw+zGbOonQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786864;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=zM23ctgwHrUayppXIxW8XUzIQfSD1RtqeaoFVk+IJ00=;
	b=R117+2XphNBAeWeoaOaxLPd02WdOfnzzFp//81E1V3kBJ8XRSp4RuK2N7o1VhXoPK67N
	 IAQldGXBABVgzaSeSfNQKEXB3LCZ/PH41JSOVfgrBZ7f/BdxTb8XcJZRwYW02NMAsicAu
	 wpV/KZfdwHDNY08s08QktoYIiEXLgMTrIPl1+XSRz2u0sfLZOm40ETeqlgq7FUXrqHi6H
	 LCY/nNvSiy0pEEo+mxs2i2yN+Xc+8KoWcynCULSGaRM5S5+AbKIDmPtT0tJUDdHFgW1h9
	 3PVvjz7q6hVWSQSnc967vfPXaUGyJru4AXIjeyWXdQO4gQ8FY2VkLB3HjyunE8sddqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YW2vSIMd;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE006606A332;
	Wed,  4 Nov 2026 10:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE006606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YW2vSIMd
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AB2611A1453;
	Wed,  4 Nov 2026 10:07:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F47C60770;
	Wed,  4 Nov 2026 10:07:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77F20103291CE;
	Wed,  4 Nov 2026 11:07:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786861; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=zM23ctgwHrUayppXIxW8XUzIQfSD1RtqeaoFVk+IJ00=;
	b=YW2vSIMdFMBsg3/B1Ppf8+3Oia6p45uvDKtz27o+pBGxt9YR2Ta3EaHc0SzgvlQxjhY4eZ
	w/MNRwiSm7yIcm6H8y+GjtDJqhyNMemkGT3A3RseZb13LC/9y4CJniOvnUge1h9bS1KHr5
	T1sHAL7CjLUQgmA1QAjH0lv59j6L4DoyJAhLLnQV/BblbBbMy2P0GxLVjzj7+8W0caGBsL
	7vPF9kEjuYpvT3hnXrwBaXMhxwClTbhSB+BHrQsu4NCIEMzLSAk0czw7BtzacxqsBEnmeg
	b2YfJuvYDN5L3FQkGQ55I+FrIgQZHmS5fOCFZV/XRl6OhN/Si/P6J/02AvnOlg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 3/5] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
Date: Wed,  4 Nov 2026 11:06:41 +0100
Message-ID: <20261104100643.162694-4-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104100643.162694-1-paul.cercueil@bootlin.com>
References: <20261104100643.162694-1-paul.cercueil@bootlin.com>
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
 drivers/spi/spi-cadence-xspi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3cb2f95b98f6..04c873f28ea6 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -331,7 +331,6 @@ struct cdns_xspi_dev {
 	void __iomem *xferbase;
 
 	int irq;
-	int cur_cs;
 	unsigned int sdmasize;
 	unsigned int sdma_xfer_len;
 
@@ -543,7 +542,7 @@ static int cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 
 static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 				       const struct spi_mem_op *op,
-				       bool data_phase)
+				       int cs, bool data_phase)
 {
 	u32 cmd_regs[6];
 	u32 cmd_status;
@@ -566,8 +565,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	} else {
 		cmd_regs[3] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_3(op, 0);
 	}
-	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op,
-						       cdns_xspi->cur_cs);
+	cmd_regs[4] = CDNS_XSPI_CMD_FLD_P1_INSTR_CMD_4(op, cs);
 
 	cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
 
@@ -576,8 +574,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 		cmd_regs[1] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_1(op);
 		cmd_regs[2] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_2(op);
 		cmd_regs[3] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_3(op, dummybytes);
-		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op,
-							   cdns_xspi->cur_cs);
+		cmd_regs[4] = CDNS_XSPI_CMD_FLD_DSEQ_CMD_4(op, cs);
 
 		cdns_xspi->in_buffer = op->data.buf.in;
 		cdns_xspi->out_buffer = op->data.buf.out;
@@ -612,11 +609,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
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
 
@@ -1265,7 +1260,6 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	cdns_xspi->pdev = pdev;
 	cdns_xspi->host = host;
 	cdns_xspi->dev = &pdev->dev;
-	cdns_xspi->cur_cs = 0;
 
 	init_completion(&cdns_xspi->cmd_complete);
 	init_completion(&cdns_xspi->auto_cmd_complete);
-- 
2.47.3

