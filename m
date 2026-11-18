Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010359;
	b=hCEqNVP4PTQhPBL6IjuN4xbExmIXZpQtgUOyS5OpJFHW9ojCYw4ldyeU/dW46Dwc7Sv/
	 h873h5Xmi0LT9kWlFSyKmn0ygv8nwIW6jfmXpbqaLiVqyuJ2hSwy2pTgTfkFlZl+j8dxn
	 BY51nsNXxqV6lXkxWOsLQEbMTDLysKrhLiv+hZSm4JC994eiHa+cz9ib9VnUsxPL8ZZ6N
	 +Yu41Sv3yHk6LMHqBix+j00CSskp5RgBU71TZOAj9O2fGCOWQiIsZqVjnlItw9XafisWD
	 wShObbPi00yZJ5kIK1PnBC4z9VGwQEMbpX+mErErTxmo2T5NM90nZraFbQ9ItvDE7tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010359;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=s+BpYLchpa1pf5ajqwxSUuxe/1gF9WVzSXBzO3/xxkc=;
	b=wTL21FUQ/wAPiDTGoZA1bVVEQNye+O253GzktEdIS8sNLcNiCmwBjTXaje4YTRhSdIw8
	 8+1uQnzs0OURdi4WiXHwoaCvmkOm+AHZysCEkWCJCEKSZ1QjafVKWfeJEYbyIEN9zznWK
	 ZSQoabL5F80UTb3v5hgQU3QEwziU59XKh47NL+vu9iAIvKPotEEvSmCOroNQM8CxxHAIx
	 crnJsDxB1g7hiU8OnSCN+/8vloqkJovrReCR53gdwIxIreoB+TKVBX0HUZLjuu0+WxoIi
	 U9xKyLdeLsVRtAMd7a+REeFBZq1YUQ4jTcRZLwHJ+pXkJGmQrw+spPW1a9ogzBG1Saw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="PibSgD/W";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54276606A325;
	Wed, 18 Nov 2026 13:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54276606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PibSgD/W
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 78829C4CBDA;
	Wed, 18 Nov 2026 13:59:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9FAD15FE9B;
	Wed, 18 Nov 2026 13:59:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6003511BC14FB;
	Wed, 18 Nov 2026 14:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795010352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=s+BpYLchpa1pf5ajqwxSUuxe/1gF9WVzSXBzO3/xxkc=;
	b=PibSgD/WM5RFvQx33QLstwvEjIYO03evEsIlyaYPXStLWyKsHsdID6YRjQabtUFFaiygKS
	xRAffipgYRDrm6Ma/waV3nj94zyfHMAuDL3EY9G4hE+GEnX0Zv27rEA3PgqA5BsnyKXQ8H
	Ja/Y4ykMxqeKx5cryCsNiqxlPKa7cQIyWuVmYR1ex1zBXiaSkaanY/oJMdu5aWmMx9gQzA
	LpW6QBllsTboqL70FmWyV658LWImyjcV+Cu+APy3Uw4SDK7ujjXNXIcNVRmy63y4oRC+Cp
	0eDf+IlLzkterx+5/ID7Kh0AVCamD/abeRlCj7CQZOUj6pPTba+Nto5A+d/iVA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 18 Nov 2026 14:59:04 +0100
Subject: [PATCH] spi: airoha: Explicitly prevent continuous reads
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
Message-Id: <20261118-winbond-upstreaming-airoha-cont-read-v1-1-acc0b6410868@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQ6CQAwAv0J6tgktiaBfMR6W3QI92CVdUBPC3
 914nDnMHFDEVQrcmwNc3lo0WwW6NBCXYLOgpsrALV+JaMCP2pgt4b6WzSW81GYM6nkJGLNtWF1
 C6joeeh5vPUeoqdVl0u9/83ie5w8xLwqEdgAAAA==
X-Change-ID: 20261118-winbond-upstreaming-airoha-cont-read-1332872b972c
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The SPI NAND core currently treats the lack of "large reads" as an
indication that continuous reads might not be properly supported, but
this is fragile and might evolve. The real problem with the Airoha
controller is that it lacks full control over its CS, which may be
spuriously deasserted. We now have a flag for this, so set it and make
it clear that this controller is not suitable for continuous reading, at
least with chips processing a CS deassertion as an end of read
condition.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-airoha-snfi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 95bfde7c8e7f..1070d4697fcb 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1018,6 +1018,10 @@ static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
 	.exec_op = airoha_snand_exec_op,
 };
 
+static const struct spi_controller_mem_caps airoha_snand_mem_caps = {
+	.no_cs_assertion = true,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1121,6 +1125,7 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = 2;
 	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
 				   : &airoha_snand_nodma_mem_ops;
+	ctrl->mem_caps = &airoha_snand_mem_caps;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261118-winbond-upstreaming-airoha-cont-read-1332872b972c

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

