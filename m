Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460BA35A3BF
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074745; cv=none; b=jiiDZsx3TxHixxiU3yHHU6l+yJQt27aivOYFAKzJgbbWNgcAoGcxrdg5xFqGpxgh/2kRFcwHsxn4vgN7sQeBijCrIDS3JttczzUX+suqiQccg+f9HiAnhEpBImviWfOhgYLb3A7bahJ6VRTQlvuW4s5InzmJ4lCGrVKa6QykfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074745; c=relaxed/simple;
	bh=V8Tqks5In4sCz8giKkpBV74fLlrmr6VF7pNbEc32CZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mG7MMALh+rc/bEcqgi89O1H1Twb4y9TKxOoLjG7LqFQMyNxayIBLZBjx2qHLHHVSTpqtiWo5BxndOqTdM2Q5rFLP32vcl30x7PJMV+fqVnqdMwUI+NBtdJuofRW1LdOAzDo1L6/iSUlUYEpUs1+25HkWGFqyLoSO+FjynTTZrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmQVPFd8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmQVPFd8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6717d83f0ceso1187116a12.3
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074743; x=1776679543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mP1ngGhMs2oVA/SSWUiO4CUdC3iL7pughQ6YpYY6ZLo=;
        b=jmQVPFd8o9PA/5mVVbSMEl+mtucuQ5pcGLPZb4uw0UMrgrMmVZBOxZSDiq+IxY0uaa
         Gu/uYLCErZ8GfAAn/sIMOaXcsZpxNG5lT1atudrmLXZDFlQPnnYa68ZFo4HMTYV9ZhWN
         WzngYkpJioxabVy/lN9IANcTgYE8bdKRgrCwVUzaZ+Vpaf7O/CvMoKXyJqzgNPIZWsIj
         i4d2x0s9PYjs0veTnwVdqSIzCD/Tbi+Vx/drjIi+UxYrAq5ba1kmxaEBkYziJtHvOhdG
         BVTMWKG/RQFoLX+fWG4Nep7PrLqSxkjF4pgmvKXXxptfN80H9unoq4EYoRd8hIrzyX+L
         LVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074743; x=1776679543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP1ngGhMs2oVA/SSWUiO4CUdC3iL7pughQ6YpYY6ZLo=;
        b=D9tzrpnlibafGCfr78/tTVHfWCyWRsRGLVf69KZ3RPfIadBEIEUpke9vyrn9lhmb4h
         3QnlO7XZrXg5M1AnBw3OPS3xDo431v9f9hHty8MxdYSebfoWwDxOVBBcqSZ9fbubFBbr
         I3pulj9ThmeL9joh3PsrWEi1Lr64xU43OUT1BosLozF7LaoQT+F/32nyLGAmrnzjPJHB
         a6Qv1lt5Ah/QQDIkHguLLOkLEBGcgQAys9jkDhUvh+OYOFhAEeXkKFhJRAvqMMP0+xCp
         rDCoPd2d0PlaKdm8bt1LDax8dRCOiydv4LMcSV5RI5qccaIbgRmMcOyilLN4yn1RNygR
         enuw==
X-Forwarded-Encrypted: i=1; AJvYcCVcG0QMJBUq+5oC9MhCoyL8Z3jwS2gxSWcwTnfqBphf1zJJexZS3cEIvmo/zFmMogSWg3k7fBOAif0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ccsGVTaeqn1AkzBCsrTLHM6wYjGH1UiR2YwfwD+Vnl2Eqjym
	xJwLdI1GDMIVAIS9hs1Zt2Og+czbJGdwvHYztYl+pnN6G87a+kRqoOOg
X-Gm-Gg: AeBDievwK309eMonN50SsSvh8AGyCeb6JcwTWZB9WKdVcydFfS9Cg2elEAefLntcuOp
	4hd+W3gZebVaILdd+tr+uoKdS3larfDrWkWEABPA5RMFO3Kqz20TeWMglx44pUh1cbOdb/uVW1z
	XXv8e2rvMJ5bnsB4uwCkj/3sagE+XvakiuInuIHnrOrFA9O3kLHQqCySvnoKrRl6Q+fNq1uhTLt
	7afQ6YECfuGFX8eQK3up3dLiD+KND81oCLZ2vztvEKkr3VSjiTXUb2E2r1czdiegEBu04IzCyRT
	WTqzhUiRYkjr9GR6l28OpqOf64OStIgxIDr+TUtHJ6jiBZ3mLXgs5VMKmsG8iIR7RVdBIYdi3yo
	A8QLHTLK1SdPC7fUC/zV0ZC/U47zvDjLTClOi3+A99BAuzlkJtMN4LAjD8o4EtmffBUr8T/Yex9
	Gieo3pEbIbfXUdW5irpcXqnA==
X-Received: by 2002:a17:907:d0d:b0:b9c:f69:598c with SMTP id a640c23a62f3a-b9d725ebe50mr697293666b.22.1776074742460;
        Mon, 13 Apr 2026 03:05:42 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c5824sm297805066b.38.2026.04.13.03.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:05:41 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>
Subject: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Mon, 13 Apr 2026 12:05:27 +0200
Message-ID: <20260413100530.580649-1-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Resend of v2 with the version tag now present on all patches in the
series (previous send only had v2 on the cover letter - apologies for
the noise).

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

