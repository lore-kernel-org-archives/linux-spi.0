Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381D367F3B;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340631; cv=none; b=oKAEfjMjioxnuLl75ad29A628fbMoQiVVLMDp3t5AsKS7baUXnKNqwwyiYuKcxyiw2hCLsz1FZWNdJMBp+gLP21SoJ5I/74F2mO0pvLh1tQDB7hsSQM1EOMSFRX4KgoybDQ3eVaybkhdcHGrTYA70g4rtuZhuvoQ1OLepWq55sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340631; c=relaxed/simple;
	bh=zfb0tGDWInGpIdZ033w7Mc3V9tJctj5+EAPSBqUzxMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWE2wJok2PtF0UdMGV8WCpDC8u6gmRcVQrS8QatCjb8KX9xZ8njKeQLWb8qYYL9Yraxzz5ypzyif9IFw+BcxCw0t8EZS8DuEUdjPhrTqHiKWfi99du/PcA/K70mKnjmWpJS0cCGIg4VxOHsN+C/RF9zd1Cxo1PQCHCIJZRtjyfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpkEQram; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpkEQram"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86AC2BCB5;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340630;
	bh=zfb0tGDWInGpIdZ033w7Mc3V9tJctj5+EAPSBqUzxMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZpkEQramLUaMF+12j3g7VkcnpicWLdMpirC8/7TGGlFwT0RkVrHBVqnZHBKIHvV0G
	 g2SMIKU3rPzkIAM4xGO7/+Z+KHlhyhvInqm7YhaXAHbvLblWqzOTsYkzzc0LcP/Ybg
	 yRAiSg3ext6EiAHjAJ50mWoW+TiyPOKJxfy5rUutGs+zbI6I80zOwCUbLCVcMA+6Y4
	 Af6VHA8xG8F9yIEEU3/AUfjZhTtQfvJeHwS3D3yAdzWkpmADkcyeAoEagYf6gSQ/7Q
	 GHOHCIU4jkI6luXBysmnzrLZjH+/Slfmmgntv6mXtJ1gGiSuccd0qOp8f3ZE0NZX9P
	 OrcbjQumsPsdQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4x3E-00000003mQG-1NBF;
	Tue, 24 Mar 2026 09:23:48 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 3/5] spi: imx: switch to managed controller allocation
Date: Tue, 24 Mar 2026 09:23:24 +0100
Message-ID: <20260324082326.901043-4-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324082326.901043-1-johan@kernel.org>
References: <20260324082326.901043-1-johan@kernel.org>
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
 drivers/spi/spi-imx.c | 45 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a8d90c86a8a1..4747899e0646 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2231,11 +2231,9 @@ static int spi_imx_probe(struct platform_device *pdev)
 	target_mode = devtype_data->has_targetmode &&
 		      of_property_read_bool(np, "spi-slave");
 	if (target_mode)
-		controller = spi_alloc_target(&pdev->dev,
-					      sizeof(struct spi_imx_data));
+		controller = devm_spi_alloc_target(&pdev->dev, sizeof(*spi_imx));
 	else
-		controller = spi_alloc_host(&pdev->dev,
-					    sizeof(struct spi_imx_data));
+		controller = devm_spi_alloc_host(&pdev->dev, sizeof(*spi_imx));
 	if (!controller)
 		return -ENOMEM;
 
@@ -2304,40 +2302,31 @@ static int spi_imx_probe(struct platform_device *pdev)
 	init_completion(&spi_imx->xfer_done);
 
 	spi_imx->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(spi_imx->base)) {
-		ret = PTR_ERR(spi_imx->base);
-		goto out_controller_put;
-	}
+	if (IS_ERR(spi_imx->base))
+		return PTR_ERR(spi_imx->base);
+
 	spi_imx->base_phys = res->start;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out_controller_put;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, spi_imx_isr, 0,
 			       dev_name(&pdev->dev), spi_imx);
-	if (ret) {
-		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_controller_put;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "can't get irq%d\n", irq);
 
 	spi_imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(spi_imx->clk_ipg)) {
-		ret = PTR_ERR(spi_imx->clk_ipg);
-		goto out_controller_put;
-	}
+	if (IS_ERR(spi_imx->clk_ipg))
+		return PTR_ERR(spi_imx->clk_ipg);
 
 	spi_imx->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(spi_imx->clk_per)) {
-		ret = PTR_ERR(spi_imx->clk_per);
-		goto out_controller_put;
-	}
+	if (IS_ERR(spi_imx->clk_per))
+		return PTR_ERR(spi_imx->clk_per);
 
 	ret = clk_prepare_enable(spi_imx->clk_per);
 	if (ret)
-		goto out_controller_put;
+		return ret;
 
 	ret = clk_prepare_enable(spi_imx->clk_ipg);
 	if (ret)
@@ -2389,8 +2378,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
 	clk_disable_unprepare(spi_imx->clk_per);
-out_controller_put:
-	spi_controller_put(controller);
 
 	return ret;
 }
@@ -2401,8 +2388,6 @@ static void spi_imx_remove(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(controller);
 	int ret;
 
-	spi_controller_get(controller);
-
 	spi_unregister_controller(controller);
 
 	ret = pm_runtime_get_sync(spi_imx->dev);
@@ -2416,8 +2401,6 @@ static void spi_imx_remove(struct platform_device *pdev)
 	pm_runtime_disable(spi_imx->dev);
 
 	spi_imx_sdma_exit(spi_imx);
-
-	spi_controller_put(controller);
 }
 
 static int spi_imx_runtime_resume(struct device *dev)
-- 
2.52.0

