Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743505;
	b=BE/DT2tdcSg/Yo2GslH6iAp2J3PmV+HOGMzIXQcBi9KhDg7QJ7/jNxVoTDHynH+BYiiz
	 0gHNL/1niciEhk6g1KJ/RUZjgfQJXXHeTD0JXOd8eslaE7uz+J7KxTy7lQtvfAbybXGTs
	 K1HpiqgxFRY6N+GFSyslcRT4eOtEVyvefJRimbNQsrgtFktTsAyM2pU9NVj8eZIYe/FXK
	 nTYtR3RhRLTpOAMbrAVLXGm6MSoZGxANZSXDES5ry06TvEwGrf1OETlkrkOu9Ls4ALz1/
	 rdrjQdtKX9v8QqjOHiqW9CUfq5ETf/N+HLrfpUnKO6a4BIinn7NiA24e0MiDAOeg0FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743505;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id;
	bh=am8aGxeUjEV8mutZp0JlxrCeFpqzRNJXUrO5XnK/hcs=;
	b=z426jhrEnXnsRHNFgzo7bjQhBVIFa4CPNCHNy9QJDWKZ0pdOI6G0izxrniggFaPllldg
	 6PnmV+zcmWFNPeJD2lj1jvroQxjfyDdXfpY3mjfNtwWPLWqw2ExEfzww+FlTRMBbq/JK2
	 TixNHvVVZvO+RKe8X2noiSnXv1BDXALj0J+icwPEk5SInF2Vc14x54ys0xKGUdcB5HvCJ
	 2IKVo6eQW7FdEBw3uoLZP9/WuZ9EPyJ3zsy3KE40i/4xBQ6TXw+siqc9bO0+BnRFWEbeX
	 aOioramqYr5yhoLd85LsgMDhBoLSP5EWj0Dunw+VH3IgbHpcFCZ465sifmRGYDQtqyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gqbw+agc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7A606A323;
	Sun, 15 Nov 2026 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gqbw+agc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C62A1F000C5;
	Sun, 15 Nov 2026 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743505;
	bh=am8aGxeUjEV8mutZp0JlxrCeFpqzRNJXUrO5XnK/hcs=;
	h=From:To:Cc:Subject:Date;
	b=Gqbw+agcXEiaTThkwxDD6VqV/dtpwGE7oiDYKUXD7RtSdC3V3v6OkrGXNHRQ/VjJY
	 XBE1jrO668HO0nVbauZCCDE2gURzmfD8Kgs4YEOkHb9WQgwhl8JY8vq3fxgl36NdMW
	 60fNoG6Qptoe6O2m1Rzh4hgC5Yv9gvCfwtbTIOkM9gYJCGKov80sAo3y+V/01zQhX+
	 V5GFwWJ6ovwBy1Q20wxmQL4XWHcQlxX9VUFmXuts0wWckE1NJocujX9SGKjz3P8guZ
	 f0MTAmCbgGYeAHAhRzWiREyFFIJK4TBfK94lVeJBHvUJU2FOMnVnu/vEmADvEyvJTh
	 EetvzdcxGsoqg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 07B293367B9E; Sun, 15 Nov 2026 11:51:42 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.4-rc2
Date: Sun, 15 Nov 2026 11:50:52 +0000
Message-Id: <20261115115143.07B293367B9E@traversing.sirena.org.uk>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc2

for you to fetch changes up to 2a490521d74ac76e5eb3c9a69d928a4c76dd3f78:

  spi: axi-spi-engine: Start the program length at zero (2026-11-13 16:26:07 +0000)

----------------------------------------------------------------
spi: Fixes for v7.4

There's a few small collection of driver fixes here, the usual story
where none of them are super remarkable if you don't have the have the
hardware.  The largest batch is the Tegra fixes which are mainly around
error handling.

----------------------------------------------------------------
Francesco Valla (1):
      spi: virtio: move teardown to .remove()

Kees Cook (1):
      spi: axi-spi-engine: Start the program length at zero

Linus Walleij (1):
      spi: dt-bindings: pl022: Allow a power domain

Mark Brown (1):
      spi: tegra210-quad: Fix timeout path status handling and DMA leak

Vishwaroop A (3):
      spi: tegra210-quad: don't overwrite refreshed status with lost-IRQ snapshot
      spi: tegra210-quad: Track DMA mapping state
      spi: tegra210-quad: Unmap DMA buffers on transfer timeout

 .../devicetree/bindings/spi/spi-pl022.yaml         |  3 ++
 drivers/spi/spi-axi-spi-engine.c                   |  2 +
 drivers/spi/spi-tegra210-quad.c                    | 52 +++++++++++++++++-----
 drivers/spi/spi-virtio.c                           | 26 ++++++-----
 4 files changed, 62 insertions(+), 21 deletions(-)
