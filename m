Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92363043C9
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268434; cv=none; b=iK8OtNHNAS8nTZC2+sqWppoleMvxXGFaPq1yaiZ/UxQOfEjABV78OClIzNLaS3pa1Z00Esnd2qIfUmzuAhoUq6l+rUouajdsNHxkD81s//S7gtm/NaSqf3L9dg2U1cZ4+Rv2p2x1cPzLHrwvMLJumvAlA/VAr0WR7wIl9dqqfcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268434; c=relaxed/simple;
	bh=j2U7343PCLlajsVw1y383z98Ew9U057f0T2d/NHHapM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1ajejJrd3+CcvThnVM8TWarEn85Iou8bQxxZotf1ymHPoPCwyFyrbUrAF5XLsUG/ai9iIXFbjKyV17Jpvn2p+pIHSNlnzhzdhtEC+wM2CZ7yK0r+mGILr+H83tPG8v98TBUe6pG5si4vS0L2UZ7H29T5uR4Ev/A/DzVpxy1W/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5TYaFC7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5TYaFC7"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45e7c636e74so2236744f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 02:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779268431; x=1779873231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvMzCj6pQd403Su6t6AiYprrAGwPup2SnBHaVQ4KV+I=;
        b=r5TYaFC7Uc+9L94KopNuD1ONQe30ScBxZ4s1mzFY5RDXtsdKg3FKRFvQbM74d+U7jA
         x1dE/XPHRqAp+NqSABm/1/3vkLVejWHsGhtJ9SmuuRpiaczhmmS6k/Y7Nip/q1GdVlhe
         b/RGe494wz15egHnDze5Fx3VC97pW05iTC1YImDyCKxllYh4UHb6QuK39p60wQqNbnIZ
         oVOt5JDCkWKE0KPDrsqNB93CJbJI1pVG4PPC6lcZQQqXZIRS+fTF54hpGFgWKhcwdp9A
         kx3mhwNY3jaLiFd8byL47F422iAHza047t12F6JeostTuVbq67vheF2OmjmeReOUKTxe
         xNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779268431; x=1779873231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvMzCj6pQd403Su6t6AiYprrAGwPup2SnBHaVQ4KV+I=;
        b=Xt/oG+3jIvkLxbxdk75X5toU1YpEZFlV48kgsh9NSjEyv1czeucVrT65UpyVqA1W+4
         QTDRyFEG2tWueV4YOo0h5qvHCNE3Fj8NhJdLW20LJ24sQzm/8cfW655SOb4UX12UqyAI
         AyhgSG6X8nkur4zD3dGZlj5/tpugNVINXYAqUa/HFf9OXvqiCuFd5bpI9BYE9kMtIzU9
         suuqb01Udtj3ifmWG+n5wj7Ag0Svs3rlnmklROzoc5ZXXIyse2HlqQBpmJNDRcIvGMng
         Xl3P+2Y1oaLOoWPg6nWPzQhqZPlcn3ccb0O1AJoyt8QftJKiyM/Mjh/CXnpSmIHv/dV8
         CxCA==
X-Gm-Message-State: AOJu0Yzzi4K1/4hqUv0Cz8juTN9mQEBBQZ5LvyeGC6MTQ9Q+E5gEDda1
	E4DODeOJOQkZgkaZXOWmcAcNX4QKEjDGn7ghtUJ2zWasd1v2dGn3IRaH
X-Gm-Gg: Acq92OH2fZZSRGdUOE4pj33o4U5+Chy2ZgXwfE5LWebx5F2Nq/NdEPIXOfletUhwNtR
	rj6Xu87cwR/zHV5FiPzAge4gKPLMW1FV64nmPU+12JOXfA2tdd81qLTETi4RJW61a3Mm8INDf6S
	ZRoxfqx9+3WiggDbCHMp4v5lHczLFSPIy6VNpkyPBzO6ueyr/pgDP/SGS+5iov2QAUewsiT1F/t
	pI2WV8H8iCbz/mQQU23PunVc6BQhn9AWo4iCkzY+3attDMQFkEScr+CpmRW0oNrOuBGbN5qSod8
	Aj2bvQDxxqB80iTmxS2Cgaum/5syVaJmq6MyYlGdIs821Iih2oOYuZek9gjIpF/Cal5Q7vBR7kL
	pYNiJb7SFnpVH+7LChCxMzwACqD/bINo4gkQIJOl7xZ4FgqYozAovxFYi8nMFn1/+DjsHUPX6lD
	QtDtrDApNEU+h6G4q9NAc1gDlPB1qOPMOi4LIR+asTgfrY71yGbjE3dK+i7aRywPWf3R0f6UCIM
	MTS7BOg2fK5pHyKePk62CWPFf1T47MWfI+cAg==
X-Received: by 2002:a05:6000:288c:b0:43d:761d:5423 with SMTP id ffacd0b85a97d-45e5c5af599mr36844818f8f.16.1779268431037;
        Wed, 20 May 2026 02:13:51 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768acesm56186420f8f.7.2026.05.20.02.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:13:50 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] spi: Drop redundant 'cs' variable declaration in __spi_add_device()
Date: Wed, 20 May 2026 10:13:42 +0100
Message-ID: <20260520091342.68029-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Remove the redundant local variable 'cs' definition declared within the
chipselect GPIO configuration block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5f57de24b9f7..96a1df0ba4cd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -732,8 +732,6 @@ static int __spi_add_device(struct spi_device *spi, struct spi_device *parent)
 	}
 
 	if (ctlr->cs_gpiods) {
-		u8 cs;
-
 		for (idx = 0; idx < spi->num_chipselect; idx++) {
 			cs = spi_get_chipselect(spi, idx);
 			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[cs]);
-- 
2.54.0

