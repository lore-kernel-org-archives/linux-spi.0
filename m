Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374D3BE153;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=nwHuyFRWFo8JkuLBRxRmoVBjEW0+MgYU/1CzuMeTSmNNlnvR5RR5R68Fk8gWCBHva9XXRt7ViW2bswIrfZzaheD9RClqVPO0LthtHGZ5Eft6lNtY3M3ngukF4SL06yDKz8XM+uGaRSSEEdxvXHjD7oh05r4UJBvU3eW7lVUSRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=LUIxmud4ItkcIhMTJTOGUqRbRfROfvHNlWkcWBcsAnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hkv6syLG0vjCqt5U8tbIuEmvUp/MtX46hvqj2ByF5AC7DA2yyXJF4niJ4RFxPhQzqMUhwye0mtCC4poMEybB6hPmuodlPo5SMm8Ts0ThsNBPoGZzrIa/tVfmtvYErQcAxvjyF0ZA/ZKetZP+Y4PpkPJ8ZFrytIt832TAb2oGWQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QS7lO1Hr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QS7lO1Hr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E052AC2BCB3;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=LUIxmud4ItkcIhMTJTOGUqRbRfROfvHNlWkcWBcsAnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QS7lO1HrWI2ESWx9VL+jkZObruH4Ods/N1j+AWmM8t/xrhKeJrUO+WhV++HiVpQwU
	 TaocIF78A57MS4dyeFDbPPBH8VRXfhCQSOXcLjhCWa97cVOE4FnZdtEOUGb1K42ZaW
	 3KA5hlThuWaUj/qE4gNUkYWD+DLfmdXFoEYb8NFUz7DJeR3BMZ+tM9yBvYRwr3nTpq
	 f3tLdhhbGgIecNix367kmzyYkCCuDB1Jdzcy5A4LGOHfPj45AUz+SwcO+nrWmjQmuo
	 oKLLbztTEVNYoqCyNsdbcdxzqIvWtMN2rwXMYoDy1V/lM06Q8mj1bDVGRuSfEqQbrg
	 u/Gy2VqfRhpUA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2b-2I0V;
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
Subject: [PATCH 10/19] spi: ep93xx: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:24 +0200
Message-ID: <20260429091333.165363-11-johan@kernel.org>
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
 drivers/spi/spi-ep93xx.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index db50018050e5..d7e82d80c35a 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -629,7 +629,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*espi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*espi));
 	if (!host)
 		return -ENOMEM;
 
@@ -654,8 +654,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	espi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(espi->clk)) {
 		dev_err(&pdev->dev, "unable to get spi clock\n");
-		error = PTR_ERR(espi->clk);
-		goto fail_release_host;
+		return PTR_ERR(espi->clk);
 	}
 
 	/*
@@ -666,22 +665,21 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	host->min_speed_hz = clk_get_rate(espi->clk) / (254 * 256);
 
 	espi->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(espi->mmio)) {
-		error = PTR_ERR(espi->mmio);
-		goto fail_release_host;
-	}
+	if (IS_ERR(espi->mmio))
+		return PTR_ERR(espi->mmio);
+
 	espi->sspdr_phys = res->start + SSPDR;
 
 	error = devm_request_irq(&pdev->dev, irq, ep93xx_spi_interrupt,
 				0, "ep93xx-spi", host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to request irq\n");
-		goto fail_release_host;
+		return error;
 	}
 
 	error = ep93xx_spi_setup_dma(&pdev->dev, espi);
 	if (error == -EPROBE_DEFER)
-		goto fail_release_host;
+		return error;
 
 	if (error)
 		dev_warn(&pdev->dev, "DMA setup failed. Falling back to PIO\n");
@@ -702,8 +700,6 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 fail_free_dma:
 	ep93xx_spi_release_dma(espi);
-fail_release_host:
-	spi_controller_put(host);
 
 	return error;
 }
@@ -713,13 +709,9 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	ep93xx_spi_release_dma(espi);
-
-	spi_controller_put(host);
 }
 
 static const struct of_device_id ep93xx_spi_of_ids[] = {
-- 
2.53.0

