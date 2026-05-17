Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E378317144
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014469; cv=none; b=qqmvwbu7dapxGxPze9yftDvYRHnoC02oYnvKLVes7B3fxFt1gosHQjc4f3WbhTSHp1RCo9sn2VH4PJiU1S6dPw88gU9LsPZAjtYL3T/+XIR2mSNEaqehA/bByufKn/aVEI3Mtc1XNY7lrYgDdxEApIy9OMDr7q/TWYvT7gpkpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014469; c=relaxed/simple;
	bh=h3D3ImvJVD6KhyB0VcERM9OQgo6ma0yzOWE/0rlCSBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RZOxMTH4bveMFGhM1KD0LnIG2vzErFGJ5LSAY9JuL83hKD9aK/N22wyEbcD5OEK+s327iS9Z+j4q+Q3WAtO1/29wtL7E4VrJvKD0CLapgjKKR03wBr7fEx9xtEjzgFWSMawgNlGtIuE1t6a83Ng7t5jKfY+JLYwXhhSnN6uPQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi0xJOgY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi0xJOgY"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c80227c9572so460960a12.2
        for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779014467; x=1779619267; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDuDwKGGWf9UcWAu5URZf49U1RBStWeCP5aE01gKgdk=;
        b=Zi0xJOgYoJcSE2pozQDad+ZjJBqZZCLFydDowgBqbrQQfr5yogz3KYjH+iMvM3snEE
         vxxXhEpXvKBPvCAGjigh9bb1e7wRUEcepxBwOUSepzZeBvY4+xOQa04biM+IOOzHHu1r
         ytcCruFLoMfTMYvVyMY3wzSOAbyPIIzO3t9x31ejtTK83n3lFGpFSC4lr6+8Gi91Jipf
         7zUiN7KnqODp22+uDCwhVNVtUzb6oZZOdY0O9uS8lhYJi50U/GAPdzxA0oquDPe6P0IK
         f+zVNyGLr5XjMhsvjhC9myjsG27puG7b/K2ZfAZl61nlJ+AkX0js/5PGP56oHX9brw9C
         or9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779014467; x=1779619267;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDuDwKGGWf9UcWAu5URZf49U1RBStWeCP5aE01gKgdk=;
        b=WTEQZ86tNsXu7q8aiAtnSJYT9ftAMCmO9m8Pl/gJ97wxYmHKisKHGyGkPua97VONbI
         cfUsM8YcXJFuFWmfDxokMYkrPuV0Sn8UaJ01RcnlAmmHSuN1tuA9MEQDMsDk+U6anv+S
         tjI9/W3GN+sHDCje8q7gTsTP2ibtiRM2fk79SG31IzRCSg9W5dEKUVhmqXWAUyr8NVGP
         UrUvPL7adxoh1a5jB0GhfP5FpK2g5075mD97np54ZnsOHUapbUM3BZjCkYD42ntve2Uz
         WBmvLs36lCPuN7XrM1bpEBjE8fzVM68eeZ13AQ8DEvvhnUDzqiPrpdVAB9vqOpx565ZV
         WFQA==
X-Gm-Message-State: AOJu0YxmqEAnon38MtOo27Xfnnc/g0VHp8xrr6HmbrvjAtVFl9UFnxnW
	EATg6EyvJ/ycRbPpp+3GmyESPLiVfbJgA3/MZHfYDzqT3F1TPfE8ZWUd
X-Gm-Gg: Acq92OEsf2Z5Xe961R2B/84cdlZdiA2gZa+nrOjXqZ5fV9yq/lE9PLGH3cYuljuKa5t
	Eqd9mTkaNQhSOKXfZmWMU4ho8js7MQ8sbLTSVJHYqmT1+uYx64yHTPWY9fRE5sE5QjAKy3i2dle
	8qlnwscy3PFicF/r0H+RrGGUGGilRU47lxaK5uwOQY4p1fifFqLhvB+73xZe7/QU2avFbKvpizA
	X59M/npFHKUq5RxJZDmQlNuuDuXJlgFn2IvUwJZb5C5vgUP8Kcz5KqVspbbWqVibgSmABHS7JiK
	ma3w39T8BP9lRMs30YpK1EcsPUu6VFpbIo+5Nypiw5QgjSSgsja5AwCGXrMutskOsQx42BElH01
	Eqry6YA117sWTNt6fkZxqMo5TnUHaHerElJLKSfmGwagOH/BxOZFhs26jjv6siTwiMAaQjsUhRY
	SJmzZ8NEgVkTvEWO6poXLowAyR9/BdQOrgTkdwmeHPmbaqbvz6gfxfGJ4dQZwEF80set04lgXkv
	s0Mv/sPdyha+cU4kQuVABPD3vWJ
X-Received: by 2002:a05:6a00:a203:b0:834:df57:9d36 with SMTP id d2e1a72fcca58-83f33d9de2dmr11177169b3a.25.1779014467267;
        Sun, 17 May 2026 03:41:07 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664712sm11488415b3a.12.2026.05.17.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 03:41:06 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 17 May 2026 18:39:54 +0800
Subject: [PATCH v2] spi: atmel: fix DMA channel and bounce buffer leaks
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-atmel-v2-1-36c836be6345@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPmaCWoC/12Nyw6DIBBFf8XMujRAFJKu+h+NC8BRp/HRAJI2x
 n8v2F2XJzn33B0CesIAt2oHj4kCrUsGeanAjWYZkFGXGSSXijdCMRNnnJjqlOWi4Wg1QnZfHnt
 6n51H++Ow2Se6WMbFGCnE1X/OoySK999MgnGmdN3bWnNtenUfZkPT1a0ztMdxfAFF+J8DrAAAA
 A==
X-Change-ID: 20260516-atmel-6d6b0150eb7e
To: Ryan Wanner <ryan.wanner@microchip.com>, 
 Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu.pirea@microchip.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779014463; l=6687;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=h3D3ImvJVD6KhyB0VcERM9OQgo6ma0yzOWE/0rlCSBo=;
 b=0qKY9HBnhgMtap3+OWCRR3mUZrdhTKmDNnlawg6EwGL7t8sxY9470XxmzVCJ68Q6pbvjNTHZL
 1AUald4HO4HCINme2x8kCpvSdZ39/kPGz0j4q/bsnNGoQO5DbmO+TJn
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The original code set use_dma to false when dma_alloc_coherent() for
bounce buffers failed, but DMA channels acquired earlier via
atmel_spi_configure_dma() were never freed.

When devm_request_irq() or clk_prepare_enable() failed later in probe,
the driver also did not release DMA channels or bounce buffers already
allocated.

And in the following error path, the driver released DMA channels but
did not free the bounce buffers.

Fix by moving bounce buffer allocation into atmel_spi_configure_dma()
and switching both DMA channels and bounce buffers to their devm-
managed variants. Any allocation failure in the DMA configuration path
now correctly rolls back through devres cleanup, and thenow-unnecessary
atmel_spi_release_dma() function is removed.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Switch to devm-managed variants to fix Claudiu Beznea's comment.
- Link to v1: https://patch.msgid.link/20260516-atmel-v1-0-674fb4707af6@gmail.com

To: Ryan Wanner <ryan.wanner@microchip.com>
To: Mark Brown <broonie@kernel.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-atmel.c | 94 ++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 67 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 25aa294631c8..23022665c3a4 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -565,14 +565,15 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 	struct device *dev = &as->pdev->dev;
 	int err;
 
-	host->dma_tx = dma_request_chan(dev, "tx");
+	host->dma_tx = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(host->dma_tx)) {
 		err = PTR_ERR(host->dma_tx);
 		dev_dbg(dev, "No TX DMA channel, DMA is disabled\n");
-		goto error_clear;
+		host->dma_tx = NULL;
+		return err;
 	}
 
-	host->dma_rx = dma_request_chan(dev, "rx");
+	host->dma_rx = devm_dma_request_chan(dev, "rx");
 	if (IS_ERR(host->dma_rx)) {
 		err = PTR_ERR(host->dma_rx);
 		/*
@@ -580,12 +581,27 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 		 * requested tx channel.
 		 */
 		dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
-		goto error;
+		host->dma_rx = NULL;
+		return err;
 	}
 
 	err = atmel_spi_dma_slave_config(as, 8);
 	if (err)
-		goto error;
+		return err;
+
+	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		as->addr_tx_bbuf = dmam_alloc_coherent(dev, SPI_MAX_DMA_XFER,
+						       &as->dma_addr_tx_bbuf,
+						       GFP_KERNEL | GFP_DMA);
+		if (!as->addr_tx_bbuf)
+			return -ENOMEM;
+
+		as->addr_rx_bbuf = dmam_alloc_coherent(dev, SPI_MAX_DMA_XFER,
+						       &as->dma_addr_rx_bbuf,
+						       GFP_KERNEL | GFP_DMA);
+		if (!as->addr_rx_bbuf)
+			return -ENOMEM;
+	}
 
 	dev_info(&as->pdev->dev,
 			"Using %s (tx) and %s (rx) for DMA transfers\n",
@@ -593,14 +609,7 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 			dma_chan_name(host->dma_rx));
 
 	return 0;
-error:
-	if (!IS_ERR(host->dma_rx))
-		dma_release_channel(host->dma_rx);
-	if (!IS_ERR(host->dma_tx))
-		dma_release_channel(host->dma_tx);
-error_clear:
-	host->dma_tx = host->dma_rx = NULL;
-	return err;
+
 }
 
 static void atmel_spi_stop_dma(struct spi_controller *host)
@@ -611,18 +620,6 @@ static void atmel_spi_stop_dma(struct spi_controller *host)
 		dmaengine_terminate_all(host->dma_tx);
 }
 
-static void atmel_spi_release_dma(struct spi_controller *host)
-{
-	if (host->dma_rx) {
-		dma_release_channel(host->dma_rx);
-		host->dma_rx = NULL;
-	}
-	if (host->dma_tx) {
-		dma_release_channel(host->dma_tx);
-		host->dma_tx = NULL;
-	}
-}
-
 /* This function is called by the DMA driver from tasklet context */
 static void dma_callback(void *data)
 {
@@ -1581,30 +1578,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		as->use_pdc = true;
 	}
 
-	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
-		as->addr_rx_bbuf = dma_alloc_coherent(&pdev->dev,
-						      SPI_MAX_DMA_XFER,
-						      &as->dma_addr_rx_bbuf,
-						      GFP_KERNEL | GFP_DMA);
-		if (!as->addr_rx_bbuf) {
-			as->use_dma = false;
-		} else {
-			as->addr_tx_bbuf = dma_alloc_coherent(&pdev->dev,
-					SPI_MAX_DMA_XFER,
-					&as->dma_addr_tx_bbuf,
-					GFP_KERNEL | GFP_DMA);
-			if (!as->addr_tx_bbuf) {
-				as->use_dma = false;
-				dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-						  as->addr_rx_bbuf,
-						  as->dma_addr_rx_bbuf);
-			}
-		}
-		if (!as->use_dma)
-			dev_info(host->dev.parent,
-				 "  can not allocate dma coherent memory\n");
-	}
-
 	if (as->caps.has_dma_support && !as->use_dma)
 		dev_info(&pdev->dev, "Atmel SPI Controller using PIO only\n");
 
@@ -1652,7 +1625,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	ret = spi_register_controller(host);
 	if (ret)
-		goto out_free_dma;
+		goto out_disable_rpm;
 
 	/* go! */
 	dev_info(&pdev->dev, "Atmel SPI Controller version 0x%x at 0x%08lx (irq %d)\n",
@@ -1661,16 +1634,13 @@ static int atmel_spi_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_free_dma:
+out_disable_rpm:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
-
-	if (as->use_dma)
-		atmel_spi_release_dma(host);
-
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
-	clk_disable_unprepare(as->gclk);
+	if (as->gclk)
+		clk_disable_unprepare(as->gclk);
 out_disable_clk:
 	clk_disable_unprepare(clk);
 
@@ -1687,18 +1657,8 @@ static void atmel_spi_remove(struct platform_device *pdev)
 	spi_unregister_controller(host);
 
 	/* reset the hardware and block queue progress */
-	if (as->use_dma) {
+	if (as->use_dma)
 		atmel_spi_stop_dma(host);
-		atmel_spi_release_dma(host);
-		if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
-			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-					  as->addr_tx_bbuf,
-					  as->dma_addr_tx_bbuf);
-			dma_free_coherent(&pdev->dev, SPI_MAX_DMA_XFER,
-					  as->addr_rx_bbuf,
-					  as->dma_addr_rx_bbuf);
-		}
-	}
 
 	spin_lock_irq(&as->lock);
 	spi_writel(as, CR, SPI_BIT(SWRST));

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260516-atmel-6d6b0150eb7e

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

