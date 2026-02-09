Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9D30F927
	for <linux-spi@vger.kernel.org>; Mon,  9 Feb 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630605; cv=none; b=Tmn7s81zws2gJpExEHmcZjTULsP8HwDDFnIJNcsjvoBTGSRsZa6S3ldA6patErhvp5k1HXeB15td9nngsZlE4RpFHz3vBzovej0/puKSJ54qTQgcbSDfE6ToB3HwOyKQ2PVzmmsH0/9fuOdET409B0LcvAsSs4Tbg1XB2RPvfd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630605; c=relaxed/simple;
	bh=FKuGCI70l5OyuRPWKZHe/fQbeGoZhbYIYCioBwk5EQE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kFkJeP58Sm9dhiowBQoG1B6BjhOLYOkHmSSQXMDv+COABf3CQa4m5Iz3Q1rLMIACYqwxxOkFpuKnds0nVswPDCQVAz5YL/ke+JFpSlSrluFzpEKRl3zwLixbI3Znbeo9M02kmw6MrttZmJ5Depxyt1tzxmpx1s0EfrNLqTaX/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BfXAqkMk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BfXAqkMk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso42138855e9.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Feb 2026 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770630603; x=1771235403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0nR1XwmgwW/lra1bMoEkgIFa7LZKv7Hh/PRz7una/k=;
        b=BfXAqkMkhep3ZETxXCMBfSWs8yT35rueVkm5Znh+bLlClcC8jvCPgKaeTdsTdynq0a
         LRf6P2JMgW8CWaQAMCqoJfA3aU3LX/fTyg8Pbx7mC9sy6vlJB578FYhWU3lCIfv8Ni5w
         o43IAx/hU/LIBEpULlzpZx3cu5K2JGl/so5jmUq0U2Gy7KZs24mPt4iMDmM6yY/lFEwn
         mdIhMOxbqc89jnQHoEJmtPnIk+Gc+6qV7R7Puvguc5Q43kG0kojXbsZYNAjJv6iS8bwm
         RaB6FXq+OMZXWz3Mr3x8PFpfwMuWH6KgwEwUuUUfDhln86iNYKVvdPNdDJ6eqhpc6kQC
         Bj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630603; x=1771235403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0nR1XwmgwW/lra1bMoEkgIFa7LZKv7Hh/PRz7una/k=;
        b=oUScSvkmv2DYnjr3DfRX1196BX5aDUax+1SRhvRC5tRDnEqa5i+Px9X2PfWCiZ54se
         PJjtgWi1Ed3+6B7cm/Tly+6gjV5Q+9AIq6uosJccbozVT60O+SqfxGkGv5qZ+2tb6Gbo
         qKxBVPAt4QYboSxbzF36rKCKsF3/2i8NMPvVGRDYQdBNEODDb9r/ec7fCFw1IbzhGDvl
         Rt1B7EGUIQ6ZrrXYnB7SdfOV6mwmPNpIQQ9Vk8Gl7HfGgzjX1n/KazouemNMy+XWo7bH
         I/hZlBK0KK/BVq8nzz5VzRuXv7H+FJaLXg+OFGFXoJqmEWlgngPvlgjcus7YrEwK6wp3
         C32w==
X-Forwarded-Encrypted: i=1; AJvYcCUqBp2vaX+fjoqqNbNMIwXa+8inAfL3PuFEsUYdhRWtNXtwOgSFUpVZ2p+3T+xkldMbfIrjbi5L/Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyisYz5ONbvKqedY0YF43renhzAUUuzmNOlXlPxnMW2UZhngSRu
	3/ug71K/RfddP5XnkyK+qbC5mQT8u576qkHSjOkJiSWyk8g+RqhKjSFjfxdAeeeg7L8=
X-Gm-Gg: AZuq6aIKJO6VnyzdV2Q92bz/61iqWBIH8D721/o+v27pwvgUT+5qRfaMZhXsUMukDja
	wT/a6JrJt4AT6JWdrs7+Zu5thQSHUdT6FZR+mGR0N6QP7aA3p0rYMEZPR8xSouc40GEgeHH5BgP
	oBamPlslEiVenhVuYESFzQJDmnHYHkgdtV1iqifaodiv+CJDAF6IKywpt0G0YqThKvqTfbR6ECR
	mJEetAczB+zceCJ1/kWq91d7V3d7feCNL1Fnq1psSoC3Zml4Yko8on5M5M1Qr3BUrwBKqIOqF91
	EFoNfeUTUOdq1Nyiu69EAEk61NYIUz/4HqjbUNtYXJadaleuQHp4aahLsGa+eNA+mqQZd85W/da
	Z0BDjirEWR3N1K1iDFuAqQrtzFNCX2lRO49B6SQrEG4U14YQPXg1+XHs9EEfDiEizdJkIfJydFK
	cE
X-Received: by 2002:a05:600c:3b03:b0:477:93f7:bbc5 with SMTP id 5b1f17b1804b1-483201e496dmr164726095e9.10.1770630603429;
        Mon, 09 Feb 2026 01:50:03 -0800 (PST)
Received: from localhost ([151.57.91.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961701sm166117755e9.5.2026.02.09.01.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:50:03 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: tools: Add include folder to .gitignore
Date: Mon,  9 Feb 2026 10:50:01 +0100
Message-Id: <20260209095001.556495-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=flavra@baylibre.com; h=from:subject; bh=FKuGCI70l5OyuRPWKZHe/fQbeGoZhbYIYCioBwk5EQE=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpia2UV0WJ6jwE9DTobvVNETH7xE5TLiVePn74M /UQtkK+AceJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaYmtlAAKCRDt8TtzzpQ2 XwzRC/9Oj4DMGW/nAoGtJEhigXUl58mVaC6Ae9TrYPnwoRn7e7XtAPqeXb2mdTCFWeAej2HVxnQ Wnw7U6g2iTq+Vclk+Q0V6nsBQtViIJ0e+Bf5GcVUMXYGlo/5NzkKqq/LuWIoiSRItkuALVS+3Ne +p6GJEkxZEeoSp4MZ2YTl1z0aanXC96dOMSVijC/dQIOEAwVar1Ta9ioKp805NiiDxp+nbJNFqm f/sXymCjspml1BqWOwYprp4gqCQ1IcGVxKwwgDWL+G71fZYYZU3P6faatTJLK2uIFYlkZFz18Eu FkLaCWy8R3MkHYp9wlnWGJ9wdyjCY1dgLjiNPbUyQt4HjU1Jm96YmfOeW1XjCzVyFrJhcIzt+vB eMYI3h/AeVn5VKeikyGEz/xVqzcWNiYvOGqKx5VPMWSayNW8vPXZ+Iy8XCRDNlVo+7cPkisv+3q d7xcUXek1s0RwE0Zch7jOcgB6Vx2BnLo1E8rnJTZm/duqGwE1C+opXafp7knRo50bHY+E=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The Makefile for the SPI tools creates an include/linux/spi folder and some
symlinks inside it. After running `make -C spi/tools`, this folder shows up
as untracked in the git status.
Add the above folder to the .gitignore file.

Fixes: f325b73dc4db ("spi: tools: move to tools buildsystem")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 tools/spi/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/spi/.gitignore b/tools/spi/.gitignore
index 14ddba3d2195..038261b34ed8 100644
--- a/tools/spi/.gitignore
+++ b/tools/spi/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 spidev_fdx
 spidev_test
+include/
-- 
2.39.5

