Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F834519A0;
	Fri, 31 Jul 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521110; cv=none; b=RWZz8nZ8FcXfuBL3KUvwxhF7akH76ILxeHhEyIfPI8Sbbz4sxNks7tyLvOLrbBDUYTdRps4KXheX37tUio9KEon0HW2Th6nHQosiC50XvSz1/9j29k/oVazksdJnUgLqOxVNlW54BI2J5VimJgpSNHoSd6jKkPz/2tL9L9hFLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521110; c=relaxed/simple;
	bh=vT0bphIuHRIJBEUkwzchbG1dvvO+qFTmQvv615Hjliw=;
	h=Message-ID:From:To:Cc:Subject:Date; b=DxCxvjb9h8EQYE634pgNAja/4+ZHen7OTH8goEp777i+SMYLlHGiKQQEzHLhH2nsslQbfdKAV052k3pgoH4hTO8wns35nbwfgduf1/UeQK7RHKEv1ETZVsMaOLLwNu7UXZu6X8T8GCV8CsLNXhnQWA+m9CkCS/VyrCSVWZ0/XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6Dvy9O4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6Dvy9O4"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 47C261F00AC4;
	Fri, 31 Jul 2026 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785521106;
	bh=ND/fxAXoknVogNugYMULwU/JiBjADi3TUDRfj9UxEf4=;
	h=From:To:Cc:Subject:Date;
	b=Y6Dvy9O4Tv31dZM8PI+C6lApKJ0K3Ke76sZR4TA1Kb5OdA6oVuaE6Lc3ugWjH2byj
	 fWYtlrMjawv+5Do/Tygakma62gm0Fuz3RmYXbMqDe/jZMsXaI6dYXRDouAaHNW8Flr
	 3N42CNjx1pfBmHut63BWR0AeJyJKduJLg1VhCTkO+T6AJ1lL971rhRJtrQbO4GR0nS
	 CMAXIXD/4tfCGlu2adbxWaMnUbdTwKZegVotiOJAzreCGuqLbQEapqaMIiyh/rSnfu
	 6gqRj9OsD+a8xyIoVImeJMDCmvWFMCwIikQh5UotpuZFRbvfmjIiMxf5FfavDkeXAl
	 nYBFKHAiT1TXg==
Message-ID: <7c414832b0625d7838a18e0bf589b4d4@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.2-rc5
Date: Fri, 31 Jul 2026 19:04:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc5

for you to fetch changes up to 9513b642d233bedb0b703ea75b5f3230eb6293a0:

  spi: Few fix/improvement for spi-nxp-fspi (2026-07-30 13:13:51 +0100)

----------------------------------------------------------------
spi: Fixes for v7.2

The drip of driver specific fixes, mostly from the device vendors
themselves, keeps on coming in.  There's more than I'd like right now
but equally nothing hugely alarming.

----------------------------------------------------------------
Haibo Chen (3):
      spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits for all supported SoCs
      spi: spi-nxp-fspi: enter stop mode before reconfiguring MCR0 and DLL
      spi: spi-nxp-fspi: propagate clock reconfig failures in nxp_fspi_select_mem()

Mark Brown (1):
      spi: Few fix/improvement for spi-nxp-fspi

Srikanth Boyapally (1):
      spi: spi-cadence: Move TX FIFO full busy-wait into FIFO

Stanislaw Pal (1):
      spi: spi-qpic-snand: write the feature value before executing SET_FEATURE

Surendra Singh Chouhan (1):
      spi: spacemit: prepare both DMA descriptors before submitting

Vijaya Krishna Nivarthi (1):
      spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure

 drivers/spi/spi-cadence.c     |  26 +++++----
 drivers/spi/spi-nxp-fspi.c    | 129 ++++++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-qcom-qspi.c   |   3 +-
 drivers/spi/spi-qpic-snand.c  |  22 +++++--
 drivers/spi/spi-spacemit-k1.c |  22 +++----
 5 files changed, 166 insertions(+), 36 deletions(-)
