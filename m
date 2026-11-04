Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786866;
	b=COUd4j3g2J2MmfIvEInZ0jpxQyCuYE+gMLPKf4gihbZ/OG017t35jGJYcceF/tWBt0tB
	 iu7Mz67vT3Xe7Rrbm33Dm6q1KXwQSxFtYnmT1uFNCPNKwPUYJ8gDKpa1pSFGfZ3dEjIvp
	 HXc0d2ziwfip1BVocA2Nbz94+81yBMBGk6vYZiustLqxdnZHf9PG2NmlMKhEZ7Tud8CxR
	 6yQuGkUKJSfBG5sQj5KAS1XfDWHt2171DDCwq+7MlSMDdq81Il3yQ/upvt0606oBBB+dh
	 wfO4ZiRVSHUZ6IWuKrGrHPt4iEKyMeOJolHMhvoZXIi82UuUGl6Pt+hrnka1mXoUBIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786866;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=3VDSeXlkZp7gpIU3cP7Tun6Dh4Z9wr9fp1d+zQm6dVI=;
	b=qWxwZTl+TaTQU7GCo89FpI7vzMa71+OoLGm6veWuCsPeU0Srey+S/6sO7ge37QRbmlR7
	 AOozkOlOhkm2DP49DA26FFqQeo8xmez3RTnDwzDMn/BIk7Q2CoziJREkY7meMfTPab2jf
	 rCZh6PNs9qoQMPeCJlcSKulQouWXxYIbSJ7aypDFLVGp9uiGw9gIHmJyeobNNozo1sVDJ
	 8zm3frYXJZJ+aeTAgJ1RCLezRUi7+Ze3n5h76zSY61+szwNsG4m0VJd3EL271qKor1ANt
	 AyOTKrikiX64vmVGmDfSkHJrHz37smNNqyooAanm1K+60MgSI98bzr+3HFdIytszrkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=c0iuHoBk;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EE606A33C
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7EE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=c0iuHoBk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 03421C8F46C;
	Wed,  4 Nov 2026 10:08:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12F1B60770;
	Wed,  4 Nov 2026 10:07:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5754C10329221;
	Wed,  4 Nov 2026 11:07:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786863; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3VDSeXlkZp7gpIU3cP7Tun6Dh4Z9wr9fp1d+zQm6dVI=;
	b=c0iuHoBk8FjebV9Dy/2+Q99Sz1X1yKQAPdI5r5C2nFS/sThuYjTg5XoE4MFevrYJ+NCpdd
	suW0x1t7/AMEgi+0aDsscfDiAt3m9P+4Kr9sa0obCga4GQdkTn1JLJqczUXwhSg0hULrat
	0MqrudAJevngTRFfQtVE880XOcs3oWeYqZcsJXfEXnA0tjDGvfKA/pMU4i4N/7eI2CzvIE
	VfbS4h4oq5/D68dtDi3YgeX4yoAbCe+Xg0HZwIgj0HSVnSHJeyVkulCdOsFDbB9LBNlam2
	N7dXqqgbw5tRCk6tgHPphvm28CGZCRL6ZXV9wHp67x8V8Ku0vpgK6G7e/KLMHQ==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 4/5] spi: cadence-xspi: Rework resource discovery
Date: Wed,  4 Nov 2026 11:06:42 +0100
Message-ID: <20261104100643.162694-5-paul.cercueil@bootlin.com>
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
 drivers/spi/spi-cadence-xspi.c | 50 ++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 04c873f28ea6..48a109f3fcdb 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1269,44 +1269,48 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
-	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "io");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	cdns_xspi->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->iobase)) {
-		cdns_xspi->iobase = devm_platform_ioremap_resource(pdev, 0);
-		if (IS_ERR(cdns_xspi->iobase)) {
-			dev_err(dev, "Failed to remap controller base address\n");
-			return PTR_ERR(cdns_xspi->iobase);
-		}
+		dev_err(dev, "Failed to remap controller base address\n");
+		return PTR_ERR(cdns_xspi->iobase);
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+
 	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->sdmabase)) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
-		if (IS_ERR(cdns_xspi->sdmabase))
-			return PTR_ERR(cdns_xspi->sdmabase);
+		dev_err(dev, "Failed to remap sdma address\n");
+		return PTR_ERR(cdns_xspi->sdmabase);
 	}
 	cdns_xspi->sdmasize = resource_size(res);
 
-	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aux");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+
+	cdns_xspi->auxbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->auxbase)) {
-		cdns_xspi->auxbase = devm_platform_ioremap_resource(pdev, 2);
-		if (IS_ERR(cdns_xspi->auxbase)) {
-			dev_err(dev, "Failed to remap AUX address\n");
-			return PTR_ERR(cdns_xspi->auxbase);
-		}
+		dev_err(dev, "Failed to remap AUX address\n");
+		return PTR_ERR(cdns_xspi->auxbase);
 	}
 
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

