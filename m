Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5063314B82
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850364; cv=none; b=KFimHDAvOYXqwUcwX1ZjK0dI4SjafnNWwgElNCX6XHD0nS1SvJ4JI8PELxYpdslDGIHMvsv3Y+7wwcOwHyNyzOX0y62zVUSk+13Z6DiO0UZ1Sni0qiK5TpeXSpWGO/WpeusQ8VhEPaWH1pJW/6iYheIIa4FFWgRUz3SAuCjqAP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850364; c=relaxed/simple;
	bh=v9woLIZgnstGAIF0Eth5tsY4n3LQFLhcy4LkO8NqurM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsvtEKyHw4Mj2j5Lb2df8uoOyLGpe9DfDmaZQk7QqWCbMN6GKmqYfuJIZHLiHi3xcY7CRziFz6Rqf+Y5TUNx5uGT0/U+JMBBhkuSPM8cPiQSBj0+ebLspkcJeW20mnvV8j8J3+yo5qsfH2JiezdwfdOx3ZyePsvRm0u6UDM2jQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rlhz0ILd; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rlhz0ILd"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35a04d6aeb0so90974a91.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850360; x=1774455160; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdZkBPAjksPIDRkwr96hfTI/z7pyk2jtrZdzb6oj8WA=;
        b=Rlhz0ILdoFxUc/ys1lsOvd05ytfTtyhVQw3Q+9mwF3BQSC7115gJMi0CxCF7+dXu1S
         tyHpSjZU2dM+QG+xSWJJvvYVMA2yRbZy+9A3bt4OI9SbYZqdjBeVGJcrliV6Jc6/qv2w
         MsxIF69r6UQO5KcAdkZHrrFJUHxtNlr5r9uid50dFy/KIqyVNk8GBOs6FZtg6+l2RHAo
         4tTsEU1F5F+Yqx8imRtqei86c3scZqn02skxp8GhJ9/oCaI0DmS3pbx1LVi8ILsRmT9l
         PpwU6mD2LhTKg47GYwOivJDhrg2Q5lh9DP8E12YWu17TI4AMtRPgUD3zsVMzYmiEDSET
         J8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850360; x=1774455160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FdZkBPAjksPIDRkwr96hfTI/z7pyk2jtrZdzb6oj8WA=;
        b=fJyzA0mwmfuDgtDJA5oWvTHEerfNK91EiAuD/pg/7XIStESTOxYKDGQWNJsIGL3D6Y
         g6JtdxozDbtIX8GR64tX87TWOllpkde5HWl7MzYPsZlobDcgWYVkMwNQbBWAE2C8Yaz6
         ekJuz8Qjz4TI42aXsxSzb/9oyriisLlJceMdXZm1sxyynaopjg3mR6Fy5WE0ZFGkky1d
         DYRZ7W74fezzhUz3Ju6rUjn327S5oMrxWst8pjAvArBkdlew2VKZtJShNpoLqhBzvgTb
         vn6lfXq5+ymQjnhdvrpFEpqcEXN90mGVS9/iLso0WmsbpF9HMOt0YA+fXp7VHX6KVOfN
         qJoA==
X-Gm-Message-State: AOJu0YzTtx20hfBN39h0rsPi4ZgjJsu1CE7eduzYijzJzvgIZzTxK0Cb
	HTAof/Q/jxiKdurqr8Aw6/C5NWoJnNMarDedyxsr+3SWr27bCRF7vSbHt/dfKg==
X-Gm-Gg: ATEYQzydVnNq9MIQMz9XZK5jkzeFFZLW4fssYKfYhP+PfHL9w8+pRcTW3b094Mlzip6
	IwDW4emPo+vEwrAxtdzth4TZkiQtrmEm0fcXM5xaOgUIU+T6Nh7uMZUkLCYX5l6pWuhYUArlAMC
	AKcO8CsZiLepMIQj8JvH6LfvbDry+oVZFtcD5jkT66/b4toqphu2jsEa8HJZEQyqUVeWyagDFDa
	INVex85o/pvO/KjH+xq8AjCaNcUxviOfEsS8ex79ZXCLgPMFTZkYK1ublAuremv49OrfKNpqndL
	qD9mxTnb62dRXV0YWiGQWqnKSQIOnoIrPzJ0LuqHW3m7U2itwWliRiidWI0oyAmifE70wNXn0Tw
	lKx+1FIZGxtHW+z0+Lz5FERLYfsGA5lGmACaV5+gth8TsWxxZXY40BodolBKnQqra4YKI3OOKLh
	+CEnU4LZHxlP5Z/p664KfCy1lZ6XzQ676HHQPx
X-Received: by 2002:a17:902:d541:b0:2b0:5903:13fe with SMTP id d9443c01a7336-2b06e325bb6mr40567795ad.12.1773850359564;
        Wed, 18 Mar 2026 09:12:39 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e430864sm43040915ad.18.2026.03.18.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:12:39 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 19 Mar 2026 00:12:34 +0800
Subject: [PATCH 1/2] spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sn-f-v1-1-33a6738d2da8@gmail.com>
References: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
In-Reply-To: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773850356; l=1715;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=v9woLIZgnstGAIF0Eth5tsY4n3LQFLhcy4LkO8NqurM=;
 b=XDxxe+Jl0TxFt2HOYzfrUi5I5sfII+Gc3wJ34vcts7QvZR4npV1kgcPV1wyR8IwJNvqj4wUru
 imfoKyZ7fO2CmdfVNO12C576YAKFIGOSveH9NbRZhjVSH3Js2nsZIyH
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In f_ospi_probe(), when num_cs validation fails, it returns without
calling spi_controller_put() on the SPI controller, which causes a
resource leak.

Use devm_spi_alloc_host() instead of spi_alloc_host() to ensure the
SPI controller is properly freed when probe fails.

Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-sn-f-ospi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index bfcc140df810..1f554aa7ca27 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -612,7 +612,7 @@ static int f_ospi_probe(struct platform_device *pdev)
 	u32 num_cs = OSPI_NUM_CS;
 	int ret;
 
-	ctlr = spi_alloc_host(dev, sizeof(*ospi));
+	ctlr = devm_spi_alloc_host(dev, sizeof(*ospi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -635,16 +635,12 @@ static int f_ospi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ospi);
 
 	ospi->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(ospi->base)) {
-		ret = PTR_ERR(ospi->base);
-		goto err_put_ctlr;
-	}
+	if (IS_ERR(ospi->base))
+		return PTR_ERR(ospi->base);
 
 	ospi->clk = devm_clk_get_enabled(dev, NULL);
-	if (IS_ERR(ospi->clk)) {
-		ret = PTR_ERR(ospi->clk);
-		goto err_put_ctlr;
-	}
+	if (IS_ERR(ospi->clk))
+		return PTR_ERR(ospi->clk);
 
 	mutex_init(&ospi->mlock);
 
@@ -661,9 +657,6 @@ static int f_ospi_probe(struct platform_device *pdev)
 err_destroy_mutex:
 	mutex_destroy(&ospi->mlock);
 
-err_put_ctlr:
-	spi_controller_put(ctlr);
-
 	return ret;
 }
 

-- 
2.43.0

