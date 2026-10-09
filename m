Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA34D98EF
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552992; cv=none; b=HEPWqk7e+nz3wIBj6IBOZh9slKKluv58EXQSc7VHYEAcGBo5iL0b29O/GejEsgppyNgalc6mMR7vxLkVrJzQg2Dwm2a8EfMJ5BpkDayHDqnE/swMRgW9r84Tbb30SvraimlMiCt6r6iPNhELp2gQYKHRdQrvT3Bqwe1DZe5R1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552992; c=relaxed/simple;
	bh=ZhsY1lRzQ+V6ijG3qFiS3fFgTjwYihevXL72coSCjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6Ez0AJe3tOeQsdlz0jFhYuvkxug64Fnkv+uXd7LP4kQsAi4KT+Yaj/vx3HB2PasQmsEmeo8xVnb+HxMBRjb5eVSW2A9Xq9n9bd65G09tmgu4uM/lYYrvnEO22nCYMhtN39CxXXyAP/+EsXX0CQKxjP+0L1DwShZsZ7qykhnwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso31573425ad.2
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552990; x=1792157790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X+cLy2VGZ7LgWJ56rIrD9j476kYKycSgx/bYHSa3aYU=;
        b=wAHd+8MySNs0Natw9nA3+Tf+czk4P3e/8vFQKdsSMr2hm7umxVepbRmWJ5ttUtEik/
         FJKBHrOX3V1Q7ZLF8I7KvWVXqKwYfQJ9hIAxIiW8oCfgENT4VDb4CET2lsB0VWZN4Oop
         Vtv5QRfN1T3WdHrqBQU8LSwUmkMdgq+0yM/5P04Iwni1YYAfn8E5O0C4r851l4id8Adc
         PSruA63eYNK0+YaPbkqBgU7tMwt29B6mjFXNJWjySqJkoNbtpZ+U8l6aAtbDYsaWGmnf
         EdlaEupr/Hwohb0wo/qlfuZpzPHfebOrKXbdiAugLXHDwyQxCpMyIjcjfi9wgT1A4+Bp
         6Q5g==
X-Gm-Message-State: AFq9FYLhux6oHl8znOK1I4mVT/UPt+BJ/LRHXjEdk16je4WGAUEqL/sf
	jwwzMSLAvC7yGkF3zSeTLBgddyjsemq/V9oBVX13MpSuAjKIYsNgZ6qO
X-Gm-Gg: AYBFou1LQ42z/IgxRDzMNOOAK+HNkgYcFxHiXikzWdJHj2wW9IF7sM0ZJ58apaVGT/r
	sLIrLTeaffPGTsJ6Vqow15dYPrfDJ89Rvlv2NAb1hjTOQez2mrOVRp9ax/lDuUND37hVypqF0Dc
	CEXYnLQwyt9l3jeYUOV1AAVQ+qAhWj+bRRHYfGAyLpy0IjreaUMBIMRvhxIJzL2Vd+50EBCMYcl
	1DwE7M0ov/YwbVb6i/SpzWph5s0E/7j32/jG7Uoi91KjUmTQNo8siHteTG9faAoz/TBxxuIAOOs
	CEIa/OSNRp9BD5FfdOXGaN5Myeqd4O13lGbRndBrhwr0uK4nBN94/HAxGe01WwfAiy8Aj3tdoZU
	8EszTnqodz41FCKzXd59E2hseQ6qrDENYQblRmOP9B6PL7V72VMyvLHJl5bV+lXI9rTX3+MspbU
	phXj13vOkyiIyrwTIZMBawhKYPI1szl0QCEQ0CdQk4a5AJJjdlDkuZ5jv+jCc=
X-Received: by 2002:a17:902:e5d1:b0:2e2:e57f:77e0 with SMTP id d9443c01a7336-2e842ac4b98mr17744015ad.24.1791552985435;
        Fri, 09 Oct 2026 06:36:25 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm7656985ad.15.2026.10.09.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:25 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 4/5] spi: omap2-mcspi: Use snprintf() instead of sprintf()
Date: Fri,  9 Oct 2026 19:06:08 +0530
Message-ID: <20261009133609.579046-5-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009133609.579046-1-code@aayushk.dev>
References: <20261009133609.579046-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use snprintf() instead of sprintf() to avoid potential buffer
overflows when formatting DMA channel names.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
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

