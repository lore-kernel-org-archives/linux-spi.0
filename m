Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AA38C2CA;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774340630; cv=none; b=jmr3QEQ9rH8eOCw3NmCBzAOC1TsZ3s77qYNiMErZwvPhFWCdxOAQ70R63wSFIRrgumv3TsvOYFH9bCGEUrNv0ndXxAWcV/mj4lwnO21NzBl8RJkPckLJfOFu6rveNsMytmAVrVc2mpJ9Zz9Pc73QlU8YhDLxN8AeMgCeLcqX7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774340630; c=relaxed/simple;
	bh=VARrRBCImFUXBLN3AofHXXDlpxj1GOHl1SFpB9FPolM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWb6ZT16TVfmZL9i0/qovehcjgmzye0LW5iwfkVKuMaRLN4TRdON3zcua1rzbrFTaprD0JOjwivOSB2HT+DVWQYU67DNMIyLagGHIeidqJCmomu97Tem7rvhHPvEZynbDFfCyZdnQkRIv5LzMVg0TIgk7nHrSPl/QqaKGQtLNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltsWJ+1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltsWJ+1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839B3C2BC9E;
	Tue, 24 Mar 2026 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774340630;
	bh=VARrRBCImFUXBLN3AofHXXDlpxj1GOHl1SFpB9FPolM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltsWJ+1oll9d3qAwfmY3Ih5OZTJpV+A5EY++Pm1mjoI2od6aAeIjhlfV67e3+o0vX
	 ylNeb5q9eXIZpjMpxbTed7/FmDqp5R29ZClkzU2b5BncvmK5cZ2giYPUEyW/L8bzrK
	 1Gh0+KGChFGZnxno0yWLPKb4Mn7JzjZXCwkFQ5jhRvzcyF4aS+y9Z3OmFNsJ2VQOuK
	 Y6wS/Rgdd1CMGSIVdx+X+kHTjr5In6BgX/TAmgQgpaCK6P8XY3N24X1AGqjRf46E9J
	 YKaTMAKi3Xr5OcUeVaFCdfWCtj6yn0rzhpsPxEgWNS2IakqweNNUqMEQkJObKE8y26
	 glQWdDcV/Wx8A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4x3E-00000003mQL-1Rba;
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
Subject: [PATCH v2 5/5] spi: rockchip: switch to managed controller allocation
Date: Tue, 24 Mar 2026 09:23:26 +0100
Message-ID: <20260324082326.901043-6-johan@kernel.org>
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
 drivers/spi/spi-rockchip.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index eb1992b4178e..14cd1b9d9793 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -767,9 +767,9 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	target_mode = of_property_read_bool(np, "spi-slave");
 
 	if (target_mode)
-		ctlr = spi_alloc_target(&pdev->dev, sizeof(struct rockchip_spi));
+		ctlr = devm_spi_alloc_target(&pdev->dev, sizeof(*rs));
 	else
-		ctlr = spi_alloc_host(&pdev->dev, sizeof(struct rockchip_spi));
+		ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*rs));
 
 	if (!ctlr)
 		return -ENOMEM;
@@ -780,35 +780,31 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	/* Get basic io resource and map it */
 	rs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(rs->regs)) {
-		ret = PTR_ERR(rs->regs);
-		goto err_put_ctlr;
-	}
+	if (IS_ERR(rs->regs))
+		return PTR_ERR(rs->regs);
 
 	rs->apb_pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(rs->apb_pclk),
-				    "Failed to get apb_pclk\n");
-		goto err_put_ctlr;
+		return dev_err_probe(&pdev->dev, PTR_ERR(rs->apb_pclk),
+				     "Failed to get apb_pclk\n");
 	}
 
 	rs->spiclk = devm_clk_get_enabled(&pdev->dev, "spiclk");
 	if (IS_ERR(rs->spiclk)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(rs->spiclk),
-				    "Failed to get spi_pclk\n");
-		goto err_put_ctlr;
+		return dev_err_probe(&pdev->dev, PTR_ERR(rs->spiclk),
+				     "Failed to get spi_pclk\n");
 	}
 
 	spi_enable_chip(rs, false);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_put_ctlr;
+		return ret;
 
 	ret = devm_request_irq(&pdev->dev, ret, rockchip_spi_isr, 0,
 			       dev_name(&pdev->dev), ctlr);
 	if (ret)
-		goto err_put_ctlr;
+		return ret;
 
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
@@ -830,10 +826,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	rs->fifo_len = get_fifo_len(rs);
-	if (!rs->fifo_len) {
-		ret = dev_err_probe(&pdev->dev, -EINVAL, "Failed to get fifo length\n");
-		goto err_put_ctlr;
-	}
+	if (!rs->fifo_len)
+		return dev_err_probe(&pdev->dev, -EINVAL, "Failed to get fifo length\n");
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -924,15 +918,13 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		dma_release_channel(ctlr->dma_tx);
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
-err_put_ctlr:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
 
 static void rockchip_spi_remove(struct platform_device *pdev)
 {
-	struct spi_controller *ctlr = spi_controller_get(platform_get_drvdata(pdev));
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -946,8 +938,6 @@ static void rockchip_spi_remove(struct platform_device *pdev)
 		dma_release_channel(ctlr->dma_tx);
 	if (ctlr->dma_rx)
 		dma_release_channel(ctlr->dma_rx);
-
-	spi_controller_put(ctlr);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.52.0

