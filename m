Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E729D264
	for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050544; cv=none; b=GEsrtRzbgjJlwVwMxaERgGUyCSi04fjoQR50jeXCGL7jigmU8zfaikuKr1pymfQlqdOuRRz6ObhdIFRwOJJwbkerlyZms4r0Ge7S+KdfkBm0zUc9Jpu07jXFBnWFJQdXZLdoNVkDCrq4azrh8s4vQ2+aFm5yWhCsEdujtYz7oag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050544; c=relaxed/simple;
	bh=DNC6Q9R6tFKQWo6Vyk42M9qQGGwCkIPajaqmxo8sjmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i8jKuT1G4PTwSenSk5SwygupO5YqgPd1az6xfZHkkst+ZEUp22+Vniw0e3447IZTj3htwZiFkN+8ZjeeCL9Cc537Dy1bXEJkdgIPhf2tG4wnHjNHmbU1LI7koZ/2nsi1o0xeec7xTk7D420h9v6xrstqt+yn1cOE0xFOKQI6Dno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuYG/w11; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuYG/w11"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1284783a12.3
        for <linux-spi@vger.kernel.org>; Sun, 26 Jul 2026 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050543; x=1785655343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7I2i4OrtuamUjaD5MYy4r8wCU1Supcz4UPlETqL+tw=;
        b=HuYG/w11S6ohag69SPuGVU3/kOTCM/5v/MPkEgDrSZdW13t4aXyq2IZdKOoWyrJboS
         /gflIHo2F/WyjwHUlLo2dS5uRSB1UhC2JLuOqZJHxHa37awKp6chfyiezu+Uc6FBuA64
         OjUDPAji8rJSdKlAjYmc4jBNV4PdVBG3HFWG/WXEOYizw+LdTXgXdvNa35Wsw9gh4r5s
         1Al3Q7a3YhYu+MaUDHueC+KpXhsXE25/Qztev8KC6JmwEu8F+rFVdP1zQsllVv9r8cR6
         MkjsaK9oR9cgDsvJCNUJd9pT3lRbsuB/z8vRyWLXnn33XH+Vy30r537U+2083DUBXRGj
         g8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050543; x=1785655343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7I2i4OrtuamUjaD5MYy4r8wCU1Supcz4UPlETqL+tw=;
        b=V1bN/sFxnQ4w/fijef0V0hExZKad+qbAtHj5LV0RCZ+lM5OtWp+hHXARYE2g7B14bv
         qnOKcaKnerdoHjxpHD3QtF6kzazYT1Ak0zGQiCCxHI50wO+cWtOyeuz/XNzgtnS2rcVc
         AAm9OjZwThq7l3DYQzKNfM94eXzT5HhrYB7XtEYuFMNQPMWqain5d5JhK7IGNRz/+E0V
         XbxQmWeDAnKJCS9otn2dXHF9CVi/3ojQ8Tr4FIedRxjbwknjrImTNege5SNDDse8lTdD
         QJVLyauLlSt+8qEGUTcVk0rNndIk1DOVctqvT2agvR85iVO6ev4TEFp486lM8iyO/3fD
         9KJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJ4f8Q7cY24SaZw26kfke6hsPX+nBenP8xAbDjXGyHKomnEMtsdqOkicO1svY8y4E5oUnnWab0U2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMStOkLEWzru0+/m+CyfPWi9eAySFVEL7EM9yPFPM9j9wO5qRh
	XDlrFE3hNDWeBEuDgi/fzgtgsoF7uKoAvqDaePxBYiFb5SxPwJJkiuYw
X-Gm-Gg: AR+sD12beT8J6x45w3u4RvbSAqRBiDppiPhM/MQbTRDzwNnpva5Jr6XSOQCW5tksUwc
	NURjafzBjmdvDIcVpaNYhUbgOs5SJCSchm89/h+zDWnngxehio6PEQOI+2GJK2Jg42JMl9yjR0G
	EZhDgVLWco3D5FWg1cJsvP58SA7tu4kKFqPo3Q08PcB++7Xh+mtvwCHUOm1smT/LpDjjfGs/Oz1
	2rx+GyAXpe4d9IEtpjyGu4U9Okk5F7JFfnbY0tKplP41n9DV7f2Qz66vAf1g1vU3HkgHaRxjR44
	Qn4lhHWvJl4zpgMa7rvVnxKwnYsYs0GehbYb0g8ymcc4QCdRsWWAjR6ePQ7I7nUdftwfE5cLs1+
	2LTV9hXSKWTS3Fmk2Dib+eP4vpN4Ea6njZnHOkIL6P3dTSGbKE4KA8iYYZj8qmhAaEVeev2Jkqf
	bY2eK8lXpiwCeu
X-Received: by 2002:a05:6a20:9f46:b0:3c4:46ca:3350 with SMTP id adf61e73a8af0-3c67dae9748mr4518322637.6.1785050542641;
        Sun, 26 Jul 2026 00:22:22 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660ee91sm1863606a12.7.2026.07.26.00.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:22:22 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] spi: sprd-adi: Fix probe succeeding without registering the controller
Date: Sun, 26 Jul 2026 07:22:21 +0000
Message-ID: <20260726072221.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_HWSPINLOCK=n the of_hwspin_lock_get_id() stub returns 0
unconditionally. In sprd_adi_probe() the guard

	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0))

is false for that 0, so it takes the else branch, where the switch has no
case for 0 and lands in

	default:
		return dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");

dev_err_probe() returns its err argument unchanged, so probe logs
"failed to find hwlock id" and then returns 0, reporting success.
sprd_adi_hw_init(), the restart handler and devm_spi_register_controller()
are all skipped: the device binds but no SPI controller is ever
registered. Since the stub is a constant-returning static inline, the
compiler folds the whole remainder of probe away as dead code - an
object built in that configuration contains no reference to
devm_spi_register_controller() at all.

The hardware spinlock is optional for this controller and the -ENOENT arm
already covers "no hardware spinlock supplied". Treat the stub's 0 the
same way and continue without a lock; all four users of sadi->hwlock
already test it for NULL.

This is not reachable on production kernels. Kconfig has

	depends on HWSPINLOCK || (COMPILE_TEST && !HWSPINLOCK)

so the affected configuration exists only under COMPILE_TEST, where no
real hardware is present. Object code for CONFIG_HWSPINLOCK=y builds is
byte-identical before and after this change.

Found by smatch:
drivers/spi/spi-sprd-adi.c:560 sprd_adi_probe() warn: passing zero to 'dev_err_probe'

Fixes: f9adf61e983f ("spi: sprd: adi: Change hwlock to be optional")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/spi/spi-sprd-adi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index e7d83c16b46c..7c29115c5b8b 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -553,6 +553,11 @@ static int sprd_adi_probe(struct platform_device *pdev)
 			return -ENXIO;
 	} else {
 		switch (ret) {
+		case 0:
+			/*
+			 * Only reachable with CONFIG_HWSPINLOCK=n, where the
+			 * of_hwspin_lock_get_id() stub returns 0.
+			 */
 		case -ENOENT:
 			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
 			break;
-- 
2.43.0

