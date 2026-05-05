Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728F3E0232;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=UFHCd5TEedoib53NxT5+bjjoXGBtfsiVSMHfWUxR++/1rUFhWGqiBGk0P4CjWnNWzng+4CMoG3bd4ZOTAw0fpeE2XmVY2e2Eo5qQpRNTy5lKr2LtgfNqBSIXH4jgWgazTFF7Ms7gFyL478EDHqJwQ3v5LWpA9GXmfdAcL8T/Lm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=cDNMrN0Yez8wSnrA6UN4k35e7qwR6fL9/Y8Ac9Y69Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+j7kJITl/0DebHEJ0p5RhUT7Sr7XFPYxf7WUGJGXQzSiBmPyV/k4tbo9vh8QQ/Q+LfzBJ+CbcJkkOuWaabXwDgDLnm2fxnVKe/zGd1Rid9cxIvWvFDWsp4ofDCqmm/blA+MsRFTpwd0aCuxQBbfgJKvwn/EyFlbCgkaJDAyrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beXySKk5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beXySKk5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD94C4DDE5;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=cDNMrN0Yez8wSnrA6UN4k35e7qwR6fL9/Y8Ac9Y69Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=beXySKk5ZPF71TKZD3egu+0ZOFwpy/kbAMlNCSc5iDx4hK+KQmvHGxH/mpxLHjxu/
	 DeyGpfGt3Wduto3hUgrYHd5YyqsZgvrCFrVyajTjZhQlvNRVCKgqxjFyz7Uz8SYcSG
	 ELMofTmQXPFX45v0XQGPU16wjVIeJmj8hoxlu7GTG7Kjx8ayRTqIAyjP/bRGBPm02g
	 QAT7bOz8dDx1k5f5zYrFKI6IdXDa8jwM19XsI/oqS11x0bsopC3hOEpZZIQcgSxQqE
	 SBGbYUb/fQZLNbee733BR5UH6HxWQJlzghKTXSwq89mM2GcJ2D+pQQIJJeZG7SSTmy
	 x6Z4eEfMXGOPw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atV-3LAY;
	Tue, 05 May 2026 09:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 20/20] spi: zync-qspi: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:09 +0200
Message-ID: <20260505072909.618363-21-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505072909.618363-1-johan@kernel.org>
References: <20260505072909.618363-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation to simplify error
handling and to avoid having to take another reference during
deregistration.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-zynq-qspi.c | 40 +++++++++++--------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 406fd9d5337e..d762aaf452af 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -637,7 +637,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	struct zynq_qspi *xqspi;
 	u32 num_cs;
 
-	ctlr = spi_alloc_host(&pdev->dev, sizeof(*xqspi));
+	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -645,16 +645,13 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->dev = dev;
 	platform_set_drvdata(pdev, ctlr);
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xqspi->regs)) {
-		ret = PTR_ERR(xqspi->regs);
-		goto remove_ctlr;
-	}
+	if (IS_ERR(xqspi->regs))
+		return PTR_ERR(xqspi->regs);
 
 	xqspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
-		ret = PTR_ERR(xqspi->pclk);
-		goto remove_ctlr;
+		return PTR_ERR(xqspi->pclk);
 	}
 
 	init_completion(&xqspi->data_completion);
@@ -662,21 +659,18 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->refclk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
-		ret = PTR_ERR(xqspi->refclk);
-		goto remove_ctlr;
+		return PTR_ERR(xqspi->refclk);
 	}
 
 	xqspi->irq = platform_get_irq(pdev, 0);
-	if (xqspi->irq < 0) {
-		ret = xqspi->irq;
-		goto remove_ctlr;
-	}
+	if (xqspi->irq < 0)
+		return xqspi->irq;
+
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
 			       0, pdev->name, xqspi);
 	if (ret != 0) {
-		ret = -ENXIO;
 		dev_err(&pdev->dev, "request_irq failed\n");
-		goto remove_ctlr;
+		return -ENXIO;
 	}
 
 	ret = of_property_read_u32(np, "num-cs",
@@ -684,9 +678,8 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		ctlr->num_chipselect = 1;
 	} else if (num_cs > ZYNQ_QSPI_MAX_NUM_CS) {
-		ret = -EINVAL;
 		dev_err(&pdev->dev, "only 2 chip selects are available\n");
-		goto remove_ctlr;
+		return -EINVAL;
 	} else {
 		ctlr->num_chipselect = num_cs;
 	}
@@ -705,15 +698,10 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register controller\n");
-		goto remove_ctlr;
+		return ret;
 	}
 
-	return ret;
-
-remove_ctlr:
-	spi_controller_put(ctlr);
-
-	return ret;
+	return 0;
 }
 
 /**
@@ -731,13 +719,9 @@ static void zynq_qspi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(ctlr);
 
-	spi_controller_get(ctlr);
-
 	spi_unregister_controller(ctlr);
 
 	zynq_qspi_write(xqspi, ZYNQ_QSPI_ENABLE_OFFSET, 0);
-
-	spi_controller_put(ctlr);
 }
 
 static const struct of_device_id zynq_qspi_of_match[] = {
-- 
2.53.0

