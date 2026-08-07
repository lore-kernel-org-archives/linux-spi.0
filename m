Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7842BEAF
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099149; cv=none; b=TD2R4Nlo5HL1C1M5OTtDCeWZsP+UYiEl9bF4/K9g21LFQJGRx7xNK8F3bz/NG5RTg41bMEwLm7KHeCw4kRslhnYZQsQRmhxzEMR8fEKQdZk3X80DK+QjbO1d0ArB734xkVI8TQrr4qUXnmic0hdOzMAbGQHP85Ss29AMfNhel7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099149; c=relaxed/simple;
	bh=N1STeXF3gIvX3FxBoq06brZY6ylGnfR9VHOV/+Bw0ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9/UUvLQfFAtoriDPpB/J7bJ46o+V2wKCOcVi3R7NKWEKsU9T0ln+NREqWs3Be5ylLcyr8We40xBxFdHcJ9S/+0/dTGfThysQ1oI2C/+qiY7sBfcee2rMpjpcZkOKKaZmNLt6Mrs8GjDoL8mVerZlPrb3bB7w7IT5UDDDzUPS9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoA2ecoa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoA2ecoa"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so3139043a91.0
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 03:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786099145; x=1786703945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=THE3ZPWZNV9KVTBiqYcB6B3/WjvgPYV/yxC+aR7o4nI=;
        b=GoA2ecoaRoklssdN9dlILA0gGJeDXk6iJD+4m5V9bV35w4meykLW2eqyhWQOwif6tD
         QypWTCUrwfM/I1hfFifGNLgDf6xHXD0zeDdVvLkmhpxXf7n+6DQVvSEF2R8ImUqe48YH
         UkUUkRwogcl3iO50gv9xK69R6w5vgrgqKH/h3di5ek3MsRudtvwyCMJymC9P/OCdWcES
         BhspLdh9KGBnXtty9wuITE1q3I9txbd8xpFXmU673BMgMU+wP3zWsAMsdBmCQFa+BURF
         e9GwFdvzhzhIye27o8V4XNl1pz6jnYkpnRKeAiaC5QL7sQlR+HBY2pJo3OixEAq69Hof
         0nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786099145; x=1786703945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=THE3ZPWZNV9KVTBiqYcB6B3/WjvgPYV/yxC+aR7o4nI=;
        b=giDDcZRQup9D29N3RqAdFULYH7zxSsknrvCRTiMTmkKOwLX/L1NqsFzj2KGYi+3CPf
         aCrsDCFByrzl5tEMAYiPGT5D7xA7OPgyV2e+aAj8g60WQHaXL8UciK5pj7Zd6jS4IUYU
         uhZtBmetjTQ6XHr+nc8tXvRM1oIPOaCkGXFZdP5iIdNZUQGc2W2XiaCrkc8101vKG6al
         q2jn99DU93ocrq0pHpUjir0x2amYRS5l2UczoeXUjlbMchSmw8+NZMpV7g9xgqdqzHhx
         GeRTiJBlxSeK9BmU2lGDUCYUr9ckDleDJmnkXp5Fna/uZOspTcfbtmiAH6L2ULwsbB5R
         KU+A==
X-Gm-Message-State: AOJu0Yyu3/LVGnVXPK/rlwnl1SvkuAIYvMpj/uHBDEMa030+MvHkc5vu
	8KqTt2Wh3Fsvd+5lJVsqPDTjMY/BVCO1lZyKgVQwHpLzcNMPseBRQp+R
X-Gm-Gg: AR+sD10czauW0fK6K9yPhPT96fd65PPTY11zyfs9rt1S9u0l+z9f3uJiE5vjU/hHZmv
	Ulqdt8KCK03AlxK7VSfg/+K5cmJak056tTgdmq6LEfl0PZVj14CsMIQV8hNu4Saf9L/+h+6PGvx
	OKUC/b66XA1ST2ZSHLeyHI+tCRxD4YquD5CRBOiI+WQ1M1POiDVjEV5JbKXD4JurZRZrFO08VN7
	afbQc0W1vgoqDkUT4hpVLe3MOdfX7d1z2XZcKE5KS68pSF9u7Yq08qmZn1iTc054chVyZh2vOCr
	ORTxQSBN8/ggj9KsRtyv6fBl33IRNGTAGTvFSC2ZK1zIcXQ3tsFg4lXgjB9og143yalDSMspVF3
	D2Poze9fjZ9kwLgRFOu9qDXfkFC8M5AmSQK5/Fb0q9xcMHflD7++8Qkz9EOg58W+oSm3NzENihU
	GJZdamt6434836reShG+2B23c34KL6alpEDH/9RSozA85tPbtnRRTLDqHnH6rH8UHxH6OxLbPyV
	2SAmhIgbMj2V6GvwxpYVuDDV6Evin+Yu4MFziyL/vP0WhjDdK01fp+NcMBYTPRjgk7MOhjARWpB
	gEIa
X-Received: by 2002:a17:90b:28d0:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-3903c57a0bbmr20936458a91.10.1786099144794;
        Fri, 07 Aug 2026 03:39:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dbf82csm4425865a91.1.2026.08.07.03.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:39:03 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Yang Shen <shenyang39@huawei.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH] spi: hisi-sfc-v3xx: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 17:38:47 +0700
Message-ID: <20260807103848.46315-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Instead of only checking for -EPROBE_DEFER, propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO, so that
failures are properly reported to the caller.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index d60db579b0fb..0790c7179868 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -454,8 +454,8 @@ static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
 		return PTR_ERR(host->regbase);
 
 	host->irq = platform_get_irq_optional(pdev, 0);
-	if (host->irq == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	if (host->irq < 0 && host->irq != -ENXIO)
+		return host->irq;
 
 	hisi_sfc_v3xx_disable_int(host);
 
-- 
2.43.0

