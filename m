Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30883769E4;
	Sun,  5 Jul 2026 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252369; cv=none; b=EllfKN4rhcqSaLTGbvvmOwsD1j92zg6mkBDEAMiMr71cofKKyWiOp05Hmf8876BmXHRHbuMB78Wy3IbI/wiqduDPfa4uqMAXK0fF468fDW3FC7GMAA8MoMMBxH1S/sB+hotMnaDNPqxu+zuUXDNeoSu0Xs5yPLGYIvFb3X+Zr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252369; c=relaxed/simple;
	bh=oz8eZZ2COSbQi790EXqF/HJskfQaL4wJ8r5Jl7DLeqI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NNjTllGb9czpR0qaskplVZ4tuB55hxnyNXY0Xe2e4k7NHcNcOxsJ63mhuhdojtDDFw7S4WFm5yMOBcGE05Faru6EVos4dJOJOv+ECpx8Nc+ib4NwiaM1C7NSk7Gji4pZya9NpKZ32/AbucVBRAqzpt69q0rpBRZshGR/5D86w24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpZwExf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpZwExf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334BD1F000E9;
	Sun,  5 Jul 2026 11:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783252368;
	bh=1mXmsUvGn0Qdf9H2HXG2v8udOVvWBzs1jy0Ea4R2Zx4=;
	h=From:To:Cc:Subject:Date;
	b=lpZwExf1S0P78DZPzLuMObyEGV/ZOLyv/7ppYWBEHPt3HjS4qh00H1i41e9v7M3h0
	 6QE3AhcWrrpqVU0kn4drkJsLdPMFhiPYQ3P6NLuhex8uQsNP7IBxfMGz1F56DY5BXK
	 w9k42paTPZUfQKk4uBE04kZFFMqvR5S6aPZN9cnGG43Fi8XTPphWKCQtJ7+xPMRwBg
	 HeMcl6FFQ2erlcjgJSfxGY7xpfWgTqKMPgc5g6qZxVinShXz/lze4NchYprSmuXTvE
	 vnfdq8l9zSmQFAV/Uw1ILLL+wjkYytGQLGqSzJOjLr0cPGTY8SvZattKUMsJNWQv8Z
	 nadT0HwmsrlqQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BE6C31AC5AC6; Sun, 05 Jul 2026 12:52:40 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.2-rc1
Date: Sun, 05 Jul 2026 12:52:31 +0100
Message-Id: <20260705115240.BE6C31AC5AC6@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 245404c26563aafb36aafb01298f148db1851be3:

  spi: imx: reconfigure for PIO when DMA cannot be started (2026-06-24 17:52:44 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc1

for you to fetch changes up to 7fc2c3dcae28347a30ccd76c8817e5719005f1c3:

  spi: rzv2h-rspi: Fix DMA transfer error handling for signal interruption (2026-06-30 19:58:20 +0100)

----------------------------------------------------------------
spi: Fixes for v7.2

A small set of fixes that came in since -rc1, we have one core fix for
shutting down target mode properly if the system suspends while it's
running plus a small set of fairly unremarkable device specific fixes.
There's also a couple of pure DT binding changes for Renesas SoCs, the
power domains one allows some SoCs to be correctly described with
existing code.

----------------------------------------------------------------
Felix Gu (1):
      spi: rzv2h-rspi: Fix DMA transfer error handling for signal interruption

Jisheng Zhang (2):
      spi: dw: fix first spi transfer with dma always fallback to PIO
      spi: dw: use the correct error msg if request_irq() fails

Pengpeng Hou (1):
      spi: sh-msiof: abort transfers when reset times out

Praveen Talari (1):
      spi: core: Abort active target transfer on controller suspend

Wolfram Sang (2):
      spi: dt-bindings: snps,dw-apb-ssi: drop superfluous RZ/N1 entry
      spi: dt-bindings: snps,dw-apb-ssi: add 'power-domains' property

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml |  4 +++-
 drivers/spi/spi-dw-core.c                                  |  2 +-
 drivers/spi/spi-dw-dma.c                                   |  3 ++-
 drivers/spi/spi-rzv2h-rspi.c                               |  4 ++--
 drivers/spi/spi-sh-msiof.c                                 | 10 ++++++----
 drivers/spi/spi.c                                          |  3 +++
 6 files changed, 17 insertions(+), 9 deletions(-)
