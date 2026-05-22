Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496373176FD;
	Fri, 22 May 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472432; cv=none; b=nrjAasm3WcZVAFR2hwF9dsOuuoUEbSP3fZCKiOupJjlxXChEWav6M0v7LV7Dh/8jfOUATa352+wVFtb4fFG3FzLmvLqdGmUsANN333abMg5PC0pRnqMqIEzuOWMoLBkjb888VbR9voM7ltZznIFJiQkzSMmhilA6yD8t7+GTS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472432; c=relaxed/simple;
	bh=ziTrp8d1qwNLipcwh7yQNFeRV033ecP98qLs1+qN8Cc=;
	h=Message-ID:From:To:Cc:Subject:Date; b=VGu5RpElo6pAmiAoQKWlmMUueki3glWh4fvotNcPJKEAHy4zYZN5RYwgfCqtKHZ2c6xJzZ88ax+qF6BNNhvQYPGhOzL16DE+PGKJ3hLfOqOI6LPJO+HnQkYqNBStyKMuyFVHTJ5W002iGLe6aBZAbdFiwMwMg/bo8nLgFtLQUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGdetoeP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGdetoeP"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6E2601F000E9;
	Fri, 22 May 2026 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472431;
	bh=jjhaN0yere3/wYnm2y1VglsyledBkxVGwjVDIkb3tfQ=;
	h=From:To:Cc:Subject:Date;
	b=aGdetoePAO4TonGPyV9/AVnKMwk++cKxKZiMXOpJlcOBT0VlOXLhpJnfyG1h2/RpR
	 AHeO+kZH8Cgejjw9CdkxvwN5EpEPEIt0t/mQlndHnL/yj54kUCkMtuy1ekxExWhqaL
	 l6WafB9C0+ok++5A//w4jXtsGDNOBWhzmIpMMkcghzpkxTgvxha5fgTS5ij00fJwqm
	 lMscONe+Ay1BVntanAYSUo90wJ9M5kKfjAG+G9jZltIUOmS4UznRGigCNpeXWxV5Id
	 olY7bt2+5NmIfPMp2c2glJYfqlnt0J8SFm6MvatJB1Uv9Tf7gMB8ZRNWp1JHFRcIOL
	 QLScbUmgxiyEg==
Message-ID: <c3dfa0ed3041398d4443c1331c7334b7@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.1-rc4
Date: Fri, 22 May 2026 18:53:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 5d6919055dec134de3c40167a490f33c74c12581:

  Linux 7.1-rc3 (2026-05-10 14:08:09 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc4

for you to fetch changes up to 27cd2dde35b2c3b8659fa18f6a935c61fedee5c1:

  spi: dt-bindings: fsl-qspi: support SpacemiT K3 (2026-05-21 21:56:07 +0100)

----------------------------------------------------------------
spi: Fixes for v7.1

Another batch of driver fixes from Johan fixing error handling paths,
plus another from Felix.  We also have a new device ID added in the DT
bindings for SpacemiT K3.

----------------------------------------------------------------
Felix Gu (1):
      spi: mtk-snfi: Fix resource leak in mtk_snand_read_page_cache()

Johan Hovold (4):
      spi: ep93xx: fix error pointer deref after DMA setup failure
      spi: qup: fix error pointer deref after DMA setup failure
      spi: sprd: fix error pointer deref after DMA setup failure
      spi: ti-qspi: fix use-after-free after DMA setup failure

Zhengyu He (1):
      spi: dt-bindings: fsl-qspi: support SpacemiT K3

 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 3 +++
 drivers/spi/spi-ep93xx.c                                    | 2 ++
 drivers/spi/spi-mtk-snfi.c                                  | 2 +-
 drivers/spi/spi-qup.c                                       | 3 +++
 drivers/spi/spi-sprd.c                                      | 3 ++-
 drivers/spi/spi-ti-qspi.c                                   | 1 +
 6 files changed, 12 insertions(+), 2 deletions(-)
