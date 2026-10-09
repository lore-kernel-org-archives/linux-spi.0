Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B83F3289
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552281; cv=none; b=Kp1RQC4OZLyBUU/+fapBboEX9b5X3liEvxCJUo7wAjCtaYZwSPpTX+bKTazkYSto2dyMA9o7nQC487e84NzEVvVbbp1jgxl5vkA8fyu9tNVxMwG/i7g4l+KwZYdHqmZ6+Gv2MlBozteIFQSul5/buxrkrLWoeDuRv1cBQRnFRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552281; c=relaxed/simple;
	bh=OP0lTXPApvGeiuwxg7E80kgKy/RRWWFcy+KfpyqNzRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkkxUoFYIQiIB7wVXouT/+1mPb+Y+VSk8aqDYDwaKz1fNr5C8R+yMWv8fLlxVsuQLu/NclHR9w2UhYbDVKEfhsEPMRhge6Bm81Wp6DdvDs0YZsThGuH6nwxwiSFsZQYkyACKUu/am4o9tL5Rti+pHBdDXrxeu+0dU4Id/u2y0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d032846c95so34023545ad.1
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552280; x=1792157080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CXHf/FKh3ncskGhCp75YJz0EIF61+XX7rivRqa49b40=;
        b=wv9izMtrRKalLkHScgwD7Sq3uVLABbRdE97hQqlXLYRNi7wD3uDBapfl0hsWieL9Qm
         c6DsDdu5VcELjy1o21ht/7IUDGOugFSzsPO1sn1n5HuVCHw8qJsRdplyH05JOLa0wV/U
         lRpDaQ3H2135u0CvKiq5x/VdeyshCm1ut86N8+ZMbYUn/5e4yOSQhmLtLOMLQY52rs59
         jubZUYADr/TiApM4MrHQPRMYyYlb3cF/D8A+vFgr1H62eM9kEir/RGblna3T/hmEyg8D
         paRdmrrwKA9+arJVZW/3qJmh5764/pXRyRFphCny0EqhxPiSg7N+pSXf7tzDoXAdOly+
         S7Ig==
X-Gm-Message-State: AFq9FYIupH+AQh2QMCXpv1FOZQ20YB1L9WgACdFkPGjibAr+iAVr5Vb6
	0EUqGivYYB/UzZxTlDfMHyWRRC4dh4uschtfpGRp4PscBe4XNY3RUqDBkMet653Xg+Y=
X-Gm-Gg: AYBFou1rFtuyXA2Wpa0Z2Dgmw8O1GK6HRMDsCeaouvG/Qfz1mmdSrQIIqfHRLk263d5
	dg4Ewick3+IAAeUyYYoFr4awm8roUsjrisWy3rmBAUN1sfPLfQaXhVlKyGQbxqZLKKlBBsXwicQ
	dj8njyKOTs7mMlPYgztP0aN4QBmK516leTQIF8C+02LkGq9pFCieQe9DKKFMQvxQFlJgiQkl1eB
	972RVDVERS7IM0W+npfZMXhMNrpcqnOHGDS8neu+n9MFUTB1jgZPy40SK4udwBwHQIsV3lnoLdy
	P33kgIXTYJoScxmblzlEd1xdfGfxiNw2u8YjCiaEyU6Gfb99xBqLROcB7FYYVThNfLpJDL3p96z
	9TMqiExRVaYiaDo5/EK3qFcSA9/ry0eeglWOcbJYTga0O0MCIlOlSvABtGE00xkhjdTQUj0DTrQ
	i4D9oLrZTGKoFr6k5PznMsRpZaWsWEOzmaRufNFZZnYkNnpPv3Kbr+GRmW+rM=
X-Received: by 2002:a17:902:cec2:b0:2e3:1bb4:611d with SMTP id d9443c01a7336-2e842ceddbamr17685635ad.49.1791552279907;
        Fri, 09 Oct 2026 06:24:39 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e2570sm9327705ad.79.2026.10.09.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:24:39 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 2/2] spi: jcore: Use devm_platform_ioremap_resource()
Date: Fri,  9 Oct 2026 18:54:21 +0530
Message-ID: <20261009132421.557758-3-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009132421.557758-1-code@aayushk.dev>
References: <20261009132421.557758-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource(), devm_request_mem_region() and devm_ioremap()
separately.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-jcore.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index a75cd61ec..df82e8adb 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -143,7 +143,6 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct jcore_spi *hw;
 	struct spi_controller *host;
-	struct resource *res;
 	u32 clock_freq;
 	struct clk *clk;
 
@@ -164,16 +163,9 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, hw);
 
 	/* Find and map our resources */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -EBUSY;
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), pdev->name))
-		return -EBUSY;
-	hw->base = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!hw->base)
-		return -EBUSY;
+	hw->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hw->base))
+		return PTR_ERR(hw->base);
 
 	/*
 	 * The SPI clock rate controlled via a configurable clock divider
-- 
2.56.0

