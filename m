Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930083A9619
	for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850363; cv=none; b=Av+L0Y8PtD43lfxw++2tcsGNyHNb3aNBsI8fQDxl2vrC7zUAZTw/I4ZMUru181SDQEi+90DbrG16tjRy3/Z3W92I12viOgjzoBUkDPmUYmY7bzbrmIXji2fmSWb9xvs2CbpkPMWVPgZpyUTh/hZzoz7J2b+qvc4NowgDnP2v53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850363; c=relaxed/simple;
	bh=gxtbwk00JN/PpbmVaNve3h4kekX+gfljPtakahhIqrU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LM2B7RE8IH4cAQ5iN84r/DWzyvzo6YqaQJYQuWrcgXnGdtbM8jmCJIDCZhylx2b/aAQ9kfQFRZZjZk0m+8ledIFiCDE6Z3Uuk7hqoA8dC2PJXiRTQdv9QI5rY6CXLPfpqMlISq49GoUlymIPDCdRsudgJzreMj0eaTb7Ka7pH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6Tg/rGc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6Tg/rGc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b04d051664so37046805ad.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Mar 2026 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773850357; x=1774455157; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQDeqJU6NEFphf33Bp3TkZJhnynglBVU4wJcKRezCYs=;
        b=i6Tg/rGcO3Ll0F1PfwodP+82bCVviWA2u6ikACuyvbFOUFTftfqccTzg63qa6NN+V0
         3mJ3rP99jZnfF5YFhMzlcHfXEhQuCJykRdHx/PrmetqJmp6UhCqPRv6czGsnBsJshCnl
         C1wTe8YY4vthtKkcL1hIn3ie2IYdTcstAaPoJxJdSQn/C+mCMTSYUdWWgQqFGzu0eydg
         ZVRyu5Md99RIHll1N0TBIOPnU+1Zj9k+CCdy3hJILx6SynIYYGdJFIxt+lWV3oC0WWq4
         rNcgr6F3VttUlCwtll5j3FNzaOYMoWTFUeeah69tfKoPlOi8RaJhmw5JSZaUSb+545Nk
         L/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773850358; x=1774455158;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQDeqJU6NEFphf33Bp3TkZJhnynglBVU4wJcKRezCYs=;
        b=ZoSTb6n8os4nG90a/0hG96TH/uOFI3tdPybzy2n6mge78yupzhZXyurueJaw2wrOd3
         khhn0c2KyqjNA89czV/xo+2Se1IM+bav2CP9N+bGITq/UX97ZGQ2/CqbB4f4KDEZqbAd
         Gi76VIxOSJfT+hIRGOm2JPsrZPVSPG3z4sUl1hgA2Hi233ZzPt7TgNX6rHPRt3A1riut
         JcrHo/Po/U8auVb1K8y+wwmlhQyGFs8ckj1xNgybGE3M5K4NAOV6SYF93SwHvXXomkIg
         kIvSELubO+SV6F2/cHOy4pHznp/1Lvh950sZ+8th/fka7veMhIbL8bRBr37eJjBi9FSp
         /cqw==
X-Gm-Message-State: AOJu0Yzld2fom32G+j+6s7uA/wLRw3koY/quz5L+kJyoE2pXQMfshWcX
	NiwdBC+vJU86mV9OZDDjlhgf+izC8k1rM5K6QoOjmYdTFzIuzEO2OivIsSCrtA==
X-Gm-Gg: ATEYQzxXuUXBncE99X8+EF5VCHk5GBG81S1pitrevcdrby9TNdYWkmFjpvfEb9zTFOt
	Mwxg5AlJ78QivDertCgkcB7N7oRNkdyNSQchzj/ZwAC0w++15QfUH50S7zgTjO7lJY9A746Kmuy
	ZcjR/U1WA1yjl79ANV7qFM+QTgU7Juec6HLngiLhLQHCLGJTTF1uWi557YY8g/eulS67y3hzEtc
	AZW0MubtMWHpn1czv499siM4tPnEfv0E3enSzGKCcFZdAdO6j+U05KcO6cXFiJnhIpVi6ZuDqYy
	D1Ob8LWWL0o1J0X/3FJ6v0UwbGeZVUGUJjx3I0a6VZ1wyjQPGsnthTEymmWYrts8VKkfaoaQnV0
	VDipyZ1OR13I/e7iOpmWiv7eH6YUvLOzlx+KTuPO/dYDx1qHICUwne/mapkwKYbzTGPgJdXMAXB
	X41+U8SvfyUmEd6OuxbRrpleCnOMW6ZZrahGvW
X-Received: by 2002:a17:903:4b46:b0:2ae:a496:d66a with SMTP id d9443c01a7336-2b06e3d3c5cmr48785285ad.26.1773850357491;
        Wed, 18 Mar 2026 09:12:37 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e430864sm43040915ad.18.2026.03.18.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 09:12:37 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/2] spi: sn-f-ospi: two small fixes
Date: Thu, 19 Mar 2026 00:12:33 +0800
Message-Id: <20260319-sn-f-v1-0-33a6738d2da8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHOumkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ML3eI83TRdQ6O0VGMD42QTw+REJaDSgqLUtMwKsDHRsbW1AGNHt0B
 WAAAA
X-Change-ID: 20260318-sn-f-12fe303c41ca
To: Mark Brown <broonie@kernel.org>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773850356; l=469;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=gxtbwk00JN/PpbmVaNve3h4kekX+gfljPtakahhIqrU=;
 b=8cs9CPja+jibI+FfeEUEcw9Meu32rqyzoxFCIscry2n4ZHNSB7Ld5cYcxzqmws8TK4STsUT5x
 S826DrpmmNgB7qA1oEvMMNg29/JJA6iVEAe/pVlTD3D423e6ClS5aWd
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (2):
      spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
      spi: sn-f-ospi: Use devm_mutex_init() to simplify code

 drivers/spi/spi-sn-f-ospi.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)
---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260318-sn-f-12fe303c41ca

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

