Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63A74B99AA;
	Sun, 18 Oct 2026 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792329833; cv=none; b=Yq2dUlRjFpZelSaIgf+Q2zVXOxzufZ7po68SyoMoSCW7eVPeybeQ+bl51qS0+D5vR5pwckSmtVaD0q3yFbTJiFf5pAgow8VeLGeCr0FnUUBcrVKkJeNOaJ1HLrsjaXcVjnE0GbPcdyKvE80UckrXRQhvRt3wxtRR6wUF3CV3h78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792329833; c=relaxed/simple;
	bh=rQWYc7acpJZ0IDkK+pfUP/nyFAIem1Dg+o5rNUhc9+A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=G//MXNDfI8Ho5FrXaPHDORSyaR/FEjM6sd4jFgUST6jB0VcuChh6OeLGv0Wy7yuGqocG1ggLosPcxk3b++uLF/DnCFQSJK9Tf2v15Cn5iSr3U+D2aWWhu7/hx3ufU6oC+ZdVZvXYMXXijCHGRpaHUn9R79CWAG2VeK9rcmGF7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAbTq8Bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAbTq8Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E041F000C5;
	Sun, 18 Oct 2026 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792329832;
	bh=KaSJdH1jaXnXAcm0csJxFpDo28kCUP6bDjD7G8uRNQk=;
	h=From:To:Cc:Subject:Date;
	b=VAbTq8BoCnnCHKNnNiA+nBGgSh7sLwiaaMJW5cJzDKDUVdNDOfUfBDtPVuWOgtg35
	 8TvC50pURIZFHbV/2DQiSrpiUTNE7tIuFTTzaH6D8Wz9EjSSNdo2YlEcpVui59Rkcn
	 IguCCWNngxbUbj70Qp0H93i2D25Nx8Kwd/yr7fBjhy/yeO/ygDH4a9AVjVBQdOUdqe
	 +tyqjMqatGlbDw4MAVXYBB+TSKlbyRRMS4l8OLWRU7UpoNT98EERmHw/PZ+uiNLQqc
	 ufP+2hqBN4e9SC+jowpDZqZ1X49o7h68YC5ff5F7CAMDbzlOs/3S7qrsNeFxZ32ov0
	 GrxAi5hsc3HMg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 75D491AC57D1; Sun, 18 Oct 2026 13:53:41 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.3-rc7
Date: Sun, 18 Oct 2026 13:52:42 +0100
Message-Id: <20261018125341.75D491AC57D1@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc7

for you to fetch changes up to b0f0c761ed3fa10754dc9295db85374a173123b7:

  spi: spi-fsl-lpspi: directly return ret in fsl_lpspi_transfer_one() (2026-10-15 22:37:15 +0100)

----------------------------------------------------------------
spi: Fixes for v7.3

A small collection of driver specific fixes, all quite important if you
have the relevant hardware.

----------------------------------------------------------------
Carlos Jones Jr (1):
      spi: tegra114: assert CS GPIO for every transfer in a message

Marc Kleine-Budde (2):
      spi: spi-fsl-lpspi: pass struct fsl_lpspi_data instead of struct spi_controller if possible
      spi: spi-fsl-lpspi: directly return ret in fsl_lpspi_transfer_one()

Richard Leitner (1):
      spi: imx: fix slab corruption from undersized DMA bounce buffers

 drivers/spi/spi-fsl-lpspi.c | 17 +++++------------
 drivers/spi/spi-imx.c       |  9 ++++++---
 drivers/spi/spi-tegra114.c  |  7 +++++++
 3 files changed, 18 insertions(+), 15 deletions(-)
