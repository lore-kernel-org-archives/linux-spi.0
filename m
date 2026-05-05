Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E943DFC78;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=FBgcRP2HeTAwS7tYw+tlVErioBux36G0uVunEwscHLjdxSwiuhHuot/4lp+vfOVdo2erqDTUSJoKa+vC3G7ckuJlKa19PR3ixTIH1JmU5zmCXIgyjais91nTZ9Nlqvz+jwscliumCQwF1CjBqO6FMDj+xt3Y+GgpnGyU3KS9pRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=0bbDG1c0Aq1LvZc1s4pTDzx4Vzjg7RxP8T0U41gLx7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F597wP4kwIdKyOH/RTvv7X1DUuzTZinUbnxQu4RsTzSiggPqniCzaLI6B9wtgjPdnvgUKxrV5VUhaz6ES6eKN8MXvtMmL+oUpbi2WZNKcc+bzSrOnBJbOlpYqGzDTWQbovpHNBdw2BDcCSk2f+F/2bYUnKuyyC335gZGjeMwEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCqAzMem; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCqAzMem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F91C4AF17;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=0bbDG1c0Aq1LvZc1s4pTDzx4Vzjg7RxP8T0U41gLx7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCqAzMemLf4kT9/RtAg9Rpj2zV+z5sKLVft5FwwPF2geIqStHiqnG/5musGIepnoX
	 iXBRvc1EGXxRKmDDu/W1wuscnoGSD3thyz6U9uJq7ip71I46iLNY2Yi7DoVBbBvDUy
	 Xwm2U9I045XiS9FK6QJvo/y4ddho190pTa3ZGZCeOQZfPy2vvQwGTwkSNvfKbgpfl3
	 SU7JdqUhyFOu/A19DqcDnkBBYBi4GWE0C0zI9BMa4NjZG9sF/SwsFHuAvXPaMW4lEx
	 I856rSRKcsT5xQCNP+cJxBZ2Po5N3uU2fFtkkmi294xr3RbtNQ2ew5lLVmZfEz26CF
	 fuNIffpAU4+NA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atC-32a6;
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
Subject: [PATCH 12/20] spi: sun4i: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:01 +0200
Message-ID: <20260505072909.618363-13-johan@kernel.org>
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
 drivers/spi/spi-sun4i.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index b7fbb5270edb..d5c16392cd4d 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -434,32 +434,26 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	struct sun4i_spi *sspi;
 	int ret = 0, irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct sun4i_spi));
-	if (!host) {
-		dev_err(&pdev->dev, "Unable to allocate SPI Host\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct sun4i_spi));
+	if (!host)
 		return -ENOMEM;
-	}
 
 	platform_set_drvdata(pdev, host);
 	sspi = spi_controller_get_devdata(host);
 
 	sspi->base_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(sspi->base_addr)) {
-		ret = PTR_ERR(sspi->base_addr);
-		goto err_free_host;
-	}
+	if (IS_ERR(sspi->base_addr))
+		return PTR_ERR(sspi->base_addr);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = -ENXIO;
-		goto err_free_host;
-	}
+	if (irq < 0)
+		return -ENXIO;
 
 	ret = devm_request_irq(&pdev->dev, irq, sun4i_spi_handler,
 			       0, "sun4i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_free_host;
+		return ret;
 	}
 
 	sspi->host = host;
@@ -477,15 +471,13 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	sspi->hclk = devm_clk_get(&pdev->dev, "ahb");
 	if (IS_ERR(sspi->hclk)) {
 		dev_err(&pdev->dev, "Unable to acquire AHB clock\n");
-		ret = PTR_ERR(sspi->hclk);
-		goto err_free_host;
+		return PTR_ERR(sspi->hclk);
 	}
 
 	sspi->mclk = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(sspi->mclk)) {
 		dev_err(&pdev->dev, "Unable to acquire module clock\n");
-		ret = PTR_ERR(sspi->mclk);
-		goto err_free_host;
+		return PTR_ERR(sspi->mclk);
 	}
 
 	init_completion(&sspi->done);
@@ -497,7 +489,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 	ret = sun4i_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
-		goto err_free_host;
+		return ret;
 	}
 
 	pm_runtime_set_active(&pdev->dev);
@@ -515,8 +507,7 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun4i_spi_runtime_suspend(&pdev->dev);
-err_free_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -524,13 +515,9 @@ static void sun4i_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_force_suspend(&pdev->dev);
-
-	spi_controller_put(host);
 }
 
 static const struct of_device_id sun4i_spi_match[] = {
-- 
2.53.0

