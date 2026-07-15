Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FAD3043C8
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154265; cv=none; b=mIyLZNFFboARFNApijTpzUl8wtWb6lhQuNDEpnUARzVlZJ+mWHL5y7AwbNOtPCAjwoPBRnyk8JnVwZ88WNHiDUnqpeJn5EqaOUczEP8jFiwyLzOVrdIOhfszmpvGrJ6ralYxEMeRsuyJ7qltqilflTFEjxwSeOcxkM7vjY607t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154265; c=relaxed/simple;
	bh=Ip/gKaWJDHAQ+Wj/ibCwEE3Yka0aQtJhK5+FRBTsqAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOGVO8NKltXEoWV5x7xdMnmWn9tgF+cMTaoAusjiBLDzxLK7WgmvnFrNrSV837kVVBaDr2rWniOT2IhaWuOd9bmWOKdWQXjfK83pXQpRhLyAorxS6tCeBr3hXXDZ9bRh222HR/8V5PCNXrdmNwbda4/U+VcQuZ8Lez+JPpK/+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/nU71cy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/nU71cy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493f45e206dso8056535e9.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154262; x=1784759062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=umdkm3mAjK+or4n9mFBOvv4Zvgm6kjr4TZjVIiAsBmE=;
        b=c/nU71cyZuljTkRYFtk+jMaF0PoQsvLCtnzpiT91RRg7rtl8IBWZnxj89CdCJl1eRl
         IOWoXtveTITmbf+ZtB80JZ1A0FVEGCMTAPaQZckw8kQAbX8ZFZ/myohRmShF4s1nTLPC
         1sUWONAE7PuGusfSWLv1udr0EJqcyoDgLqmbNJ3NTBVCZwcFEMV6bKmuS0ppWhk6f9lx
         EPkITkzoU3Hh9rqr45jRXZ/fZ2iGgynoLvA7tloGl6P4bmnkHuYvXs7nbdudc987TJd4
         dt9NYGEvwrfUEFmJyJCy2JEpFgo5sPNUdOOUmF6LJZ6VyesZgtCJCkojbDL9WuTWfXiL
         N7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154262; x=1784759062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=umdkm3mAjK+or4n9mFBOvv4Zvgm6kjr4TZjVIiAsBmE=;
        b=TTL8LUr/s704h/DwZ30jVuuCCGyM7oOLRN4jVt8nnzIKoM2n7mhs79Dwb6IKEfgAx8
         vFjQ7g+6nmLYnrHChnD61UBVK3ATUKbI9qIX2Hj1tZefyA/tlQrHirSw2/rVnGvIpBZt
         GL+JeFccuLS+USAF7sg957RrmDJx23JO2nmZ4rdfL25E6xenCDf+PL50TJatb5Kjpl+E
         dAOSfWoDhTHkhRMVMoex5kt969H3lLrWPeVuEb5T7yvU9lv96vu1GfCRROeDq39ylmqH
         EmI8lL5Ha5kcea8BES3nGv/ch9TxbmesAmqc0MeL791+Qs251AnnaFanJeqDhnWaVZzb
         9d4A==
X-Forwarded-Encrypted: i=1; AHgh+RrTqTMtSabI22uxe+y3W/mSCbG3fuVpmrlynoZPYgN/SXf5ppT0WYpeSID7/zomVtUCTFdctAFIg4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0lo36D4sv0rSn6epXLlKICRXrHGffD2LzDRG7f5FTHdKB7XA
	VtNMhXOnOantD2gMRvfiFRZivDTvfmIVzfQsMp9olaSHU9KRpYvd/D6C
X-Gm-Gg: AfdE7cnsD5fhwQ1tsmq+dL1egonpYXcStl9fzCNl6zp7CnJQJRODvtp4k1zX1kbtpvN
	nPxRGMr/gIcWrFFDQtMPMbex1fNVOgG85m40/DUHholirXsTzoq/pE1U6/2DmJRdQf8YaB2RVUQ
	B4b/7XIKE/u+N8BUwh9qrX9ZJVrGet8gW2+1284iARz7axXv5GD3PGdlBYaTz9M/kM7/O1w83rh
	6XJnbcNh6cny/ArEs9Kcgdnpfgv0i2gzR3CBTeLOgFbsqWOeM928S0x643CpXiQJ46crJZ5SHSm
	DibkJOXh8MddTPapRJKd7o8lqUGnni2KQquIsonoWWCIQHz8ckflhSQY1ZCs3ufErQbQcXfN6gX
	33Vxgr4CuDlK+A+5Je1Xkap2g5ypZl1AVHOFNIQ150X88SSc/3w2pAJq1xxaXlm3kHmcAIpDFn8
	IMfmD4EoU8yien/EgaF+ny18sAttTImCc+3HbNzW6UvyNqWQYU0GlphUWspd0suHA4uhCKQMo0i
	tbF4Es3TVKr2eaM
X-Received: by 2002:a05:600c:21d7:b0:493:eec0:69dc with SMTP id 5b1f17b1804b1-49540f0605fmr7434825e9.17.1784154262093;
        Wed, 15 Jul 2026 15:24:22 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:21 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/7] memory: renesas-rpc-if: Optimize transfer overhead and implement runtime PM autosuspend
Date: Wed, 15 Jul 2026 23:24:10 +0100
Message-ID: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series optimizes the Renesas RPC-IF driver by significantly
reducing software overhead in both the direct memory-mapped (dirmap) and
manual transfer paths, maximizing transaction throughput, and introducing
runtime PM autosuspend to prevent aggressive power gating during
consecutive flash operations.

---
Performance Results:

These changes were benchmarked using flash_speed on the RZ/T2H EVK with 
xSPI0/1 interfaces operating in 1S-1S-1S mode for write operations:

xSPI0(MX25LW51245G):
                 Without        With Fixes
  Write Speed:  806 KiB/s       942 KiB/s
  Read Speed:   5333 KiB/s      5361 KiB/s

xSPI1(AT25SF128A):
  Write Speed:  467 KiB/s       501 KiB/s
  Read Speed:   17964 KiB/s     18285 KiB/s


Note:
- Patches have been rebased on top of next-20260714.
- Ive kept patches 6 and 7 separate as they belong
  to different subsystems (SPI and memory) and may
  be applied independently.

Cheers,
Prabhakar

Lad Prabhakar (7):
  memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
  memory: renesas-rpc-if: Move static bridge configurations out of
    dirmap hot paths
  memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in write path
  memory: renesas-rpc-if: Consolidate XSPI_CDTBUF0 updates in read path
  memory: renesas-rpc-if: Consolidate command setup register programming
  spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay
  memory: renesas-rpc-if: Use runtime PM autosuspend after transfers

 drivers/memory/renesas-rpc-if.c | 87 ++++++++++++++-------------------
 drivers/spi/spi-rpc-if.c        |  4 ++
 2 files changed, 40 insertions(+), 51 deletions(-)

-- 
2.54.0

