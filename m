Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3D371CEA;
	Fri, 29 May 2026 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095656; cv=none; b=hDn7AxqgmYmI1XE4cfVLCMaADT2Rnm5TZ3J8wozb0wL4kEnUY2+YZxZbiudPH1ygkpAiXnSVIUFumHzJTsF0+RgLGDm4UgrACVftgfXyerQo9dpUwDTiqYhgjtGJ8SWt32Uv5n7NLBbZPijeCgUtizB769bS68ebK8lcYiKW2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095656; c=relaxed/simple;
	bh=BOAwUoIzJ6aujx3ij/6a9ejAOTmuM3U0soqjfLhJkoY=;
	h=Message-ID:From:To:Cc:Subject:Date; b=GrTEybx5O7MOp/yJFGpT/Qq22dWl/WaqCs9obMXEhs8kNeFb7wSRW3HfgChigDfa7m+/is7bmU8efQfoZsOIUvPqfKoWlQEVm3AsTFjxEyKgY6twn2TW2S5/Dfwly5N1rG7bvhw+dQ77219gyQ3Qhi7Ll0L3m2Tsd+Xj7Q5cWjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab1tpNhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab1tpNhA"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C1DB41F00893;
	Fri, 29 May 2026 23:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780095655;
	bh=iKM0uNW7bW0gUnHsl31ol8xet9x1YqFfKoo2HoqEGKc=;
	h=From:To:Cc:Subject:Date;
	b=Ab1tpNhAkiuNAaXn+5nT7lvd/E5sewRLIGv7i05VAIb1op/WKu98sIc0RIzssMfeP
	 H8BeTj0clMAG9KvXMW7KEZof1ksCuPCr7Ri6LO+aNSi45TG9FuJtN6r0Cipvl7JS00
	 6Pou2hysEA+6e6TkM2ghMubA2+9s8as9BLsKsR6p9Cp9UKOiidvT6cu/mmEAYG4LU5
	 khWTjTlv6/gq5IBLJRPjvlWyH8b+KDlqVPpI6AWvUpxfXRQdCkjYlYzdFyIR7epxiL
	 Mgh5EfmQKerv7A2fpG1JoMfdJ9LVIv8kbuQGNRQu4r3QH9Ds9FSMQF6h2CO0RR4jjo
	 2DqevnqjEK3Aw==
Message-ID: <882ea35db619e3f9c74cca4619e9eede@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.1-rc5
Date: Sat, 30 May 2026 00:00:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc5

for you to fetch changes up to 79378db6a86c7014cce40b65252e6c18f5b8bcc2:

  spi: spi-mem: avoid mutating op template in spi_mem_supports_op() (2026-05-28 13:49:00 +0100)

----------------------------------------------------------------
spi: Updaets for v7.1

One substantive fix here, fixing corruption of the maximum frequency for
spi-mem operations which caused users to remember what should have been
a temporarily modified maximum frequency as the standard going forward,
potentially causing instability when the modification raised rather than
lowered the frequency.

We also have a trivial patch which just documents the correct way to
describe the Qualcomm IPQ5210 SNAND controller in the DT, there are no
code changes.

----------------------------------------------------------------
Santhosh Kumar K (1):
      spi: spi-mem: avoid mutating op template in spi_mem_supports_op()

Varadarajan Narayanan (1):
      spi: dt-bindings: spi-qpic-snand: Add ipq5210 compatible

 .../devicetree/bindings/spi/qcom,spi-qpic-snand.yaml      |  1 +
 drivers/spi/spi-mem.c                                     | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)
