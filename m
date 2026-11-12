Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493896;
	b=opgqMA6HWrQbfK9+MHKE7TYux21OSfAPbVtETUElYh6kOFs2dBBI/kxJIrYCJnShyeKY
	 8ffw4Kt/jjGKepsJ7CRFjiRpmP4ni18bJf/NmlDzpnRQRoNFbMF4rXtI76ySQcuZCvDxs
	 mgDiB+xPk3JYb0hDpcZyXatlLuhuEes2w/Xvovrm7G+WDRP6jZw6BfFEAI9PnOMgzHuFE
	 5SzS9XUfmrE5236xho4JavGQ7ToaKiC8SCu0JyHkapZZEzE1gHZKIjl3X7v31jGQ5Gq9d
	 Y/x7jNnfKThhexjnh0QvRFMLOO53qwKGqjDDCai8wrKUSiap+RoNr6B2ndRi6aNoe7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493896;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=yUVoUDgShpTwfQtd4+44a8uPErBR6hfH6mm+v8YdQw4=;
	b=TPe4sxHGO1fbwhJxNz/1KmwWJLjIRZ90dZYbv38rzK2MmZTFLuie6iZGByOCBWpFmuMX
	 8yefV28TdCeEJLcLFlDbGEQ/pVNKjLc1783uc+xZ+2KBSh8lMAmKLyP9Ih/pwknOyBkck
	 Duqsi0J1cNuy7wnktvFY2E9HsMWYo9pdPVypPQ6ohd3NySoQgNAlJife018PUebzSl9ge
	 4EpZU0ViloxfS+FQfan2Cni3TzyKoevfd+XxkqFMnNsgo4BdhHAivXuhLmkXmXfiLvgnZ
	 uLSD8W+uQ+DGIRmEh1INAO2iwqcpl3GIQQi65MEYiZpkE+UjERxxh9j8gYKIlC+E2Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="NMsG4Nw/";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88595606B2EA
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 14:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88595606B2EA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NMsG4Nw/
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 497671A1629;
	Thu, 12 Nov 2026 14:31:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FA4D5FF85;
	Thu, 12 Nov 2026 14:31:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB97611BC0326;
	Thu, 12 Nov 2026 15:31:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794493889; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yUVoUDgShpTwfQtd4+44a8uPErBR6hfH6mm+v8YdQw4=;
	b=NMsG4Nw/IJD0wKk15fHgtX52Vwh4XkofvpWcSXqQ3cGAFOSf+PuaZLxEjEOdijm9LdD8ao
	ur/n7lhaBwki8KmaJu8ESIvTCVR2/POmpr6ARXBD2pler90TVG6KpG7uYqBGIyR2JFnbw1
	YjaZRztoDdchoo2Xp1EfOp8eswogoKVcvrFNEJefsWm+Dd9MbLAj4T9CLapxVhw7+oDepS
	Edt3L4WECe08DFf6UthUTLulvcPSkZ3gwVKrKtUmRHo10zTRUe+dIvnZ6mRS9JHrv+ewNf
	O3I4qLw/szvFvDSUHbe7lx7I/zvzA2Gxac92D/Yt5lhBn7YPlqYpLHDsA0LS9Q==
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
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH v3 5/6] spi: cadence-xspi: Rework resource discovery
Date: Thu, 12 Nov 2026 15:30:49 +0100
Message-ID: <20261112143050.53347-6-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112143050.53347-1-paul.cercueil@bootlin.com>
References: <20261112143050.53347-1-paul.cercueil@bootlin.com>
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

The previous code worked, but calling
devm_platform_ioremap_resource_byname() on ACPI where resources aren't
named causes warnings to be printed, one per call:

cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)
cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)
cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)
cadence-xspi PRP0001:02: error -EINVAL: invalid resource (null)

We can avoid these warnings by first obtaining a pointer to the resource
with platform_get_resource_byname() and fallback to
platform_get_resource() if it fails, and then ioremap the resource using
devm_ioremap_resource().

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

---

v2: - Drop warnings. devm_ioremap_resource() already warns.

v3: No change
---
 drivers/spi/spi-cadence-xspi.c | 56 ++++++++++++++++------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index f4ce4820b08f..8fa58a0412e3 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1276,44 +1276,42 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
-	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
-	if (IS_ERR(cdns_xspi->iobase)) {
-		cdns_xspi->iobase = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(cdns_xspi->iobase)) {
-			dev_err(dev, "Failed to remap controller base address\n");
-			return PTR_ERR(cdns_xspi->iobase);
-		}
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "io");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	cdns_xspi->iobase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cdns_xspi->iobase))
+		return PTR_ERR(cdns_xspi->iobase);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
-	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(cdns_xspi->sdmabase)) {
+	if (!res)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
-		if (IS_ERR(cdns_xspi->sdmabase))
-			return PTR_ERR(cdns_xspi->sdmabase);
-	}
+
+	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cdns_xspi->sdmabase))
+		return PTR_ERR(cdns_xspi->sdmabase);
 	cdns_xspi->sdmasize = resource_size(res);
 
-	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
-	if (IS_ERR(cdns_xspi->auxbase)) {
-		cdns_xspi->auxbase = devm_platform_ioremap_resource(pdev, 2);
-		if (IS_ERR(cdns_xspi->auxbase)) {
-			dev_err(dev, "Failed to remap AUX address\n");
-			return PTR_ERR(cdns_xspi->auxbase);
-		}
-	}
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+
+	cdns_xspi->auxbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cdns_xspi->auxbase))
+		return PTR_ERR(cdns_xspi->auxbase);
 
 #ifdef CONFIG_64BIT
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
-		cdns_xspi->xferbase = devm_platform_ioremap_resource_byname(pdev, "xfer");
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
+		if (!res)
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+
+		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);
 		if (IS_ERR(cdns_xspi->xferbase)) {
-			cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
-			if (IS_ERR(cdns_xspi->xferbase)) {
-				dev_info(dev, "XFER register base not found, set it\n");
-				// For compatibility with older firmware
-				cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
-			}
+			dev_info(dev, "XFER register base not found, set it\n");
+			// For compatibility with older firmware
+			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
 		}
 	}
 #endif
-- 
2.47.3

