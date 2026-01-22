Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2743803F3
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094857; cv=none; b=WD6KdyHsY2njygM4DPSRKS0buEdCTTHQQOanAroOKbr8pJYhwjfmoNIpl/4umsUQDh2X7r53WdascM4v5X8C5auW/PERHsGp5yNwS7ywDjLEVM+4ZO2klI9e3xgqL0G2OfhqNeQvzt7w63DWDf7gypLHfoP4hyZW/UyHXvpHK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094857; c=relaxed/simple;
	bh=bm9R2Lb2fFoSME4oOP2tzvaj3qQ5iES+rkam/nGTCOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5cWjVmxEPctfsc7AcXw9aUyCLcCoZLz5XNMHMkjXSfpGTq/pi5n+YENLfAbb6X7qrmgOANKJw4TstaAw+ki3PEvmj8xbHvqZiFR+p55VqY3q4nRaMHj3JnQDygqxJcdgOBcNJ9bhmEldxOpfs+v33L1ZuXK/APZBvbmLl60hEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w+FBxz2Z; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w+FBxz2Z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 41A851A2A60;
	Thu, 22 Jan 2026 15:14:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 178F9606B6;
	Thu, 22 Jan 2026 15:14:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A04A119B82DB;
	Thu, 22 Jan 2026 16:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1dYR1lsf1+/uGCewQmsxVMEPBYVxpmGk/RUoFKBx98M=;
	b=w+FBxz2ZyRVpq9wpDtTCjqbySUfewBYxD1QD6BWPnSokibPGslOzUJNuXzP47xenKCBELe
	tXZQ2csXB/5lSNazQjs8WTzy6yVktPnYmDvp5JsBThXS6QI9RmYH7DbNKLAkOmYjWrvyeb
	b2x3jSOuO4sYiWPhQzptcqOujzgfScPZ0t5MU3Ucp6az1n5MiR3Ov78lEog6tA/y162iOG
	k7ZNdOaIxdD2XTegQWdjX7CK2U28LtgsSDZ1MWaw/K/HTmFZ9Pi9vB5LwUcHcdQoNrWYRP
	ZPyq7D8iZXcz9jQ0J3sdxA2Ea/8WJEROwrcZkJVqQjIj70Bt03uEvgrGFEKKnQ==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:34 +0100
Subject: [PATCH v4 09/15] spi: cadence-qspi: Try hard to disable the clocks
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-9-f9c21419a3e6@bootlin.com>
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

In the remove path, we should try hard to perform all steps as we simply
cannot fail.

The "no runtime PM" quirk must only alter the state of the RPM core, but
the clocks should still be disabled if that is possible. Move the
disable call outside of the RPM quirk.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 4bfe65af458e..af0ad24d8d39 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2039,6 +2039,7 @@ static void cqspi_remove(struct platform_device *pdev)
 	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	int ret = 0;
 
 	ddata = of_device_get_match_data(dev);
 
@@ -2058,8 +2059,10 @@ static void cqspi_remove(struct platform_device *pdev)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
-		if (pm_runtime_get_sync(&pdev->dev) >= 0)
-			clk_disable(cqspi->clk);
+		ret = pm_runtime_get_sync(&pdev->dev);
+
+	if (ret >= 0)
+		clk_disable(cqspi->clk);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_put_sync(&pdev->dev);

-- 
2.51.1

