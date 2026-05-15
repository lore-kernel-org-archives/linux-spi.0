Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BED3DCDAC
	for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865647; cv=none; b=GzafPeLieygT/zHdXo4GcCgd9oyy1EJFfCXDljVc9/LQPRUhwljd5GYWjxrgTpdI4v+rnmuAZjpWk/wMRutlSpvvp6fjkVVeXanzruQ/Vq/b1xtfSRpFQk95hs6LU4Q+A+G+aN4eqEkMD1NAnXesAAIM8m1zWjLbQFEdbdTXj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865647; c=relaxed/simple;
	bh=lGBlNCNijk/Efa5PcvFYiun6BRP1lu0JZOhZHIl9RTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8iCLI2zpPEYPma1/nfVLhX0F8WLMzdCsalj7UBoO00RChqwTNDbtAM41gLEig1e96H+P9AB1bR9fibI9hU3h2Gwz+XQYlr3fXgacylrIGvic8WopyhMzZqGqLiaYTHqymEnV25FkjMnB0NX478Q57EHOshDkGE7L9oqLYbiK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JufiQFUS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JufiQFUS"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bd2c147abaso736985ad.3
        for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778865646; x=1779470446; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wVByEQNzHAoTLnCJhtnshp7ljQBgBd5RO0oGJrAuAM=;
        b=JufiQFUSUayxPPH9ccsv9H2/uLndVlYMNVFO7j3+M6r/IhIWQTfd/Bjg1DPPM5sokz
         AhJFzkbRU1DiNhocUL+KXcXwiOIBuvKZdrZXYRoXLOuV9m1XQJG4PrGhRTAkbWFK/o4w
         4cd6iiSHwrtygyzVYiDW9evODbU9zYoO/trkwWKVDzM6Gmz3UMoaakDqX6cFXHsekEBV
         5ZF34z+JYYkJVFtibXy4PBOf+N6hxvPAJCIVJHXBKNHWYFjDlt9rNtP9/lFBiCSk9Bg/
         mXTHAe0KAQbQfvc5zuawmx025iD7ap2sGhIhnoOlaOGl7ov8HxJWiu2vsDLMKq7t1tBe
         Tsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865646; x=1779470446;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7wVByEQNzHAoTLnCJhtnshp7ljQBgBd5RO0oGJrAuAM=;
        b=I0fmLWBrLgfx+yBe6Ebc7pTIN53YG3yUeIv3eYmX5/RViAm4khvKzR2JOaTVE6hnPG
         rqYX2lYpnI79JkNew+aFm0+moUJWyrZ+a/TJCZk472Yp3dQsIQeM1JfI8LUdCyOC+7w4
         LSgd93PO9jwtkqlMy+/+QjR9/+3SRhOh6FlMU6DTArdSYyarw9WZCrKiq/oldziWxUnO
         WEAL0srAjNtaM+RtCFMByvklRWg1mqqsW927DD9x7SPgG+t4Hl4ZeZLlhX5ypBevFTGp
         vWDYulRUuqx31Hw3VUP5dJpksPrX907ZLrW7kl5dVUGbUg7r9W0YLghKMMq4xaAqYZrg
         DGSQ==
X-Gm-Message-State: AOJu0YwFDE6hjIr1eni1Ij9bYIAtK2TkH38MccRJKisIAEn2xnwHfo9G
	VuNh1kxSRyERLGLJRij6vNLHgfAUz6x9CzC2lgWpr0o024brMw+IklMp4N+a1uSk
X-Gm-Gg: Acq92OHeh5NFAvU1MfOJj0VOM6x3XgHCFlIGtJvWqGj5F3/9AS5tk9+IZ3aVjE7lu+j
	0PMmZ8Y5C3BMVswZIxbU4AxMv5cZIUQriXBvJAvq+ev39iaE1vfEjqaZ46euL4n8EOa3SYPN47u
	7qGa8Ekn/uaP1NcvjIHCW5MbxakRfREUIdlwIA+iiODE1vP5hk7hG6wTa3d/YCevbZ48mt13nv0
	otw3uRKtlFSIbqgTeruoQoXQGp5zaqphJbGxkFxnkFS8Z8IcilP5uDcGjsdGVA+9zEwSSmR/ZPO
	ij3SJEuLdlhcTQR8J7Ex+cUvVTr/JmzExbh8Qg8Iug1+GDBUEkQq0xsmibL3hwKJvelbXK/6CIA
	F80Pi5EVTfyU3T0h+Uk4T8mFWt+3nmuomdSnWAFFK7lis4ukT9aR/NIn7G5Ov0XYu7JttID9Fas
	/2uP5UJMCPqtgeLhgDEaGSvJqN73kZyoCd27/hg3k7vG5A1UtoCcO+xD1+cEnZ+oH+HDXLovkiQ
	OmO13MSiJYzOEGEHtY=
X-Received: by 2002:a17:902:bb96:b0:2bd:147d:c712 with SMTP id d9443c01a7336-2bd7e78540bmr38358085ad.1.1778865645369;
        Fri, 15 May 2026 10:20:45 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600c3sm63151085ad.29.2026.05.15.10.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:20:44 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 16 May 2026 01:20:34 +0800
Subject: [PATCH 1/2] spi: atmel: fix resource leak on DMA buffer allocation
 failure
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-atmel-v1-1-674fb4707af6@gmail.com>
References: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
In-Reply-To: <20260516-atmel-v1-0-674fb4707af6@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778865636; l=5833;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=lGBlNCNijk/Efa5PcvFYiun6BRP1lu0JZOhZHIl9RTg=;
 b=5Q+74fz79MgI4YIBMsTxIncGfHx+moPofA723Hs/A6xnwjiRnVh8nzw2LNOwc4mgE2iWD/nBL
 HHV9kWxV/dkBpiXGKjC6jk+WyFnJypGwKXXSKG6GakYrEojezMZrrMB
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The original code set use_dma to false when dma_alloc_coherent() fails,
so DMA channels allocated earlier were never freed, causing a resource
leak.

Fix by moving the bounce buffer allocation into
atmel_spi_configure_dma() and extending atmel_spi_release_dma() to
also free the bounce buffers. Any allocation failure in the DMA
configuration path now rolls back both channels and buffers through
the same release function.

Fixes: a9889ed62d06 ("spi: atmel: Implements transfers with bounce buffer")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-atmel.c | 113 ++++++++++++++++++++++++------------------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 25aa294631c8..e519a86a2b45 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -559,6 +559,34 @@ static int atmel_spi_dma_slave_config(struct atmel_spi *as, u8 bits_per_word)
 	return err;
 }
 
+static void atmel_spi_release_dma(struct spi_controller *host,
+				  struct atmel_spi *as)
+{
+	if (host->dma_rx) {
+		dma_release_channel(host->dma_rx);
+		host->dma_rx = NULL;
+	}
+	if (host->dma_tx) {
+		dma_release_channel(host->dma_tx);
+		host->dma_tx = NULL;
+	}
+
+	if (IS_ENABLED(CONFIG_SOC_SAM_V4_V5)) {
+		if (as->addr_tx_bbuf) {
+			dma_free_coherent(&as->pdev->dev, SPI_MAX_DMA_XFER,
+					  as->addr_tx_bbuf,
+					  as->dma_addr_tx_bbuf);
+			as->addr_tx_bbuf = NULL;
+		}
+		if (as->addr_rx_bbuf) {
+			dma_free_coherent(&as->pdev->dev, SPI_MAX_DMA_XFER,
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
@@ -569,7 +597,8 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 	if (IS_ERR(host->dma_tx)) {
 		err = PTR_ERR(host->dma_tx);
 		dev_dbg(dev, "No TX DMA channel, DMA is disabled\n");
-		goto error_clear;
+		host->dma_tx = NULL;
+		return err;
 	}
 
 	host->dma_rx = dma_request_chan(dev, "rx");
@@ -580,12 +609,31 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
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
 
 	dev_info(&as->pdev->dev,
 			"Using %s (tx) and %s (rx) for DMA transfers\n",
@@ -593,13 +641,10 @@ static int atmel_spi_configure_dma(struct spi_controller *host,
 			dma_chan_name(host->dma_rx));
 
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
+	atmel_spi_release_dma(host, as);
+
 	return err;
 }
 
@@ -611,18 +656,6 @@ static void atmel_spi_stop_dma(struct spi_controller *host)
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
@@ -1581,30 +1614,6 @@ static int atmel_spi_probe(struct platform_device *pdev)
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
 
@@ -1666,7 +1675,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 
 	if (as->use_dma)
-		atmel_spi_release_dma(host);
+		atmel_spi_release_dma(host, as);
 
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
@@ -1689,15 +1698,7 @@ static void atmel_spi_remove(struct platform_device *pdev)
 	/* reset the hardware and block queue progress */
 	if (as->use_dma) {
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
+		atmel_spi_release_dma(host, as);
 	}
 
 	spin_lock_irq(&as->lock);

-- 
2.43.0

