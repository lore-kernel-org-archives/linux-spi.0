Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070273E2740;
	Fri,  8 May 2026 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248246; cv=none; b=EZFFmgGRSA9tS93dyIjJuA1af266apbCGcg7OhCaN6HiYT3Mpmo7K08JtnBc3WaWReNZkRZO4NoE01FUUdg7vbgEp0AuVjot/MakWDpnUeo128dtmNAe5ctRQQT1714NY5fA8Wkx+C2JJCFta071EdIT64o7lNwLObLG6vkDXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248246; c=relaxed/simple;
	bh=lmqnmYgbOQGwhDJSelZEl3vpUvnekJHRYpUdC7oWVNQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pPoDc3l50G/+tMka1Awmz89EYvsgXWQ465xoUu31DFeNdJVEvhyB5MhYy8FgpjvEzy8ymfgtjqZKVG/8FyNf10T6GS5LVeI7ozrXZIEYHZRGD+RCrKCwgIFHII6pTM8Zs6u7BPEooHwZTJ29AWMd7LCSmCaZuAsWcTJCyP59qbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4faj7Z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4faj7Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5607AC2BCC7;
	Fri,  8 May 2026 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778248245;
	bh=lmqnmYgbOQGwhDJSelZEl3vpUvnekJHRYpUdC7oWVNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=F4faj7Z1EnzWHK0/YJDr1p9RK+SseWeEBrDIF5Ik6+H7k/2P+wC2PF1hPcwp8L0zz
	 eDp1C/R+03Gq787nfaMr9oapgrtUF15Vk69v/Ag/wv0hS6d7sXu1KJ9BDnHD4GDq48
	 QGWwbc4cZTP0Tfhx3j1iuvZ39b9lIuSq9cxsDUawCG4mLh2aOZ5g6dC3997orD5TG/
	 wfnxtn53SjeTJ1GY6E0TrluE4gr3z/UsujWAfzGaNlbg3MRqIH+RMfJKGxk1xR6Y8C
	 D/Hk8uy7jHBfOWiWNK+BeFrD0BJLF9EnjmjI4ULzSBGzZB3K3MnzzwX3vYaHbc0Cfg
	 kV50O1u3G1MBA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 1A2791AC5896; Fri, 08 May 2026 14:50:42 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.1-rc2
Date: Fri, 08 May 2026 22:50:28 +0900
Message-Id: <20260508135042.1A2791AC5896@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc2

for you to fetch changes up to 4bacec2317527ba04b7172145848f1c206999ea1:

  spi: ch341: correct company name in MODULE_DESCRIPTION (2026-05-06 23:09:33 +0900)

----------------------------------------------------------------
spi: Fixes for v7.1

There's two main serieses here, fixing issues that came up in the
Microchip QSPI and Freescale i.MX drivers.  Both of those could result
in some quite noticable issues if they were encountered in production.
We also have one minor documentation fix in the ch341 driver.

----------------------------------------------------------------
Conor Dooley (3):
      spi: microchip-core-qspi: control built-in cs manually
      spi: microchip-core-qspi: don't attempt to transmit during emulated read-only dual/quad operations
      spi: microchip-core-qspi: remove some inline markings

Jiawei Liu (1):
      spi: ch341: correct company name in MODULE_DESCRIPTION

John Madieu (3):
      spi: imx: Fix precedence bug in spi_imx_dma_max_wml_find()
      spi: imx: Fix UAF on package-1 prepare failure in spi_imx_dma_data_prepare()
      spi: imx: Propagate prepare_transfer() error from spi_imx_setupxfer()

Mark Brown (2):
      spi: imx: Three fixes for the i.MX SPI driver
      spi: microchip core-qspi gpio-cs fixes + cleanup

 drivers/spi/spi-ch341.c               |  2 +-
 drivers/spi/spi-imx.c                 |  7 ++-
 drivers/spi/spi-microchip-core-qspi.c | 99 ++++++++++++++++++++++++++++-------
 3 files changed, 83 insertions(+), 25 deletions(-)
