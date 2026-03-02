Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D7532861F
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451165; cv=none; b=kzN5xtPB+lZlL5Nj7LXuYXLAkpCsKr8Aa3Ha2W9KNT1nHSVJbXVf/UkzoT4LI5cxbj8jNyhmzqPoAMWg2lgaTRxHlYcDXGRCa3iqHeOJZrNPhFjOJ8ia4OLUfPcppqhyDeaa6t0+4M0P5KU6ipmIsgVFDCUziKwSdOCfJyYS61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451165; c=relaxed/simple;
	bh=xsXkTsqDybP01DU0M5+eSUTyxbeltoVBrnL25UXqDS8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMs+BhfRbMoAmyCDtHkWCfP4Q/T359EcKCXC7+1Z2GFyQJ8ZwdO0JYauGzGaibQ99lEICZNGnDWfUZmFXA4giSgnIIfx2mffoEUNLkt/5aDU5uEA508D7fzlQBFMOjA4d8RvcwNdHI6kTypcSgyFFaDQ+MeSS4ooW0FyXSJgltg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6Q+tVHO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6Q+tVHO"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-389f173b91fso71062211fa.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Mar 2026 03:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772451162; x=1773055962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ph0mJgB7HYIwW0nvueRiYt9vnVAPWkrPvs+Wvblhxfg=;
        b=D6Q+tVHOxFz7VvCzZ+W0a4aaKfrLjM9Wm8dKeigKHCksD2DxLJ8aP7M4uxISVvo2ZO
         nsBdyARcLSpbkUUCp35OsTpRZzZ6iUTOcCmagxu4zuRM4MwCSC/KqbsJIEcqLTyPMJ+e
         3OsP/GlgDj+rIwpkKaso2wcMS6S3febGCb+1A3J8hgC2kUddbeiX0dyDdugMTgTvkXr4
         jwtQUfT+Ja95WX8zd84BLtchTD8WRJ1M7xad77SjvvDilHS4vugfwCHK/syGm9TROr5L
         2k7QQ3ZGbUacZ1W8evlrDpn5CkhOAP4rES/Br/hvBtgsS10iElGptX8ANz720uRGRX8S
         7wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772451162; x=1773055962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph0mJgB7HYIwW0nvueRiYt9vnVAPWkrPvs+Wvblhxfg=;
        b=l+mdcP8QvD7Ve1fIDPDO9aEgLjhM8J39/YvVi+dHEdc0Ro6pbi23Y9QT1RhEmTIq4m
         eYOt5XdmEifTZ/KtQ9zLP1X4nWnmLnTwB07vD5VUhwvMka/LDfhB1gpaHH2ZI6H0CulG
         raObs1azht2TkDvGPLcHsSu2JOq/LDgBFN+b/LT9wpPx6jYefYHRiFY5jX9FYC0ahfKb
         j1opkUd74jG5QpH92jI2AwNXAXiTqESmTq8WG9MgJaZ/iOmBfF6rv/iz9k3snnn9k3dx
         1k0sZtqTOh3TvwUZdWGYEyPcRW6ZTcE0KrrXLc7F+TXCT3/u6SDCBNcTXF3+ENrkLcCv
         MAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcsoOnwcoM+A7tuci/34qKQWxT3OvE+hleWXDZR14UW+ZZHcUNxCGYrrS35sJQjxztSelLy6agmaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIS0uM1pTuniYmxddnU8KSTa1JPYaIt7mwwm63qtu62zUVpNI
	HoG+ESgTvzSpumEtrCSbMEKBnqctY4G4t/pex0vU/l2X0pvrEhXiYXQ2
X-Gm-Gg: ATEYQzy/XXUi6HbsBp+lj7sFbIeMe1bCoSlsdhEn3FM3dG7KihkYjSOwfDAcMvCgLMd
	FX6JS774C5Ktul+wYrCuJpzx5uSFCMSjzwMhwbmgTAkjVFWpNv+g4rSUU0IB8mqGYgfXrMVS3+s
	63hKWfC/j7TT7o5H8Xjhw5heIVdZkbPdowQ27I39xe2QvmdW2USTw/T7nUYyivr9I298r5DJ8WC
	oo99SQ2yrXfzflkC0kSAkU/NtPPGy5IMUTcvaRS+M8Z6dm7FAoKMY22nicTrXCB7rqltYVAOxo/
	boTDWftJyzbB+W9Mq+WkPbFpsBF4UhDpGGwMsQnOt/vOfGW0r8sYASvAdVt9IY1bW+Rhuq+/BPL
	CJt6B1VvZ/GUrP2Ok/9zoetADo4TGTfI+I+Ivp2k77UrxgTbZ0c5LElCWPgivDji90O5Kf0Ak6X
	BkAM8l5vy0Q6NofezDX1dwKvmb0Si8CYQ=
X-Received: by 2002:a2e:bd82:0:b0:385:d061:cde7 with SMTP id 38308e7fff4ca-389ff34cc4emr79196991fa.21.1772451161951;
        Mon, 02 Mar 2026 03:32:41 -0800 (PST)
Received: from vovchkir.localdomain ([95.161.223.42])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-389f2f70ceasm30101631fa.20.2026.03.02.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:32:41 -0800 (PST)
From: Vladimir Yakovlev <vovchkir@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Yakovlev <vovchkir@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-dw-dma: fix print error log when wait finish transaction
Date: Mon,  2 Mar 2026 14:32:33 +0300
Message-Id: <20260302113233.773414-1-vovchkir@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs, the device may not have a current message. In this
case, the system will crash.

In this case, it's better to use dev from the struct host.

Signed-off-by: Vladimir Yakovlev <vovchkir@gmail.com>
---
 drivers/spi/spi-dw-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index 65adec7c7524..d83466166abe 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -271,7 +271,7 @@ static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
 					 msecs_to_jiffies(ms));
 
 	if (ms == 0) {
-		dev_err(&dws->ctlr->cur_msg->spi->dev,
+		dev_err(&dws->host->dev,
 			"DMA transaction timed out\n");
 		return -ETIMEDOUT;
 	}
-- 
2.34.1

