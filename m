Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D9B39FCC6
	for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453660; cv=none; b=SlMOh5o9KarHboP5wad5O063uo+praPWXFymvxdHUwr86YBt8SJQepiskW18wPcJ76DO02tkoJB5TChvblsRxnTCpUpVdFYorItzWq54DgY+vz1qem4UPpJywbuJUBgLwy4xEmddSSD8v/E+aydNOcoEKWPwjdHVUfsTPkzSww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453660; c=relaxed/simple;
	bh=Y82jaR7ig01C99YVTX1uP7k3+xb7iSdiU2qTIciu+vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BoIFh8e+BF6YqVA43F49X9q9yBHqrHkU18eEJmNSaI9nw4wiiyAHCudC8+nvJ4LsqmiNjkBFiobf/U9rtuRoZ30kXdnQIlJh7SHwx/eC1HjWf4AszSH0S+XoxMa8kFQ+IXwlNjIKfeevK8JRY/uSH/ffYRfzVrZX0SQAfofsme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScK4BHmV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScK4BHmV"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8353c9f24d2so3740439b3a.3
        for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 05:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453657; x=1780058457; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JHMw4rHowryIGHkjcmpjPUf8sGdPW4drldezm1GiZm0=;
        b=ScK4BHmVAss6hHZ337IJm5+jVB7ebmdiBln59utabdbF3vI6wxvcIsTQ3pgazCklYl
         Q70HbrGL2IsULOEIFP+2GNc7xHj5dqanOWXAoZlEiqitagW462kZmiFW1Z84jTzoctn9
         4wG0zZPooChyVnhoX7jEakTAnXFrKxNILrxWmjKa3yp03HR5Z9Y5vnmR6t32+cNYN6Cf
         UwAKeG8lRyJEFhs1udwMIKUej+nNegs7gsSk+WVfWzVj6IeWAnOnzzJigakupkoqbn+N
         wPcBc5l1dQpUm2ZaXKI3LJdfDf/We8ke8bBh8kRUVZ/GNd1WOuYLq9uW+IDb9FG3cIWi
         +cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453657; x=1780058457;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHMw4rHowryIGHkjcmpjPUf8sGdPW4drldezm1GiZm0=;
        b=sWIEOCHa0ljBw5YI9GShpmBO6ES8qTAbhMbIDJFL6lYxuPefK7MdtoL8dSseXFqz3Q
         pETF2qzyue9pZ8b8b039JODcCq9G8qy9UyH+vwcqoD92PB+WHOX3Fk8eaZBW+7WV9AiR
         8qFeJagAfWmFnP/PFeMWe/xit92pRlmItyFTEvPf0G2VxBgZkMUuaJ+T4dbSdkQ1cyow
         LY6EcUTOyfYx6dApdweo8evGN+5YGTj7ipfktZ/qiKEp/iwq0+92Hn+u11ernEmGBhQG
         aN+SxpSiDoojRP4rh2IhLs7ZH8QbH664mJTFGzaImrPgO4ztEwIZWD/P+Cbqz1Nw71DY
         EGFQ==
X-Gm-Message-State: AOJu0Yw1W2bayLlWWGp4l1/7jztKNWpNMbmCJP6UPCjqQBo7nrDOGd4E
	TVoxnHyNfEJrd9OOV2IO/7F/oPo9GKqYGJFIcjcJwik78oeeVvob9+M+
X-Gm-Gg: Acq92OFlCneLkUZieLt+7u4BXI2glRwDdg6VZdz2gCR6c87gkBoju4LZQeAaqnmY/EX
	9YP85qTgZovE1IQwrkgYCREGVvMeyoMD/tvddyNKl1mlaB9Zvm679zX+Cuj+Tz3xxnp+6v309QX
	0Kw/nT/F6UtPffzeoS8DmkAdIQUdgk6grzu8WhhiaxSMaX6gX5Jibc2Ft0whTg6IkSCQOBCt94t
	bv/VR1reKeflSMZKhvmRM+9LlmgMVq0oWhh6h6x2hT9BwNrjlDLoZkNTdl21U52jejY98G6BADG
	2lc1JaHf/Y27aVxj+Dx+269tmD5nbuhk8zd1DdWpKugxrhMj8nZnSy0c3/yRiYiZXkD1cG/zvP4
	aXve+GKMXSuWeCnQj9TOPQfSEKVmW3xKV/lyEp3mUzW3k9V/if968824+QUnjPHfothSKs9PuZz
	40m0nUi0YzxCFh1Hg+/4XpqYqWhDfn9uUijCFNpMZeeeExlS3vMX6mJAXy8fYbgJEdZiV5d1dHJ
	cogp6HmX5YsFxpfVw==
X-Received: by 2002:a05:6a00:1c8a:b0:83a:3155:c5e9 with SMTP id d2e1a72fcca58-8415f2dade2mr3857383b3a.6.1779453656944;
        Fri, 22 May 2026 05:40:56 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aee7f5sm1929461b3a.14.2026.05.22.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:40:55 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 22 May 2026 20:40:48 +0800
Subject: [PATCH v3] spi: atmel: fix DMA channel and bounce buffer leaks
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-atmel-v3-1-23f8c6e6aa43@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM9OEGoC/12Nyw6CMBQFf4V0bU0fcGtc+R/GRVsuUAPUtNhoC
 P8uxZgQl5OcmTOTiMFhJOdiJgGTi86PK8hDQWynxxapq1cmgglgFQeqpwF7CjUYxiuGRiFZt4+
 AjXttnevty/Fp7minLOdF5+Lkw3s7Sjzv/puJU0ZBlY0pFVO6gUs7aNcfrR9Ibiaxt9TPEpRTC
 fYkwSDIstpby7J8AGtuoqbiAAAA
X-Change-ID: 20260516-atmel-6d6b0150eb7e
To: Ryan Wanner <ryan.wanner@microchip.com>, 
 Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Radu Pirea <radu.pirea@microchip.com>, 
 Richard Genoud <richard.genoud@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779453651; l=7250;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Y82jaR7ig01C99YVTX1uP7k3+xb7iSdiU2qTIciu+vY=;
 b=+R9Ushno/vwtOe8P1yjlWaCnoC/axXRM26wAw3q+bNjUEGjdFxqaHTLkeRe8cxvvOzvhgomID
 9Z1paZaF1J/AlSPXublvQaGFLTluZIsQ4maNSwnQBFkv0y4qiVQJDtp
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The original code set use_dma to false when dma_alloc_coherent() for
bounce buffers failed, but DMA channels acquired earlier via
atmel_spi_configure_dma() were never freed.

When devm_request_irq() or clk_prepare_enable() failed later in probe,
the driver also did not release DMA channels or bounce buffers already
allocated.

The out_free_dma error path released DMA channels but did not free the
bounce buffers.

Fix by moving bounce buffer allocation into atmel_spi_configure_dma()
and registering the devres cleanup for DMA channels and bounce buffers.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v3:
- Fix Mark's comment.
- Link to v2: https://patch.msgid.link/20260517-atmel-v2-1-36c836be6345@gmail.com

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
 drivers/spi/spi-atmel.c | 133 +++++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 25aa294631c8..c8012c82c3a7 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -559,6 +559,38 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 	return err;
 }
 
+static void atmel_spi_release_dma(void *data)
+{
+	struct spi_controller *host = data;
+	struct atmel_spi *as = spi_controller_get_devdata(host);
+	struct device *dev = &as->pdev->dev;
+
+	if (host->dma_tx) {
+		dma_release_channel(host->dma_tx);
+		host->dma_tx = NULL;
+	}
+
+	if (host->dma_rx) {
+		dma_release_channel(host->dma_rx);
+		host->dma_rx = NULL;
+	}
+
+	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		if (as->addr_tx_bbuf) {
+			dma_free_coherent(dev, SPI_MAX_DMA_XFER,
+					  as->addr_tx_bbuf,
+					  as->dma_addr_tx_bbuf);
+			as->addr_tx_bbuf = NULL;
+		}
+		if (as->addr_rx_bbuf) {
+			dma_free_coherent(dev, SPI_MAX_DMA_XFER,
+					  as->addr_rx_bbuf,
+					  as->dma_addr_rx_bbuf);
+			as->addr_rx_bbuf = NULL;
+		}
+	}
+}
+
 static int atmel_spi_configure_dma(struct spi_controller *host,
 				   struct atmel_spi *as)
 {
@@ -569,7 +601,8 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 	if (IS_ERR(host->dma_tx)) {
 		err = PTR_ERR(host->dma_tx);
 		dev_dbg(dev, "No TX DMA channel, DMA is disabled\n");
-		goto error_clear;
+		host->dma_tx = NULL;
+		return err;
 	}
 
 	host->dma_rx = dma_request_chan(dev, "rx");
@@ -580,26 +613,45 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 		 * requested tx channel.
 		 */
 		dev_dbg(dev, "No RX DMA channel, DMA is disabled\n");
-		goto error;
+		host->dma_rx = NULL;
+		goto err_release_dma;
 	}
 
 	err = atmel_spi_dma_slave_config(as, 8);
 	if (err)
-		goto error;
+		goto err_release_dma;
+
+	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		as->addr_tx_bbuf = dma_alloc_coherent(dev, SPI_MAX_DMA_XFER,
+						      &as->dma_addr_tx_bbuf,
+						      GFP_KERNEL | GFP_DMA);
+		if (!as->addr_tx_bbuf) {
+			err = -ENOMEM;
+			goto err_release_dma;
+		}
+
+		as->addr_rx_bbuf = dma_alloc_coherent(dev, SPI_MAX_DMA_XFER,
+						      &as->dma_addr_rx_bbuf,
+						      GFP_KERNEL | GFP_DMA);
+		if (!as->addr_rx_bbuf) {
+			err = -ENOMEM;
+			goto err_release_dma;
+		}
+	}
+
+	err = devm_add_action_or_reset(dev, atmel_spi_release_dma, host);
+	if (err)
+		return err;
 
 	dev_info(&as->pdev->dev,
-			"Using %s (tx) and %s (rx) for DMA transfers\n",
-			dma_chan_name(host->dma_tx),
-			dma_chan_name(host->dma_rx));
+		 "Using %s (tx) and %s (rx) for DMA transfers\n",
+		 dma_chan_name(host->dma_tx), dma_chan_name(host->dma_rx));
 
 	return 0;
-error:
-	if (!IS_ERR(host->dma_rx))
-		dma_release_channel(host->dma_rx);
-	if (!IS_ERR(host->dma_tx))
-		dma_release_channel(host->dma_tx);
-error_clear:
-	host->dma_tx = host->dma_rx = NULL;
+
+err_release_dma:
+	atmel_spi_release_dma(host);
+
 	return err;
 }
 
@@ -611,18 +663,6 @@ static void atmel_spi_stop_dma(struct spi_controller *host)
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
@@ -1581,30 +1621,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
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
 
@@ -1664,13 +1680,10 @@ static int atmel_spi_probe(struct platform_device *pdev)
 out_free_dma:
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
 
@@ -1687,18 +1700,8 @@ static void atmel_spi_remove(struct platform_device *pdev)
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

