Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27595439F71
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737504; cv=none; b=ZZ7DqEaWRgXKKVNvNwgNPA2Z4rgn9nLZYO0fccmPCYRGNPD8SoG0JWGTaLfIvRHU0lG+IBpAHhAQHk5ujGUOhN65eVBaghn5VZ7pOSEhBNCBl1Ex63Im5XDQuxzGTdk45gluCez+JQV3zfUxDL17x18TqMXaYmmzdPUscjMQQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737504; c=relaxed/simple;
	bh=afNZGMtYzA30KV4bDEhm00UcoH2/+9UJYMOEjo4Xyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USeoHBh/p6VfZ6zfkeScHuVp5lklH7hitDB2OI1QMToCVsHDi3spc+K0vGni2FUkRXEuMQhs0l0AN5cEPHP7TOZRM14s+RcsSg35ClTrUp4OEgofAVyUXz7fWsoH7w6dWpbDKVdeqwXBplXo8w7wczZULT3JzJ4nYvzvo0u8d0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7yrjnwn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7yrjnwn"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c998fd549a8so8477346a12.2
        for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784737502; x=1785342302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tXYrafFh6v41hHNrCujwkEXP25aXy1QcuniyU+tuiOM=;
        b=Z7yrjnwn1T/FgpH2ZBaGlcKT5OzJRnd8eY5VzV4OzUaJS45HsX8WcSGMbT8shCgvvj
         O51gJ+VC6bjArBim+8EnqkiRNPGzzVj6QhBqIwMg9nG7jMWRHZcp2cdbyNcsTrJmf9Z4
         wHrEu5qqRBG2UqHryjbPH8B2yELf13Oi1tDd62mer5HXrXluMeJHPQuL/d5rBIgbfzKv
         MzbPHeBrnT52jPhqqQf8GFMseg6CEOHyC9vYhZy/UEzlay4A9a1PFGEwWCObDZNdmjkA
         GxT6GW8pbP+OoDsqFSbFmVncL3Pa9/9fGInNTUjeVF5uY32HaJ9/uCbL939j7MA/ZGXe
         3HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737502; x=1785342302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tXYrafFh6v41hHNrCujwkEXP25aXy1QcuniyU+tuiOM=;
        b=DUyiMCe/jzvP9UeTE6zDbu88CXJ0/xt0Ns+eeQ2nZTCec2uwM0DWkcNw8hov6c2c7c
         dizp5ptTFggR1xMS1cCCiipC5kF1CZy6vBsI53Rhl+cml+MywF+QMyeOV7/QByCJlq/G
         Ns5jXDS/RvwXn/f9N+fMivJmf0Uu1HaT/Xh8x7I9E/F23AdAbveVxMvkBfNEyJ370MJ8
         REJovsc53XnnUjN9hdzxUkzey9ruDXOPJII7ieHitUyZJxCDLD3HbRqxG02hWZMTGmMX
         b/ize0gNaQTv6Cn+X+fy4quoDpMRTy2tpKWM/f6UdplUYHTJvmx1iBKJBwGqf8FT3+/J
         MgtA==
X-Forwarded-Encrypted: i=1; AHgh+Rq9GReHXW9n/ot5/qdA2ngv6GUTEn3Hq/Cgjm0i10cMDxz3tl1bxqn9Z7QbTXJpPuNUlJhh+6RDP94=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeeijJzTSEBrHPc15J9vs+vRfpEO68qwVwZ7Wx1rhMAEFxmuX
	i7QXv/rrq/EBvVipjb6n6iqOZQwa3iHHDw9ZKFR9wvUpdCezFsrTjHQ=
X-Gm-Gg: AR+sD10v80DfOKaAWj65ufJBBHo+G42UBIKfpHtsDgRXoLtdRETOaKXksSuHp21qvlO
	1KIyvcKR6ZRXlkLjbHYFK+ycg1qREbsPV77mYZ+/4AdN6KNW1dxf+X3gYGe/ropQ9afG3IPfGam
	X4SPVuc6YhIhdj3oJy/Xmp39zbrI9Uw9CW3WTK/WnW500REnhMYJpt3P3w7xdLX/RuJj3unKEP5
	ORanebSb2hD81bWkwpY+HvzFGBsz5MueqHzUQXzWOSUw54XwwO1mV3E2i09n6VkBWCBNDK2dC34
	8GCUYKncj6yWQcU3GWF301Q+vaqycmcTlyp8UZAe1ro0Oqqs7priUphgNOB4qJGSMHylkO6CGAb
	3AtMAn1fWtKD1y5H1gz3D/kltIBPsi+OtQMEliV+fkwh10jsYxgf8FAHnEJzPjMiEg29m73mFDW
	DZbxnncsL/jcyNo6eoNXkkfsn0YfSgywdj08EH
X-Received: by 2002:a05:6a20:a10a:b0:3c3:88a5:83db with SMTP id adf61e73a8af0-3c3ad6036b0mr25638872637.5.1784737502208;
        Wed, 22 Jul 2026 09:25:02 -0700 (PDT)
Received: from t-rex ([2401:4900:c212:546e:3d3e:f0d9:52c0:8a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6162csm10753122eec.7.2026.07.22.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:25:01 -0700 (PDT)
From: kr494167@gmail.com
To: broonie@kernel.org,
	dlan@kernel.org
Cc: elder@riscstar.com,
	linux-spi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Surendra Singh Chouhan <kr494167@gmail.com>
Subject: [PATCH v2] spi: spacemit: prepare both DMA descriptors before submitting
Date: Wed, 22 Jul 2026 21:54:44 +0530
Message-ID: <20260722162444.11415-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Surendra Singh Chouhan <kr494167@gmail.com>

k1_spi_dma_one() currently submits the TX DMA descriptor to the DMA engine
before preparing the RX DMA descriptor. If preparing the RX descriptor
subsequently fails, the function jumps to the fallback error path without
canceling or aborting the already submitted TX DMA descriptor.

Fix this by preparing both the TX and RX descriptors before submitting
either of them to the DMA engine.

Fixes: efcd8b9d1111 ("spi: spacemit: introduce SpacemiT K1 SPI controller driver")
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Surendra Singh Chouhan <kr494167@gmail.com>
---
 drivers/spi/spi-spacemit-k1.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-spacemit-k1.c b/drivers/spi/spi-spacemit-k1.c
index 215fe66d27b4..96b41b67fcbf 100644
--- a/drivers/spi/spi-spacemit-k1.c
+++ b/drivers/spi/spi-spacemit-k1.c
@@ -278,25 +278,25 @@ static int k1_spi_dma_one(struct spi_controller *host, struct spi_device *spi,
 			  struct spi_transfer *transfer)
 {
 	struct k1_spi_driver_data *drv_data = spi_controller_get_devdata(host);
-	struct dma_async_tx_descriptor *desc;
+	struct dma_async_tx_descriptor *txdesc, *rxdesc;
 	u32 val;
 
-	/* Prepare the TX descriptor and submit it */
-	desc = k1_spi_dma_prep(drv_data, transfer, true);
-	if (!desc)
+	/* Prepare the TX descriptor */
+	txdesc = k1_spi_dma_prep(drv_data, transfer, true);
+	if (!txdesc)
 		goto fallback;
-	dmaengine_submit(desc);
 
-	/* Prepare the RX descriptor and submit it */
-	desc = k1_spi_dma_prep(drv_data, transfer, false);
-	if (!desc)
+	/* Prepare the RX descriptor */
+	rxdesc = k1_spi_dma_prep(drv_data, transfer, false);
+	if (!rxdesc)
 		goto fallback;
 
 	/* When RX is complete we also know TX has completed */
-	desc->callback = k1_spi_dma_callback;
-	desc->callback_param = drv_data;
+	rxdesc->callback = k1_spi_dma_callback;
+	rxdesc->callback_param = drv_data;
 
-	dmaengine_submit(desc);
+	dmaengine_submit(txdesc);
+	dmaengine_submit(rxdesc);
 
 	val = readl(drv_data->base + SSP_TOP_CTRL);
 	val |= TOP_TRAIL;		/* Trailing bytes handled by DMA */
-- 
2.55.0

