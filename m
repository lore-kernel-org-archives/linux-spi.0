Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795700;
	b=FzGfj00kQPXqHPWF7jp/Q1Z3/BX2r2Sye4cP42Oee3St90Miz76mjLs9YGNpm+PnUCe/
	 wjr2wv2G/gOb7GR5trw/V+QcfVTZ06xV2aPsW9SJo5xxHpSPY2YwVBTuC7A+P/Ubrt/R8
	 NzNTfgdR2GQJLtGB/GEacG+6zbyC2Nio/e+flo2oEKoueXysslsYwhtmVWUyyWi8a/a1z
	 UXS2Lcz2ejuupm0tBxkfkjDSNib43+wjFR9zbFM0cjt+cRAjTaOnCcKHqxxjIJN8rSoqX
	 irdxKcEAeT13QCzp012RYvFBHaOgAO3G8UB74W3pOZ5jDkkuYCxYNrbUcW+ZJfT84UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795700;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=s7XUL2gr6UETYVHFyDnE1g1QkZ3YJqPZcHtp9FpkfFs=;
	b=RKVoXp+Zo+NBr0k4QqYPdB/Bj9qRwKFYKCRvejcPnUBuVX2d6UeavA5MSAePA5zNQ32H
	 sl4c/fvb8aqgqcuM7e8jm+ut9O7KPR0eUYBpCl61szbV8wyVg/0yk65LtgpaN4zAP6xyQ
	 iROgim/LYooTEMW/1SWFG/5CwP16vnv8JpckeQPi62yFlTbvKaCpHuKjWByicAUUbeoEX
	 fW856NMM1OBVnhMvdde2iLGQnBn4UMe1XYdgMolD7bnls0cYgbVbrwU6mHQLLrn4/tB6N
	 1kVudqWA3ej1CLIxRcmV2hrPGDJmaP2N8119A/lX3yZ65lGbudrwwSUNdOXRIxRK8zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=N2vMlmZM;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC5606A32C;
	Fri, 27 Nov 2026 16:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EBC5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=N2vMlmZM
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4D6D2C2AC4E;
	Fri, 27 Nov 2026 16:08:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7E5016049C;
	Fri, 27 Nov 2026 16:08:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5500211E90CE3;
	Fri, 27 Nov 2026 17:08:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795795696; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=s7XUL2gr6UETYVHFyDnE1g1QkZ3YJqPZcHtp9FpkfFs=;
	b=N2vMlmZM6OXCwykJn6xk4azsFg+avsrsUE/kMAP7T35PQ5HcU+sRvvNWwFg9uBtLqX5Nr/
	qc08u3tyOB1GUHMaTbKXUymnXrKkjCcf035CV4yITsMqsdnzwYpU6vG8PmC7RW+giXMY6f
	lTCJgz/IbkF2MuFdwSlDKPVQvSRHahZLKfxZ6ugiCOmJk5723XVPh6GcIJNSrwcUuMYEKw
	eFpGyLGPtdZEg/GdccYTLJBBbqO+PbIPwOGDyjA+wfqWJ/pgXGaU+chl35BZsUe2Rfy5ZI
	NfDBaYKisnC5YG+IqF/B3gVhxy1idkI7aw23FUy3Y+pwXlu2UmbhpAGy7hkgPA==
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
Subject: [PATCH v6 1/1] spi: cadence-xspi: Rework resource discovery
Date: Fri, 27 Nov 2026 17:07:59 +0100
Message-ID: <20261127160759.249979-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127160759.249979-1-paul.cercueil@bootlin.com>
References: <20261127160759.249979-1-paul.cercueil@bootlin.com>
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

v6: Properly handle errors of devm_platform_ioremap_resource() for the
    xfer base
---
 drivers/spi/spi-cadence-xspi.c | 61 +++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 594b46304a6e..a42fab719b7a 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1454,48 +1454,49 @@ static int cdns_xspi_probe(struct platform_device *pdev)
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
-		if (IS_ERR(cdns_xspi->xferbase)) {
-			cdns_xspi->xferbase = devm_platform_ioremap_resource(pdev, 3);
-			if (IS_ERR(cdns_xspi->xferbase)) {
-				dev_info(dev, "XFER register base not found, set it\n");
-				// For compatibility with older firmware
-				cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
-			}
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
+		if (!res)
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+
+		if (res) {
+			cdns_xspi->xferbase = devm_ioremap_resource(dev, res);
+			if (IS_ERR(cdns_xspi->xferbase))
+				return PTR_ERR(cdns_xspi->xferbase);
+		} else {
+			dev_info(dev, "XFER register base not found, set it\n");
+			// For compatibility with older firmware
+			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
 		}
 	}
 #endif
-- 
2.47.3

