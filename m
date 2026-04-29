Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749073BED1F;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=FItnW8eDM+viz4xVO+XxJlDo3uLpUnLM5IDDVREjlzJ8EvSz5SwU7VVj0IV/R8ybKzzhVdmsY4BzRlzTah7ejOfZOSMg1yyqygOqNmqsHakr3GUuiZLUzV+SJN18r3p6QZGXBsCYgC+vnwm0epNb/Wmd759MO7Uotxi8wARalAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=udOPvQqu01S/r33g68acSIYEHytGJeFyiFVks9xsMbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7nN5mSFF6kA3tHRPwUWcs6bgmqxdpRRjP4XhlaZCb9/LecvL1VkdhRIp474qbWiTZsudsf46v3ULzVFohlc+y7j4Nik/3ojF+kVeJBgxPYaLxf5NllsKBg848dsyPvB2Vd0NSqgcnwpJ+gpQNaANC85L0GbB/jdey0AfiaHFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghvOQuBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghvOQuBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105F3C4AF0D;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=udOPvQqu01S/r33g68acSIYEHytGJeFyiFVks9xsMbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghvOQuBUCqkgh65aQDjmmISOb3WNFxgpc/0zWo/rMBT+f8GExrOWJtLlfbt41CAj0
	 1gCTjNAriQo+HFPrXF6BtJrTwQIYgG9Bfx1SS25GhAc+ze8KcufqmnKJ2r4NCT+usw
	 RT8Fb0yj4Z6kJqHPT2eHFpz+uAcOXFjuWgDEpyZsf5Or8dBXzOfVt/w2x3bNcUNFfa
	 4KziDLPBUbsTDsX04MpO9KSBJFdjT1ENp5YgCWApjEzSJwtvIZhQF4f98DnuInNEHe
	 ChPq/qC23VQZvS4ilk6sF8xF1OWuazluItbeLTm/Ha0He4fyUZLyCw3gIy18tYSE40
	 g9+cbZTiCQPTg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2r-2bdM;
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
Subject: [PATCH 18/19] spi: omap2-mcspi: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:32 +0200
Message-ID: <20260429091333.165363-19-johan@kernel.org>
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
 drivers/spi/spi-omap2-mcspi.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 56b30ff58771..0426adc94ee1 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1484,9 +1484,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	if (of_property_read_bool(node, "spi-slave"))
-		ctlr = spi_alloc_target(&pdev->dev, sizeof(*mcspi));
+		ctlr = devm_spi_alloc_target(&pdev->dev, sizeof(*mcspi));
 	else
-		ctlr = spi_alloc_host(&pdev->dev, sizeof(*mcspi));
+		ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*mcspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1530,10 +1530,9 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	mcspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
-	if (IS_ERR(mcspi->base)) {
-		status = PTR_ERR(mcspi->base);
-		goto free_ctlr;
-	}
+	if (IS_ERR(mcspi->base))
+		return PTR_ERR(mcspi->base);
+
 	mcspi->phys = r->start + regs_offset;
 	mcspi->base += regs_offset;
 
@@ -1544,10 +1543,8 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	mcspi->dma_channels = devm_kcalloc(&pdev->dev, ctlr->num_chipselect,
 					   sizeof(struct omap2_mcspi_dma),
 					   GFP_KERNEL);
-	if (mcspi->dma_channels == NULL) {
-		status = -ENOMEM;
-		goto free_ctlr;
-	}
+	if (mcspi->dma_channels == NULL)
+		return -ENOMEM;
 
 	for (i = 0; i < ctlr->num_chipselect; i++) {
 		sprintf(mcspi->dma_channels[i].dma_rx_ch_name, "rx%d", i);
@@ -1556,7 +1553,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		status = omap2_mcspi_request_dma(mcspi,
 						 &mcspi->dma_channels[i]);
 		if (status == -EPROBE_DEFER)
-			goto free_ctlr;
+			return status;
 	}
 
 	status = platform_get_irq(pdev, 0);
@@ -1604,7 +1601,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 free_ctlr:
 	omap2_mcspi_release_dma(ctlr);
-	spi_controller_put(ctlr);
+
 	return status;
 }
 
@@ -1613,8 +1610,6 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_controller_get_devdata(ctlr);
 
-	spi_controller_get(ctlr);
-
 	spi_unregister_controller(ctlr);
 
 	omap2_mcspi_release_dma(ctlr);
@@ -1622,8 +1617,6 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	spi_controller_put(ctlr);
 }
 
 /* work with hotplug and coldplug */
-- 
2.53.0

