Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BA39185B;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263001; cv=none; b=My2s+F857yTtMD9YkcJ1OiCmtKShDlcnGyC7rfI5sbmY96K1u8rFtgCPXQGebIaRY9mMTo/++j3RpAasVl23q1ZemCi9A2A9pNvMtJRmXg0XUDPJwED7v+wxRhrq1n73vljQq1cWD5x+cpoEj09nn1I3jMZ9eX3JuT28ZbVi0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263001; c=relaxed/simple;
	bh=67pnIC+A2geoNacxUmxh6sPMQbZzlDjvy4uNoR1sE/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptNmFr+YavMhVjBni5CKlWVjkYW0g3tBhpm6aRcWv7Tru90ijKVKz86xMCof1jb/iK/6VEqkL+fEguD+2fXDUHoVHkzHMxp10TaJxv8ePdfXqgT0OAM44EaK0TZsEDfZsLouYq9BxXH3ixNAN0HPoaGGbJD9EJI9khhLLOeFB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pq0Xn0+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pq0Xn0+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB174C2BC9E;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263000;
	bh=67pnIC+A2geoNacxUmxh6sPMQbZzlDjvy4uNoR1sE/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pq0Xn0+CWpxdyxBK7nMXDmgGee7NHH7NjjNKbyVcUu/tAbrOjg7OidxqAkT9qAm3F
	 HPkTYopOlLKgqRqLgVFAmqw+RAvyTT6JsLy7DEWM6ljdkRxQEZ9rLDWAS344MFqX5X
	 x6n7IMEVfzWUdP5Cu2aR97g0UVRbF0Rfm8UZ/bQSkD83eVVM6SJ0u8yhsVaStAMoE5
	 93kVB9KHcOMV6KULUsGp8E2c+veOxsWT3AFdotgW8IxOsY/qeYokcqx7sN+tYVpayF
	 wUpo2FkAp9AW7wqmDlliIoNRNO13Py5LbKScRsu4R0JAnkCEr5RSdeQiuFGwUqJbUG
	 gS5D2nFn7hOKQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cr8-00000003Xiq-1bYy;
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
Subject: [PATCH 3/5] spi: tegra20-slink: switch to managed controller allocation
Date: Mon, 23 Mar 2026 11:49:46 +0100
Message-ID: <20260323104948.844583-4-johan@kernel.org>
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

