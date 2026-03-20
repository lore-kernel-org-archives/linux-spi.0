Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA0383C7C;
	Fri, 20 Mar 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774019694; cv=none; b=CiSmL+CjohpWy33Ux1CVC5dYAJyNMK9Z6JyWA4hkSPfTvp941+7pt5HuGktOHDx5Gs1hb4IRfnlRNIjezT/LzlMFW7r96mSNW6D0Cuarp9hcJRha5vd4E9VOdtjzMNV7sbzDuAq8OsEWcjKgdEuag/D+mdzeq4BeiqAZxOhlff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774019694; c=relaxed/simple;
	bh=2+VmlrLSANN9QkMNRHlgSyklgrMPf9LqkvQOCKGXV1o=;
	h=Message-ID:From:To:Cc:Subject:Date; b=aTDvpjfzteq88GICBjwWCI/+hBBfikBPU3/AR1VOOEVPfLoTXjE9EVRW9iB4oNwbiX0kmzIIfa4Ioq1mvD83EN4FEMI6xzrXmEQDzzmEHUT+8I2SizBxOGiiYv6T18iMNWgXiBWRKSSH0GhUdmNrB1nlqJXyeTWJi3HGaXzjQuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebw9saRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebw9saRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D4FC4CEF7;
	Fri, 20 Mar 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774019694;
	bh=2+VmlrLSANN9QkMNRHlgSyklgrMPf9LqkvQOCKGXV1o=;
	h=From:To:Cc:Subject:Date:From;
	b=ebw9saRXjmKUNcKm079s1AfbTpk03od7ws5urSKBsV7T3tkMTx/cj+cND6geewbu6
	 sw7A68yOTsdus02kflMIcppm8wl1EDtvx8wg2Y7AN9DNqMqz2diQn0DVamoH1SloPi
	 r1sAs3Vf/llQutUr0vy9dbCdIvG3dddlTeS6hL50zHGrs5LmEdC1GSwzlKAGYR3Bk+
	 lvHrHGFgFkMTvRAVu2XINPaA3H21dh5jKMZsZXwSTQdVWwGnFaJmaILuwUikHV+kSx
	 Vrw5MvH4jjqkAfE49d5EIH2KG0ACQegL6GiATKnrnrIuRoXdqoloJWcy/fy42mAOTA
	 ggridhPdKJLCQ==
Message-ID: <a4e342d6b3bc37b9a25872843d25f5db@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc4
Date: Fri, 20 Mar 2026 15:14:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc4

for you to fetch changes up to 8c89a077ca796a2fe248c584e9d7e66cff0388c8:

  spi: geni-qcom: Check DMA interrupts early in ISR (2026-03-17 17:07:47 +0000)

----------------------------------------------------------------
spi: Fixes for v7.0

There's a couple of core fixes here from Johan, fixing a race condition
and an error handling path, plus a bunch of driver specific fixups.
The Qualcomm issues could be nasty if you ran into them, especially the
DMA ordering one.

----------------------------------------------------------------
Felix Gu (3):
      spi: amlogic: spifc-a4: Remove redundant clock cleanup
      spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()
      spi: axiado: Fix double-free in ax_spi_probe()

Johan Hovold (2):
      spi: fix use-after-free on controller registration failure
      spi: fix statistics allocation

Maramaina Naresh (1):
      spi: geni-qcom: Fix CPHA and CPOL mode change detection

Praveen Talari (1):
      spi: geni-qcom: Check DMA interrupts early in ISR

 drivers/spi/spi-amlogic-spifc-a4.c | 46 ++++++--------------------------------
 drivers/spi/spi-amlogic-spisg.c    | 12 ++++------
 drivers/spi/spi-axiado.c           | 31 +++++++++----------------
 drivers/spi/spi-geni-qcom.c        | 13 ++++++-----
 drivers/spi/spi.c                  | 25 ++++++++++-----------
 5 files changed, 41 insertions(+), 86 deletions(-)
