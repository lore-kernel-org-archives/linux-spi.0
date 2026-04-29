Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AF3BE17D;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=MQCbj/MUPO3q+wB9uhQ8t3du8rlX9wjXsPnYUXALfSlutdaCtiISE/Yh5oHuyfgmDaOTaDIw9dc5U/j7sU+DtpAlayBRhFQV/uxA3pvuPjjFwVVAqMrTKbXQuA0RSocrkt2h8ssfN02aKR9ngjf6R9TnL2Y6NRVgWLnmL5OjB9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=SYyTc5Qkr6/3Iev1Fi01OmgKAGJQ5Y9+ZmSF5kcN/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txDeGuvXsYxIyISG1Hm5Ask2tQAOzh+S76eqttG8DTN15CKffJdjSM4b/YzeuNKqKU06Q42dhY2sgLT40VcMTEIbdXHZRLpPdV9PvGZUnKQHxFE8DRXA5+PnahjUndd+WQ85ZHUMyu53ypXMTpVSpeYJglDhjz9BG9inSaYyeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKeeQUT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKeeQUT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2157C2BCF4;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=SYyTc5Qkr6/3Iev1Fi01OmgKAGJQ5Y9+ZmSF5kcN/U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKeeQUT3FkhHpwa0jA+M0r4yyjzVdtPVIQxg2WTKgoVbRJqNsHWztLcOf/n24WfV+
	 4ROs0zNQa3i0IcRl5MBs5akFGowX0n1auxqjAUbJ4H11y6g3gir8VKjyFoL73CPZSS
	 sQF/BtxpeRk8xaiqIIy8P3qdiu4/tty+XjI3VjB0ghDksQXgzs7/0UTIhxaXw8c7ok
	 KnUi22KzG30M1tKxqMkTbrAEB5gIFnBjTMmvH0EOUpqk8CyvR7ocMsjQ7J9ArlvLqw
	 VOv6VXuxcmybEniOl9VVtu5M81+3W1W1MhdapR1CiMkLvodAMBR4fhMtij9/XgJXTY
	 qmP0r3Z+eu1bg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2R-25bW;
	Wed, 29 Apr 2026 11:14:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 05/19] spi: cadence: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:19 +0200
Message-ID: <20260429091333.165363-6-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091333.165363-1-johan@kernel.org>
References: <20260429091333.165363-1-johan@kernel.org>
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
 drivers/spi/spi-cadence.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index d108e89fda22..9b4e5b7013ae 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -643,9 +643,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 
 	target = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	if (target)
-		ctlr = spi_alloc_target(&pdev->dev, sizeof(*xspi));
+		ctlr = devm_spi_alloc_target(&pdev->dev, sizeof(*xspi));
 	else
-		ctlr = spi_alloc_host(&pdev->dev, sizeof(*xspi));
+		ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*xspi));
 
 	if (!ctlr)
 		return -ENOMEM;
@@ -654,23 +654,19 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ctlr);
 
 	xspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xspi->regs)) {
-		ret = PTR_ERR(xspi->regs);
-		goto err_put_ctlr;
-	}
+	if (IS_ERR(xspi->regs))
+		return PTR_ERR(xspi->regs);
 
 	xspi->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(xspi->pclk)) {
 		dev_err(&pdev->dev, "pclk clock not found.\n");
-		ret = PTR_ERR(xspi->pclk);
-		goto err_put_ctlr;
+		return PTR_ERR(xspi->pclk);
 	}
 
 	xspi->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(xspi->rstc)) {
-		ret = dev_err_probe(&pdev->dev, PTR_ERR(xspi->rstc),
-				    "Cannot get SPI reset.\n");
-		goto err_put_ctlr;
+		return dev_err_probe(&pdev->dev, PTR_ERR(xspi->rstc),
+				     "Cannot get SPI reset.\n");
 	}
 
 	reset_control_assert(xspi->rstc);
@@ -679,8 +675,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	xspi->ref_clk = devm_clk_get_enabled(&pdev->dev, "ref_clk");
 	if (IS_ERR(xspi->ref_clk)) {
 		dev_err(&pdev->dev, "ref_clk clock not found.\n");
-		ret = PTR_ERR(xspi->ref_clk);
-		goto err_put_ctlr;
+		return PTR_ERR(xspi->ref_clk);
 	}
 
 	if (!spi_controller_is_target(ctlr)) {
@@ -763,8 +758,7 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		pm_runtime_put_noidle(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
-err_put_ctlr:
-	spi_controller_put(ctlr);
+
 	return ret;
 }
 
@@ -785,8 +779,6 @@ static void cdns_spi_remove(struct platform_device *pdev)
 	if (!spi_controller_is_target(ctlr))
 		ret = pm_runtime_get_sync(&pdev->dev);
 
-	spi_controller_get(ctlr);
-
 	spi_unregister_controller(ctlr);
 
 	if (ret >= 0)
@@ -798,8 +790,6 @@ static void cdns_spi_remove(struct platform_device *pdev)
 		pm_runtime_put_noidle(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
-
-	spi_controller_put(ctlr);
 }
 
 /**
-- 
2.53.0

