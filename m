Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308D03B52E1
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785303346; cv=none; b=EVEiReCr/4DIuFASiUEvgPpsEkgBNxP6GD79GjApKmz24p0aTMAHxCDqrtHNuNSLZZ3AYGbrjoBic2w+jGFrxLBPNSsdx851wTFdoTRmMj4hYyf64OA0sUfREkaUozb1apmyArcAHruEz2d1kDuU7q2ByZk1Njpw72pMLypEVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785303346; c=relaxed/simple;
	bh=BBPvNa9NJr6CbVXU+Zf4d0TESsrXu46Thrx+s3xq67o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3u91rZsbgX/1L01rIRRYZf2uS5lFQs0uNU+QfQ2fSEetuxcBK2A4ljkZahEDyINZpBgr1RWKG9vhzg375ZEtw//Gm6KZy6eGrgpdco/641c/QONOPwQC7K6cf4BMbFMv+jFspkZz5IryYM62Fi7mDIMEDsu4d6+d+QlKHUI388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItLQ0l55; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItLQ0l55"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so438578a91.3
        for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785303344; x=1785908144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tH8w4Ad7nQtBY5y7Ola8fN7/o/nUCedgysqG3JBFuDE=;
        b=ItLQ0l55dj5dCdZ9CgLsEtKpb3HA6tki+EI6N2OygSKFXVo4Nalyq1ne7gS3vV0gk6
         kvxlUPDL8KuqRROg0mb86mmGs+hdQdvQYyj8Gp0yzRVbblQShmtgQZ8T86SacGmlYRfU
         89Qlq4kNfoRpnSnTOWjKjztLxrJ5Bc4mUFPaQCpsbDNCbq9gOf6QqU0Yoxj+nESKlLEj
         zoORNM5NNyUTyWJFStv2tAVMw6jcr8TnXi2FZtrd0mLgDbv+xiIOFiYuh+iilJLqdn96
         h/yo+k2GlQuoBO4LL05uj4r+uS5U7u4cppPJiH18Csi8kJiPvjCT9OgtR9/lALXkpzsg
         j9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785303344; x=1785908144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tH8w4Ad7nQtBY5y7Ola8fN7/o/nUCedgysqG3JBFuDE=;
        b=bGOt3euOoVSxsTWk3KBZ7fWLXDQ9WJCouvHSUtKOkPAOQys+VsG+/cptYs7kUj/rNJ
         lVOKDELuCY7VBrQSgAaQFVehdj2r+W9vWjOPhy3peeKb7AKy6xqGUIo+CqfP07IBsik3
         knInbsCg8Q7RBGVBtnhwfozY5w7JmGxLBEmQllgMIW7DXVyxYPdFJvcPCAELnZnsGQVU
         1osoiEQKtLsArtgMUGxfVwmVvZLExYXmO9M7GCjzz4kksJBXW26bmpHv4sVQWFszbZxZ
         yoP6wFua2Y3a1zEn+FKPYcS3gfgYCOUF/7yTNpnHWSH6jHqXAVOFcNkqRe9FRk9FkIj+
         sceg==
X-Forwarded-Encrypted: i=1; AHgh+RoYn/0EJI6CyYu35KFTjoKWGEF0eIkDU1Md9BDR6lLFBZ4YFzzf3CmFdpVcqeKdGyjGVRXLU01LoQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLYZV1wpgmKVbvPsMMWzR+DgOTk0tARIqr/qq94MXyN3UC7QD6
	We3wJ4/v21HH60wWSL28vuG0QBA3koLc7W4Zw8JxS0RQDvAiqJXdv+f/
X-Gm-Gg: AR+sD108g2hAGv3pBZGCZNywDAz+Mrv7H9YoR5dleWulExwcqmxpZbK1FRJlmYevqtV
	4/7EMOEfOHjtxnbckAGzuaNTOcT/CUVYTdyitmdu8q4MbCEAPQN66CBze4WyZngii+gx4uFNVUS
	LnH5DJrUopAF3v8VyDL9OaIp9bJ/+noKTa6mgUjzoog59cSutPXpGGAOyfrDbv6R7XWQCgujZxm
	o/JJezMBmhvX7H1DD7Wf9yvt5kKcF75Tmwxcgedt7b65fMxYCJTsu04XYnK75PYZAELmrj4+RdS
	rzTW3+MwXpWJQO1/9l7cdQYtzg67qvWCjZl1D1qisD4RlOFzCH5zNOC6jiEkg7doEM3BCtnndzA
	9WZpvIRNKEhn4hhFFTPNGjS8TJCoCNQrl+KC/0JnHLLv/XrhSTxMw8RnOIX3RqfSdne1XiRWKUb
	h+ifrzVCxz+gZH04ujs1joVAg9+exGvyB1+mhTMivM9NiTYxlVeuacU13KnE0S
X-Received: by 2002:a17:90b:5106:b0:387:e0db:3d8f with SMTP id 98e67ed59e1d1-38f6a588a2fmr5454870a91.42.1785303344429;
        Tue, 28 Jul 2026 22:35:44 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f64111441sm2228870a91.1.2026.07.28.22.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 22:35:44 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v2] spi: sprd-adi: Fix probe succeeding without registering the controller
Date: Wed, 29 Jul 2026 05:35:43 +0000
Message-ID: <20260729053543.7-1-bbnpreetsingh@gmail.com>
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
registered.

The hardware spinlock is optional for this controller and the -ENOENT arm
already covers "no hardware spinlock supplied". Treat the stub's 0 the
same way and continue without a lock; all four users of sadi->hwlock
already test it for NULL.

This is not reachable on production kernels. Kconfig has

	depends on HWSPINLOCK || (COMPILE_TEST && !HWSPINLOCK)

so the affected configuration exists only under COMPILE_TEST, where no
real hardware is present.

Found by smatch:
drivers/spi/spi-sprd-adi.c:560 sprd_adi_probe() warn: passing zero to 'dev_err_probe'

Fixes: f9adf61e983f ("spi: sprd: adi: Change hwlock to be optional")
Assisted-by: Claude:claude-opus-5
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
Changes in v2:
- Add the fallthrough; Baolin Wang asked for [1], and carry his
  Reviewed-by. The v1 case carried only a comment, so gcc's
  -Wimplicit-fallthrough never fired and W=1 was clean either way; this
  makes the intent explicit rather than fixing a warning.
- Trim two sentences of build-verification detail out of the changelog.

v1: https://lore.kernel.org/all/20260726072221.7-1-bbnpreetsingh@gmail.com/
[1] https://lore.kernel.org/all/7792d078-f80e-42f4-9217-190ef5fb8573@linux.alibaba.com/

 drivers/spi/spi-sprd-adi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index e7d83c16b46c..a6baaf02b3c8 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -553,6 +553,12 @@ static int sprd_adi_probe(struct platform_device *pdev)
 			return -ENXIO;
 	} else {
 		switch (ret) {
+		case 0:
+			/*
+			 * Only reachable with CONFIG_HWSPINLOCK=n, where the
+			 * of_hwspin_lock_get_id() stub returns 0.
+			 */
+			fallthrough;
 		case -ENOENT:
 			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
 			break;
-- 
2.43.0

