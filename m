Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942043BFE38;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=GkIkk8S7Sn+tAhH+z4uuvhI6pVDY5tcycVoAZzCnTiKqYtciL3quv2FDPc3+jTZJPCC+zqs1/bjtmsHCtUN8eF8EUfzJg4lL4Yi8jnxBd/aLzkBw9MqNawQp/Ay23cEaBgA/uEh13YF9pqtJoLp6XTzo1v2PkOw0h1svswdM+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=cm6m0GuyLRlBqhGRew3SkABtZJDptksWZw3TSTlu/E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzxqYZFA8L/k3egTZEV0O+oP4BbXOaLK2obLU1jWfHGDVsygS1Ow8VQJoiVFWs4uIyhSKvp87N7Agyqpe1dN8p6LTJZc6y5oTTnuSO9lrBROk7SZsvbVnFswKqwEz1vVW+A73hL55TTpOuhG/K1aGXdAEVZKwX8ZIdxtFPB60gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAorugjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAorugjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FC3C2BD01;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=cm6m0GuyLRlBqhGRew3SkABtZJDptksWZw3TSTlu/E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAorugjSFoo6DDA05FhE9IDDf3uRCBUXa3rtr5IpvXog/6Qps109uYSfkW713bcD6
	 ihtIKU51r8Y8iVfS0n4xU75zN5IEJGLps9XZFclohWIjjGAjcEE0EdRjQfy8F1+49x
	 +9jEWjy4hKP5uReMJQsNYrn0OeG5M3Yz2veQrwt66h8tYY3p5qPYEwWClWpQDOv4K8
	 x8/Xk5so08IZOvP4HPtstdOf3tCswLGPOSWwiLhX+EWreyX32cTD1Mfk0SVBxFzqvz
	 TIMLh+Vs7IdotfxuKJpzqLH1GOVhdmq5u5uTrtV3MJm5nrLHJ0h4pwFwLVHv8InJ8y
	 Juz1efcfbZLgg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2l-2UKO;
	Wed, 29 Apr 2026 11:14:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 15/19] spi: meson-spicc: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:29 +0200
Message-ID: <20260429091333.165363-16-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091333.165363-1-johan@kernel.org>
References: <20260429091333.165363-1-johan@kernel.org>
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
 drivers/spi/spi-meson-spicc.c | 43 +++++++++++------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b80f9f457b66..8ad2ad0c97e2 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -982,7 +982,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	struct meson_spicc_device *spicc;
 	int ret, irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spicc));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spicc));
 	if (!host) {
 		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
@@ -993,8 +993,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	spicc->data = of_device_get_match_data(&pdev->dev);
 	if (!spicc->data) {
 		dev_err(&pdev->dev, "failed to get match data\n");
-		ret = -EINVAL;
-		goto out_host;
+		return -EINVAL;
 	}
 
 	spicc->pdev = pdev;
@@ -1005,8 +1004,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	spicc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spicc->base)) {
 		dev_err(&pdev->dev, "io resource mapping failed\n");
-		ret = PTR_ERR(spicc->base);
-		goto out_host;
+		return PTR_ERR(spicc->base);
 	}
 
 	/* Set master mode and enable controller */
@@ -1017,39 +1015,33 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	writel_relaxed(0, spicc->base + SPICC_INTREG);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out_host;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, meson_spicc_irq,
 			       0, NULL, spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request failed\n");
-		goto out_host;
+		return ret;
 	}
 
 	spicc->core = devm_clk_get_enabled(&pdev->dev, "core");
 	if (IS_ERR(spicc->core)) {
 		dev_err(&pdev->dev, "core clock request failed\n");
-		ret = PTR_ERR(spicc->core);
-		goto out_host;
+		return PTR_ERR(spicc->core);
 	}
 
 	if (spicc->data->has_pclk) {
 		spicc->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 		if (IS_ERR(spicc->pclk)) {
 			dev_err(&pdev->dev, "pclk clock request failed\n");
-			ret = PTR_ERR(spicc->pclk);
-			goto out_host;
+			return PTR_ERR(spicc->pclk);
 		}
 	}
 
 	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
-	if (IS_ERR(spicc->pinctrl)) {
-		ret = PTR_ERR(spicc->pinctrl);
-		goto out_host;
-	}
+	if (IS_ERR(spicc->pinctrl))
+		return PTR_ERR(spicc->pinctrl);
 
 	device_reset_optional(&pdev->dev);
 
@@ -1070,43 +1062,34 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = meson_spicc_pow2_clk_init(spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "pow2 clock registration failed\n");
-		goto out_host;
+		return ret;
 	}
 
 	if (spicc->data->has_enhance_clk_div) {
 		ret = meson_spicc_enh_clk_init(spicc);
 		if (ret) {
 			dev_err(&pdev->dev, "clock registration failed\n");
-			goto out_host;
+			return ret;
 		}
 	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "spi registration failed\n");
-		goto out_host;
+		return ret;
 	}
 
 	return 0;
-
-out_host:
-	spi_controller_put(host);
-
-	return ret;
 }
 
 static void meson_spicc_remove(struct platform_device *pdev)
 {
 	struct meson_spicc_device *spicc = platform_get_drvdata(pdev);
 
-	spi_controller_get(spicc->host);
-
 	spi_unregister_controller(spicc->host);
 
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
-
-	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
-- 
2.53.0

