Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915630C345
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249037; cv=none; b=tfbQpJ7K5iQf60i39Cd8TcDf6BXFtnqI/koKE/IMiYSJ2cRkNNeFt2VcbwrHmS8Hi+/xwXet4UYU0m71I+yX/pmGONMbVY597RiIuk8Aez/IRZ0RBvNPFk6MQ79nhpBHgyVLofEcwdOOsYSM6qV+JFLsi3aRAooWB8/b8QyaWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249037; c=relaxed/simple;
	bh=2QTwZeicuBqIZnQxI5R11SHQxg2Y25iPU5VryuEgcEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8mvn+0KjcVGrWxdSYjehrNbcZ98o6iuJHZiogYWj/K9zaV+0/PCCv3LbngYLc5UzD2ovVpyiEawGvKNhurMqmKKsk8hA9wpLHvNS8fvsgijfS9x/K4tOLSCO8hJh525kUrZcHO2Do1yfISLsHXFhoBDNaPQmTfWQDXxE9s73Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZ0htTZ; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZ0htTZ"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df8818fe1eso633315ad.1
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790249035; x=1790853835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VVZyQuOx10W8AoQP9MzIvUBAsru1Ry+CJZYSEvVQ+/k=;
        b=bdZ0htTZvsWq2yazoRE5OL2ovDW26/fh8EMsDOQN0sFMAmU9v8/jp5ievSONSQmj19
         tyWUZFS/g8MheffHdG3y6lekfts76YhdAHsi+wT2WVn4SbbH+oElH/yxq3nx1M7RjaeL
         VFWuIXUmqHvIU6u423ZL8HWnlnP/hk+PmFrtowDa05J3tnzSu2IYU/Bl88HmllB0fsH3
         TTzYgGddLCXxRBkPEGhEMCRvOf2r+Szby7pE8QB9hFkcvOgoBc89XXuHElnKwUHDDv5x
         tQwiJq7t2nGe3fh8ZsG72tN7sSIshpaJE41WbOuOPjc7fzuGxjN4mVGpSMHc1MiW4vEA
         EH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790249035; x=1790853835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VVZyQuOx10W8AoQP9MzIvUBAsru1Ry+CJZYSEvVQ+/k=;
        b=w5mSsUPeKWtI6zhwE4mxST4MqqoPbJUyV9j+1/kAVjpAKE6X8sF0dzsDuqndWW5GDE
         FmdeA+Q/71YOjO3K47itElEmAcQNI6s5apPe1/m0omykWs+9gDw/DZXfIV6WtTjOQf5J
         UyC/f+f7+g3JYV6BRuP3RPG+bZNdtZn9egULvXtVRKDdc0mPVYKV6TcTOC77BdaJ7fEB
         a4dG6wiRnS6nq5DpOoX+AEStGY/sGl8I6+iHXSoNRw7zpCb8ZXYAPmyGzVLyac4+hMaK
         VYaVT0w3TumE6l+n8pe7L0pqT5U/jWq3u5CDKAsf/t3w6Lwlzh9baMvPz4qLNdBKl/Jw
         qqCA==
X-Gm-Message-State: AFuF++no7H6fNrZedmNEQkoJtwPUrJ8WbW7dKo0ZEPu7cVLEsCOyoGpw
	pHrFuq56lPx/2lTF2fVb1iHSlf22bjjISQt1vnA2Mh+4ZX8A48jiEKbOXofWeZZmf5rSsg==
X-Gm-Gg: AYBFou1JxC79y/n6xN3DaqEX0SQDgqo7WdQGC52cKdJq9x089jC7uuT+BM0ZOIKKxGB
	/2PEycWXVlap9SNtWtVIQJTWoX6I60VPzF/ejDjWNmOp2G8AOteNNJ4x/8IhD50DFLBgRcdH4Fi
	U5uvwR1bzU3anK/3PFmcjukwzkqencD2Z7CfC5nl10jFiuElR/Ug6G1LiUkjcgTg2Z7Fhh+rPf/
	oKoFxKaLFkqlCapRS6RbD8A6y1aFEiDFoPu9ldfqAkgCSAe4j0rtxHls5Y12kYn9hBZU9ITR5IC
	BCwHDIANxa52krZzz8Wn19QYyThHrHGaGid48IMdCgbwrq1+621HkM2R9hNKiL1sxO8/QCS5Sg1
	msFNpBdWevpfbwVgh0BZcD54swgrS8Z0MieJzZAJYHPeHY6c2s1W+KQKAEzf9FFroG0odCCiSQ0
	1OKsWA6a7wA5y9jGyCRM2a1nYRv+x8EH+cOGqR8LnJdZ5mb0ACX4U/PQ==
X-Received: by 2002:a17:90b:1a82:b0:3a0:8050:2ecf with SMTP id 98e67ed59e1d1-3a098ac556cmr1232198a91.25.1790249035317;
        Thu, 24 Sep 2026 04:23:55 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0813318c1sm3586800a91.4.2026.09.24.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:23:54 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	jon.lin@rock-chips.com,
	bcm-kernel-feedback-list@broadcom.com,
	noltari@gmail.com,
	lgs201920130244@gmail.com
Subject: [PATCH 3/3] spi: bcm63xx-hsspi: Disable runtime PM on remove
Date: Thu, 24 Sep 2026 19:23:29 +0800
Message-ID: <20260924112329.1566051-4-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924112329.1566051-1-lgs201920130244@gmail.com>
References: <20260924112329.1566051-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcm63xx_hsspi_probe() enables runtime PM before creating the sysfs
 group, but bcm63xx_hsspi_remove() does not perform the matching
pm_runtime_disable() after a successful probe.

The probe error paths already disable runtime PM when sysfs group
creation or controller registration fails.

Add pm_runtime_disable() to the remove path after removing the sysfs
group to balance pm_runtime_enable() from bcm63xx_hsspi_probe().

Fixes: fb8695e3749e ("spi: bcm63xx-hsspi: fix pm_runtime")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 25f169a2a81d..80bf02bc324a 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -882,6 +882,7 @@ static void bcm63xx_hsspi_remove(struct platform_device *pdev)
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
+	pm_runtime_disable(&pdev->dev);
 }
 
 static int bcm63xx_hsspi_suspend(struct device *dev)
-- 
2.43.0

