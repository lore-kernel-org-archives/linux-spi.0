Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1842405E7
	for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011539; cv=none; b=GjYH5Unl+IUjC+nUuvb+UltQVB3wPBGJI3n+INcHxYnMub9GQhvddQ0cNAEv1ubTvlX954o58mGPGB0FvCf5WeWIi8QD7w4cfBZtKiIu7VI5UnGB12Cj2NcYvSeipJGdz7EpPGHJmnIrOD7vokMUQAy6xCCUyoxWB5mYNqsWD0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011539; c=relaxed/simple;
	bh=fGMrJdVHO3BNg782zgRhFj4456fWdretKPYfi/QjIgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvgKxkO3aJRY+yCMK1102HLYv0OY0xwmJwo8Y0vk+N8e6iB/I7InhVWR8razXV6vhJYhgltEo9tz+vaeVBuOgA9+niV+31KRUH5OSKvHVNWOSmMInxy0+fhbxNTPw40ygFORgiceENtLe4kUPEKXDtqmvzd8mPv+K37lohNpXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eknjw8Ht; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eknjw8Ht"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c6f1d1282so482765266b.3
        for <linux-spi@vger.kernel.org>; Sun, 12 Apr 2026 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776011536; x=1776616336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HugtwxIexB7rRcOd2FqtNpLxabVB7H+4U5esmVbZeJ4=;
        b=eknjw8HtInTbRpuiEvy4pVfvXNJw4KnC+Dl4HPHMHBtQQBdeIMPiBmb/D477xI6n12
         hUXCNVNSKz+R28UpI3LynqsEinVBvLvJEqSKcvwcsKOxqPqmS0YTS1rq5UPLhTvt42fu
         qcTc7MDL+fpbLXovymshFad/5eQvcdzY3WnwlEjlnlxJOAxDhA+mQOOaGh9vgQlRixXO
         3q8frR2BC9ShLBQ0OKtXGP1vAhvBjM1Fir/iJwqInWK5JNVWd8KOWRITnHCHcPCrmsHF
         mTixKNF7ukiLe35/nnxH6Qu1Gengjnc+XbipfxG/pjHoT+1rbJB4qXqo/sDkHfwzKtwJ
         eKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776011536; x=1776616336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HugtwxIexB7rRcOd2FqtNpLxabVB7H+4U5esmVbZeJ4=;
        b=YMBTJLECWgFOG3QJDg00lH36s/76pjc/wPVN+yzw1sj2qKbE7Z8cyaD4AeRqDJuVpj
         YBDxGP5Uj9lhlsA+3H6Ghx7mlk5GjhXz+OoKBoZ0Rn6kgeuVpXTWJ15JtX7giP2E3ewI
         EBEcEIpoRdEjk1VU4qzCG7lKlMvNGPitp+06Py4v1tDIVibPw1boHIp/8j9oJVRiCO2C
         H3AX9IqMFue9czXpXwFUpnF7JIFVguRO3VrDLZeB+wi9o/L2RjeY/HUnH0WZoNhTux27
         LE3l92nNrDOn9N7MaL8e4jyk7NndVwjhZBCxzsLvoNVOzRSNiBR5oEjy+qWzwOVZWKGg
         CoHg==
X-Forwarded-Encrypted: i=1; AJvYcCVDuf6JGALnWclDt0xQ/w/1d/wl8qG9IJE54bWWiNiCxlAeg+LxW1KZEXWfdLPPCe9cb5254SoWOWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6SDGTg3my3drWT67s3CDCwvv7h9oM5+VJzyey9LAp/1I/mNM3
	9IenLWTjp81+C0620Q+MZG4t3/jPqykTUpDvRNlRjLnetwycCleZMdMu
X-Gm-Gg: AeBDieskYnybKp1/jAkOjQbEOmTGpXDCCze25WcfyjbhCSXBW5+u/23OVmITy0cuRvI
	Rc8JwAX2l+QjRh2NR/xX+YzeBs24Jj0fM+TIFkNNI1RuPrJ6T2DpU5CBcodZuiOUYrO4A0CDNZ6
	d+5dTKyFKipJLbJM0/0ZmvFN0Fd+JeNlpYb+WPZ0Rs2XPmQkG7xDlYNhTQxOv26eU+kGD11kXg7
	zAfrdEIsxf35M8qqxmG7f7PFltSG8Rhv0zLFk7m87+5CB+X0EV9AXMsYX8Z31E2exMVovG4/7+i
	GeLI/yuaD198kw5Xwv7el1zNnwSCSb+ZaXZ3t/AqoNLA9eeStmGhxSOge6OZ20c1Ef9JH8N0JH9
	r76Y/mYYxMyopBwrD4KS2mJxHqAHoN+ExiRcSwGzFM1p08JYiN5Z4M8GA9ER5r3DvoCkoRIBfXm
	KcIq6nnlXB6H0AAIF+NG7mGg==
X-Received: by 2002:a17:906:bf45:b0:b98:36cd:7e0e with SMTP id a640c23a62f3a-b9d729bfe44mr587550466b.45.1776011535850;
        Sun, 12 Apr 2026 09:32:15 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f1a3bsm236468666b.62.2026.04.12.09.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 09:32:15 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>
Subject: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Sun, 12 Apr 2026 18:31:48 +0200
Message-ID: <20260412163151.506282-1-khalil@rentman.nl>
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

 .../platform/x86/serial-multi-instantiate.c   | 168 ++++++++++++++++++
 drivers/spi/spi-pxa2xx.c                      |  45 ++++-
 drivers/spi/spi.c                             |   3 +-
 3 files changed, 211 insertions(+), 5 deletions(-)

-- 
2.43.0

