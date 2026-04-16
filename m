Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738253A3826
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356885; cv=none; b=FOJAgaNsRB4uoT1iXEk7AoB0S1ftlkSHd8zMNNV53AQ2Zdkc28Fy0QUlV2GGDKqdbinI0qNJgtk3lN8dUD7osCCzNi6Ep9CQhEFKeJcX1gs9Dv8oWGfe0Vy0KsUCe4Ew8iDt/Z98hw2UYDf35H+xn6BuSsiLRi45oSoYS8bsAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356885; c=relaxed/simple;
	bh=FZ6qkpMKVIcbowELRYRBQvoC35yyjFuA/kOKYyZ/2F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEu0kYIaF8SzmtBeHcdgn3kx+v16CZH7TyLCV1dhsWeT0AG5sz3PlYvihNqf4Nkeu4r+gH0PJEY8q2Js42XIPsfvSZQ6z1WdDA7PU5xUIfvy1zvpFAeGBqsXquEWRzE9qi1mtURhEoy84jZjBv9EepIjNL4poY3gCH/b5BG+e2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqoTSq/v; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqoTSq/v"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c79662668bbso391611a12.1
        for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776356884; x=1776961684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSry/j/bHDuu9fpNbbaBULIlYY0NQBFJddY/G6VITfM=;
        b=LqoTSq/vSHHaTVf9NZnEKPJAp8PmWI4Wjrsca6oHTL9LxVJFYzCao/TZ9RLY0JUu/F
         TAP3dvGQrHyRH1hu0Ss7ZX46vNDnUp+zJVmr+WKGDK9CefPPWnshvrTIB4IxcOmVP0WE
         gsmUs4urBBOt/4ThiqRYZqmaRbA+V1333bCndsktE2Lvsdo2Xq9uVCv9GXIYLnqK5ZSY
         0FLBeO1z9/j/8ePcMiCVPTbnRuvZLTzw+Newwe7U2j6wxQVyBcYncIcaB5KOKvE50duu
         ddswq1yio4Gpv3tS1+CUEv2wuIluX7F9DHD8RKzPpri5tw4vRHjbMv8vaZtAWPBuhEnZ
         PWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776356884; x=1776961684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSry/j/bHDuu9fpNbbaBULIlYY0NQBFJddY/G6VITfM=;
        b=JHH2fVBHsmNJjQbTpQY4S3JLE10U4BZjBbMSKaUWhuu2fUQBOHT2Sx76+EUQpOn7no
         w/VVX++8z5fzUAtegV/ELRnw89TJyu07Jti5xhxlUq+a39iGJYajw7ww79AptNQTeapr
         gWd0RlBeTUw9WdmZMy3MmIp7WCt3skZwOiHm+OYdv+06JXvxI0HxbaxFIwj6sfGpm3Bd
         nn7IUHqerBgtMZgi47aoZSsEu3X3u9oq8cwaDfwUs4zrY98MKBxFtb7vf49C1tzVn24c
         KRdaTbbKtQMzwFpAQ4GoTgvdwCRKEGyHhUPKIQmm2FO+9hN1YqLm7BtCBYa8b4+tX5t+
         FBww==
X-Gm-Message-State: AOJu0YzacEz5irYECVl1Pk4F7gaKpbEQQVOadPsHfPb6G+KplinBRjtv
	lO/EVZJKUM0XMxknqVkAEa4cMFLgTHmndrfgpr2FySAXYFJtCJWFSwI7x7Dl7wUh/tk=
X-Gm-Gg: AeBDieu1FBkx1ILeyc01F87/XpWRbOPjec7ySO5bT9FanLkOAXBDCjhCdY0m7unZ/1h
	3KwfxHuImdBlKQLmY+pMD3jntdyVyUCNIAkdd285sKwKLM1s1FApRBVBm+AFL8AM6hMCPCMuOwX
	S1WhnYJkp/kTD/ywid8Y1MYsDBnuemK4mpQ0wvItY++8nqyH2WRUXBVUAplzRzZiEJ0BbTO92j5
	6aq1PiePlnL5B4wgmmuXTo+lNI4AcZeZc9OkNASYxVFk6HQQEt78M9I13Fppgpiapp7mwP52zjO
	nRgRPOmRlla1djtuebnk8I67oiPaGAA+x7lVORmRjtT0NifPP10Jdgsl6DR9BzlamRDCl5d0cW+
	jhVplgnReFOIMUJ8c0UuSnxSRyT64loA8Om1eL/HxCuX243VxixRmDB1/uuEYIp9I73ae3WecGq
	43de0du0nU2ZKIbI1ld4yH0a4ifbjEf5HhyfMBIS77bKJseB3D5aFp4deDpSXAfbnTAqR/cgdW0
	1y936cAeYG4qdqALyNxyaDH7iSgpFI=
X-Received: by 2002:a05:6a20:3d1c:b0:398:8dbb:d1f with SMTP id adf61e73a8af0-39fe4108830mr29897868637.55.1776356883559;
        Thu, 16 Apr 2026 09:28:03 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ed03f1sm4899852a12.3.2026.04.16.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:28:03 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 17 Apr 2026 00:27:55 +0800
Subject: [PATCH 2/2] spi: atcspi200: switch to devm functions
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-atcspi-v1-2-854831667d63@gmail.com>
References: <20260417-atcspi-v1-0-854831667d63@gmail.com>
In-Reply-To: <20260417-atcspi-v1-0-854831667d63@gmail.com>
To: CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776356879; l=1911;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=FZ6qkpMKVIcbowELRYRBQvoC35yyjFuA/kOKYyZ/2F8=;
 b=QLuqZT+7GA4+3UyeKUqZC05mgpQ14rMiwnyfexefXYc7G3zRe5ajp9NIjxkWa5x8KYyRy4cDS
 B6U0ax8sMynBKEi2q4SRMmMIeDnArOeb4JR2JM47Q4Ybwv3zwEeiLu2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Switch to use devm_spi_alloc_host and devm_mutex_init to make code clean.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-atcspi200.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index c5cf1aa2d674..6d4b6aeb3f5b 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -550,7 +550,7 @@ static int atcspi_probe(struct platform_device *pdev)
 	struct resource *mem_res;
 	int ret;
 
-	host = spi_alloc_host(&pdev->dev, sizeof(*spi));
+	host = devm_spi_alloc_host(&pdev->dev, sizeof(*spi));
 	if (!host)
 		return -ENOMEM;
 
@@ -559,21 +559,23 @@ static int atcspi_probe(struct platform_device *pdev)
 	spi->dev = &pdev->dev;
 	dev_set_drvdata(&pdev->dev, host);
 
-	mutex_init(&spi->mutex_lock);
+	ret = devm_mutex_init(&pdev->dev, &spi->mutex_lock);
+	if (ret)
+		return ret;
 
 	ret = atcspi_init_resources(pdev, spi, &mem_res);
 	if (ret)
-		goto free_controller;
+		return ret;
 
 	ret = atcspi_enable_clk(spi);
 	if (ret)
-		goto free_controller;
+		return ret;
 
 	atcspi_init_controller(pdev, spi, host, mem_res);
 
 	ret = atcspi_setup(spi);
 	if (ret)
-		goto free_controller;
+		return ret;
 
 	spi->use_dma = false;
 	if (ATCSPI_DMA_SUPPORT) {
@@ -586,18 +588,11 @@ static int atcspi_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_spi_register_controller(&pdev->dev, host);
-	if (ret) {
-		dev_err_probe(spi->dev, ret,
-			      "Failed to register SPI controller\n");
-		goto free_controller;
-	}
+	if (ret)
+		return dev_err_probe(spi->dev, ret,
+				     "Failed to register SPI controller\n");
 
 	return 0;
-
-free_controller:
-	mutex_destroy(&spi->mutex_lock);
-	spi_controller_put(host);
-	return ret;
 }
 
 static int atcspi_suspend(struct device *dev)

-- 
2.43.0

