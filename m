Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653AE3EE1FD
	for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068676; cv=none; b=i7lqRIQiSUk6wXxEUASYkdJxN6IyLp003JRL8acV/hQdyaQQfRbhFSGbZBC0Mym+AAr7KTWYGuOuiM3Nlga6uF5lIwV9sUjGvUEWoFzHqijHoSWV+/oe7pgaI5eufrUg2ZtBiVVPrKoKLlmhDWDV1tCzK8ar4A2qh1YaPT0GMZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068676; c=relaxed/simple;
	bh=eJuQsSbIUmzmtEu/bWG7mY3YrCPkTrW2FdqKlU4xov0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zh2rsO5Q1TjJjCJjMxahn8C6PTDglW6jlHg4B5YJA/qAIfEknbaAKgJ9otaY7aB7hI4Ltvbs0/EIXv+3nfETRDskGP8m7sAXlBRoOFZ/NWVnxVlX1Ylw0C3y821AjoFNyZ1gsygOySkjjbBU8INIck5wz0ls/2NX0jsCI+kFDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YceRmrtt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YceRmrtt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b941cd869cso91857415ad.1
        for <linux-spi@vger.kernel.org>; Fri, 29 May 2026 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780068675; x=1780673475; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYERa8QIjbZjdU1uU3reFCyVnxM6XxPLugpJZu6+mns=;
        b=YceRmrttvui+Eu57kOHxJd2SreSLak80u9GgTTR6y+6DKCMUNeFmrMxCqmLCIRcDgb
         eJUmohMcrki23B0RNa4piYUGbwepzoN37tMffCB20IHGmIBxCSZBPOKLI1Qfpjv7Z0Gq
         JNycat27CAOLHs1Ck5HY2ymPV0gMzyJrFRhdM08cC5iwG10+yb1mldA9V+Gx3SAf3jNa
         wmj8Lkv9aSG6Gt2LA65siF26dTOOHbCdwAKFn3WVuPMcYuTzmYoOwQOak3gfnBv3X69h
         5sgfdTmEXu2xC8tOyLy50ofNAjDkmVRuYRfLNWrdQbVj3VGaY4jXa3U0rxArsvt0qX73
         hSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068675; x=1780673475;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYERa8QIjbZjdU1uU3reFCyVnxM6XxPLugpJZu6+mns=;
        b=TY+X4iCdDZRiF84PJ25i54vq2DWYhbZyBZtttJefEXhKFeR5MpuaskdzrCAtw55ehx
         5NzS4czlA01AaVH+ln6rlOTt3lHK0rBQkwZlof2oflGqoKijcvZG3V0ACjV020LQ8XtH
         h2JhevXCsiR41GPBRXjuHXq9Bar53NM1kPi4sAzn8PcGECAmDQ0HOjfv5ZeiifmtcJox
         dGwaOd1OtyKDIUTGaKJHRZVkkxnmFpTW92tfSZGJ6pNVQS3eWeza592nMsGrTadHLD9Y
         /WEasRIf7KyvOeuFUnVLSg5Q41CUPKoQ7cJPrMg8kUc3gyd5t/ndlcmc/3piSxtSZEJQ
         Tdlw==
X-Gm-Message-State: AOJu0Yyi/mKEYOx84T89fdJbpYkIzFR519pdbkUo7b6DD47jXOI1FUog
	2GT1qbfuI2GzcEdSydbM7/tTTyy5HDyu2IaJ6QJSVUDDy8JHAYhYQP3I
X-Gm-Gg: Acq92OHyUPK/9Fd3vaNvxrK43c00Q1XEJDrN3FRSHJMYbHbxWiQ9/3p7dIuZjpzzwA5
	+92Ov9pWkgqCMXPmiFkBsBL0hxVZS83sahcIoRT7TzaWAe2i0uOo3Pw0vfzXmBEVJ5VRtfW0tTd
	nVMbZWbuwPvzNbUR6iTpIixFu6xcWjNeHad/+pJvPDayG4uo83AaO4hMYgBzeuODeLCnBvRVIJW
	LpTBVsA2jCqg7z2l48gFpXH3WWsL7SCJ0VUGKjwISbTwezfMK5Vi2LYqPAbwYWmWQbM6XdZEtER
	Twoh7dP2T8FB50btTwC1Z3OHAAljMU71BAex0AcKIBdSWHuEJ2bN+z2x7ngnunWqKWQzfGwZ/TU
	sYNU0vx0XVilYINAbdw6gnE7uQcioqCxXbA6gOaPklB3P3Zux9oIb/KGFm4VgYyEayahbhKF06r
	rBuXOflguPT662HE+zUsMoMf6MXqFwuPTh5AeBTSNsgzD2pxd2fhCkhhnPFKC7rGp/BGN7ycrbK
	CyN9jNO7KrjpZhXjzL8rFWd66aodZXvXc75COLgij8Yc1suGw==
X-Received: by 2002:a17:903:a8f:b0:2bf:2326:4aa with SMTP id d9443c01a7336-2bf3689aff4mr3848185ad.39.1780068674202;
        Fri, 29 May 2026 08:31:14 -0700 (PDT)
Received: from junjungu-PC.localdomain ([2408:820c:9009:6f32:859c:ace3:4713:668a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c1e46asm21733755ad.61.2026.05.29.08.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:31:13 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Fri, 29 May 2026 23:31:06 +0800
Subject: [PATCH] spi: ep93xx: fix double-free of zeropage on DMA setup
 failure
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-ep93xx-v1-1-9185070ca1fc@gmail.com>
X-B4-Tracking: v=1; b=H4sIADmxGWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3dQCS+OKCl2LxGRjA/PkJFMTYxMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0Au2TAqWoAAAA=
X-Change-ID: 20260529-ep93xx-8ac307cb5434
To: Mark Brown <broonie@kernel.org>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>, 
 Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vkoul@kernel.org>, 
 Mika Westerberg <mika.westerberg@iki.fi>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780068671; l=1032;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=eJuQsSbIUmzmtEu/bWG7mY3YrCPkTrW2FdqKlU4xov0=;
 b=E+z9n/r98/0Cetq7lo6d6TsUSFBvTw25QPkqELrgqCet0iS2GAl60qdar3YWeGqjViIu98y/v
 Ngk0AokBcg5Djl53UyalNbzPGxQYHE6OM3Kn1nnS23WaraSS2PlX71H
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

If DMA setup fails after allocating the zeropage, the error path frees
the page but leaves espi->zeropage dangling. A subsequent call to
ep93xx_spi_release_dma() sees the non-NULL pointer and frees the page
again.

Clear the pointer after freeing in the error path of
ep93xx_spi_setup_dma().

Fixes: 626a96db1169 ("spi/ep93xx: add DMA support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-ep93xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index ea610b0537a9..bf389d7590d3 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -600,6 +600,7 @@ static int ep93xx_spi_setup_dma(struct device *dev, struct ep93xx_spi *espi)
 	espi->dma_rx = NULL;
 fail_free_page:
 	free_page((unsigned long)espi->zeropage);
+	espi->zeropage = NULL;
 
 	return ret;
 }

---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260529-ep93xx-8ac307cb5434

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

