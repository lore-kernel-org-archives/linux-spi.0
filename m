Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFC04E36EC
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791552991; cv=none; b=CKSBVpkse4U3Mw5mhvR5nnP35zA4yGO+weEv1Xlcx1spA+4ouKg7DLBroqpTaRPR0CIy0Q1FLKg2BE8+Bw8qnruIWdggEfEOAg/d3SGZU9sSNg9Ub9XFzqDLX7GhLYesuo5/NYB8qeM+ZMBhxFtFr+OU4KYIgbKmjJH75BZGhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791552991; c=relaxed/simple;
	bh=NHe5P8xaZMYon8Yt3xMtARUagvmOi+SVhipWZIQ7y0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFU7Khu2PuuJo5KLpd+F/6+fjCv2YfPUpme0h4sdv71ZIkdQ/bITbzvjZEG1XIhJKmB2IlqjgbPWxpgYhIciU4N3yt87pN4BoN/pvBk5PJIq+4v7jC6cvVPrHTsp/nKNgOY6Smua8mRJRR1mHUeGbKQSjt3Ehy1H/LLJgiAzGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e7006bbf77so14402765ad.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791552988; x=1792157788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AqvUHDbEtMERdIpHzV9HikVjBgNvbJTmZWz286oPhCY=;
        b=C6f856mN2uy8zvvI6Hcth2rz6+xQj9zltRT4+RTczs3X+2uo26orVO7bvG9CJ+JD7N
         xI5IfpH9xE/WAtHr7C6HaYXdOnEuumP0T+RaR5izkCqocFxPrlwWXw2w/SVW4vFCSgDD
         FMxuZwRCVsCf7Ktk7hJm5gIuUoBCBug1E8XdMywk1B8cMiLzOMS/5LAb1pO941WOgIG+
         XBQwHCG1kAsUQm5GuZSmUakeNT7xbxzYcvjyPRe0AN4fzYyckOFvNccOsH8tRhy7Ke+m
         2F1MIDEYxQCzN40sFk4Pdzxxg5u0I6+XalvDH8afcSLTC/ylgmCIj5bkq+sPZwn27vTX
         TidQ==
X-Gm-Message-State: AFq9FYIJ624umTxt6jUBV0R+tpMZI/dHJ7D6lBTXF3Qm9hQvAdfPARWg
	dFvPmXVG4cOrra4dWaM58m5mLbDBSnvsF74nJ19dqtCnmHqwdNeh21k5Q74cErUPfp4=
X-Gm-Gg: AYBFou1TIPIJJJW14rybOkBXhguSSy6JaUdVDCcLd8eR3yXGFyyc3M+o4zBE9StIp73
	zBOM+QNz+Wm9MIi3oVbMzlc9widwWTPywmB4uu9T4+gJw7zay6zGwmWzklFlhWs20ZNhseFMDGv
	Tm4+Uf0Rgi8ZrnNpOge5Kxg/zF5dMCdjsa5n4B23vP18rSS6pzZEEh8VCbK5ZorGnOa5C5W3BKF
	gu0EFradpxw/ityt2J/arIr2Y4rkVS70CwIiF++xC3P3wQVhT5RAmtg/krOFpi/0JOkvnCJ2mLe
	utV7zviNDBzuKxdnn9iu2dqe9A28YTkN1yxwja4HoP7WtO/ueJdr5E2GeipszD36pK5gLyPayXb
	TN/Hks9YAGj8/I0WUOjsvuE5G3blf4y25SRKDPUqA2aM/MFWCQK6ANbZ6ml6yKUwiM5D55G/fvn
	6D/ycaWhLQJcM6iVmgMpd/KNsdk1IYJnn3veDjSUZR3zlo93UvY1xK7GJM9qI=
X-Received: by 2002:a17:903:19cf:b0:2e5:41dc:9ac7 with SMTP id d9443c01a7336-2e842bc7708mr17655435ad.24.1791552988157;
        Fri, 09 Oct 2026 06:36:28 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8484c1641sm7656985ad.15.2026.10.09.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:36:27 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <code@aayushk.dev>
Subject: [PATCH 5/5] spi: s3c64xx: Use snprintf() instead of sprintf()
Date: Fri,  9 Oct 2026 19:06:09 +0530
Message-ID: <20261009133609.579046-6-code@aayushk.dev>
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
overflows when formatting the clock name.

Signed-off-by: Aayush Kumar <code@aayushk.dev>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8d4120cf9..8195bf376 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1331,7 +1331,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(sdd->clk),
 				     "Unable to acquire clock 'spi'\n");
 
-	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
+	snprintf(clk_name, sizeof(clk_name), "spi_busclk%d",
+		 sci->src_clk_nr);
 	sdd->src_clk = devm_clk_get_enabled(&pdev->dev, clk_name);
 	if (IS_ERR(sdd->src_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(sdd->src_clk),
-- 
2.56.0

