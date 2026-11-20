Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176014;
	b=Ul+yyQnIpZKNEShGq0rZEui4jCaXzUuLjT88u/5zbywoQmla+ryuhnlI1sw2CTXyqtIR
	 8apwTZJk1fZ/fVuIQdRs7T1fRK+Y32/bXa+rIRVbDo/efe+4EOKnV02bNySkHC3gTfHYe
	 SK1tLXMLnrJiSz52EMn+l0qzoG2ZkZ3DV/5xbfhohHtNrZnL9Py/D2ux6DeqoPfpwHHtT
	 yasJX/y9CrSeYb4kNDOmDP3SXh0zkX7Ooytb0qFeWhX8Hbi3l8GvfK7F48LgVZYE7dzs1
	 boWnyM4sdeZ334wmR7JQ+Lg7bzTc+CYVcrViHUdW4YuAOsilebeqkHxR+dg/ZF2ZBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176014;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=iwjXZysY45ID9OUtrlIHm6lO++zTF+9as4iaG9vYPqE=;
	b=2xBP0TnfU5ywNZhMrbj8v885sZu7WiqU93IxKbzeBaEwmWwOq2Atvb/5heSWAvfmZikR
	 zYYAMVkAjoPtA4gGCiQjHc1Qo6DZgZUD544hGs9IDEl1Lvl6Q1dhPAln8ChON7vhYTyHl
	 TwDdc/y5Gr7jXQmnNVFwvK2zPYWytgFn/obnhzGk1iAxbt9+IFng6MkrDRmYi6D6Ehivg
	 YFHa1gpS3v61a4ZRLL1k1zJ1/p0BhHyhPvvHxoiNKCCa38aEDcKqOx7Oc5sPXSjvTP/AM
	 SgACU/kiZ66j1+zOqsVQYrURbxxWI3QQxTyMAqcbXs+U2kRueCoPiWIBkB0BsfghpZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hPIalulG;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210060A380C
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 12:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B210060A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=hPIalulG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 02607C6221B;
	Fri, 20 Nov 2026 12:00:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47DD86017D;
	Fri, 20 Nov 2026 12:00:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 652F311BC00A8;
	Fri, 20 Nov 2026 13:00:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795176007; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iwjXZysY45ID9OUtrlIHm6lO++zTF+9as4iaG9vYPqE=;
	b=hPIalulGRF0TrNw4ax7k9wmgiHVy5JrOxKbvsDiIm4VmF7bTAvist+tOs20fOM3bDf6hmJ
	XCteHXf2ZxU6yV8CUq0o8r57xJTwDcsN36GIXEQvfn0CtgPCxvI0V6Pd+P6SpI/MgzF3cW
	qgF0WV05Pq3/mBcuD/kXqfMW/U7PKffvjOOj4rRbyWucS1xkGzBq6/WxovjWLZJ4PonwQl
	GSQ8Y4HCwzhfNIivXe5Q3jfjUXO3ESRjP3VHCP09fSQ9C9aWjRREgkv1+lkdmO36k/a07b
	TuE2kycTQYGo5bAnKHIUuOkUzG6KiSNp6WfgzMU9WyNUBGdcGnxeGLVs1UsF9A==
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
Subject: [PATCH v5 6/7] spi: cadence-xspi: Rework resource discovery
Date: Fri, 20 Nov 2026 12:59:24 +0100
Message-ID: <20261120115925.173568-7-paul.cercueil@bootlin.com>
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

v3-v5: No change
---
 drivers/spi/spi-cadence-xspi.c | 56 ++++++++++++++++------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index c752328bf267..dbfb07e6751f 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1415,48 +1415,46 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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
 
 	ret = cdns_xspi_dma_init(cdns_xspi, res->start);
 	if (ret)
 		return ret;
 
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

