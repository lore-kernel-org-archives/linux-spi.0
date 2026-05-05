Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D96C3DE441;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=b4qh6J2NJlW6KELFC1yIgL8kfwiM08KaSUWjT2liGr21Jd30GkmKT8WKZjLS5jBEdqGxUzs3b9ZorTjXVIEcRlioItMpKLzEl973qINnEu/1oeX1a72jb8lsX1mbqXiXumAVvnjTRe8lai74MRJMyWQ3ZFuXr9rQqTPTiNij7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=p4LpLN5fZdjv0gvKwYitgL50AzdFKWheQIp442BhXpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5zWMBxS4fyCaBzbQL/nc8Tiw6XqPlWqFlYLjl5POEid6fLMSPoDyfN4R6YoOL4vTNx1WkYRgZamGD18Lsrs2uAbvrK6UWCJ4iihQGbpTcVJqx9Ktxo2csdo9Q9FSTHIS8eQleDA2oEwzOZk9N1PKvDo8X6DhrnBvJAqmAEWCRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3cJlxEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3cJlxEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA6EC2BD05;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=p4LpLN5fZdjv0gvKwYitgL50AzdFKWheQIp442BhXpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3cJlxEgiom+IKwODkhKVsxPb61JgEGqIxSQhKIXGbGdiP/mwUCw5yDKtB0bk4+Lp
	 8tY2+/DA3ytbxJeLgRX6ZHen/rcIEgGnU4RGJKSdNbOwghFiMlXX87Nx0BWT8rr+mQ
	 LUU6FL7AZh5o938s3SGe9yM1A3hCw145jYDMvKYSW7iDcj1O5JW9TZZSFx8uavhrU3
	 ngVYKM1VWroLtRi2M3gY67nzcxNnq6a4oPjLrmCBu7CdE3kGshAJ12gMhvdwTo2/Fv
	 V/z9tsF+0qJjB2YfI9+CdR+E1X2mtAv907dsGTdTHTX/jswoh9mlZYPwIYC9oSPrCx
	 tGy78BDExEY4w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atM-3DzD;
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
Subject: [PATCH 17/20] spi: ti-qspi: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:06 +0200
Message-ID: <20260505072909.618363-18-johan@kernel.org>
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
 drivers/spi/spi-ti-qspi.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 1fbd710d616f..2a8548810f84 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -765,7 +765,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	int ret = 0, num_cs, irq;
 	dma_cap_mask_t mask;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*qspi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*qspi));
 	if (!host)
 		return -ENOMEM;
 
@@ -793,8 +793,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (r == NULL) {
 			dev_err(&pdev->dev, "missing platform data\n");
-			ret = -ENODEV;
-			goto free_host;
+			return -ENODEV;
 		}
 	}
 
@@ -812,28 +811,22 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		qspi->mmap_size = resource_size(res_mmap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto free_host;
-	}
+	if (irq < 0)
+		return irq;
 
 	mutex_init(&qspi->list_lock);
 
 	qspi->base = devm_ioremap_resource(&pdev->dev, r);
-	if (IS_ERR(qspi->base)) {
-		ret = PTR_ERR(qspi->base);
-		goto free_host;
-	}
+	if (IS_ERR(qspi->base))
+		return PTR_ERR(qspi->base);
 
 
 	if (of_property_present(np, "syscon-chipselects")) {
 		qspi->ctrl_base =
 			syscon_regmap_lookup_by_phandle_args(np, "syscon-chipselects",
 							     1, &qspi->ctrl_reg);
-		if (IS_ERR(qspi->ctrl_base)) {
-			ret = PTR_ERR(qspi->ctrl_base);
-			goto free_host;
-		}
+		if (IS_ERR(qspi->ctrl_base))
+			return PTR_ERR(qspi->ctrl_base);
 	}
 
 	qspi->fclk = devm_clk_get(&pdev->dev, "fck");
@@ -895,8 +888,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	ti_qspi_dma_cleanup(qspi);
 
 	pm_runtime_disable(&pdev->dev);
-free_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -904,16 +896,12 @@ static void ti_qspi_remove(struct platform_device *pdev)
 {
 	struct ti_qspi *qspi = platform_get_drvdata(pdev);
 
-	spi_controller_get(qspi->host);
-
 	spi_unregister_controller(qspi->host);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	ti_qspi_dma_cleanup(qspi);
-
-	spi_controller_put(qspi->host);
 }
 
 static const struct dev_pm_ops ti_qspi_pm_ops = {
-- 
2.53.0

