Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74524BBFD
	for <linux-spi@vger.kernel.org>; Sat, 11 Apr 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775930663; cv=none; b=LL9EqoN1mxskA1VJtcgQXnnDI56PoVw5qHuJMnXmNvVybczdkJsBSR3eZ+3/YHW2L/m+2+AMSqiAoKVPri1tfYfl5VEmVemCIMjcZgmtj9GmmEQSfmsAuzUpbPUUdLyoavzRj1/v9Yy0l2ZJ2aRxe1411KdDp1qUGv6c34HsqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775930663; c=relaxed/simple;
	bh=hw+SP67MUczjNWm2PgIVoT1LydkC/JLPEi4afGQ7WQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqieBuxm6+4ibxoT22S9Jasassv+LNnA7dS2yV37xjSg4/dQQlFivw0XTGtvSTKsy+Qif8cNvv1SSOGd1oxkjKVu5Vh2phcojxM5VWKcjPevtZyT9tLIsl084IOhVljTCyVh4LmoDHdlaC7+xWokiIfR2KUbQqcTSKl9Ao9wUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMjfzGsV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMjfzGsV"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso406200366b.3
        for <linux-spi@vger.kernel.org>; Sat, 11 Apr 2026 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775930660; x=1776535460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7P0p0kVaJzs6hmjX5/J5a5R/qOsuqr4kJlAR2Hczlg=;
        b=mMjfzGsVLseLjpoXSlHDsEL7ho4VOPc7hLpAFM3ebMQUMT0eMh96BGIBZVhLbJOZdz
         WUAugmoBXV5h9p9Tx5j10m4y6FdPtRVMmbYTXQPetkP5mMr5llAMcVMdFKPiyo7Cagvm
         1Dp663k4mANfXF+/F3rcIRJwdoCCt3MxPSg0yf9M1hdTkNvrRDfaZtE+h60CppH4lfVa
         Ld/U3DhuLC6R5/cbsKqJRiwQ1wPLipYehlEexAz87kiJRUPzo/Ivj3/Nqbx8Mz8z/fki
         CO/HShY+2lWheIjcaJ/psR82Iw1JQUo4P9RVd1B2djQUfb0sE9wLvfPLmTNsppiaBiQm
         5s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775930660; x=1776535460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7P0p0kVaJzs6hmjX5/J5a5R/qOsuqr4kJlAR2Hczlg=;
        b=b6nahVR+hLanknozgOcP85ou6Kv7C4vaUjq46xso0Ep2dOuccoafCVpODUP5v/tJB3
         x6qbk+IPyyYVe2y3Reghrz/Bp1KySRmvVetocR/kATVq4mriZclsymOJt2d5wwoFSVNM
         1+1sre2aUlQNQn2yAuVlTPp9EQqBysSIZH696ewB4I7teNfiu5WAn3xtgGPXg7K+huXC
         U0GqG7fxMq8xu2Hk1MBukLc37fbR8mgmpHpeFx7LtVoE/GHoVdnK866iwNdGveum3Mdn
         kCnfRDoUCdLTfDWFn0ik7QdJWSzgp6Q18KRZGRufL4dbNNij4eblianlJ/dK97syShZP
         5kcg==
X-Forwarded-Encrypted: i=1; AJvYcCXHFvhil/vTS1uAURV5kjxAOUT6J8MjIxmZYjgnjaTIBMNUdFcBz7ufnSSBqIANmxwb/f9tydOiH44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41j8CzIK4rJqna+f0crurjf7eq4W6GWtdRcHL6aL3FMTP7GfJ
	NHg1mebvWs2+eey8KBPCn98QhO28O/CmkH+1rq9oSkn217NasFiHNdiY
X-Gm-Gg: AeBDieusCdE/UFjWOTic5I87P1cmS9IyqaC2BmCI0XDjqkIMC2ZL2sdHFgxv6D0V58i
	bfeP0InU2SM0IerFVIYIYM/o/j0ZfbpuxXa7uvRDe/3ydq1DBZb7xB1KMznhHMPapbo6wDE0bjc
	7boXJPeWIh1IDStx+JiH0tApWU3pvaveyfI38n/ppFsFkKqzAXc1G4bARBOGQ/msUh/GFcFa8KC
	rawXtXkO5F3artYu0INdMkL2/zi/MRl4PTX/ElI5BTeIiLzVF9xAQzaT7nUE82brME3llde7V/f
	i29peHdfGhctGIw/yjkes0qEEfAGrbx9zYUJkHkNJsynp6fafiLby42FBD9Y96GYSXqaY44bh5k
	Dkk2QIIx2NpkKYpR6csXU2xALlBm5AE7hMAW2RIqCJ2uSPz4BURlkBlf42SJN0xFmEVwbxe0IVO
	CzbGQyuWGzGuuvY8zEJ4QudA==
X-Received: by 2002:a17:906:7943:b0:b9d:6e82:10f7 with SMTP id a640c23a62f3a-b9d72483ff2mr445226566b.13.1775930659367;
        Sat, 11 Apr 2026 11:04:19 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c56d3sm186160666b.32.2026.04.11.11.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 11:04:18 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Sat, 11 Apr 2026 20:04:11 +0200
Message-ID: <20260411180414.481427-1-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215135524.1171065-2-khalil@rentman.nl>
References: <20260215135524.1171065-2-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To: broonie@kernel.org, hdegoede@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com, linux-spi@vger.kernel.org,
    platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260215135524.1171065-2-khalil@rentman.nl>

Hi,

This is v2 of the patch series fixing dual CS35L56 amplifiers on HP
laptops with Intel Lunar Lake and broken ACPI cs-gpios.

Changes since RFC v1 (addressing feedback from Richard Fitzgerald):

- Added DMI quirk table: GPIO CS fixup is now only applied on known
  affected platforms (HP EliteBook 8 G1i, board 8D8A), not generically
  for all devices with CS > 0.

- Fixed chip select range check: only chip selects outside the
  controller's num_chipselect range are fixed up. A NULL cs_gpiods[cs]
  within range means "native chip select", not broken. This avoids
  incorrectly replacing native CS0 with the GPIO descriptor.

- Removed ASUS reference (GU605C was fixed by BIOS update).

- Added Patch 1/3 (spi core): __spi_add_device() now preserves preset
  cs_gpiod on the device instead of unconditionally overwriting from
  ctlr->cs_gpiods. This was suggested by Richard as the preferred
  approach to avoid modifying controller state post-probe.

- Patch 2/3 (serial-multi-instantiate): Extracted GPIO fixup into a
  dedicated helper function. Currently still installs the GPIO on the
  controller's cs_gpiods array because __spi_add_device() overwrites
  device-level cs_gpiod. With Patch 1/3 applied, a future cleanup
  could set the GPIO directly on the device instead.

- Patch 3/3 (spi-pxa2xx): Unchanged from v1. Handles clock gating
  on Intel LPSS controllers when GPIO chip select is active.

Note: While Richard also suggested the cs35l41_hda self-fixup approach
(setting cs_gpiod on the device post-probe via spi_setup), this doesn't
work here because the device can't even be added to the bus - SPI core
rejects it with -EINVAL when cs >= num_chipselect. The serial-multi-
instantiate approach is necessary to extend num_chipselect first.

Regarding modifying the probed controller: I acknowledge this is not
ideal. Patch 1/3 is a step toward the cleaner approach (preset on
device). However, num_chipselect still needs to be extended, and
cs_gpiods needs to be expanded to prevent out-of-bounds access in
__spi_add_device(). I'm open to suggestions for a cleaner way to
handle this.

Tested on HP EliteBook 8 G1i 16 inch (Intel Core Ultra 7 258V,
Lunar Lake-M) with 2x CS35L56 Rev B0. Both amplifiers probe
successfully, load calibration and tuning, and produce audio.

Related bug reports:
- https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/2131138
- https://bugzilla.kernel.org/show_bug.cgi?id=221064
- https://github.com/thesofproject/linux/issues/5621

Khalil (3):
  spi: Preserve preset cs_gpiod in __spi_add_device()
  platform/x86: serial-multi-instantiate: Fix SPI chip select on
    platforms with incomplete ACPI cs-gpios
  spi: pxa2xx: Handle clock gating for GPIO chip select devices

 drivers/spi/spi.c                                |   3 +-
 drivers/platform/x86/serial-multi-instantiate.c  | 156 +++++++++++++++-
 drivers/spi/spi-pxa2xx.c                         |  78 ++++-----
 3 files changed, 196 insertions(+), 41 deletions(-)

--
