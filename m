Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55A3DDDC6;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=MWcS7lzsYBnfoCNnQR4+tDQu8eJs8L8Uf+k9aK3oIy+9XNSgPGeN9CkqBESqhc39Or1cwcWlo9bHhS5vWpUsMiP3YhXwkC6MygumBI8byN6Y2SF5QE/z24ZifE2AMwcYeWTf4445FiSPq2yDZlz4obRdYGZ64vyV/jd7nK/NM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=1fnWOhhQkXL1oDmwJDZrVyJcPZ+uLS0tOnD+naDGHls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8lLJQct1zI6ibsl/UYRE6nMvVEJ3Zl9meuR7Te9bU/19NgiVf7tY8zTJCRda7sZAjAmd0Sx/1jVYe6KDwxtlqs/R27x3nn9ZSHP/fDekghXKoVd8fSWwEjOO+GavETQXHHRomuIjCyrpQZbMcuYEoNDHIySgiVYU7KAmZdVn9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZHlnGuT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZHlnGuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ABAC2BCFD;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=1fnWOhhQkXL1oDmwJDZrVyJcPZ+uLS0tOnD+naDGHls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZHlnGuTvnjKApKJpuh0hGm1sCGFlVp3Xhl7Qwu4bYHeXFDY2Pm81/4Kp3sUv9gp5
	 UUIxMdBAk8rjLpE68fbhOkIm8Th7sdwMMrFNtizk2q5GScfj1wGJMmBA6NYmtmlzNn
	 ba5eciADis6Hefatx0K08PlbeunL3iCSUADxc8noduNqRqaMAi8KAQuNzt4oEUW8Ji
	 tkVfmHCY2LcPYDiqyjESXX7/52SIP4Z+kjIXGQLUeHYsKlXOUUmLK9xHi3oiV2liwp
	 JmrFJL2IKF8DfQ0vc9TUgHvQMF4YfTaOI3jrNsvH/PEpAXYYGL+F3VEXIDONVG90zx
	 iFv0CBfHAXdlg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atE-34sX;
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
Subject: [PATCH 13/20] spi: sun6i: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:02 +0200
Message-ID: <20260505072909.618363-14-johan@kernel.org>
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
 drivers/spi/spi-sun6i.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 5ac73d324d06..4631e9c7ca1d 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -633,7 +633,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int ret = 0, irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(struct sun6i_spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(struct sun6i_spi));
 	if (!host) {
 		dev_err(&pdev->dev, "Unable to allocate SPI Host\n");
 		return -ENOMEM;
@@ -643,22 +643,18 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	sspi = spi_controller_get_devdata(host);
 
 	sspi->base_addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
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
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_spi_handler,
 			       0, "sun6i-spi", sspi);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot request IRQ\n");
-		goto err_free_host;
+		return ret;
 	}
 
 	sspi->host = host;
@@ -679,15 +675,13 @@ static int sun6i_spi_probe(struct platform_device *pdev)
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
@@ -696,17 +690,14 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	sspi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(sspi->rstc)) {
 		dev_err(&pdev->dev, "Couldn't get reset controller\n");
-		ret = PTR_ERR(sspi->rstc);
-		goto err_free_host;
+		return PTR_ERR(sspi->rstc);
 	}
 
 	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR(host->dma_tx)) {
 		/* Check tx to see if we need defer probing driver */
-		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto err_free_host;
-		}
+		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_warn(&pdev->dev, "Failed to request TX DMA channel\n");
 		host->dma_tx = NULL;
 	}
@@ -759,8 +750,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 err_free_dma_tx:
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
-err_free_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -768,8 +758,6 @@ static void sun6i_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_force_suspend(&pdev->dev);
@@ -778,8 +766,6 @@ static void sun6i_spi_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
-
-	spi_controller_put(host);
 }
 
 static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
-- 
2.53.0

