Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765A2CCB9
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781137977; cv=none; b=ALZdHIWF78hJ5uHuuLg6NMRJlRK+cPrObX+KGkSAm6gxMo3exOVxyK+f3IlzkNIyZJJlrIS8dfI35nvqRxBTtlN8Ss9oEGmOhhaTtkcM0RT+lTEeEKlcqoo65QqTrqa+wSkZ5GqjJNuKjP7s0oa8LwUfihZVlh4itQs29C2y18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781137977; c=relaxed/simple;
	bh=QElv3vPOy1KOCQZXCoc+EP4G4Ouf9IjsVp3HAeE0pzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ybm9hgsdawEbRx6Z1mcGXlpUC+QFLp/KMsp2/vHRopZ0VRkevF7DdWkjQoWcLzPkb+0Gjte4xPMxnRBVOgwQVGnonYHXU3gNe/3NgvVNlMJ4exldNqp+vbS+tgTaNg2mObbuwpqRJG+D6Mg2QDhuf/aPevvqEE81pVitPHqmDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmqNq+kB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmqNq+kB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4905529b933so78581765e9.0
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781137974; x=1781742774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXu0PXJjn7ZgTTo5ijnJE0bKBHlU1hsu8Qm8CiPCYus=;
        b=qmqNq+kBpOMnri2Pssolwwjusn1REoUNmUn/mJg/bamMYMjevIpM0SrlEOug5WGFE9
         jh8gi5y0SKe32zYRm5NdMun3iSp/LQCx/NBulG8OFrhq20KjLtOvl8mZPcL1zK/vGdH2
         R0JA6am/BFFLrCmj+aGVMalwg1rPY2z6cErfwtnleE82UCx4+ycje5jkpe2NVg/6gKFF
         RrOL1swgYB11wHYFj1+kSB0Rtta6hB0Oa2S9iStjVGHBMJnycV8Y3HvPxSpceT+wpBf+
         E2jpwkoq+dBAlTxhPHBgv5UBVwehsmFgotmGetDUKzm8ZREZGY1LVigXfj8kjwIaMn2Z
         vvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781137974; x=1781742774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rXu0PXJjn7ZgTTo5ijnJE0bKBHlU1hsu8Qm8CiPCYus=;
        b=GA73k0+SQMcFRU6Ko2nGexCkMEdkEREOtG/sZljGhlIvctC00k4SXwPeTuviSeXWVs
         60R0ja+CgLXZyN4ir/izk3SyiP4x2GcnDrtgGjaCWmD+LlQHZK0PACdv3/Tzxvo+wuPq
         GgQGy5FsINcqXMIAS6Sz660ZzImKj2L/2ceb7Dym2RF9gBxLJD6zBDKESQB3x84z1QV6
         hOcybC5FnQ8l+RxWd+fAFwZlYod6ir5yyfqexoOaiOtdubkIx4fsrJSlJn6fMvqgO9wn
         TGEXZmzmA/4WLVsf+CLXxaWTukE9PMFHpTAU5WS3XmClLvXd+FhAeOQ9XvnXgTinqJTN
         nkOw==
X-Forwarded-Encrypted: i=1; AFNElJ+ECBW71+cMYjGTYkc1xQcAkzqnAkYlG1PDUS31PntJ5Wzz5ZBRpZDYBS73gViJTFiioyP2HDYJNH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutOZSWF0hAvftpbjUee0nGXwO7/YIx5fDT9dTSXgXHpxFc6WF
	As2NGMg+Y9Vj8D8tFxEQK5i9iY4/8RiUVsEyPWLFFc9JKAjFxSAqGsra
X-Gm-Gg: Acq92OESNm29RHQEXf6bvJ8bigdYJ7RzX1Dj89zCgJ2N6vqfPMVblinTty6JbaoVXbU
	pEIyeYORoegk82ETx3hbok1XY5KKMqvwXDjqVp0Rjf6aGfGiIbkmFvt4WBOr1D2puPEzDxT/aGP
	c2SQFosUmBq49y2ucSGdqGtFmGLom9ZU7IOn1DQQYLZ6AnW6Ej1/OGVri6ArE64zRClJcoME6bG
	4qtyuJrW9KVy53XO5fGEo/6GAHIT7cEmZ1UBgTTZdslPzSnt4e7V6MHLan8dr38aaLWcY6gIPH+
	RNeqU3lU9Ms1BEZzsipVnH584X00dXAGOheySDBVsjyjUG1AQsWyoiICZf3tPP7wO3AmfP5UU04
	8tnMBrMDzv22ehWVprWrusolSlfEOicTdq3gmfWABGEcO/9+5ilFIFRxr/aOfyrJ1uSo7tuXnh9
	x+0a81SqinGfTH77lGeFyfKwNMpJbLfesmcQ3puMtUYRLCPyj+utK84nvP5AbpRotrOHkpnaug9
	VX1Bhp5Ut9kYMV1z4smqYiZS5bHkYCjvKDz7EKcNb+t
X-Received: by 2002:a05:600c:c093:b0:490:c2a3:1782 with SMTP id 5b1f17b1804b1-490e56231e4mr1721875e9.35.1781137973959;
        Wed, 10 Jun 2026 17:32:53 -0700 (PDT)
Received: from linux-kernel ([2a01:11:f30:3290:a00:27ff:fe92:9192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm75807409f8f.20.2026.06.10.17.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 17:32:52 -0700 (PDT)
From: Diogo Pimenta <diogo2003pimenta@gmail.com>
X-Google-Original-From: Diogo Pimenta <diogo2003.pimenta@gmail.com>
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Diogo Pimenta <diogo2003.pimenta@gmail.com>
Subject: [PATCH] Documentation: spi: clarify clock modes question heading
Date: Thu, 11 Jun 2026 00:32:42 +0000
Message-ID: <20260611003242.44820-2-diogo2003.pimenta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611003242.44820-1-diogo2003.pimenta@gmail.com>
References: <20260611003242.44820-1-diogo2003.pimenta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Diogo Pimenta <diogo2003.pimenta@gmail.com>
---
 Documentation/spi/spi-summary.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 23e07ba4f8cc..f6fee00210d9 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -93,7 +93,7 @@ interfaces with SPI modes.  Given SPI support, they could use MMC or SD
 cards without needing a special purpose MMC/SD/SDIO controller.
 
 
-I'm confused.  What are these four SPI "clock modes"?
+What are the four SPI "clock modes"?
 -----------------------------------------------------
 It's easy to be confused here, and the vendor documentation you'll
 find isn't necessarily helpful.  The four modes combine two mode bits:
-- 
2.53.0

