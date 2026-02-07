Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7912D9EE2;
	Sat,  7 Feb 2026 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770468192; cv=none; b=YcFYVDm4MFX+pCZidzvokERO8vm9gC5CHF2qhYTHP4EJmWmNV+ab3tMUChfZ5kx7icX5hi1icPn2+qcmv8l7C7XQBaLbPbRfSUiWWD+QJ1cV0nGhJHH9g1PSQsmDb/1XkfvsataavZDXybOihtKtFfxUbS87ix2kIwrALZx3hhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770468192; c=relaxed/simple;
	bh=mf3/j1/bT8ZRrs8nb0KGW/ZMx8OvEGnLLupyKZJurPg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gPYDiX3D8Nl7Deg56FlwKUr7H/0Wt589pHPy9MyeJzbvpIiBKkSFAySUxYySUXqi71qVC7CSzIo1Zc3V8yww39Et2W1D0jjnYLl5psGHcAHGG6TqOKQI9hdB2hep+3TdCr5c3nVszpSnzpM7h9msSwTw++ldq6KVdgeuYzfd7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIiSomAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIiSomAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D824C116D0;
	Sat,  7 Feb 2026 12:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770468192;
	bh=mf3/j1/bT8ZRrs8nb0KGW/ZMx8OvEGnLLupyKZJurPg=;
	h=From:To:Cc:Subject:Date:From;
	b=CIiSomAAjku6Mxw4rRcZrKqXHJOflNvKDeJYN1S4roRtaBkDZHmnCuQXl7NeAS6wk
	 TpN7jiYXUeO9vDpD7ASYSmZHQJGfsKWRR0ywxWtEdr9jJxr1vnohMyr3DF7+ARIoNc
	 jwoCoeEjcAT9QPw0ax7z+yMj2g8ZJ+AOJSHwjdVK22iUwY54TdP6Mk8UFW3re71LMX
	 nX22gC+qQGwE7pcBKfiZPta1RAgJ65ymmhGApK0NEDWuLOIih8/mjf/txzP2Gm5jNg
	 5joeySWXNBJ2pwKc7nrsVTtgVRsAEP6XXirZSkReSSN7Swgu2pOshRF9rSae3i+sbq
	 ICWWq7p4/7Z7g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 7508F1AC57ED; Sat, 07 Feb 2026 12:43:09 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.19-rc8
Date: Sat, 07 Feb 2026 12:43:02 +0000
Message-Id: <20260207124309.7508F1AC57ED@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 63804fed149a6750ffd28610c5c1c98cce6bd377:

  Linux 6.19-rc7 (2026-01-25 14:11:24 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc8

for you to fetch changes up to a0a75b40c919b9f6d3a0b6c978e6ccf344c1be5a:

  spi: tegra114: Preserve SPI mode bits in def_command1_reg (2026-02-05 19:29:36 +0000)

----------------------------------------------------------------
spi: Fixes for v6.19

One final batch of fixes for the Tegra SPI drivers, the main one is a
batch of fixes for races with the interrupts in the Tegra210 QSPI driver
that Breno has been working on for a while.

----------------------------------------------------------------
Breno Leitao (6):
      spi: tegra210-quad: Return IRQ_HANDLED when timeout already processed transfer
      spi: tegra210-quad: Move curr_xfer read inside spinlock
      spi: tegra210-quad: Protect curr_xfer assignment in tegra_qspi_setup_transfer_one
      spi: tegra210-quad: Protect curr_xfer in tegra_qspi_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer clearing in tegra_qspi_non_combined_seq_xfer
      spi: tegra210-quad: Protect curr_xfer check in IRQ handler

Felix Gu (1):
      spi: tegra: Fix a memory leak in tegra_slink_probe()

Vishwaroop A (1):
      spi: tegra114: Preserve SPI mode bits in def_command1_reg

 drivers/spi/spi-tegra114.c      |  3 +++
 drivers/spi/spi-tegra20-slink.c |  6 +++--
 drivers/spi/spi-tegra210-quad.c | 56 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 59 insertions(+), 6 deletions(-)
