Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD803BE64B;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=OeMX5vyVwtg/hcqG1N0u/hq7jidDXJSM9aMav+HAJJ8cD8GYiIeKzeTgx2iZlZoyRiaJPEOgg7Je/qHrZJqC69zJMwPxIc+q9fXoezF4QCokcPGCuz0Hwf9o452YM+3T0DxKLLSR1kqj3uAZPnnVPDd9bnaTEYIV5/vpCBN8oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=ga+FOMp9qVwI8l87FgM0Iz0sGRIiFaESZzWnM4Wja4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxZ7umbjz1LnFPr1g2qGhF4LZkrX2yaBqxHldS1m+1y0B8VKm9AT4yo+hX4SNgc/Wpx6efQtp8cVm7dbQzxCyDOt4AaohyNhlibMLt3YIx8iVmbFmc3bEMth009Zv3F2ECS7mIf0TucCthr0s3IMbLna6s0dwXwkadlLj3qz0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDkQchGM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDkQchGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096E6C2BCFA;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=ga+FOMp9qVwI8l87FgM0Iz0sGRIiFaESZzWnM4Wja4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDkQchGMD21nFV/Ka4Edcv9xzqL6QEEGLlIsdBC2YenGrzrV0xZA1sKYAB0/z7DX+
	 Jrnlaf4d/dhtzMVaN+ThSuhmYVfPWgNGS+ND3droylnEbo9Md1b48iIr3lcjhIcdOE
	 rRuOIpEGGA233NvXuwlFraI4cVEaVGjbWT45zQHsrjAwHyg0FhbD/rp3Rp8iySSV8S
	 j7NNeRL4z1rgyLRnFDBqZfAceBdffDgDPS1cSrnHxfR3ir0FX7kIrVP/pLoM971I36
	 TISV7AxAgM+RoyxAxwluHsrzFUVkm0rddJI7G8jUevC25YGYhwubbZZPgN/WdA7nx0
	 mtUecZOK+4eig==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2X-2CiX;
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
Subject: [PATCH 08/19] spi: coldfire-qspi: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:22 +0200
Message-ID: <20260429091333.165363-9-johan@kernel.org>
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
 drivers/spi/spi-coldfire-qspi.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index b45f44de85dc..3b175c1da36b 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -353,39 +353,33 @@ static int mcfqspi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*mcfqspi));
-	if (host == NULL) {
-		dev_dbg(&pdev->dev, "spi_alloc_host failed\n");
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*mcfqspi));
+	if (host == NULL)
 		return -ENOMEM;
-	}
 
 	mcfqspi = spi_controller_get_devdata(host);
 
 	mcfqspi->iobase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mcfqspi->iobase)) {
-		status = PTR_ERR(mcfqspi->iobase);
-		goto fail0;
-	}
+	if (IS_ERR(mcfqspi->iobase))
+		return PTR_ERR(mcfqspi->iobase);
 
 	mcfqspi->irq = platform_get_irq(pdev, 0);
 	if (mcfqspi->irq < 0) {
 		dev_dbg(&pdev->dev, "platform_get_irq failed\n");
-		status = -ENXIO;
-		goto fail0;
+		return -ENXIO;
 	}
 
 	status = devm_request_irq(&pdev->dev, mcfqspi->irq, mcfqspi_irq_handler,
 				0, pdev->name, mcfqspi);
 	if (status) {
 		dev_dbg(&pdev->dev, "request_irq failed\n");
-		goto fail0;
+		return status;
 	}
 
 	mcfqspi->clk = devm_clk_get_enabled(&pdev->dev, "qspi_clk");
 	if (IS_ERR(mcfqspi->clk)) {
 		dev_dbg(&pdev->dev, "clk_get failed\n");
-		status = PTR_ERR(mcfqspi->clk);
-		goto fail0;
+		return PTR_ERR(mcfqspi->clk);
 	}
 
 	host->bus_num = pdata->bus_num;
@@ -395,7 +389,7 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	status = mcfqspi_cs_setup(mcfqspi);
 	if (status) {
 		dev_dbg(&pdev->dev, "error initializing cs_control\n");
-		goto fail0;
+		return status;
 	}
 
 	init_waitqueue_head(&mcfqspi->waitq);
@@ -423,8 +417,6 @@ static int mcfqspi_probe(struct platform_device *pdev)
 fail1:
 	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
-fail0:
-	spi_controller_put(host);
 
 	dev_dbg(&pdev->dev, "Coldfire QSPI probe failed\n");
 
@@ -436,8 +428,6 @@ static void mcfqspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_disable(&pdev->dev);
@@ -445,8 +435,6 @@ static void mcfqspi_remove(struct platform_device *pdev)
 	mcfqspi_wr_qmr(mcfqspi, MCFQSPI_QMR_MSTR);
 
 	mcfqspi_cs_teardown(mcfqspi);
-
-	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

