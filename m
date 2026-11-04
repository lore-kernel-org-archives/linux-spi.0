Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786867;
	b=fne7ZCaFmsPEcgdFY49ed76WD3XE4DaED1cJytyaj5ScPFyQHYJitj75GTLjjbhldmJT
	 +UmYJ8cSFiapzWQP+dikavnzCbF03bIKIe8rF7Vem3vGwmcveYM6c92pMh6kcPN2EuNdY
	 ug8UTHZ8xCEDnZ128ahtEE8qX1a42XBGXYGhW97//fQFc1MaYSxAoGp1B2xQLvpw4adrH
	 +CMPWK0Ht9QWhUoairkWrTiA6vTF6Wzb6gI4y+kwK1UFHVZk2ua/nO95KSnv66w/jpGpc
	 IZHPLnw1dyyktafkaq7yGypHJ/eqK5rvTPKbcEOpVpsAeb2uCAiKbeK5+xohhRMPfYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786867;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=hsmjJdtofEHC9QyyKC1t6QrNnXBp77lZpC68HVD5my0=;
	b=V7jcTvRhpSoKc9VRZ6SqR3YCu3o26RjFZxOHFFfIe6sz63KuHz4RmR1TMQDNYoNeOIZE
	 4THcQ3ZUJbjOmiMpHclTXgeQ7a1xS9p14tw40kx05hPN98nYUKy6y3V8N0i7Pe+uELpeT
	 fW08nTWd8RE4uba0e4PgKKDdT00DSnRK5EL1mzg2JdSto/H9Z+ym0TCrR+9pYBQPjAbKL
	 VRq2iGWxhtwa/ykpx5wUab83KDNxCwrxYaXVYoNzrV6H1Jy/X+d6hBtsjmUBo32zE9Tq3
	 DUurt6P/UZILAMRWhrBZpbB0eHfOClQO8nh786QICBYoipHkgNpodbttQJXp/7fCCIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nzWy6pCk;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E872606D806
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 10:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E872606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nzWy6pCk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EF97E4E413F8;
	Wed,  4 Nov 2026 10:07:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C485260770;
	Wed,  4 Nov 2026 10:07:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF2C4103291FC;
	Wed,  4 Nov 2026 11:07:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793786864; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hsmjJdtofEHC9QyyKC1t6QrNnXBp77lZpC68HVD5my0=;
	b=nzWy6pCkRPaZWGcfEqj14RbkPWenzUog/IUG09JSAi8sPCzyun3b2W+KEkWcmVbOtbt5kx
	VXD1DI5Lbvk0/2a84Y5geQAMqEpsnXa23NOLpQuVR6Q70GBMeUWU+BLivpxYn80KeKlJWA
	bY13ppx6TTJWOlwpHvLAXZiwNBx9UZ+u3RU4mFK6sNFqtxoOjZE+QE002USmll/g1/VjJZ
	gdd8tsjMMisMUGbvkjaGNEM9hfyOL3oYagNLxdmOHt518eCc9Y52EWgqGcR3YD/mGSVp8X
	kEPyBIfY/uUoJtbqzHLdPlhUR9aexh9kayh/zeIcrJt0SG3KK0kmjob2azjgNA==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 5/5] spi: cadence-xspi: Add workaround for old Marvell firmwares
Date: Wed,  4 Nov 2026 11:06:43 +0100
Message-ID: <20261104100643.162694-6-paul.cercueil@bootlin.com>
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

Older firmwares from Marvell used the cdns,xspi-nor compatible string
for the Marvell-specific xSPI IP, which is incompatible.

Add a workaround to support this by assuming that if the "xfer" resource
is found, it means that a Marvell IP is used.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/spi/spi-cadence-xspi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 48a109f3fcdb..d326589a6ca3 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -1301,11 +1301,21 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_64BIT
-	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
-		if (!res)
-			res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "xfer");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+
+	if (res && !cdns_xspi->driver_data->mrvl_hw_overlay) {
+		/*
+		 * Handle old Marvell firmwares using the cdns,xspi-nor string
+		 * instead of the marvell,cn10-xspi-nor string.
+		 */
+		dev_warn(dev, "Marvell-specific xfer resource passed, but using the cdns,xspi-nor compatible string. Please fix firmware!\n");
 
+		cdns_xspi->driver_data = &marvell_driver_data;
+	}
+
+	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);
 		if (IS_ERR(cdns_xspi->xferbase)) {
 			dev_info(dev, "XFER register base not found, set it\n");
-- 
2.47.3

