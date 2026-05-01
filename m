Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7499296BCC;
	Fri,  1 May 2026 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599567; cv=none; b=nz/xALr1Aqs9uwUox40ZQI1z4QSgerPHw4WCmGFRCvNPwaKOYY5GMcVoMfO9LmqAXKvL23InXWcta/BKyaGJYkRndSKpzoEVjSRzXPBCmGDalFJ9c0iHPHel75OcDoHHCWOiu3JEqrKfCjKqg6SVyu+XOUbu4tUcUfHGF11aJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599567; c=relaxed/simple;
	bh=7gzihJjIpTCty3zQu6HL4JTJ5ssER+CZq/c56F2eCHs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ktUdU8aje1tjZLg3gmEZZ9KetJWkX6dAMcIbzq5o7/NXstQid47knvG1aIj5x//h6Vem4ZOfSDlMXEiGfsT1TF9len3ESafb0MiKe3io1syc9YuPDbCPlDlST3YqzHuO/qmGE4qMpu1TizYGiVLGagzNDqrCrITPgH2FSaSGdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJZgTV9v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJZgTV9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E7CC2BCB3;
	Fri,  1 May 2026 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777599567;
	bh=7gzihJjIpTCty3zQu6HL4JTJ5ssER+CZq/c56F2eCHs=;
	h=From:To:Cc:Subject:Date:From;
	b=JJZgTV9vMBVzaDMfrfRhIEo1eRg2rYi/ry5rKY9CFMCZrcdlpKacuHof6vGsP7S0Q
	 REud0SA7CNoOYYtKEOWMOuRdOcZVs8e+8t1rHyT/0is5Ov9uMpZkgEts2wi6tvuaZz
	 IOsyPfp5LzQ8tyMN2NRyLXSLHWL2x9IvSz/YHU2ULVgyKd6dJdPFBXz/KJ9HEJ2Dn9
	 Uz+liSqYjCkOvHmt4xnyTVYef+Be4xl8E9/wB9PVlQx6e5Z7Ryen+PzCpixEzlMM7H
	 WkvVZuN+sYV7RJkLP028ZwWgGmcEULkza+svInUx9e08nKGcofR2UPH5OBsAzxKLNT
	 sFTHfZjIRex4Q==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id B14F81AC5863; Fri, 01 May 2026 02:39:24 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.1-rc1
Date: Fri, 01 May 2026 10:39:16 +0900
Message-Id: <20260501013924.B14F81AC5863@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc1

for you to fetch changes up to 8c0f9cd1df41ee029711baca839b99d9592c5dd4:

  spi: cadence: Probe and unbind fixes (2026-05-01 10:14:39 +0900)

----------------------------------------------------------------
spi: Fixes for v7.1

There are a couple of nasty issues fixed here in the axiado and rockchip
drivers.  We've also got more of the fixes from Johan here, this time
for the two Cadence drivers, plus a couple of other similar fixes from
John and Felix.

----------------------------------------------------------------
Felix Gu (2):
      spi: axiado: replace usleep_range() with udelay() in IRQ path
      spi: amlogic-spisg: initialize completion before requesting IRQ

Johan Hovold (6):
      spi: cadence: fix unclocked access on unbind
      spi: cadence: fix clock imbalance on probe failure
      spi: cadence-quadspi: fix runtime pm disable imbalance on probe failure
      spi: cadence-quadspi: fix clock imbalance on probe failure
      spi: cadence-quadspi: fix unclocked access on unbind
      spi: cadence-quadspi: fix runtime pm and clock imbalance on unbind

John Madieu (3):
      spi: rzv2h-rspi: Fix silent failure in clock setup error path
      spi: rockchip: Read ISR, not IMR, to detect cs-inactive IRQ
      spi: rockchip: Drop unused and broken CR0 macros

Mark Brown (2):
      spi: cadence-quadspi: Probe and unbind fixes
      spi: cadence: Probe and unbind fixes

 drivers/spi/spi-amlogic-spisg.c   |  3 +--
 drivers/spi/spi-axiado.c          |  2 +-
 drivers/spi/spi-cadence-quadspi.c | 36 ++++++++++++++++++------------------
 drivers/spi/spi-cadence.c         | 15 +++++++++++++--
 drivers/spi/spi-rockchip.c        |  6 ++----
 drivers/spi/spi-rzv2h-rspi.c      |  2 +-
 6 files changed, 36 insertions(+), 28 deletions(-)
