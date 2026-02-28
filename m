Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BC33DEC9;
	Sat, 28 Feb 2026 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283824; cv=none; b=r2uhFHV8l5ut9vt1KM1hEA4pUg1X1yBhUbXUH7Ht10Gc/zAVY79lL2DLaUWE78UXC3CRx+/dIu9BZkWsRu6+QVJOmsU2LqtYiJqOspeODjZ0vEJyf3PqdWMvN7b8khqWPDlqGR9FiddGY+qkf9MKbA7CXpuwC/E1+KqUogDOM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283824; c=relaxed/simple;
	bh=xtDJJsh+MizGbuvSU4iqxXE8ztBRHIlu33POVWilcmg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kkbCPbPq/hlekAa8rUjHndBSXAds1IV0YkqT26R6PsRSLxDS0M3tD7qd82e3Y+iRjFSGOCkdxkK9eO7PGSr0fraVuJjTTfiq7Iof74OncVfCQhnxsMgNy41II8+XS19Hjl16F5/73rhcMhuODgT8rwX2bwjngkJK1U9CHzoX9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMWBADPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMWBADPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD123C116D0;
	Sat, 28 Feb 2026 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772283824;
	bh=xtDJJsh+MizGbuvSU4iqxXE8ztBRHIlu33POVWilcmg=;
	h=From:To:Cc:Subject:Date:From;
	b=EMWBADPm4y5kg7ycPpjnEvS0Wx/gQKNFbx+NF1uFgpXjKAtOe6f26tUavEjJrN7KF
	 ZA0XJT4PUgocTbU5MO+whj97hop9/pl6IMHoG9XwMJyCQ7l7QwWn7LUx9AigAEA/Ow
	 NTwpdDjoAA2E58+6pr/Dck5l7mcFiYx+MoBVnjZODlFN0GozZRSIozHog4+iw/IlRy
	 B3Mwk0QKkhJ1gKVw/CGFQXViARUiIfJV+gzTCBLMd3DCWy45DqCx7IvtNj98sI8mwW
	 4tPt9LYXkFQE78izBp6RcTvIY79HkaUeBjIXlsJtMEwKo2ysfwIRcNa5f+ZziBNa56
	 zu0OU8A6LC7iA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 543831AC58E4; Sat, 28 Feb 2026 13:03:41 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc1
Date: Sat, 28 Feb 2026 13:03:34 +0000
Message-Id: <20260228130341.543831AC58E4@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc1

for you to fetch changes up to e96493229a6399e902062213c6381162464cdd50:

  spi: stm32: fix missing pointer assignment in case of dma chaining (2026-02-26 23:16:12 +0000)

----------------------------------------------------------------
spi: Fixes for v7.0

One fix for the stm32 driver which got broken for DMA chaining cases,
plus a removal of some straggling bindings for the Bikal SoC which has
been pulled out of the kernel.

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: fix missing pointer assignment in case of dma chaining

Andy Shevchenko (1):
      spi: dt-bindings: snps,dw-abp-ssi: Remove unused bindings

 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   | 31 +---------------------
 drivers/spi/spi-stm32.c                            |  3 +++
 2 files changed, 4 insertions(+), 30 deletions(-)
