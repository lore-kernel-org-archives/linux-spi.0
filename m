Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4F3DF00C;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966182; cv=none; b=udtiNqp46hwWGj26SqJOM4S8m7sjgTN1OGhy+jpDySipV9/cUQj+Hpk9stnS9RIpEt2ljcGI+dvOM5ycYw+ZDA4679mg3Kzv50WEiqTuZ8ZbB5JtiCWfJuMtGiLp92pLrNFdZZH/KbAHoH4Bqm3rDzUY2Iqvb1gXNmOlt/w6N8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966182; c=relaxed/simple;
	bh=L60LRplpjDk2zRJEBey+SBkvYzdLM0uRKSpgaCU8PQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2LxfZoRtWOoOpwDnNh++rGdX4wMNlfOZFks7r6fK9hyFejtxh97Hdj02ozxR5WmV92ko9FCp22meDfQ2j76Q1A5HE4A0JHVma7yI3cuU5bFl05OIvbLNO7eUpCgf8shQUiyGQKaWe+0N+SRtajWkjxIIVBqLNTqff21ZxeqH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdJ5CikN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdJ5CikN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218DFC4AF14;
	Tue,  5 May 2026 07:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966182;
	bh=L60LRplpjDk2zRJEBey+SBkvYzdLM0uRKSpgaCU8PQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdJ5CikNgPwYi8RI309Nbe8S5gNfUlNk69L0Lr0wqHHc/NMisknXG8kSonQ2hV9N8
	 ceiQKZR1r+LKaAEc1NBe3TitoKLNUC2C77UPdnennQt4pYHl1ZUrRVD5Fpe3pmkSox
	 9o+9N4XkOglXaMpquP8BzydoaPGFcHfUJiD9uxVv6hfDT2wXkjVk+rtBxxgaQq7yfo
	 fsJBJywkh80M5XJ0bycCZBY+ra6eifGTC1W+1WCyLS0D7sXwDbBXcsK2Dn2DvMueYw
	 VbHhavAbzPWGZHl+i0L+omC1MxhSJfT+oWxgzhCz+TIyw894iXTtlu5Sh8dqD5AkBw
	 5RuTOCt0YsHog==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKADr-00000002atI-39Ou;
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
Subject: [PATCH 15/20] spi: tegra114: switch to managed controller allocation
Date: Tue,  5 May 2026 09:29:04 +0200
Message-ID: <20260505072909.618363-16-johan@kernel.org>
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
 drivers/spi/spi-tegra114.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b8b0ebe0fe93..aa44ffd09e61 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1302,7 +1302,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	int ret, spi_irq;
 	int bus_num;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*tspi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*tspi));
 	if (!host) {
 		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
@@ -1336,36 +1336,31 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tspi->soc_data = of_device_get_match_data(&pdev->dev);
 	if (!tspi->soc_data) {
 		dev_err(&pdev->dev, "unsupported tegra\n");
-		ret = -ENODEV;
-		goto exit_free_host;
+		return -ENODEV;
 	}
 
 	tspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(tspi->base)) {
-		ret = PTR_ERR(tspi->base);
-		goto exit_free_host;
-	}
+	if (IS_ERR(tspi->base))
+		return PTR_ERR(tspi->base);
+
 	tspi->phys = r->start;
 
 	spi_irq = platform_get_irq(pdev, 0);
-	if (spi_irq < 0) {
-		ret = spi_irq;
-		goto exit_free_host;
-	}
+	if (spi_irq < 0)
+		return spi_irq;
+
 	tspi->irq = spi_irq;
 
 	tspi->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
-		ret = PTR_ERR(tspi->clk);
-		goto exit_free_host;
+		return PTR_ERR(tspi->clk);
 	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
 		dev_err(&pdev->dev, "can not get reset\n");
-		ret = PTR_ERR(tspi->rst);
-		goto exit_free_host;
+		return PTR_ERR(tspi->rst);
 	}
 
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
@@ -1373,7 +1368,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	ret = tegra_spi_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_host;
+		return ret;
 	ret = tegra_spi_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1431,8 +1426,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_spi_deinit_dma_param(tspi, true);
-exit_free_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -1441,8 +1435,6 @@ static void tegra_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_spi_data	*tspi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	free_irq(tspi->irq, tspi);
@@ -1456,8 +1448,6 @@ static void tegra_spi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra_spi_runtime_suspend(&pdev->dev);
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

