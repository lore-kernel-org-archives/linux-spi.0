Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com [74.125.225.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3438E119
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956535; cv=none; b=fRoQ9Gt3CylGTwwq1rjze1rFr1g2Zdx7j6Gn8IWhfUqUuRuUHKQaMPJNzopcdvecVMatxmrPls/b+uDjA8/fnbqjFVlAZwO/TZUOUZFw5iWEBVpOPhZ7gethWdjRL/5c2oGVxuAIltqW+xr55c7BFVzavjCyV4HW3vMfyF5WX8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956535; c=relaxed/simple;
	bh=niryGSxJX4gME/6a0U2DNx8L2QBjbTB9EOlGt9+7IDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mx3qsGvmf6CMkT4mfbG/ckIoJvxuUWKi//dn0po4HaujKVXMDUd703uSV+rdtGh8AgvokQjqXKKkFztCdLp8/aLmk5zjXAvOmg3HzQx2pjdhsonFEaOnU8639uLS5qdyrrwnqvn5hsKcvOAUQBnSbZ4H3q+CuwjvoEZog+PNhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR0+ORMW; arc=none smtp.client-ip=74.125.225.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR0+ORMW"
Received: by mail-wr2-f33.google.com with SMTP id ffacd0b85a97d-48b104f6aa3so36205f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 02 Oct 2026 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790956532; x=1791561332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ctxUkXm5BOo7/5u4JOJklLBmiQwzEkLfsaEZ1PEQrs=;
        b=VR0+ORMWoI+Momzj9k23qVVJV4/eZqQ7rgkncf0RoOAr81IXaVNQxV3tDDejRMbkYE
         0XBf1FtNObzyfDNTTqx67snPaTVnsi7UxeIF7HV0yx93Moy/zlIzcjFtzgsizqxkKMhI
         ZPij4iwyLmsPYkhVNJtSChODRnOSPNUnSQHyWkA6nSWfuDSoCpgqcN2c5epul9KbD4Px
         MdG36ern7TXCamP0G3GUBIvvVDl4YS9k+/o+odg/SNbkeeKc7SAF+80+WBGaCGMCyBog
         VECqa9t+srLF3CqXzyRJzWwf+Xsx39wqgJpQrBrC+AawizLNVbYfecIc3CfPAKVRVqXh
         287g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790956532; x=1791561332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ctxUkXm5BOo7/5u4JOJklLBmiQwzEkLfsaEZ1PEQrs=;
        b=L8DpPJDO7m7egDnez7Y6N4RxpvRvnXEIBUeJq3n0eepfzRfBmkg49YxOh38uqdpUna
         lo7cNIVMaTmvZ+zAevanETCtL/6pQZ/hkrjOH5IqAW+WLekJnbM08Dkmtri4L919KpRp
         tOgDaSGiQV0k080q7cw0pkFY+MLktTiTkNt7xljzLRKlPtkODHBHBvCc5taRtKw6dIfX
         aPH3Zm78fbgrZWZ9Bea5iWjCZnlY5Xmw8Wqqg+k+Kl/8XBO8fG5O5i9mywtB1Usbhlyh
         2DddlE0Kg4ZNa6pyYbPnPPk6J7Xrfc/AyPPT4HaQZ64+EbUr+mGRad+guEpa6ohlU4kz
         lRBw==
X-Forwarded-Encrypted: i=1; AKwUvBwa5+XVGz7CxU+kOImK0Au1U9D1c3x7pyT+GxvqNviJyVg1JonqbEsesirrw3tla3XIl1t0ISc5nIA=@vger.kernel.org
X-Gm-Message-State: AFuF++lovslLUP9J6fVIIbL+vWHplqIP2R9HcjTKGFNbTCTMiQJBjsab
	9kLEOEZPxnV4utmOou7LNPtTpQvN9TZQKLWAQOTbFOMH9ATHnnKtx1Kt/ZK+91Xm
X-Gm-Gg: AYBFou1S6QikhdU2wWlzPPOfTMQKVWceCx/b6Vx/Np/E2FJ64M8FT/u91ILTtu1tKkX
	6liRDNLNkzpw7vdHIYyTF13r2erwJDV4NRBXFLH22Ky5Q6pUAGgTByxHbqJqe8vpq87znyiE8Kt
	pkuGdufOTwKZv1GB4epwAtAcw+G4QYmjEfqObRvBsVomzKptOVm+JQWTeFf1YZp+RipGo8FGzuc
	hA/xc0sjRk1yi00jzMRVUlZ9QIYRolhgqkTKc7dkfBjWAOalZa4DDlhotCVP7hRsW1lKQjciicZ
	DqcXdVBM+1klO4Ov6kHNaA1vzSkZGhOFxgK3ipdX7F2vXtRgYSItmwZLD0Oe2Im8AgbBkMRRfTy
	ECIcYO2CYEWLHB+5o4XknD/7sqhffKe2WNVFPhCjT2OJLQvK+Ow/OtGFeGScEPuyH5J708oplWU
	ohkkDidfeHp3NObDSAuGbc9I5YEzp8De+d05PDqHq19o9CCJtKzz/6FJXeoA0m97F3pmy3aSkoN
	j433DamFurUzoCslTW5xGMs1i3dEKHEyX1NvXS/zg==
X-Received: by 2002:a05:600c:1907:b0:4a0:3b9:f16b with SMTP id 5b1f17b1804b1-4a027459456mr60034955e9.0.1790956532121;
        Fri, 02 Oct 2026 08:55:32 -0700 (PDT)
Received: from localhost.localdomain ([182.189.185.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02854073csm81515965e9.3.2026.10.02.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:55:31 -0700 (PDT)
From: Saad Anjum <saadanjum239@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Saad Anjum <saadanjum239@gmail.com>
Subject: [PATCH v2] spi: bitbang: Drop duplicated word in file header comment
Date: Fri,  2 Oct 2026 20:55:27 +0500
Message-ID: <20261002155527.24845-1-saadanjum239@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8ee46db14169 ("spi: bitbang: Add missing MODULE_DESCRIPTION()")
updated the terminology in the file header from "SPI master controller"
to "SPI host controller", but only the word "master" was replaced, so the
header now says "controller" twice in a row.

Drop the duplicated "controller" so that the comment matches the wording
used by the Kconfig entry and the MODULE_DESCRIPTION() string.

No functional change.

Signed-off-by: Saad Anjum <saadanjum239@gmail.com>
---
v2: Resending with the correct From/Signed-off-by - v1 went out under the
wrong identity by mistake, sorry for the noise.

 drivers/spi/spi-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index fb288ed56..347265e80 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Polling/bitbanging SPI host controller controller driver utilities
+ * Polling/bitbanging SPI host controller driver utilities
  */
 
 #include <linux/spinlock.h>

base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
-- 
2.50.1 (Apple Git-155)

