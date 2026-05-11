Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C627FB1C;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511874; cv=none; b=KazimIFnFILe5y9SWJAFvMDZ9Vy5DpolYwkxKNammMXFs2nWQVHYSYhoGdpUUgLTjWxkCFYua6kGT43Zc+phtGM/nqp0YxeA4/xESSsGZnWzUk46bNuq88yd5GgkI9K5lAaKeE0HbzK90Nzw3Akiyak0W+toveyxZiSaUNBMmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511874; c=relaxed/simple;
	bh=kUyWlndITH1nQAg6uBKgX1+v96ilBq/nvncUqlFkAVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLWeaBKG4mu/fHcnTIdQJIOfAizzKbToXZ6Wlr4dm3LiSmzueny/PO9M4eWXeoMEkexjdq9B12t37ups0fO3FAHeP1V4lpkUDMmeMMiqIXza7s7Owpri/ZCX68vS6fjd/25ZxWmHyo6pEO4t5MtvA0pvGKu9oyv7ZI78v0427jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI0ldOBv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI0ldOBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9464C2BCFA;
	Mon, 11 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511873;
	bh=kUyWlndITH1nQAg6uBKgX1+v96ilBq/nvncUqlFkAVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sI0ldOBvkmqLtImXJQbODQoe5XjcwGQNI/+FR44nLsYKbWjpSSDIl9q+XCn9zbJxd
	 pdFs1cHxxCHNDG8e9VcgcjA03FJYCwym6ITDfB05oaMqjmJ70LZ3JrzChJXcClMfFs
	 xQnvFtuu8gVfVIJycbbUKH7sWL7ytkWOV8lHSB4lD5OwQWvJueI1DAxpasUZMETde6
	 pwz+CJb2gbD9gYFr5BdeQgFvpiJ/w6tOwFNbZ/2I5riiet1IrMV77C7HXYMZ1Ikjls
	 EkZkJKgu4p8e/EuCfS6lYAPFpPElEIAEY/Erss/7A6Las8Lx9ymOfijpGWlCJye14q
	 IqQlPQmcAKo+w==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMSBL-00000003L86-1ySt;
	Mon, 11 May 2026 17:04:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Eddie James <eajames@linux.ibm.com>,
	Yang Shen <shenyang39@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 02/12] spi: armada-3700: switch to managed controller allocation
Date: Mon, 11 May 2026 17:03:58 +0200
Message-ID: <20260511150408.796155-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511150408.796155-1-johan@kernel.org>
References: <20260511150408.796155-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to device managed controller allocation for consistency and to
simplify error handling.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 44 +++++++++++------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 78248729d3e9..ca2faa265ca0 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -818,17 +818,13 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	u32 num_cs = 0;
 	int irq, ret = 0;
 
-	host = spi_alloc_host(dev, sizeof(*spi));
-	if (!host) {
-		dev_err(dev, "host allocation failed\n");
-		ret = -ENOMEM;
-		goto out;
-	}
+	host = devm_spi_alloc_host(dev, sizeof(*spi));
+	if (!host)
+		return -ENOMEM;
 
 	if (of_property_read_u32(dev->of_node, "num-cs", &num_cs)) {
 		dev_err(dev, "could not find num-cs\n");
-		ret = -ENXIO;
-		goto error;
+		return -ENXIO;
 	}
 
 	host->bus_num = pdev->id;
@@ -849,25 +845,20 @@ static int a3700_spi_probe(struct platform_device *pdev)
 	spi->host = host;
 
 	spi->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(spi->base)) {
-		ret = PTR_ERR(spi->base);
-		goto error;
-	}
+	if (IS_ERR(spi->base))
+		return PTR_ERR(spi->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = -ENXIO;
-		goto error;
-	}
+	if (irq < 0)
+		return -ENXIO;
+
 	spi->irq = irq;
 
 	init_completion(&spi->done);
 
 	spi->clk = devm_clk_get_prepared(dev, NULL);
-	if (IS_ERR(spi->clk)) {
-		dev_err(dev, "could not find clk: %ld\n", PTR_ERR(spi->clk));
-		goto error;
-	}
+	if (IS_ERR(spi->clk))
+		return dev_err_probe(dev, PTR_ERR(spi->clk), "could not find clk\n");
 
 	host->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
 					clk_get_rate(spi->clk));
@@ -878,23 +869,16 @@ static int a3700_spi_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, spi->irq, a3700_spi_interrupt, 0,
 			       dev_name(dev), host);
-	if (ret) {
-		dev_err(dev, "could not request IRQ: %d\n", ret);
-		goto error;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "could not request IRQ\n");
 
 	ret = devm_spi_register_controller(dev, host);
 	if (ret) {
 		dev_err(dev, "Failed to register host\n");
-		goto error;
+		return ret;
 	}
 
 	return 0;
-
-error:
-	spi_controller_put(host);
-out:
-	return ret;
 }
 
 static struct platform_driver a3700_spi_driver = {
-- 
2.53.0

