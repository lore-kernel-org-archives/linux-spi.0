Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7D39185D;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263001; cv=none; b=OG4oZLzxubGxmDXoatlQHP8r78ZTv8OR2pX0tz8/LhlFXLSe3B5kwa5IvucvSIQNbBFEHISN3U7k3G2LGaZ8Ku2wA0b6Rj0ey9OD1kEvW4yrrfOstpaox1IYA6eO9fm1GGj2Drd+DUgHdDYgBX3p3oIvCx8yf3yDkm2Lnq2rHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263001; c=relaxed/simple;
	bh=zfb0tGDWInGpIdZ033w7Mc3V9tJctj5+EAPSBqUzxMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpYmHlNcvtORLlVn4a5iZoItcbwbeC0nKqhZKiCoepUmM/hlHFpJIRtv6xcyaJETHXuac/Iv1Z2a0IV8EFz+pl198WU5Mnovf3uo92cOVPhfF7WQVRJUkQA3KiZ04i2OJ9+uofm2q32Rn6PNGbMIQNR3r60ixE+IbIPpX2Ct4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM+deHvV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM+deHvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42FAC2BC87;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263000;
	bh=zfb0tGDWInGpIdZ033w7Mc3V9tJctj5+EAPSBqUzxMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lM+deHvVMsb5p15Rcodqs3st9C4TCzSTyfZ1fc5+kSjccvB0qCUWOK9r6ttfQdKMf
	 gr2byY6MykA+H/ryJ0PldAZb4rATpd5/2Y8MnWqMemjRmMc+ju7xZbuVoBBgg4Dh+D
	 OYrcFuwN0V/KDp0qgpdPF8TeI0N/uhEDv9sR50uTmL/TyHimajytO08oGgD2pyndMt
	 K9tcUQqt+2S+ETRwaeMsk9ViMhPkcHD+6j33lTKxRSzft6qL9KPMwY78Ckk/VA7KNR
	 3zdyfZ2eeVIL2FvzGAiTqtQAcWUa+64DS3XqYMdiGy4EbgHaFMi05w7qgnrLdOr2l8
	 1324s89q37tsQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cr8-00000003Xio-1ZDt;
	Mon, 23 Mar 2026 11:49:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/5] spi: imx: switch to managed controller allocation
Date: Mon, 23 Mar 2026 11:49:45 +0100
Message-ID: <20260323104948.844583-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323104948.844583-1-johan@kernel.org>
References: <20260323104948.844583-1-johan@kernel.org>
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

