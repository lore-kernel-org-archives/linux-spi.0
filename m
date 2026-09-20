Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C052F8E8F;
	Sun, 20 Sep 2026 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789893024; cv=none; b=qoNbFZdOTDL+HIoUCYRN9mtZQZD8hX6kt1MYBYchoTLVXfR/PBtBP2R/dQu8mCB/lGK7TYZyOviJxajLisifckAy6wOiFJ4LhxChH3GgYX7hnlB79/y+0qdYtpVDvo3SI7DuV8cHmmzpuPqhpoZkaXi9zZ4VJfjmJ1OxrmfszV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789893024; c=relaxed/simple;
	bh=5Ufzj55crcPSVtJnyqaSePwW0LwWwqKoAHn08k8HfyA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TFFXg3Qj42D5cnvsbhpbnKCuPdba83zN7b/a3+Bbe2ropcyR6PKViXAOXN42JlVKcuW8WKCnXBjLHdBR8nga1VEF/Dpid1FObY7iANaHpkWazf2A22H573N1GESn64t39oazw7tF8laNDQQFMCH6zsxzdlPzJdw4hCldCDnGAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fybt8gdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fybt8gdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8FC1F000FF;
	Sun, 20 Sep 2026 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789893023;
	bh=+sep99UlUe6/aWG7LHBMEMhFdHwW8S8H/i2ubu/s5HE=;
	h=From:To:Cc:Subject:Date;
	b=Fybt8gdK1061pxWF8bdhW1bh8gRAqSMByWBV8XjgJsvY5X64C/IxBzOrO5W8UX2Os
	 KoIKifERb8IpYonsLR7TubyOvVh0uVk3w9mkQbOgEzV9gkLRARBxcI4BvpJt1xvFsa
	 UQWMw7o09+GSNnrdYcP1OyukujKR8Qo8magJy9+Ksin7UPLew6C7Nl5Lrj6jPA3IJZ
	 CtpEGjRV0OSkq/L25C3uSpPnyye29Le2A9RxE6mi2zymd9AN7NpHo3Z8JgFhwa0iOr
	 SBCrdgAW+/AK0xl+7GA9xj4OkaLoye4aRHh0xpDK+Sa5O+R0fqkRGdJW3K2UI4wvPj
	 5JHgY100PpSHw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id A96F811D3CAE; Sun, 20 Sep 2026 09:30:18 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.3-rc3
Date: Sun, 20 Sep 2026 10:29:59 +0200
Message-Id: <20260920083018.A96F811D3CAE@traversing.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc3

for you to fetch changes up to 3d743adf090cd4c9a2120c1e02b0482e88aa0d2d:

  spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes (2026-09-17 19:46:29 +0100)

----------------------------------------------------------------
spi: Fixes for v7.3

A few driver specific fixes, none of them particularly severe or
unusual.

----------------------------------------------------------------
Frieder Schrempf (1):
      spi: fsl-qspi: Reprogram the clock rate when the operation frequency changes

Gabor Juhos (1):
      spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG register

Hao-Qun Huang (1):
      spi: virtio: Use the per-transfer bits per word

Itai Handler (1):
      spi: spi-zynqmp-gqspi: stop the controller on shutdown

 drivers/spi/spi-fsl-qspi.c     |  5 ++++-
 drivers/spi/spi-qpic-snand.c   |  4 ----
 drivers/spi/spi-virtio.c       |  2 +-
 drivers/spi/spi-zynqmp-gqspi.c | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+), 6 deletions(-)
