Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE103CC9F3;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=Znz4CfyBNOftzLf0xqZ/mbCjWS/u+iR35ZMGtM1JiVc9TzZrq8blTg3Fcsa3MVYH2SJC3pmq1P6fbsWTtPgNlhT7ozsW7dMP819Ps5FD2GtJX1O29GpQRsNSSgNv+TpruvZhAZyJPAE4zc4k8Ibv7Ncgvu+yjRBY6emQW9FV+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=DcBIcztv06KehyJiviadjiwViGdV/clO/R6sY+JkjLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJZ4lmaQtSBrvfqylskryXvZxfLOKHzc0+LsOZ64CMHXHBmeA/eiBoO73eZS12Fnu9kWgipR7gPKAGhz16fwHmkV5xGXPKtQtfyPMSEGIR9c9GCL2XFKnJQMCEJch/NAWJcWyDTDhg3D976bKvBV1Ci8cLRyTT3cGSCWOfAvv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ/itkg0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ/itkg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138C4C2BD00;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=DcBIcztv06KehyJiviadjiwViGdV/clO/R6sY+JkjLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQ/itkg0a+lQsfmvKBmzlxv+LRNAy6+4YPW2mLAGQTD5aqiG+mnVCvnnaH5QeNXmn
	 Lwpk1EWtTCp3KxXR2EmI8wYmfZm5KoOuf8ebdzFN1tcloLSjCd1lq69ofCa/ggZTt5
	 /sFUjnkyG686G7FEm1FmGzs2Onc+CUgCi+g6Mwax44k2GJzIoA9HnrgcnHpQstATdg
	 /SfY9BhhgzKc++m2IOERdkYxVmqwea9tZd1vnTmasGPsqDXZ5PJJxs+kE0fAZWLJGl
	 Ib7AsIRy20Tdbz25ARUuiRaIAKydHuQKrwpD6I/wFnsluyNR8vDUMqjlRdnUhln9TF
	 Fj7sX+Dk0P4TQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002at8-2y2m;
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
Subject: [PATCH 10/20] spi: sprd: switch to managed controller allocation
Date: Tue,  5 May 2026 09:28:59 +0200
Message-ID: <20260505072909.618363-11-johan@kernel.org>
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
 drivers/spi/spi-sprd.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index fd3fd0ce122c..d27b51698dbd 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -923,16 +923,14 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	int ret;
 
 	pdev->id = of_alias_get_id(pdev->dev.of_node, "spi");
-	sctlr = spi_alloc_host(&pdev->dev, sizeof(*ss));
+	sctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*ss));
 	if (!sctlr)
 		return -ENOMEM;
 
 	ss = spi_controller_get_devdata(sctlr);
 	ss->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(ss->base)) {
-		ret = PTR_ERR(ss->base);
-		goto free_controller;
-	}
+	if (IS_ERR(ss->base))
+		return PTR_ERR(ss->base);
 
 	ss->phy_base = res->start;
 	ss->dev = &pdev->dev;
@@ -949,15 +947,15 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sctlr);
 	ret = sprd_spi_clk_init(pdev, ss);
 	if (ret)
-		goto free_controller;
+		return ret;
 
 	ret = sprd_spi_irq_init(pdev, ss);
 	if (ret)
-		goto free_controller;
+		return ret;
 
 	ret = sprd_spi_dma_init(pdev, ss);
 	if (ret)
-		goto free_controller;
+		return ret;
 
 	ret = clk_prepare_enable(ss->clk);
 	if (ret)
@@ -992,8 +990,6 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(ss->clk);
 release_dma:
 	sprd_spi_dma_release(ss);
-free_controller:
-	spi_controller_put(sctlr);
 
 	return ret;
 }
@@ -1008,8 +1004,6 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(ss->dev, "failed to resume SPI controller\n");
 
-	spi_controller_get(sctlr);
-
 	spi_unregister_controller(sctlr);
 
 	if (ret >= 0) {
@@ -1019,8 +1013,6 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(sctlr);
 }
 
 static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
-- 
2.53.0

