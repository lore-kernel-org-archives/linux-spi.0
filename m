Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B33DFC68;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=lQD1JLJ4aoN/Te/p8YxJMkf4pJRjlEoYXzJBy+mw5Lw+6ZcolX5i9kDfrOi6bNpyXg3vAxzO9d2OGCJ8xflWxNpNrWrQrJRgfgyLcyJpfAmFSOnESeTCQRK3PGa1tgRgbFAzSA5xg08ts9kNjTqMb6cDSb+phSHeFacBqydhML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=UXBCHywms5b7E6t4ihwwEXOZ9EJx2Yu/9U7Ij9QSn4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjoZfAQx7jwGTUN3zImi6ljW31DQQ1zTDTqJOy9CYS0ERjTylNGL2pyDUMQdp3hNgreUH+EsQsJuYbzV5pRi9wFHz2cNb2OkA0/ObmPaB6KJI/MSVpr7f6sOY3qaG74i3XLqSPRH3LckYW4KM0XDfeiAfPzxgGqlLFGQR/Yj7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaUgypJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaUgypJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2124CC4AF15;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=UXBCHywms5b7E6t4ihwwEXOZ9EJx2Yu/9U7Ij9QSn4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kaUgypJHI3hyPkE7K40HvVB2GnJPE4QRb56Y1180j1vDuS+RypJ9ORgUXpY2RCQNf
	 oo1RM7HhHRPdV/U1+GxnfcQ10fcEF3TqrOtVpPSEj0aRkk6sIQV42ksUje/I5Y/itU
	 NRZCC8YhLGGGUpMl8KaJ1W//aw1RkXLrw0+yuc1vrOOLZN5iNMF7sfSVROfgnhWB03
	 qgY5eemWVUeAqNfL9GJeHxtQ3xdUONsAaIv0Eb9o1FFjt3um0Y34UYoC4rpDOEkHmF
	 n/K5LxzAmlWAfOn7cTvFmjyxKGChthHtc0bIpPYiqYUQ8HA7tGZjpJDLEqzJjTCLH6
	 MyJzUKDJUUfGA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atQ-3Iwt;
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
Subject: [PATCH 19/20] spi: uniphier: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:08 +0200
Message-ID: <20260505072909.618363-20-johan@kernel.org>
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
 drivers/spi/spi-uniphier.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index eac6c3e8908b..5f0abc59b716 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -649,7 +649,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*priv));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*priv));
 	if (!host)
 		return -ENOMEM;
 
@@ -660,30 +660,26 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	priv->is_save_param = false;
 
 	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(priv->base)) {
-		ret = PTR_ERR(priv->base);
-		goto out_host_put;
-	}
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
 	priv->base_dma_addr = res->start;
 
 	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-		ret = PTR_ERR(priv->clk);
-		goto out_host_put;
+		return PTR_ERR(priv->clk);
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto out_host_put;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
 			       0, "uniphier-spi", priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto out_host_put;
+		return ret;
 	}
 
 	init_completion(&priv->xfer_done);
@@ -710,10 +706,9 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	host->dma_tx = dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR_OR_NULL(host->dma_tx)) {
-		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
-			goto out_host_put;
-		}
+		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
 		host->dma_tx = NULL;
 		dma_tx_burst = INT_MAX;
 	} else {
@@ -762,8 +757,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		host->dma_tx = NULL;
 	}
 
-out_host_put:
-	spi_controller_put(host);
 	return ret;
 }
 
@@ -771,16 +764,12 @@ static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
-
-	spi_controller_put(host);
 }
 
 static const struct of_device_id uniphier_spi_match[] = {
-- 
2.53.0

