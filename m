Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0C18BC3B
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628452; cv=none; b=pLS6962YVcH2cQkq27IYwJ4bg5Ry7frlT8epN9yMEfonnFB4A4YOsah6iiiyMdxDrF/EM5mOXTDuX/CeA9TSjgDDYSoX1H8iw6MUo+z4qY9SfMw6m0SYRaa5HLq+3wJxkm5gtkFHFV4zmaehftWKGWFfpGFKFQUxlls0b5wL39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628452; c=relaxed/simple;
	bh=tVJB/5QV1ClMp/xbJ+PLWJPyv5EQ41vZXbE/F9ItU+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fNP742wPPB8GTwPvDMd2pXSFQJQXC/nhWUrrIdQaQT8uk+6EMI540NbML3Xf+PO2ayrRyxRpD49Zev+1epVpwY/MLQt0xHFdLtcW14FZeYCMmSBh4menM2nZZuqv4mt1EozeiAHR4TO/srFdCR1NCXkwCRx0ARGFHdGkYP0WK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJZ0prQL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJZ0prQL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3597b474cbdso2016101a91.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Mar 2026 04:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772628451; x=1773233251; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un236t70aK9C+LYKfl6LV8hfmsluRaGW5mOoPgkCRvY=;
        b=gJZ0prQLbOQd554Wke1GmDfrUXlVKW0hvAqpW4qH5McwbG3WlwIgbL2XJjQGtLegtB
         rdK13y/yVhvo8+PHMglcKsoQ8aqsNWgLW7AUT2mZgmxIi0W5BVj2NwDVW5gxJBnu0ciR
         GrAlshsloUUV1/SRawTEZKaWlTDB6DBTSmH+BqfG1MpRaThRf7+Z6od1p5h/ULy2q2y7
         2pSSDzTFLqj4+ntsMCpeIF/ve79WaUCfJKOHYdD1SsWpmUglTVD1czG4XzyoKvWZS4R+
         GPBBo48Ey6ZOiCTXHNxqh3X5okJH587hfn6jQ2FOTY0uviF6NAAeTVDCQijSHcEnHP1j
         UsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628451; x=1773233251;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un236t70aK9C+LYKfl6LV8hfmsluRaGW5mOoPgkCRvY=;
        b=R0MmnQ+0H//vQVQPUwpk1IpzZBfzichHHVYd2/UcdHVHWxUOYKATK+TTIv/aHrIOCi
         cgzUOcG8CtNcVmbkjesWJlGigRKsfna1px0aCJ2P+9wTGi+QpBwkGsIvp50ENl3Rj4pH
         pe31r/viwoRCPrejwXERVKlTFlOdh6mywBY0D6r6A1WNEq3xvmRP/gbl2hrWigX09MCv
         UdkJZjxvUxixWQHyDfu6YopAaCCzknNbueHvWik8Wnbx4DJ3fpCQMDW2ACoxThqaOL9O
         /bowSCi88rN/iHWN/bDazx3JDAUr9Me6+Fur3ebRXYFYofd3fSfNYLJHYDeyIE9GHh9l
         Kg8g==
X-Gm-Message-State: AOJu0YxzG/Kh0Yx0LqUZ00q0g1ZznDL1gIs6A8pyvqBwXv/8BrsTbXdu
	4t3n06hOA/fmhLSB2J4O8YDmHuAH2YF2G2c1S9yBQ4WPZ8QB8zH5P5Rg
X-Gm-Gg: ATEYQzx2ElqXLGYuOk7P1UcO2KAVFywLnzzJeS4Dhy8hnC0FiD8CIcqhmh6fT/QUvCs
	ld3Ci3ZPSHfS29+Beoh5SRyv+pefZC4b3PYWqYl99gM7YhnJsZYQX4Xl5e0Wh9agY3uQ4xbsJee
	oBS72GGnYVasseqQdVOHsblHsoqeua1Nd5YnOuj8NupchHpiaWbk0LpCJ0+YquDO+MNlm67j8B/
	sfla5u15tjTUiG915dyAiF0TAzLV8hHd9H27p0vrQfsr4AIYmVCkApJEMLkNxN8ENQERLHmD6OD
	diHoekQIYFM6jfqk86uQ6O8Z2kdmZShBvr47SB6eKIpDK8Rqf1R3DQUyAGN+oQ6jC+rBlTtNpPm
	dxB43dW3ZGocsZPD2OpoEa/fDlagB2+pyphzrUIS9QI9Df5xM5/SeUxrpvLsH7laWxs8eYoB7Js
	jbQoitDVWsQp8h4RSHIpf5HBi8MNtLz/XseG49
X-Received: by 2002:a17:90b:4fd0:b0:359:8055:df63 with SMTP id 98e67ed59e1d1-359a6893bb2mr1883589a91.0.1772628450743;
        Wed, 04 Mar 2026 04:47:30 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:c48d:9c04:d04e:c13a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0625sm5000450a91.13.2026.03.04.04.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:47:30 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH v2 0/3] spi: nxp: Use reinit_completion() for repeated
 operations
Date: Wed, 04 Mar 2026 20:47:18 +0800
Message-Id: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYpqGkC/2XMSw7CIBSF4a00dyyG0ijoyH2YDnjctjexQMCQm
 oa9i506/E9Ovh0yJsIM926HhIUyBd9CnDqwi/YzMnKtQXBx5QMfWI7E/BaZk9zcpFZu4graOya
 caDuk59h6ofwO6XPApf+t/0bpWc+MVBfJnRHK4mNeNb3ONqww1lq/7ovEcZ4AAAA=
X-Change-ID: 20260303-spi-nxp-d70b97a8df08
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772628443; l=793;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=tVJB/5QV1ClMp/xbJ+PLWJPyv5EQ41vZXbE/F9ItU+4=;
 b=eADYv+bdcOtbSTN4igmdAr7rsRR1fF5UYei4LYGy6xymPEqT3Ih91iSIHCF6FeSYm7KuayXW0
 8Ajv53wMpBjDTpH7CInKfK4vP6zdRN1n24GmfREnYwaLgyReQG+Vhy+
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Frank's comments.
- Fix for spi-nxp-fspi.c and spi-fsl-qspi.c suggested by Bough. 
- Link to v1: https://lore.kernel.org/r/20260303-spi-nxp-v1-1-b78570db28ce@gmail.com

---
Felix Gu (3):
      spi: nxp-xspi: Use reinit_completion() for repeated operations
      spi: nxp-fspi: Use reinit_completion() for repeated operations
      spi: fsl-qspi: Use reinit_completion() for repeated operations

 drivers/spi/spi-fsl-qspi.c | 3 ++-
 drivers/spi/spi-nxp-fspi.c | 3 ++-
 drivers/spi/spi-nxp-xspi.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)
---
base-commit: d517cb8cea012f43b069617fc8179b45404f8018
change-id: 20260303-spi-nxp-d70b97a8df08

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

