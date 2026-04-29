Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E8D3BED16;
	Wed, 29 Apr 2026 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454043; cv=none; b=AiMy40NZoIduaS99c6QMcXa2JhLJ3rsrTQjXSe3vbe4nSDBO7u4hXEUeRXLAOx3sCHg62m9JhKXLMqgsXjnAsmfSSXOVIskfSkAwCSUmcdjLX7qlOn5cdi0w9mfE5JNCsd2IGMCGE5vrcWroMYKkmiRb0LE14+xWPpqrRQinPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454043; c=relaxed/simple;
	bh=9ks0tIXQVv0GEMmjzFDCbTIyASIoMPHlGN+xS+DhGaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKxCYxwChI74fcZQpEEpuvEAEAkzgsI0hBzPYhZZQaducJfySq6sjut+VQy9q7JetXAatO+SOL4EeVdrzjyVLpGzTBCBR/uCddAkO6EBx5O1Xqc3aZSBEwYxFbyLPo1UDqimU9PQo3IC+oyiTofy5IJk+/6AwelCvYDBKpcsMFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3s1zra/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3s1zra/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C1C2BCFB;
	Wed, 29 Apr 2026 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777454043;
	bh=9ks0tIXQVv0GEMmjzFDCbTIyASIoMPHlGN+xS+DhGaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3s1zra/m0TQB1pH07JNgZ2XAzu8irJe+hw2jCdNEx4x6Xu7EGLlY3p0pueGXAIXI
	 ZECM6A2KZrnEjzms7ySscYY7+6hBnHv88PI/HQY3R2I70OjGcIPH6phNBHju8fMpkK
	 M+SZ6FAamRgSDlffk1nFLaumIQDvvyIyBg1s2lZnMN/ux8jP8ngqLZfSvGYuNojUb3
	 BGhXOHQWubgbMSXkSIu0Rjj3N4WNJ+nIRhXEBWr6eKmhtDUSv6Qu25utD/5OCgqPyC
	 kXx/kOHxXteznJISPxu9yY0kCQdSmEAqtgnqqvbHafYWGW4YHgI9lVyPvVpuHsSC+5
	 X/zu28MHdWE/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI0zY-00000000h2n-2WoV;
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
Subject: [PATCH 16/19] spi: mxs: switch to managed controller allocation
Date: Wed, 29 Apr 2026 11:13:30 +0200
Message-ID: <20260429091333.165363-17-johan@kernel.org>
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
 drivers/spi/spi-mxs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 0164e04d59a1..fda1d260b296 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -563,7 +563,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		clk_freq = clk_freq_default;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
 		return -ENOMEM;
 
@@ -589,13 +589,12 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq_err, mxs_ssp_irq_handler, 0,
 			       dev_name(&pdev->dev), ssp);
 	if (ret)
-		goto out_host_free;
+		return ret;
 
 	ssp->dmach = dma_request_chan(&pdev->dev, "rx-tx");
 	if (IS_ERR(ssp->dmach)) {
 		dev_err(ssp->dev, "Failed to request DMA\n");
-		ret = PTR_ERR(ssp->dmach);
-		goto out_host_free;
+		return PTR_ERR(ssp->dmach);
 	}
 
 	pm_runtime_enable(ssp->dev);
@@ -635,8 +634,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(ssp->dev);
 out_dma_release:
 	dma_release_channel(ssp->dmach);
-out_host_free:
-	spi_controller_put(host);
+
 	return ret;
 }
 
@@ -650,8 +648,6 @@ static void mxs_spi_remove(struct platform_device *pdev)
 	spi = spi_controller_get_devdata(host);
 	ssp = &spi->ssp;
 
-	spi_controller_get(host);
-
 	spi_unregister_controller(host);
 
 	pm_runtime_disable(&pdev->dev);
@@ -659,8 +655,6 @@ static void mxs_spi_remove(struct platform_device *pdev)
 		mxs_spi_runtime_suspend(&pdev->dev);
 
 	dma_release_channel(ssp->dmach);
-
-	spi_controller_put(host);
 }
 
 static struct platform_driver mxs_spi_driver = {
-- 
2.53.0

