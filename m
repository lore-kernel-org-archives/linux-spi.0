Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436043BD63B;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=VGloZQ7G7tKt53jbzboYHM0Cya0rBcHToqXtLMRHI5TpnRDygK7eEeNhiIm06aduQ+qc0W2MWEdz4EFC041Q93zYgMMdaNPNUkVlD+u7KNwX4q468ACGiNU/8E4zUgUyiTANeFKuzhVfRUpA3Gz1sk0WWQTj6oFoGIL/jfteeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=dkoaKrtU8MEPD/3hoa7/0tQPNgxVvbjWmBlSh3CG308=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYNr1LggXGdwgIRCnRqag1ZRUJLmi8AlpQ8K/dNegWhrBeMO7W80sxU0q1ghQjTPdUdNQFt95go/plbeQgmCXU+wgY3st60xaT6xDb3s+yMaNaprCoGA1DlmvHaYAluamAb8iHyOaTOCv6StXhmdhj0RkOPm3MxigPYzq7WYafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwkDUWES; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwkDUWES"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D860BC2BCC4;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=dkoaKrtU8MEPD/3hoa7/0tQPNgxVvbjWmBlSh3CG308=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rwkDUWESVm7pC4VG5qm5ezT+U0yWa1NoOg0BfNRLsqyLTK6EMlNqx0FR97/8Khwsf
	 T1kZkMRP32aT2OGYTnp0UwPliJjNorSJdznyq99IXuNZ20X55D5POFw3fjJeZ9nrcI
	 RbJqd0TiQktdyWEmIYxJHbtUg2ngOAxfVQIz3lKM8AlDzFrb0O05nmjJSHnl+0vt7P
	 Bz7FCr63iOqdyGpC2SwcJoDdyOY2LWer97vW7xvsHw39bfveq6gdD6I2uMmy9QyMft
	 yMXaZ/QKQKsOjEphzdbScNoXby9pqbgRIlFA2mDxAArFjQWVSvzTU4IbkHKroY5gWU
	 agGsc2Upjv+iQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2L-1xzC;
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
Subject: [PATCH 02/19] spi: atmel: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:16 +0200
Message-ID: <20260429091333.165363-3-johan@kernel.org>
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
 drivers/spi/spi-atmel.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 42db85d7ff8e..25aa294631c8 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1528,7 +1528,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	/* setup spi core then atmel-specific driver state */
-	host = spi_alloc_host(&pdev->dev, sizeof(*as));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*as));
 	if (!host)
 		return -ENOMEM;
 
@@ -1555,18 +1555,15 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	as->pdev = pdev;
 	as->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
-	if (IS_ERR(as->regs)) {
-		ret = PTR_ERR(as->regs);
-		goto out_unmap_regs;
-	}
+	if (IS_ERR(as->regs))
+		return PTR_ERR(as->regs);
+
 	as->phybase = regs->start;
 	as->irq = irq;
 	as->clk = clk;
 	as->gclk = devm_clk_get_optional(&pdev->dev, "spi_gclk");
-	if (IS_ERR(as->gclk)) {
-		ret = PTR_ERR(as->gclk);
-		goto out_unmap_regs;
-	}
+	if (IS_ERR(as->gclk))
+		return PTR_ERR(as->gclk);
 
 	init_completion(&as->xfer_completion);
 
@@ -1576,11 +1573,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->use_pdc = false;
 	if (as->caps.has_dma_support) {
 		ret = atmel_spi_configure_dma(host, as);
-		if (ret == 0) {
+		if (ret == 0)
 			as->use_dma = true;
-		} else if (ret == -EPROBE_DEFER) {
-			goto out_unmap_regs;
-		}
+		else if (ret == -EPROBE_DEFER)
+			return ret;
 	} else if (as->caps.has_pdc_support) {
 		as->use_pdc = true;
 	}
@@ -1620,12 +1616,12 @@ static int atmel_spi_probe(struct platform_device *pdev)
 					0, dev_name(&pdev->dev), host);
 	}
 	if (ret)
-		goto out_unmap_regs;
+		return ret;
 
 	/* Initialize the hardware */
 	ret = clk_prepare_enable(clk);
 	if (ret)
-		goto out_free_irq;
+		return ret;
 
 	/*
 	 * In cases where the peripheral clock is higher,the FLEX_SPI_CSRx.SCBR
@@ -1677,9 +1673,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(as->gclk);
 out_disable_clk:
 	clk_disable_unprepare(clk);
-out_free_irq:
-out_unmap_regs:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -1688,8 +1682,6 @@ static void atmel_spi_remove(struct platform_device *pdev)
 	struct spi_controller	*host = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	pm_runtime_get_sync(&pdev->dev);
 
 	spi_unregister_controller(host);
@@ -1720,8 +1712,6 @@ static void atmel_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(host);
 }
 
 static int atmel_spi_runtime_suspend(struct device *dev)
-- 
2.53.0

