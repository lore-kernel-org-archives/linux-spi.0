Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D39F3859CE
	for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777109428; cv=none; b=C+2H/7y7SAaKZNsCZpR4wlFmsR4llfDlStkBdk4USHVsSjo+5PRko9zKWypGkqYypCzcYf0clNn/BZvaCGHmdNsdEVbkZaVZaVRd/DIYM06ycH2LtC+r64rZ5ooflri/UeecuysaLSP/Uez8XOdW80dA0phB15EHGwyzY5Ho1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777109428; c=relaxed/simple;
	bh=FESLfCoxU9M/CkHD+IrL0BjuHbYP5gH9OqdMVYJHqjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPWIOHJzLv4PThaKX3m6l7YUuk2NvQaIPm3Tz2FK9CGX241ojU8+F83WnOiuITdxON8RD+YPkvGzzyojXsRtKadJl+/bA6tHUQFz4g5VEVyR5oLCtEfZWUqGLEdniV4VwN+C+H4mqA+cBwPbomPuw0/skoEPqF6g4NbXPqU4Xdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSRiB2VI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSRiB2VI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso67931435e9.2
        for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777109425; x=1777714225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFcunWIpYnqUnWj/RVVTZn+6mdgY5gobPpPfEuSRWIU=;
        b=ZSRiB2VI3I59sfZPAWHqqPp+aR8clSDYJCeshVIavbL1674kcXqLieagMrQQdD+ADb
         HrpNP196JrNZZLPPja1lFiukfUxxICQOmQYmEgGiRjxbSjp2CC9prmNUdHP8egVla+Ql
         ufeIwvbeFIK2nyZrSKHqpJOjrjUGC7LJgYGe3MhyKgZwlXGwHlXngKS9xzF13/n6dVJI
         DFxEbK/adzuzGYdRdSKx7/kb/4TvZ2j8XSardFaBjJ9c9FVv5f+dAAgOuwCN5V7q4nwP
         bgQ51FJrBA9HO12p8XYk7D1AVIJpFXQQqCS+X4By6SajFEBsEpiTfdhSFTthSLDE9SPD
         k3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777109425; x=1777714225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFcunWIpYnqUnWj/RVVTZn+6mdgY5gobPpPfEuSRWIU=;
        b=KLEGy8kNdu+FK1xXPOFz6DSJE/f5zbEFGFcRMdq662Pcpsese4U29O4Sq4zcSlolBW
         8m5fQuXxxqVcD/br6vShB9yzFhn7qFTb31tMJjW4DZZLJGTGyGn60MhDcevVgaOrG5T/
         Hfx8lxfbHQ2dzpFPMhGCYvps7p7ySV8lP/AYghKGwJzwOLPk/Ow5S4bpeE5lHACSGbzX
         nvn5DEtBMvce/eGgbr5ptzxLJUmgw3CtweEFF7HUQ+fgqYG45GmlpPMT6OS+AbJDRLSa
         boqJBxN7kFt1OSa1xRzaz8Jx/IbNhD1wFoFywqZqBc6T9lCm1A+aRtM8GNhZF20nKuBm
         MKWQ==
X-Forwarded-Encrypted: i=1; AFNElJ98qhF11psd03laApkxw/qxlbtRQI1TAS8iLORUyzOUSG0pyxANp+tMs7k9VWFgSqmXlO7RvmZMfDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6MUio1bTQ+h9ZmVN9gxYyoYj3nGCM7EJzzfwtzr2dyoiVt7t
	oDz5wJz2GLk950U29SevqrNUVtJPWjSJCRDkuO5hkXx+K4sGH5armK2m
X-Gm-Gg: AeBDietLEpik1C+RsTiScjXPTli1M9qrZvAJU+dCgSE6S9fzeg3WUvvuKZfMA+m+ele
	tICr1OV+GqV+efF7ulDVCT1YrHITSVhtgQuWneWmFLppE4Dpv1VPDiJ1CUGhkidXzUZ3qfqnDoT
	eJCxdCDhWDV68BoEv5aEBLfNmOjX7auAMfLVNQ+qE2BFBuX1n8ds/YYBCoplSBEapoEKNsLmtVR
	qesY9tubR4bJWCx9/u4FPffe8kY3u8Bn52UwAfrplWg+FSmAB6Fa1tK0d2LCSZH7kFdZLN+d2W9
	NAF4akVLyxgPNYz+RjrqT1INB42e+Keo6TP8lBnX3V9aDOvsvc+e5Sgss2q9ekWEOu9ZvbGGoFO
	Wl+NBFJ5QPL6f7hql27B0t/OMs9sbQAc+uMLjMu8y/jU+37u6M2lvkEN9vaPaKnH2RqbtwbbSL5
	rH9++2CJzBhwhQtHK401XAivVwYklRtzwMwOmCXQCxLcFVNLbIQfAiqs3kDgZD9wxnXO0xLmUFL
	sYl
X-Received: by 2002:a05:600c:858c:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48a55d87a58mr238596535e9.9.1777109424887;
        Sat, 25 Apr 2026 02:30:24 -0700 (PDT)
Received: from localhost.localdomain (ns31537009.ip-141-94-163.eu. [141.94.163.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7b2716sm204422615e9.30.2026.04.25.02.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 02:30:23 -0700 (PDT)
From: John Madieu <john.madieu@gmail.com>
To: broonie@kernel.org,
	heiko@sntech.de
Cc: jon.lin@rock-chips.com,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu@gmail.com>
Subject: [PATCH 2/3] spi: rockchip: Drop unused and broken CR0 macros
Date: Sat, 25 Apr 2026 09:29:35 +0000
Message-Id: <20260425092936.2590132-3-john.madieu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260425092936.2590132-1-john.madieu@gmail.com>
References: <20260425092936.2590132-1-john.madieu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two CTRLR0 macros are defined but never referenced, and both are wrong:

 - CR0_XFM_MASK shifts by SPI_XFM_OFFSET, which does not exist anywhere
   in the tree. The intended symbol is CR0_XFM_OFFSET.

 - CR0_MTM_OFFSET is defined as 0x21, i.e. bit 33 of a 32-bit register.
   The value is meaningless and the macro is unused.

Drop both. They can be re-introduced correctly when an actual user
appears.

Signed-off-by: John Madieu <john.madieu@gmail.com>
---
 drivers/spi/spi-rockchip.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index de39f5da62cb..231fbcf0e7aa 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -98,7 +98,6 @@
 #define CR0_FRF_MICROWIRE			0x2
 
 #define CR0_XFM_OFFSET				18
-#define CR0_XFM_MASK				(0x03 << SPI_XFM_OFFSET)
 #define CR0_XFM_TR					0x0
 #define CR0_XFM_TO					0x1
 #define CR0_XFM_RO					0x2
@@ -109,8 +108,6 @@
 
 #define CR0_SOI_OFFSET				23
 
-#define CR0_MTM_OFFSET				0x21
-
 /* Bit fields in SER, 2bit */
 #define SER_MASK					0x3
 
-- 
2.25.1

