Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDA376A0D;
	Thu, 27 Aug 2026 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837045; cv=none; b=KQA0bVSWt2cvZwZPmkwz1x5iINZ2wmjkfgFkIMxVqidSreO09sAiFoaFWXGLyBo8LjSYLhktPI9NNV5dUaOIsFOTXGY/VCzMHkDtMrKElLSSoPE52imBbTdyleN0EEvIGR8mAvLFiXA6dfpdusQWxoNzvPNMZzAYRufwCxpe63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837045; c=relaxed/simple;
	bh=TluuxE/PMkuwS+zipm+ceg6seocyhMUh8MzIxJv0fik=;
	h=Message-ID:From:To:Cc:Subject:Date; b=LGWzqbenqCQ9WANcGpwg9nT5A0XQqq8W2Y9KATGnzCJTqtt1vuN5dVaSTHXZZe8RK6Z7M3/LYWqd6XE84ndoXiNhewPHjtYprdWBshIov3sVUhuaHsb8w0BmPUiRD4Mp1D8/8ZaeBfwOmWejL14GA9rnXaeeROBccOTH1fM+elU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zlkmr21V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zlkmr21V"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 04BD51F000E9;
	Thu, 27 Aug 2026 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837028;
	bh=vmQtSDsc1o8LGthenfKte8jOi5cnWoMFGYnbQo2XSZM=;
	h=From:To:Cc:Subject:Date;
	b=Zlkmr21VZx57XB7+JiW2QS1KgcGbV8m6Ohjw0IxJOt5v8/PaMi3FwC2930umrj0Rk
	 9oaIvV4/d4P5bX/MTWbKBx+3M0oaQ1hMerZhhGDKrH3X2AdGuEVtl7i2xZU2gWvcST
	 +EXtf630NRfaIeu46iP4CdasKVbmwfU8FhAXAQttZM9VuTr+PgVgxnNJ8SbmSzfbej
	 MPKYIRufb7XWRmqeGkFEXZEO1bsVL6OLtv1fzvogcjp5kPOgBSKH1Q2QlUsiUa6Oy9
	 vBSw6V/HIZcHVw1SjnAmBmH52Dn2j1t4IpOVwWEN2eHv1bG1Zt4Xjh7yNLRNIavwa4
	 D2EyKdqVkMwJQ==
Message-ID: <35d342b33f882cd09e0eaee43805648a@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.3-merge-window
Date: Thu, 27 Aug 2026 14:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 23688febe4b44b10f4b454eb1cde0ba379a84119:

  spi: Fix DMA mapping ownership on partial map failure (2026-08-14 16:48:53 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-merge-window

for you to fetch changes up to a9c2f0d401fd1e11ce59e4243946a59bd818e8c5:

  spi: loongson: pm: add .freeze .poweroff .thaw .restore (2026-08-20 13:14:02 +0100)

----------------------------------------------------------------
spi: Fixes for v7.3

A couple of fixes that came in during the merge window, Geert fixed an
uninitialised data bug in the amlogic-spisg driver which could crash and
in the Loongson driver Li Jun hooked up the existing suspend operations
more fully to fix hibernation.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      spi: amlogic-spisg: Make sure clk_init_data is fully initialized

Li Jun (1):
      spi: loongson: pm: add .freeze .poweroff .thaw .restore

 drivers/spi/spi-amlogic-spisg.c | 2 +-
 drivers/spi/spi-loongson-core.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)
