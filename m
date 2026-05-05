Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F73DF000;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=kNCq7VCMZ517t4p8D560KbVGXmK2la9YZabQF2dYJg6KlxiJ5E4Q+8Kx5f3zYPz+pvomIZlKRUjWf0yJXDRbgFCidRjiQt6/9nisITIZC64pYnYrl5cnV4A3KaEb37kQQ2rS4Gyf1Ude4aU9HdOPuHoCNvAZfbJ1okYqGD8Xvmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=OP+6E2NzBeEAp/Lal2Cswhu32tlbi5G5YANee/6XVsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtWxXEoN0Z+qurLg4CocjtEC6xZr5IXBfJ6EHZgQVfTUMNoZVxsJT320LvZTA1uAsJQ2zDvAgxj148XZxYfqAs4jI4/5TY6c+/XoPcjyLTcDtaOvkDCV7SPjQT/UI6E0kRTy8f1uRjYqITv/Ch03wT/GexVSIRNXnbdqczqMg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLMUqdg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLMUqdg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF2AC32786;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=OP+6E2NzBeEAp/Lal2Cswhu32tlbi5G5YANee/6XVsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uLMUqdg45oP0bGKDUXXbhYYXmYnup0cVqRaHB0+lORZPEdnYLlKVzILyViodQo+w2
	 Hbkf1C6zCbZEXWST6c0xruFfHtoxcxGsLAqOtAVg9OuC9fWgbxZBMXTFPpVQHKT2nB
	 pg2XRXsfZhyLex5lTLz80G9hQXjJrhifLTvPOGlKh0p0+Ay/OosTGirc5hhsp/dJVv
	 edJTt81bTYaEQ13oTFcTlefc7xQTbn+JI+Bhk2vfA84FBZitAH+EYa0Q2OivcnxqCz
	 tR+bIhPDNzJa3k52xL+zT1Q4WvVixOYO7yw70xq5KhJhHyfahK1wekE6YLADV/1aFO
	 cd0R0SK7kKh5A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atK-3Bcu;
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
Subject: [PATCH 16/20] spi: tegra20-sflash: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:05 +0200
Message-ID: <20260505072909.618363-17-johan@kernel.org>
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
 drivers/spi/spi-tegra20-sflash.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
index 9256729f2d49..2caa33f0a52c 100644
--- a/drivers/spi/spi-tegra20-sflash.c
+++ b/drivers/spi/spi-tegra20-sflash.c
@@ -427,11 +427,9 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*tsd));
-	if (!host) {
-		dev_err(&pdev->dev, "host allocation failed\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*tsd));
+	if (!host)
 		return -ENOMEM;
-	}
 
 	/* the spi->mode bits understood by this driver: */
 	host->mode_bits = SPI_CPOL | SPI_CPHA;
@@ -450,14 +448,13 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		host->max_speed_hz = 25000000; /* 25MHz */
 
 	tsd->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tsd->base)) {
-		ret = PTR_ERR(tsd->base);
-		goto exit_free_host;
-	}
+	if (IS_ERR(tsd->base))
+		return PTR_ERR(tsd->base);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto exit_free_host;
+		return ret;
+
 	tsd->irq = ret;
 
 	ret = request_irq(tsd->irq, tegra_sflash_isr, 0,
@@ -465,7 +462,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
 					tsd->irq);
-		goto exit_free_host;
+		return ret;
 	}
 
 	tsd->clk = devm_clk_get(&pdev->dev, NULL);
@@ -518,8 +515,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
 		tegra_sflash_runtime_suspend(&pdev->dev);
 exit_free_irq:
 	free_irq(tsd->irq, tsd);
-exit_free_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -528,8 +524,6 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_sflash_data	*tsd = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	free_irq(tsd->irq, tsd);
@@ -537,8 +531,6 @@ static void tegra_sflash_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_sflash_runtime_suspend(&pdev->dev);
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

