Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5B2D7DD7;
	Mon, 11 May 2026 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=sK3V6/hzgo6gc1Fw4WleOSYTr1QRYiQlAdZmUQ8IewF2XzC5gkz3zPqA1up0Obxu6v0H4JkbWPC6gorVtM8Kdicn6FceRyLznRB0Uqh0SYYNS5HHcsRFTBpdJCrS7rmFEoNCmbxGUxEIMHiQ0/avHkDIZPa4KHgR4QNCEBs2v/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=8zaaMmjQrzHH7jv09/7EndR2/KWRdkHmMxODj41cFf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPdrOIfVxXJPkEossH3ViTCgRxdfozNUI3CyqKcoKuL1goDA2Od1KmuStYFwxLVXthRSuXBQLp0KQcdFZ0w4cgBM9R4S4RMp7fSkxcNHLqanCS84k0SPWIrymtS21PrLtxUerI2WYNUlmVX30JS2ADYFOFJwj7xXEilZ2fF4uAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB+klaiz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB+klaiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60E1C4AF12;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=8zaaMmjQrzHH7jv09/7EndR2/KWRdkHmMxODj41cFf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NB+klaizLAFBwpL9zdURq4Qvdv8sklLJGOzMbvwFa1xplIMK3RwXC8iDe/M9UAJgL
	 BVkJB2sArYglR/fE6UGMSj3Oed9JJKebp7Nr2B7+ToAXFPbXF75BGPiMKy+8F8dZpB
	 KqfH/rzHOYxNkBmCZh8cIKYh45XvfBbeBiHnoXq3BtDf21VgSdHBHBvR+SnN3dJHfT
	 mfSGAETo78wq5WhJsWjm6Wrx+cMmwlhpKyrLZTZKDUs3YbL5Fx1zGszro8SscOKeQZ
	 Gj9qiNhR+uhiHOXSMyOqTzkugcpAwOwxl6o1uB8hmToBYYkPyvm71ShNa/GAzsG2i3
	 xQzi6m/xDATfA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L8E-27v3;
	Mon, 11 May 2026 17:04:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>,
	Yang Shen <shenyang39@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 06/12] spi: hisi-sfc-v3xx: switch to managed controller allocation
Date: Mon, 11 May 2026 17:04:02 +0200
Message-ID: <20260511150408.796155-7-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511150408.796155-1-johan@kernel.org>
References: <20260511150408.796155-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation for consistency and to
simplify error handling.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index b2af2eed197f..eeeb86381862 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -436,7 +436,7 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	u32 version, glb_config;
 	int ret;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*host));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*host));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -451,16 +451,12 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	host->regbase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->regbase)) {
-		ret = PTR_ERR(host->regbase);
-		goto err_put_host;
-	}
+	if (IS_ERR(host->regbase))
+		return PTR_ERR(host->regbase);
 
 	host->irq = platform_get_irq_optional(pdev, 0);
-	if (host->irq == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto err_put_host;
-	}
+	if (host->irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 
 	hisi_sfc_v3xx_disable_int(host);
 
@@ -501,16 +497,12 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
-		goto err_put_host;
+		return ret;
 
 	dev_info(&pdev->dev, "hw version 0x%x, %s mode.\n",
 		 version, host->irq ? "irq" : "polling");
 
 	return 0;
-
-err_put_host:
-	spi_controller_put(ctlr);
-	return ret;
 }
 
 static const struct acpi_device_id hisi_sfc_v3xx_acpi_ids[] = {
-- 
2.53.0

