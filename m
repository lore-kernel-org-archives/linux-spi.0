Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840588;
	b=jcd62kM+rq+rjOPN9JeAcqVw3U1qHo3O7SROW0+i6KXv6ie5KeuulC0ZAD6dqrdSYJ6x
	 TxC9vDYoZELy9l4LPbHnATng9a69OMb/IOgGuCO5uLi3OLslsUw+MHeGH75ZJERn9TKZK
	 YsuPtFMhzHZD+HI5LsV0govt6IwsFW2nLjGpWDTPXCBwlS6mM7CcK4uCT3MckMBvq4mmA
	 zGwdJrR1wIxQn7T9+9P89gQ27+6+lGBXp2ukO79Qs18g7Vh6qHQQBaiDtaQr4S8zR7PHz
	 qqfG4/1+qtxRvO8eWDdEbsRX14TeGE4DcEDahEhppafKBIygLAxqGFHq7d2G85Ux0oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840588;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Hqdz9emTgdG55o5vdIJB7J+QFoCoxQnQn53CPR2yMzE=;
	b=gNUT6l9+MB33zT3yoIncGewc0KvLbjPTlMcrD7x1k+VWEg9xUKMUbRO8cMsw9O8s9NVW
	 lBFe7YZKeGQZ4yNBg+tdRFUhBuynlagHpCVGZwrisKFCkk8TfivUvO+ZisZqhgvu4Xcch
	 ghtJqgKj0Tk01bLUWkfX+jFTQpoY+usTPCxTfi/isnGd143ZDRgV6Hsi8aDYPyx9a5kIc
	 sut7ZQ5qaUrOq7Kart4cmjMLzNiqmGBdDbY/cWETFSLVlLH9ulw9E7V6XEVB18kbcvwh3
	 qkNQrehoAkY+5rQJ0irYc4IZ3EYeqeGrTPb3+MZdsSc/wyjgzkA0c7KhBV59b7/qepA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="j6NdhY/0";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4F606A333;
	Mon, 16 Nov 2026 14:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0A4F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=j6NdhY/0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7D1A51A1699;
	Mon, 16 Nov 2026 14:49:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4E7426023F;
	Mon, 16 Nov 2026 14:49:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3951011BC1D5F;
	Mon, 16 Nov 2026 15:49:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794840584; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Hqdz9emTgdG55o5vdIJB7J+QFoCoxQnQn53CPR2yMzE=;
	b=j6NdhY/01ouc9rkldvUSTu56QFvHwxmCe/n+qBgxD3TKyRAS1vMAwNCW2RsK0KSzPgBpwt
	5LDcn31Je3zFa1hlGmlgv66+pI8gUAqUnC6P/DEpUW4Nc6TOTlN5qcXrfzqbH6ahWTBXMy
	l0+zkRjEeliUujmZJ+3p7PuY1FWtt5gEWG94KNhTb6SIpP30pIfyqxKmRBfSrdLb02kG5D
	wrOAOsT2H06WS2HrLqH96hmSLEcDQJpJpWDq0QFolhMTnfF4OS9jXXGmTv/SKcfXAIK8Ik
	G0Sx1cpwjf31Pwv54+f8wQvdBNGv712HDlHFBvctmMuipKyW7gfQJnrZHzF7Uw==
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
Subject: [PATCH v4 6/7] spi: cadence-xspi: Rework resource discovery
Date: Mon, 16 Nov 2026 15:49:09 +0100
Message-ID: <20261116144910.44151-7-paul.cercueil@bootlin.com>
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

v3-v4: No change
---
 drivers/spi/spi-cadence-xspi.c | 56 ++++++++++++++++------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 48315d1694e8..04557f111397 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1286,44 +1286,42 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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

