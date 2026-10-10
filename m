Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC9331A48
	for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621321; cv=none; b=Wynfhed5A4xboPiN7iz4OzfPvOoRwwiIBwFrwq/R4ODn7q1mo474hdi4lGak3PvsUEf/9CwwawWSD8AD4WwZyYXARigBKtYfvXzDmFCsbrLLGwPN4XKVXXHTMttgjeweWPbuz01FcjqUkH97bm3adyH1STYjT9BlaaNykkvhvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621321; c=relaxed/simple;
	bh=1kRF5VOmfeAPBhGf6I8e3OR35yHYRa7vHOBMANSzLvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgnMtm11qC4HYdYcRoVIt8/7/bROD0lEmWSf6JSWDNE+q6vSGm2R2wzo318Sf2ePT+i2x5XFuWdappVXHoQQBz6WSCMmWxR3S+DwZWIuhfGJuR+243XIevI9tVDL13uUTdIMAJPku8VrFL4uxkrDc7tDM7QqOrX0QZ7iRZGgK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30b6dad2382so970958eec.0
        for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 01:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621318; x=1792226118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vd6PvYub55DkYTK4Z2RMOKatSjX+x4KShfXJLN8v41I=;
        b=c7aXImwCGzDKjBGeFCi99PiANY0+A9qTerqZDpUqaGbur0iXhrocJmsABlPczL4/U0
         8hJzQl4Njdfw2EsTOSQQmvqR+iT60PVG1XGslVHXJFJOVHQJx6k3ifCI/kwgkcPwIrdG
         xjcVVof87tS1fMNew7054ov71but5a2juKwLUyF1nFen8PEATuTX98lup6diNqTfzjKn
         ARde7a0R3Yf+6J7MyDBWQtqW12WeedfslSkJ9poqW3r27oWcAi6gwj5ZxUSXcxhjAtbC
         j5OInxAUuwn/aHoB2JG+ho/nqNrk3bpSJ6j2njnoeBOohK4o5YxCpiF/3zieq8klYXfV
         wn7g==
X-Forwarded-Encrypted: i=1; AKwUvBzS4khmaLXKogfoXB/cW507zfD4LuBL10X1x3m627CD4HU17g6J+M91FQbsrkZdhQzczMSwqwMgpR0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjBZKgaC+xbXC4h6G10UIrIDeUj7RrLE5x4Rl6lXYp7sdImxZ/
	CA8+7ZfIw7LuBaxgVwRjUsZnYqebk7zjZclkQwexyQ6oZH3/CrZMbyPsG/dF2pFCfxE=
X-Gm-Gg: AYBFou1Ibz8Q4VvS4+HAgZDsikGrm0ilAi26eNfaG75DGGZP4s5cSlpu2CN3VgTY6dQ
	jS4mt8xNKcbpOeiRcA5o2ac7QG3YV9K0TdyPTOacBkDyjMZnxCztTFijVLaU7xY4xP7WUlVpA7J
	StWnTEd6+fvjlFDEg3h85qYO8qzf/V0JNwOnXwdrQ3mhs6FHmQBAja8fyk95YTsalkIIy1KK2Fm
	U3S0zCB255ih1fIamrLf8M/ks1YrJFpS6/iDCc9JsciR9Po9YwQhjjwsD7FylseY3IeEAY1hz/s
	tAheMdLgEWFiM8Gzgyq7R7FrCezecOSFyQ5m1bhe1SeHOtYzCQ9+Z9q8OysSGwwDPoOnju2zKm/
	7Bn+iaiu9Z/1rjagcOSfXj+IzhWaMhOvcqCWw6dhKSouz9nYqHbSMSH0Ic8f01BQpiC+ahqqNn2
	BYcQnFQYlw6B7LJBbUQgbPOWKELzdQ7lMlGC9GhGu3OZsWbt8ajJlcZT6uFtA=
X-Received: by 2002:a05:7301:1629:b0:356:9345:9da6 with SMTP id 5a478bee46e88-3569345a800mr3369002eec.2.1791621317730;
        Sat, 10 Oct 2026 01:35:17 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm12689858eec.4.2026.10.10.01.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:35:17 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <aayushkmx@gmail.com>
Subject: [PATCH v2 2/3] spi: omap2-mcspi: Use snprintf() instead of sprintf()
Date: Sat, 10 Oct 2026 14:05:03 +0530
Message-ID: <20261010083504.26261-3-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010083504.26261-1-code@aayushk.dev>
References: <20261010083504.26261-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aayush Kumar <aayushkmx@gmail.com>

Use snprintf() instead of sprintf() to avoid potential buffer
overflows when formatting DMA channel names.

Signed-off-by: Aayush Kumar <aayushkmx@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index a3355147f..311ee0ca9 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1544,8 +1544,10 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < ctlr->num_chipselect; i++) {
-		sprintf(mcspi->dma_channels[i].dma_rx_ch_name, "rx%d", i);
-		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
+		snprintf(mcspi->dma_channels[i].dma_rx_ch_name,
+			 sizeof(mcspi->dma_channels[i].dma_rx_ch_name), "rx%d", i);
+		snprintf(mcspi->dma_channels[i].dma_tx_ch_name,
+			 sizeof(mcspi->dma_channels[i].dma_tx_ch_name), "tx%d", i);
 
 		status = omap2_mcspi_request_dma(mcspi,
 						 &mcspi->dma_channels[i]);
-- 
2.56.0

