Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624643B19AE
	for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074527; cv=none; b=A1mw9OxUKp3ohpBQvVKllBo8eb1vqVQN9lRPjCg69CWsVgUAtWsArxC6SI05LihJmb6/3M7sdry9gl21iUVpr1GwUxbarUZ9iMENRDq/trPWlQQOjPi39q3lnlLlZ3g1Cal8McMi8WIQT6WJ4bgLStLipnJSu+joeevq11P1zKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074527; c=relaxed/simple;
	bh=V8Tqks5In4sCz8giKkpBV74fLlrmr6VF7pNbEc32CZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XB64Lr419vTPwvO5C7+VlIVwcyNUTojW6Xcb6q3xfBgfExJO1KTV6Jne060mQvm9aR92FuvaGn1yz/Z+4xgP94iArpp2v9zLDnidzAhFpecMeHg0vhs9OP+ksikS1oRERyB6i/9G3s0sRYKHlGKAG+SzeKqH6btrHj2obRS4UTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYQDTtip; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYQDTtip"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f97c626aaso652833466b.2
        for <linux-spi@vger.kernel.org>; Mon, 13 Apr 2026 03:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776074525; x=1776679325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mP1ngGhMs2oVA/SSWUiO4CUdC3iL7pughQ6YpYY6ZLo=;
        b=PYQDTtipJolVXZkJrVNHJhxanHZYhRuRgtHYsgUpl+KykEgZIGU5LMnIKyfl9aXl11
         u4hISQ2dXri8qKY1o9JLZV2iXqVpajPyZGjhAdoYcZOy7RByuPiweLj7tV2FlS5jKA5b
         5iGU7M2ohO+M2Fq0eweAioaw3t+Gv80T3k9PNaOTdsDS2YuplqObub+U4/IjjoCWhMBX
         b4HU5DVExzPbl0xibM4vmGy1zIsS0LiGCwIfYhjgAwvXOQIpqE87ImK5i/ds2bVipqQD
         n6QqD/taORzGH6i3alNGY+fEA7FOFhTOHyszjpOXshjTMR5YF2DCD67eNRALVvQv5UEf
         ixpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776074525; x=1776679325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP1ngGhMs2oVA/SSWUiO4CUdC3iL7pughQ6YpYY6ZLo=;
        b=SefzgfYTwU56hYa0QJUPKBlxEbvwLWKIBUKd13HbEvSN+z3D2GxWZRVMl9WpVbFhwO
         oN19ASURdh+fLxpQ1xbRm2mh6CNtEOPiPsq1hESG+AcpPBVdf2VzDBAFAhS24Qr9GSlu
         wTNfa1jeIzrk91yQwnKBpFALdRVkmK8+WWtmaLMBkTOqZNBQDedRUpcUHTNg5LdSFVeX
         BVkQHB7LQw4lWn6LGYJdUbksWfHjTf5qMOkmjX207uIt+6Ks+YEm8TbQsqWKr4ARufcB
         Fy16rL9OSgr75Rse4/Ffk9sTmJ7qkHSIckGa6023dGhmjRefSoSWq5tsBgfHEgRzrLlF
         qPIw==
X-Forwarded-Encrypted: i=1; AFNElJ8/YWp5nezUOe/Qyu1gaIXMI8V6Jzx5+G/1am5AikUcnNSkcDIZBzUXfn3Czj8WhzfjPQkae9g3dA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx77s/E9mpdQ4nv9FvMh0UjW/s+ZJMSXjqWzpP67zFWDfldXHh0
	M1Sw3USuI9M3kXReUQrIyyinua0w3NsymyBCuF2IGT3cwEclEGpgnozp
X-Gm-Gg: AeBDiesfI7ftg878v+HUhe50mfcZr8KpWv/v4PtDniY3isBm8yEhr8Jczh5HAI9Ys2s
	FCtupG5SGKRT1A26J2Q9jQk+QIkEav2vfgj0ifPYp3Yjo4vkrTkYTmijpre2wVs9bKk/ZEdLFjY
	oLIU58/x53AM58XACSHP453xTo8BUc7gRWE7d7EOT4gmIlQ5rDXMIfDwVGfO4hUmUZbRx+ZRI5x
	Ex0XNa8vBXajTosZDzgfyzRTGHFvLncMnBHpbD18thhWQ5SBqmaBZP0UndAlnAJVnIVQ6GE6JR/
	nQO6D0tbWMR8SAu1nq8FEAASCqNV7sb2FkBe5zSOUPa7oy75YTw91n87OBh6DUbWcImOcfgLYwI
	uZRDWsoZo9n/Z1gi+CYM2oS+eGVZCJdceauk9V6/GTnibM7o+Rz9YU54fUVv+HS7DwfhxOBEmbq
	oIG2UNaEm46jgxmtVSoPmykcm2uvgVTM8q
X-Received: by 2002:a17:907:72d4:b0:b9d:e352:f7f4 with SMTP id a640c23a62f3a-b9de352f82fmr152429666b.29.1776074524194;
        Mon, 13 Apr 2026 03:02:04 -0700 (PDT)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7f189esm291993566b.58.2026.04.13.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 03:02:03 -0700 (PDT)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalil <khalil@rentman.nl>
Subject: [PATCH v2 0/3] Fix CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Mon, 13 Apr 2026 12:01:37 +0200
Message-ID: <20260413100140.579845-1-khalil@rentman.nl>
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

