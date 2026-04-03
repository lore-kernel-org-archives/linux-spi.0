Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19393AE191;
	Fri,  3 Apr 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226809; cv=none; b=mY8x1wsP0SO7e+jtM//MkEcCDAGPI2cQFcoND5Dm9dn7klIHTK9o9g+fex6nmNJfD73OMNTTbt2sBECtQfCqww6Fzuaj5q9LIKv8fo6LpLDQh++mV5bjqxkwyz1tJeCv3xUXCmuCKtnpqNcenftduZc7jDW2qhkdZJVA+Aa+T6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226809; c=relaxed/simple;
	bh=YIzVDVnuBTBHN8WdMnaynMOTCN0IRPUzGSPzwqfc6+k=;
	h=Message-ID:From:To:Cc:Subject:Date; b=oyz6yjiN/jBqJHS7WNnBJEinhRZLOR1PJvZIZal/fGpdVRWGKof20i7KKAd1ut66jY/0DIx6S5L4VgC2hOvkZyGehwkOqBugc8z3WFWF2eF4+2dv6cdEJsqiRvO6YbEgvecXBhpOfqQpU8O5FUIS2HcF8SOpP2WQlJF3Q5juF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyXHwjX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyXHwjX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11733C4CEF7;
	Fri,  3 Apr 2026 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775226809;
	bh=YIzVDVnuBTBHN8WdMnaynMOTCN0IRPUzGSPzwqfc6+k=;
	h=From:To:Cc:Subject:Date:From;
	b=qyXHwjX062rfgFpcMrwyR11Kp4zH2ldYUdDqHnT6bnKsbqcKEJuXnwtQhEfzDfVzO
	 IrMBcbdxGnt6u1znHHSsaoRqOBB+SqQfWMQr/9Ay7SR1pRKG0gtRxYmLkbdkZQLA3h
	 bZ1yYDOscrrtRRNCeZD7AStAoJ2XgvWerSViMeUrrpwhVZdxbVae+m0zzjdwEjkI5p
	 laP4N+S36EihSk8TMZXmvBs5pX+G4qPF8l5PtLb60Kum5R/zKDPc/4wKV3BXO1OFlo
	 ZGK3sv/CX4AWLqG3so7F7lXYFz/rd5qA1McVHL/vfBcfGLLAzUmywUofSJAKpHVK9C
	 dXQ8p3ew6Ql5A==
Message-ID: <155f5413c87935ce30a4a00cce806386@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc6
Date: Fri, 03 Apr 2026 15:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc6

for you to fetch changes up to 59e1be1278f064d7172b00473b7e0c453cb1ec52:

  spi: cadence-qspi: Fix exec_mem_op error handling (2026-03-30 21:34:53 +0100)

----------------------------------------------------------------
spi: Fixes for v7.0

A small collection of fixes, mostly probe/remove issues that are the
result of Felix Gu going and auditing those areas, plus one error
handling fix for the Cadence QSPI driver.

----------------------------------------------------------------
Emanuele Ghidoli (1):
      spi: cadence-qspi: Fix exec_mem_op error handling

Felix Gu (4):
      spi: stm32-ospi: Fix resource leak in remove() callback
      spi: stm32-ospi: Fix reset control leak on probe error
      spi: stm32-ospi: Fix DMA channel leak on stm32_ospi_dma_setup() failure
      spi: amlogic: spifc-a4: unregister ECC engine on probe failure and remove() callback

 drivers/spi/spi-amlogic-spifc-a4.c | 12 ++++++++++++
 drivers/spi/spi-cadence-quadspi.c  | 17 +++++++++--------
 drivers/spi/spi-stm32-ospi.c       | 12 ++++++------
 3 files changed, 27 insertions(+), 14 deletions(-)
