Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840585;
	b=hGFzonO4JrcO2PRW+DWF7Ke88wTEmGKWQkCaMQdvcuKqsAuMH8/6jG2C3aDigUFMBNnz
	 /UKTJMt8A1PVzFmGLE/ijwkUA/o4SfYnokAF6BUQ5KGSlyWXOiTY7ai/DFX2mH215UWlD
	 mtRoqbqi8kOud9mJ0q7Q19zCDFHiKWAz0KlBcZtEVklZUlRc6aHNzmtafn2ZcOkebDyAy
	 hGdP46sM6I4oYI1ICzLMc5W5ShgMxHoZ7HiDNfMV4vOvjusSQy+m+y5k/WCxhDLF4v58v
	 3asYyuPdYzq0e/SZk5QEXJ2uG5XmEvPVr+nqvIqJyLvLh7YVBltvbHIWkWVt+BwJqeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840585;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=7RIZl+DxrZy+ykIKYnhVmX0bgyA1Pg/uHVuxykX6D9s=;
	b=q6rtL7Yc+1KOEexG8OghMQoWnP6QnEmtiX+KYM+zkg8sbI7V2vW7iLhjmTdpvROF8+cN
	 wNwDqbuUActufPwWmb7F79E4Ql3+ZBQFDT38Nliuy8ocPH/GOOqASAZ0LqjXi5U5ZpsGb
	 bz8NjymfMI/t7oclCkRd3dUJ2hGmrZKU4pMuOxQ5nfYUihV6MqfDWLGHJ3elf+vNv3M8A
	 3CoFvCrbh2e4GhMeymOgullqCcO1BBvt7D6NqY/OKrvYSEXR2qDkLDQX3i+wVPCVRnudl
	 3LDo7DuKwrBbO90HurVHJnunw/g4hEczSEXVS83z027WNbI+5f+EQKA4HoFSjOvUqqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ersOD9z8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B90606A332
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 14:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28B90606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ersOD9z8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ABE80C4EFD7;
	Mon, 16 Nov 2026 14:49:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8F6B6023F;
	Mon, 16 Nov 2026 14:49:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC87711BC1D5B;
	Mon, 16 Nov 2026 15:49:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840582; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7RIZl+DxrZy+ykIKYnhVmX0bgyA1Pg/uHVuxykX6D9s=;
	b=ersOD9z8ID6QR7Y3+s1dOljbqML3JuJ7YDL04s1kQwXtI5Uzl8vdzw6JaD9VuE0UGy4lws
	HzCatFlcv1ZQlqB2T4vhROwwcptwv+CkiN3gVBDbVE7/m9uHh8/4LPDjWgR5BCTYYaPLch
	o59LJizh08h5RcbVULu3mDf6CMoL4qy7YK3rn2x+6w6EvExGae0bvnItE8ySf5m6FXonev
	uLok9LC497qaqIaiaSlOg8pd+zwum2XJt2Ke50ABu0QU4IA8WgOBKvMh3l3CK+IrGW7PB5
	7FvuGqFvleAIrYsoRTNaeqSX8De1FYhC+WOpIEbb7M+N+Ry1hsFdKwCjx4idAQ==
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
Subject: [PATCH v4 5/7] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
Date: Mon, 16 Nov 2026 15:49:08 +0100
Message-ID: <20261116144910.44151-6-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116144910.44151-1-paul.cercueil@bootlin.com>
References: <20261116144910.44151-1-paul.cercueil@bootlin.com>
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

v2-v4: No change
---
 drivers/spi/spi-cadence-xspi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 4db734b8990d..48315d1694e8 100644
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
 
@@ -1282,7 +1277,6 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	cdns_xspi->pdev = pdev;
 	cdns_xspi->host = host;
 	cdns_xspi->dev = &pdev->dev;
-	cdns_xspi->cur_cs = 0;
 
 	init_completion(&cdns_xspi->cmd_complete);
 	init_completion(&cdns_xspi->auto_cmd_complete);
-- 
2.47.3

