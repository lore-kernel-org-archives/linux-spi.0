Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394236CE19;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340631; cv=none; b=liPmW4jY/4TVF404Q6LUCXPmN1/1zMyDCT8fATrnpINgiTVO7xMfMcydCyTwke8vIA6yo4RX3ft33QYwpN2K6txfPZ37oMhTu77sBIRrI/Evvqpn5iPS1rJLbS0s6tBaloBbQ5DkLbdEwHWnobohVRQYJUCMSf+lTS9gRVaG508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340631; c=relaxed/simple;
	bh=67pnIC+A2geoNacxUmxh6sPMQbZzlDjvy4uNoR1sE/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUgA9ZsNoGgQeFpsNDjy1ZqiTfbTNVksY0mR7+2pTtpX9d7YJXO8VcwzxTAl67JXI9uXWf3QV8jfPZ3oSVYVx8W2MgDWk5t2cu8DSFwL7VqupabLMA6Spt1Aoexo0dqg0Xq3Pox9bOawegDrPNGkxR4coBJROGe3ruNXTWLdUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXi565sw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXi565sw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EF8C2BCB3;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340630;
	bh=67pnIC+A2geoNacxUmxh6sPMQbZzlDjvy4uNoR1sE/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXi565swY7iEfbsqZ6sRInRNWbsj875aYEUolSA1NtoEW2wXEQlakVzwzX+IgYFAt
	 ciKxDXOXHjSJElD+cH71BwDRuzELYiwwzYE4QZXUv02hh0CDtr1RO3TpdCW4L+L/+6
	 dmtE9BaRaYBHJmMXfcfKND3h9hmn4MsSVmqlTSiUy+zkb/itB/bLRXzdKIIaAvg23V
	 NCbe1za6tPwIsYvFPdSDbgFbgCsnXHyasK+e9sE1MHqp07KDFtGKCWDB+PGkBHAIW0
	 gRwBIgygMyM15TMaNHhq/XNBOJZJD9gQY6RSYWVNaLWkrA8pmd8ikSS4ZV7hT5pHzD
	 g1fhZleLw518Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4x3E-00000003mQI-1PSh;
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
Subject: [PATCH v2 4/5] spi: tegra20-slink: switch to managed controller allocation
Date: Tue, 24 Mar 2026 09:23:25 +0100
Message-ID: <20260324082326.901043-5-johan@kernel.org>
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
 drivers/spi/spi-tegra20-slink.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 8c608abd6076..c15c076295cd 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1007,7 +1007,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 
 	cdata = of_device_get_match_data(&pdev->dev);
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*tspi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*tspi));
 	if (!host) {
 		dev_err(&pdev->dev, "host allocation failed\n");
 		return -ENOMEM;
@@ -1034,37 +1034,34 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		host->max_speed_hz = 25000000; /* 25MHz */
 
 	tspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(tspi->base)) {
-		ret = PTR_ERR(tspi->base);
-		goto exit_free_host;
-	}
+	if (IS_ERR(tspi->base))
+		return PTR_ERR(tspi->base);
+
 	tspi->phys = r->start;
 
 	/* disabled clock may cause interrupt storm upon request */
 	tspi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(tspi->clk)) {
 		ret = PTR_ERR(tspi->clk);
-		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
-		goto exit_free_host;
+		return dev_err_probe(&pdev->dev, ret, "Can not get clock\n");
 	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
-		dev_err(&pdev->dev, "can not get reset\n");
 		ret = PTR_ERR(tspi->rst);
-		goto exit_free_host;
+		return dev_err_probe(&pdev->dev, ret, "can not get reset\n");
 	}
 
 	ret = devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
 	if (ret)
-		goto exit_free_host;
+		return ret;
 
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
 	tspi->dma_buf_size = DEFAULT_SPI_DMA_BUF_LEN;
 
 	ret = tegra_slink_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_host;
+		return ret;
 	ret = tegra_slink_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1125,14 +1122,13 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tegra_slink_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_slink_deinit_dma_param(tspi, true);
-exit_free_host:
-	spi_controller_put(host);
+
 	return ret;
 }
 
 static void tegra_slink_remove(struct platform_device *pdev)
 {
-	struct spi_controller *host = spi_controller_get(platform_get_drvdata(pdev));
+	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct tegra_slink_data	*tspi = spi_controller_get_devdata(host);
 
 	spi_unregister_controller(host);
@@ -1146,8 +1142,6 @@ static void tegra_slink_remove(struct platform_device *pdev)
 
 	if (tspi->rx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, true);
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.52.0

