Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B683328E6
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808334; cv=none; b=jyVctLX30aHmVGxxfFK5B5HonV1N43o5SKx++ip09KEfI8LmCzmiLANdoULmMoNllfulJ/ttNmsi4PRxKsox4b8sUy7B+0jM6+Px3mb/ielWM65gf4lKKzxVl+xMhm/9f+K+IGZsJQEsmpyAj1D6rS4s3tJWGJ3XiQHDBvkSfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808334; c=relaxed/simple;
	bh=vi12rUe+JRZ31B2xxgnufJ0xVUiwiUZRMYqpk7tNGWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1Arkx1SO/vU8f5aJeVylzUADm5wIguKFP6GtBKOdQ9FLZYRpbhX+FhO6GVMAa/fk4DhFWayMZgmPMGwQ/aLVzfcn4bkXbO37FGxY83U2tqXLpUEI1peYT6Oatw4vtIy3etEoPCc0XQZFeyKqup/CsOqgC4DnpTY1iJu+p8LK50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj7/X88w; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj7/X88w"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso19164195e9.3
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808331; x=1776413131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=em0YanQPPRlOBJZmjOVtclWSTynM2Xp9mKdluzb0Kj0=;
        b=Xj7/X88whNTvImg8ckdRXAAOgurGMLj34fnYREz2LCLUB/MzX3XtmlP1umns4T137K
         kG6bf5aJPyLp1ABEchvBub3+hZHgjmoitN6yLggwnadql3Vk+27HnUlBgcHyYZ0P90+O
         ODiHc2YLWjpVELT/glrM9NVyXo5fTZcJ3n8/gd6UCpjECHRWnOVIUlTI/6JZd2DD6clr
         JKGiW+TwT/7BLFyJip63xyz4HQLnxuGhrMoVMEJzlnaBjGimUEWr1l9c43BlUcQF74RR
         yKiiSTmRLjv8iL1oqwRA25lgDThtXR9SNDo6n8I44ODlO9AYLMk0znNvtq6xNns7yy3J
         SSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808331; x=1776413131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em0YanQPPRlOBJZmjOVtclWSTynM2Xp9mKdluzb0Kj0=;
        b=GPVS77+lzExF3pgTg2h24l+0dhemQpUAi6oLp2li+oKAJBA7NMKhT+c7edVGIphs0n
         IE2ZvzdRStBa+ueRLXJddHc8JVTLZuD2tG+irLEe+EVJ9QY/RGZbnZKyWJGJ4V9LQMPv
         UH6K2Yez29bdBLvpGsNGloY3iXoLncmyeZBnw7hOGJXZvDbQr3CxFiazsFjGpYQa21wf
         wTy42aMvpHTEYJdJc5UwAJQQaAK30L6Inzm5OIACTAhGJ8yOqR/UXTl0adKfdNkjcDqe
         kv7ioQj07ofVSws45V8iNaHirOk8lGUWnSFPO5Q2yE+bjNuBVtIdXWGZrbLikaD2/FoZ
         0X+w==
X-Gm-Message-State: AOJu0YyhX4khFMRdCYjqd118vU5+s+MSQTT8+eAGFCgDiFgl07FtdedM
	Hxt2OAZLELk9+xP75YsUt+nFlzE2VjmUPDXVSun8iwwC6avEX7CIAGZH
X-Gm-Gg: AeBDievRKhWcMqxgQDm7lj9LENflXXuFKBh3y/6UuwdBPS3BcUymHFZq+J/Lur54VXQ
	Ew/vE6CQKAxlFyxZ0f64jwS+I+XdszcEpbmCrFpwyO/YXgnzO3RRyXwb44izXfzyrVDJ6yxjGMW
	dtcHLEqIFSESatKH5NLz3b/0nepaYvLC4g/JG5m4hoh8TE8CKaQzTgcPtd1i2zVgs54YLmJXZAi
	ylB4/yExTcyvktBFjiLvOOMAaIGeSIDgrF29KL2LQaP5+OYEQ5vndOnHmp8Nr3TkCX/biI+wVu/
	9RT+SVo3A9dSFl1Md8REZ+4Lbl9SgkfhrbuzVCZ4yWe0jQDoBuDj/S50koszqIJmBSbZRuIE4U8
	zNDkBG05DWiT2tluoNR/mqsZU6I7cicCnYi7hbJS1nzHAR3iG0ySZO/zTp5VYRuozQxw+DY+Sc4
	MOhzROk+QfYRdQfdZjMvIMrrkhMPb2KpYm3SAq4w4dXy57wm8Mmdvgl6fPZsEDL4A8agOe0muxQ
	yZOnkAwSc4qM/zJwlQSo+jaahOb1hVWYUwaZA==
X-Received: by 2002:a05:600c:8594:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-488d67f9a73mr16538045e9.13.1775808330989;
        Fri, 10 Apr 2026 01:05:30 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a73b:688a:4297:c5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm29950375e9.5.2026.04.10.01.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:05:30 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] spi: rzv2h-rspi: Fix max_speed_hz and clock configuration issues
Date: Fri, 10 Apr 2026 09:05:14 +0100
Message-ID: <20260410080517.2405700-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series addresses three issues in the RZV2H RSPI driver:
1. The max_speed_hz field was advertising a prohibited bit rate, which
   could lead to incorrect behavior when userspace applications attempt
   to set the SPI clock speed.
2. The clock configuration logic allowed for an invalid combination of
   SPR=0 and BRDV=0, which is not supported by the hardware.
3. Simplified  the clock rate search function as min/max speed parameters
   are not needed.

Note, patches apply on top of next-20260409.

Cheers,
Prabhakar

Lad Prabhakar (3):
  spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
  spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration
  spi: rzv2h-rspi: Simplify clock rate search function signatures

 drivers/spi/spi-rzv2h-rspi.c | 52 +++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

-- 
2.53.0

