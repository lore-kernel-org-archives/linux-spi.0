Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70C3C6A58
	for <linux-spi@vger.kernel.org>; Thu,  5 Mar 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725108; cv=none; b=Ku3hrOFA1swfMlUqPC0am17tDOsrJa6JZWlpnU100qmpR6c5/V+EM1tC61j0jXy2ieiorZ0mrhrnqTap5zDPGsZ1ggWl5tvipwMVNdSyLvwEWhS1mPklj1/ZQ7+7rCdPvmqD0+7P91ZpWMh/im1Fq6Zfi68FNYccMigI0nLWWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725108; c=relaxed/simple;
	bh=abxR5oIsLcrkxbLIHiQZCFRJOUOd6Ae6V6Vg+uXUVjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t7Aqn16wsE23CQRtmQRRkHwbI1N2MY9FAm4fegr/L1pdup8AdI+ShZ8avqesa+hoqfTNnpsTQj4UTyBMlFmsVU5hsTF0AYm9ToyhlOGIIJTKnt5FVCIs+MUeZ9voEJ/y3RoJ9EoF3xHrUqbCrOG+VUrajKzfy5EfCfKjDekNHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVZsJPdv; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVZsJPdv"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-829928e512aso212778b3a.2
        for <linux-spi@vger.kernel.org>; Thu, 05 Mar 2026 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772725106; x=1773329906; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+rLnJ3aJ6D+F+fZbg2d06YcvZPxOEiVrOGPvy9ur+c=;
        b=VVZsJPdvLD+Jx9w8Ige3ZD5hPTpvk2BQCGeyre0uAzOB2M6gKi7b8UR+/LwZLQNoUu
         EyWxJs8P2nOZ3Otr/G4iX/SX9LJ49qg6EYPJTYCwJO+b8PCO/U5AX/mqVdVyPrK38xTK
         Zshaekd4NJy5yLTZGCCllSX8UjIwu+JbEHSLgWoTcnC5j5ovrY7SDvnw9tvWldfYYfAv
         OomItYMibF3dgpesiIHExOYJWpnuwMra4PMG3Hk+gxMG0as3U/xYf4c4RteY6mbKEjOX
         JMF0nvpmf2RMAh6CJV6fsp9wm5t3tn8dmH12yLlyql+5u9ylTQWNBTk7TYwTgX6Mon6h
         i7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772725106; x=1773329906;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+rLnJ3aJ6D+F+fZbg2d06YcvZPxOEiVrOGPvy9ur+c=;
        b=KFMsiQNEB/mPSrAUz2i73epO4RLFN1K4/LDp86XrHqlSxf4uTf6VIG+cfRw98ftpBQ
         Y/EDGE/IoowyhJz2SD9+bEHGEkRaAMPUzd4CzCU+1ArVNDwlH+WOklgUq4QH0nQ2DGUB
         hTW7nJU+MDChSwaT6F72PnwKoSjIhOd0vi2Va3zWK3panLQxkwl+g97IIBva0m9HbCI8
         mT4C1ZGqKQNxtw2Y8IzjtVyZdg0/qtNfOoPIGerg9QQfeUzWsGMZ6xzAcMdeYtvvHUwY
         8Ry67otxQtElZ2/eWIx+6bI1PrzfhR68IMzhFV9gZjeZysLEofi/bNWRL6WWxe1nedE1
         C7+g==
X-Gm-Message-State: AOJu0YxtjXDe1RqRlBc9NuShpEZx+9iWRkKGHtp0H7ifZEX1Gw2UrlMw
	wGm2fB0LfVxhlikDok/LOwu2SxsKlatzAEEXNyYDNFPpbX3bAmHyXNnS
X-Gm-Gg: ATEYQzzilG8if4Qy9fqbFFeSQX2LyLAhVpRXukY5oA1gjUsSupoThbvbRsrJoOXjQvh
	JzhZBg3xw6bVTVVIBG5+kiDc13NFccpe7gK7qXwEYlJqnziQQVA9ARv8/kCJGZxoaSPOEz9gEKg
	i4g5tSzDnH3nFlgvw5i+STMi/6vwd+WyJJco30MmeG8lcRmjOS0xV9CqeOJUVzTejBfPVrKcF1P
	bEa7u1JQP3pRTrsYbOymJDYbW5Q2LXgeIfHBnMttHOLp7HYNEYB+VZKt826iQYhUpsuBAPzs2VT
	zaTx4SJ7ujWOVmmj99fjAnmjrPfQ184I9XvP3+6rr/85dp0HJraP/qxvjNUuNzgSoAvdHuVtjUG
	gQT4Eq/EHRBoWZUhGvCTiZ5rvEN+WO1aK+wzyt5ZR2EAPZyD7KXG8/NERTjxeY/fksIS1p5gsX8
	iKOM+PbDG9Ua7mLLFaUA==
X-Received: by 2002:a05:6a00:3d4a:b0:821:7d7e:41d5 with SMTP id d2e1a72fcca58-82972cce807mr5929465b3a.52.1772725105728;
        Thu, 05 Mar 2026 07:38:25 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2::3a87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8297d3d6aedsm3376850b3a.31.2026.03.05.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 07:38:25 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 05 Mar 2026 23:38:21 +0800
Subject: [PATCH] spi: rockchip-sfc: Remove redundant
 spi_unregister_controller() call
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-sfc-v1-1-6fbf6df0e899@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGyjqWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNT3eK0ZF1jA3NzA4tUy5RkM3MloMqCotS0zAqwKdGxtbUAik9DnlU
 AAAA=
X-Change-ID: 20260305-sfc-307708e9dc67
To: Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Jon Lin <jon.lin@rock-chips.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772725103; l=1268;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=abxR5oIsLcrkxbLIHiQZCFRJOUOd6Ae6V6Vg+uXUVjY=;
 b=J6tc/xqw+Xy5g7gTlKOpBVM1cXwg5atz100uVzTGIdf5HIjfSEWQs+6wpbxq6GRY/zxwHcmAr
 vgb60XU41OnC3/BsuE0mAYuLmktzO9OE35d06KPi0QWgA3YedwXJ0WS
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver uses devm_spi_register_controller() for registration, which
automatically unregisters the controller via devm cleanup when the
device is removed.

The manual call to spi_unregister_controller() in the remove() callback
is therefore redundant and should be removed.

Fixes: 8011709906d0 ("spi: rockchip-sfc: Support pm ops")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-rockchip-sfc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 2990bf85ee47..19e832f045d2 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -740,9 +740,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 static void rockchip_sfc_remove(struct platform_device *pdev)
 {
 	struct rockchip_sfc *sfc = platform_get_drvdata(pdev);
-	struct spi_controller *host = sfc->host;
 
-	spi_unregister_controller(host);
 	dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
 			 DMA_BIDIRECTIONAL);
 	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));

---
base-commit: 3f9cd19e764b782706dbaacc69e502099cb014ba
change-id: 20260305-sfc-307708e9dc67

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

