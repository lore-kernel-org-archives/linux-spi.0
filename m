Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8FC84A3E;
	Fri,  6 Dec 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499049; cv=none; b=VoXgD6y4lOf8ZEePUUTFy3moyjawKAWOOOiTnN7JpEa8ttxqu9bIUM+eMcJue5w07OeeR0Hau+nYO1BgOocIoqQM1/IU6WcimQOvYQoY+vT9fDnvlyijoJ4oecSPM4ZmOOukB8qWASwyI9G0/iMCi5UfykjWoMC7Imp3elU8rrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499049; c=relaxed/simple;
	bh=+Agkt1IA2btzFSg+NrFAUU2+rxwlneDR53xx8aRVSAQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=UhEpday3B+AfEx6cjcWvzmRYIi3TU0xHc63eaBYonYULOHD+/795cWFELNFrTxGJwFVgCVQIYYFyzbN4PxxvWlOH0btXRn6vdLRUNDiJuQYb+xZ9lky4dEc6aXAR4BMyc7g72EU9A7rvtR+e7RuI5+ZBdHjSHjeO/1ps5XPO0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE/Uvivx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE/Uvivx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E984AC4CED1;
	Fri,  6 Dec 2024 15:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733499048;
	bh=+Agkt1IA2btzFSg+NrFAUU2+rxwlneDR53xx8aRVSAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HE/UvivxcRzk3B/sLR4hXd/yLO5b+unqAD7Rypo10+rrcxbnvsmnTPLtjoIP8VHxs
	 xpkpiYyBmhfMLICzdQjECdf50ObBv31hYCTkR4h2BJQjM4eZ24pAkluqbT1gqlP0Lh
	 4VLCBHX0dtydjzghIVn0F/HVwQq0Lm/2pJbl8wzrMsLtdhYdL4aBXKRK9hZnPHqJC5
	 HDX5lfrJwVEwN3qMpaEOR6SuusuvgbmYzvBOCh9OsQtLC0pLMidFkJaQwIL3R14PQM
	 /yadJVKQGMEF6pcFqq27LqR8MU9Z6IYoZO/FeD5t3YGiCPNfjDYiaJbbLGh+OORHUa
	 +Y80uvzQO/4yw==
Message-ID: <95c3aaea3b0fa248c2a9a5a852c444b2.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.13-rc1
Date: Fri, 06 Dec 2024 15:30:37 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.13-rc1

for you to fetch changes up to 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad:

  spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled() (2024-12-05 11:32:26 +0000)

----------------------------------------------------------------
spi: Fixes for v6.13

A few small driver specific fixes and device ID updates for SPI.  The
Apple change flags the driver as being compatible with the core's GPIO
chip select support, fixing support for some systems.

----------------------------------------------------------------
Aapo Vienamo (1):
      spi: intel: Add Panther Lake SPI controller support

Pei Xiao (1):
      spi: mpc52xx: Add cancel_work_sync before module remove

Purushothama Siddaiah (1):
      spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()

Sasha Finkelstein (1):
      spi: apple: Set use_gpio_descriptors to true

 drivers/spi/spi-apple.c       | 1 +
 drivers/spi/spi-intel-pci.c   | 2 ++
 drivers/spi/spi-mpc52xx.c     | 1 +
 drivers/spi/spi-omap2-mcspi.c | 6 +++---
 4 files changed, 7 insertions(+), 3 deletions(-)
