Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3520F391E7F;
	Mon, 23 Mar 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263001; cv=none; b=cqybGr+lok5Isn38AKhCuXPOm1RFStCQbnXFCmtBqzcSvNAEx+ZkI0AuvGZhPgex7fUN0ec4x8hEeSjaz/lDdw1knVgdziPr+dyN/1IpmwsdibOwsTAul+Y+6PxiEPOVm24AFcCBc11KgxUAiQ93/m5kVoPxkrhHGq++qJe0N5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263001; c=relaxed/simple;
	bh=VARrRBCImFUXBLN3AofHXXDlpxj1GOHl1SFpB9FPolM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbqnu4omNX8ZDhF4FPNyqS4RE7bSnDvg8ELcD+Dr/FZyYKIa+DOJR3zowJx1Kt+RIS9u3yb/980DLXDm3YiRBNlGB+X8xxMuEpTsQKwzmn/HDRQQWuGk7HPXOWG8bf1OtXuf4Kcg7gBCRqQWCCyjE1jlLKXyGbg8peYIi+Tqk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRR0b2nH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRR0b2nH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD798C2BCB5;
	Mon, 23 Mar 2026 10:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263000;
	bh=VARrRBCImFUXBLN3AofHXXDlpxj1GOHl1SFpB9FPolM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRR0b2nH2J7+sVWt5mpJL3F0mhyQlSKTPMy1+LeYa4wCvYsHh2vXMtHfg+mcWhTqA
	 hr7kOjQxmDKCUFI5Ap8SqdQifsuj+9IniZMa9nkB9FZYOK7gS2AxJ5AoSr+aF+L0NQ
	 l0PC97NduE5DD9eYuq7SC5Uvpjd7iPcGhcezkQbBqRH4giUpiU4RVq4xSxDqff+dks
	 iQZii9WuHFHwG6KtB9LBhlaBUfYnOIXO5PhfXa71I1uNKlBqSkDLVG93iizr4+fzK/
	 undrIpEYhm/XqbJXcF7J7cLPvLWCJmU7IP2+NM8W0UoZJj3GE8hbd6Uh+E1Bet/VoL
	 BAv1AvQuZOzYw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w4cr8-00000003Xiu-1gIr;
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
Subject: [PATCH 5/5] spi: rockchip: switch to managed controller allocation
Date: Mon, 23 Mar 2026 11:49:48 +0100
Message-ID: <20260323104948.844583-6-johan@kernel.org>
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

