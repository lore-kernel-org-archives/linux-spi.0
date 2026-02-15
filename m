Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFC290DBB
	for <linux-spi@vger.kernel.org>; Sun, 15 Feb 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771163777; cv=none; b=cocIEGOS+xG/N2crBO6QuPoPznCngMmAQ0CMLcX4Dze46KxM1zSZFGcOtDl+jDvq6NOqUlX0wn2m2SqVmdcWyysuM4Rn1XgNVfjy7+G1l24J+Wv1IhaKV+mhx9mTiXif59l5FGe/GU3vRsanGqmi9MtG7I6eZI31eg1lkroMMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771163777; c=relaxed/simple;
	bh=+WJiQte+AsZ/dUhzrC0dzyP1leIpbrUwR2RY5EQmbUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpYe6cNdTxnnamzJY8BMiUKssiAnCoakrHOYC2NtKYtf+sqrI750q8FKC0C/cuGQR17n578NEUc0Qvr8+WwWTutpKRZgASPxwL2YlNnbqzw0fjjucMwxbkfuAQeChg9R+2ZYYfcZ/ZXaouQIE0w9T24DiyfZLmqTsJ5yTBvL6cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfxO+zZa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfxO+zZa"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65a26c220b6so3216294a12.0
        for <linux-spi@vger.kernel.org>; Sun, 15 Feb 2026 05:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771163773; x=1771768573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KHB6jjovGvHbln1wA1V5AA9RwOqt3Q1qKjY8PY62RDI=;
        b=OfxO+zZaMwjqD4WcNT/NsXIyJgXO76LfX/Ce+MU5e9o9GOEY39Y3jD+0DE2QVY9+1D
         Gaq9vJGTpyQmxJ2vJQXeQFL1VO+JIEdWPJjrxH2h2e9yN5Igv9q5ZaPiSbjSRLn49aHo
         lhSj35j/Ty1k00tY8mX+Luo1ttOiBXGmSjVA+U2IF3dLxsy/ATxoCeW90s8vRWgVhTKF
         xFRkSKEgEp8nvyEo0UoI6InyEqnknKi/sU4pOKbjo58gDE7kGxnoOIawilvPfA5h2eUX
         DVjMa+456/4r3cu9azTey0duVx78dl8UZ6aEm7V6WLtiOdrHqkV2IxTA/xD3oSwxyXka
         ifwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771163773; x=1771768573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHB6jjovGvHbln1wA1V5AA9RwOqt3Q1qKjY8PY62RDI=;
        b=efJhjq7EgDy8eQXOR/xmiplqVJhtzgb74IzsqQGUdKG1NmtaRUDeTzEUZhiBiYeXtr
         4AgdAqnG+3ga22Wlb+j158wM/cbpJ7ZqXxpZzzp36IPBbd9HEFhQ8DsGJL/rZBHp/zVl
         Oukq8w72JLQygVsGvWGyNQjr3TBStglfOx5DxBVf5yX92jD9s2V4UVegk7jH6lO+0u/5
         6VOI4UTEsDQdjkFFIGQbBVnhzgSHOZQbNPBvAF0/Sym4NjLlMb2eAqi4ozvfFGp2lLMs
         pqRIdQ6/ZGTaH+b5nlTL2K+ngKFB4w8ydFWFkYX82y7L3qyBBq6qIwS/UFkH5txVNYgO
         dvmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1AMOJDdLVuWBEujftYLPb/uYSCotn01sbowsQNGykxnGxPbq6mo/VcloPaXhdUlWW45GyiJEuWKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaHNRUVt3OXcc7Wg5zNGKjpfqTjkG3Npv1SGTlLdM+GYwXUGOU
	Od6zfINotxhXFXWb/eI3D/lLRxh1ZILb7xxcDhCeMV8tlc5Lz4NryzNw
X-Gm-Gg: AZuq6aJ/daLpDy5edeWCqCa7Ovk4XXiWWjCToFFxrX5mJpDn6jv6HI3HtpPnQOmGvyz
	BCBTkF8MJHIodhAmbeJ+BEPoASqyjpSnWJhOEzfU0+t6O8BTtu9CW/i6VDpNfteqIZUVDid7hnj
	alRBPjnDXsXl7ipMjn9c2dp1be06f8wqu3+rrlrhokiStCL/k3P53plOjih/qoKT30N1hCLjU81
	Tn95xU5Z/PORXwtxJ4ITZ0QyFZOhv5/01K8k8ybXnKCU/528jSnPEK8zVDAgEVEuWI5QZlRhjb5
	cmnU5D1jOFGIIxO+E6Li5lfEnVEtAlN2nofhB1FXK/Y0Toink1Q7uMbva+74W6fcW8DgOzkcMDe
	sR+ubQj/PNnjyR4l7ucE2jK0LSvXFLXyijeM4LDtHV0VPfWXvFYLYnd6z9rwoEjxEtuAEEP9jXn
	rt1O0BENSJXnYub/SvANttcQ==
X-Received: by 2002:a17:907:6d17:b0:b8f:ad62:edc7 with SMTP id a640c23a62f3a-b8fb41fc64bmr418527566b.24.1771163773144;
        Sun, 15 Feb 2026 05:56:13 -0800 (PST)
Received: from khalil-hp.home ([62.250.67.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7626bdbsm164179166b.40.2026.02.15.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 05:56:11 -0800 (PST)
From: Khalil <khalilst@gmail.com>
X-Google-Original-From: Khalil <khalil@rentman.nl>
To: broonie@kernel.org,
	hdegoede@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: rf@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] Fix second CS35L56 amplifier on Intel LPSS SPI with broken ACPI cs-gpios
Date: Sun, 15 Feb 2026 14:55:22 +0100
Message-ID: <20260215135524.1171065-1-khalil@rentman.nl>
X-Mailer: git-send-email 2.43.0
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

Hi,

This patch series fixes an issue where the second Cirrus Logic CS35L56
amplifier fails to probe on several HP and ASUS laptops with Intel Lunar
Lake processors. The amplifiers are connected via SPI, and the second
one (CS1) always times out reading HALO_STATE (returns all zeros).
Speakers work correctly in Windows.

The root cause is a broken ACPI DSDT on these machines. The SPI
controller's _DSD declares:

    "cs-gpios", Package (0x01) { Zero }

This only defines CS0 (native). The CS1 GPIO entry is missing entirely,
even though the ACPI device node (CSC3556) does define a GpioIo resource
for CS1 and both SpiSerialBusV2 resources correctly specify
DeviceSelection 0 and 1.

This causes two problems:

1. The SPI framework has no GPIO descriptor for CS1, so it never toggles
   the actual chip select line to the second amplifier.

2. On Intel LPSS controllers with dynamic clock gating
   (cs_clk_stays_gated=true, e.g., Cannon Lake and later), the SPI
   clock is gated when no native CS is asserted. With GPIO chip select,
   the native CS register is never asserted, so the clock never runs.

The fix is in two parts:

Patch 1 modifies serial-multi-instantiate to acquire the CS GPIO from
the ACPI GpioIo resource and install it on the controller's cs_gpiods
array. Setting it directly on the spi_device doesn't work because
__spi_add_device() unconditionally overwrites spi->cs_gpiod[] from
ctlr->cs_gpiods[cs]. The array is reallocated to accommodate the
additional chip select.

Patch 2 modifies spi-pxa2xx to handle GPIO chip select on LPSS
controllers with dynamic clock gating. When spi_is_csgpiod() is true,
cs_assert asserts the native CS in the control register (to enable the
clock domain) and forces the clock gate on. cs_deassert reverses both.

Tested on HP EliteBook 8 G1i (Intel Core Ultra 7 258V, Lunar Lake-M)
with 2x CS35L56 Rev B0. Both amplifiers now probe successfully, load
calibration and tuning, and produce audio.

Related bug reports:
- https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/2131138
- https://bugzilla.kernel.org/show_bug.cgi?id=221064
- https://github.com/thesofproject/linux/issues/5621

Khalil Laleh (2):
  platform/x86: serial-multi-instantiate: Add GPIO chip select support
    for SPI devices
  spi: pxa2xx: Handle dynamic clock gating for GPIO chip select devices

 drivers/platform/x86/serial-multi-instantiate.c | 83 ++++++++++++++++++
 drivers/spi/spi-pxa2xx.c                        | 35 +++++++-
 2 files changed, 114 insertions(+), 4 deletions(-)

--
