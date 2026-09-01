Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C9B4A0EF3
	for <linux-spi@vger.kernel.org>; Tue,  1 Sep 2026 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290796; cv=none; b=ewXqerz6IQqpkMLJVam9wd+M3qhwHeh9r36ixnSJN/9WZvjTZFxG9xehAHR+W4XoCscPVDID3h7Nsdal6afi1QoZ0dUsz2cHsNGAChbWB3RaeskUn8D5KuMGZjBRlcykmKb7JbSiZa/4gEGku37wGczJUikDU9mRGRDudYKA8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290796; c=relaxed/simple;
	bh=8IldVcKFWxRF8a6xnc4EgOvN6n/T6fyKnTnlCA44KsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhmkYOisqM8ewlCdtVWLUjFkprEre3qIFbTV7VFfczviDINHGUoDjHl465nNKuk02rorMCui9P3PO83X3M6itg+48EG3HHvZxWZo0ohNlGeUX3ipKUfcfqPO+47P6w0jpwSHir08h8r40RRUoIWvvcE4OOUyhmi7TZdxH4AK7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ocFyX2/p; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ocFyX2/p"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso356823a12.0
        for <linux-spi@vger.kernel.org>; Tue, 01 Sep 2026 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788290793; x=1788895593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R+dXlhW9X6Vrf/RHdUTXz/EyouRxzz9SL0VdPXRzdMM=;
        b=ocFyX2/pyQNio0CRrsg2Rx8OvZTrONbRU0wGmi3iA5xKSDvKSL2a3iyY8cyCfwfWex
         ar7+ldz4uhJ+RTQcj9FOv5OZFufVo/eclXExogi3+PmXsDIuYVQYRQEwf/9m3xPv5XYf
         o1vY0QaMjvM90vOIamed9iqGLbgSyiGpy1LdgT1fG0Ul/KH9EXtEiqQ3OrNNSgiv0RUp
         K354k3ikbAyfm/0Ur85LF+KTqvqb1kxRnfAEVMpVeksKq5o23SBRkQwRfFX0oz2SK2DF
         KyYWmcz2htoQfQkw1x47CcJBv/d6w6rOW3z2m8p4zc6YMn1xxaZ8POogSo3iT/vpn2EO
         U+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290793; x=1788895593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R+dXlhW9X6Vrf/RHdUTXz/EyouRxzz9SL0VdPXRzdMM=;
        b=AfCizVhK8/NcFTnA3RV7vjpHYcO81iMYihHMAudeTs6wtM3cnM+VRQtQwMUsB1V+Au
         C1PHITJsjBO2NC7nESODFKO9e6eraLBvLQWl3WKDjBOONYpuBdXWnvlH2kxd8yVMBETy
         DJWpeOTEXQFouzNVIIWOI0+YQpdvyGO/4DxdZ5QV7S7E+pqhGm2Qr10VZujVNnNYXQC4
         XRbvIww8wmNd1vVlUNWtGw1hBTJVano9fdTI5kboWKtpQ+XyTO1toODcPOVXqCdXwoZA
         fC2uvYASzcQnQ4QAY+FRSGE5Lbyyv+g4Xxkd/qsSXrBl5gHDrBKF6bNQ2xLdeVW2BsCN
         bG9g==
X-Forwarded-Encrypted: i=1; AKwUvBwt3S6VePST9jIM2pwij1YN3fQtKslFPJHNZWHbY1Z5cE4kCThWFOuw8Q9+QSbZgwCmnR1r9duYEdg=@vger.kernel.org
X-Gm-Message-State: AFuF++nFYpi8AQz5r+H3cU5IQUxLxtdTQIYR+gkUvBnjRzW5reECuXis
	Poz0GYR2BfVhPCJWhO4+3BckB7rSa9YketPq5yaSPAnjraWkZ8A3tAMC
X-Gm-Gg: AYBFou2/M2YjofnpOZrQs0aysCnGcnVIcRy/GPjmklg1p8YcEm+zZspR90wo+MaGYiD
	pjA2SeGJsTzXyOeX4GdKoC5F85BWKE94vzYcN3r+M5qxrUo234yfgD1bQlhdsQLyDHCbaRoL2F6
	X6G2zEXmmYoNvpunHe/Fj81c6aKtTnAu3m7O41V+lR8IwDcyahEhzGDN6PiyoDuGFdtQ64qRhGq
	+dhqe5FK6XjOA1wNuSNFXMT7O2SbQLhPjrjkqll2/GBE6AK0yPd2ycnXrSEKieASWHsj5/SnBYV
	FFZhdjSac6xiTGgAVw+cuctmfHay3jUABEWFiZTifdHXYXIjaF5mzfUpW07CO17UxodKZIWGAV/
	WI7jWlIWmgt6CGUDTYtAAO4QPdLxHaKT0Z5guq7s7fECZ39U3o9ikI1Fypt0LXLtn4bkAIgEZUH
	tUCJQKBFtYS4nPv6XF/MC8+fqWO5IKT6ObwWI8Eg8UbVhO+7rDuzeindKnwd+19g==
X-Received: by 2002:a05:6402:388b:b0:6a3:f4fe:9d5f with SMTP id 4fb4d7f45d1cf-6a6829af072mr27436a12.11.1788290792518;
        Tue, 01 Sep 2026 12:26:32 -0700 (PDT)
Received: from khalil-hp.home ([62.250.116.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a67f94242csm146373a12.21.2026.09.01.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:26:32 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: Mark Brown <broonie@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>
Subject: [PATCH v3 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Tue,  1 Sep 2026 21:26:22 +0200
Message-ID: <20260901192625.1497791-1-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3 of the patch series fixing dual CS35L56 amplifiers on HP laptops
with Intel Lunar Lake and broken ACPI cs-gpios.

Changes since v2:
- Rebased onto broonie/spi for-next (commit b00c00f7dc)
- No code changes

Changes since RFC v1 (addressing feedback from Richard Fitzgerald):
- Added DMI quirk table: GPIO CS fixup is now only applied on known
  affected platforms (HP EliteBook 8 G1i, board 8D8A), not generically
  for all devices with CS > 0.
- Fixed chip select range check: only chip selects outside the
  controller's num_chipselect range are fixed up. A NULL cs_gpiods[cs]
  within range means "native chip select", not broken.
- Removed ASUS reference (GU605C was fixed by BIOS update).
- Added Patch 1/3 (spi core): __spi_add_device() now preserves preset
  cs_gpiod on the device instead of unconditionally overwriting from
  ctlr->cs_gpiods. Suggested by Richard Fitzgerald.
- Patch 2/3 (serial-multi-instantiate): Extracted GPIO fixup into a
  dedicated helper function with DMI-based quirk table.
- Patch 3/3 (spi-pxa2xx): Handles clock gating on Intel LPSS
  controllers when GPIO chip select is active.

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

 .../platform/x86/serial-multi-instantiate.c   | 168 ++++++++++++++++++
 drivers/spi/spi-pxa2xx.c                      |  45 ++++-
 drivers/spi/spi.c                             |   3 +-
 3 files changed, 211 insertions(+), 5 deletions(-)

-- 
2.43.0

