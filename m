Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CF36606C;
	Fri, 20 Feb 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614613; cv=none; b=nRf9d5BDiInPdMp4hOk0N9t/q3/mPS+/VeWnXYLqGudCKXSSF/71EJehDvm84qMW1VhRT8wfuJa/sHZ4l9ulMxl03+2J6nL6rgxGXLvLHebRt7kKoi57e1aEAi59XrktWQ44+w6ntR8vaJr4+omNHT60AgWft66raAeYPTvRNok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614613; c=relaxed/simple;
	bh=NgPLERcKi1k4Td+mzo68bEDAt1hzHxhXdDObuuvT3/w=;
	h=Message-ID:From:To:Cc:Subject:Date; b=kWEEbsWlBmTeNCTEtf56KnPtl+80tPULEf88yimFNEXr1ND9K61D7LWi4UmFuSb2e6s6E6NOUBunvBMQUnvM0IQHmxFPnosjLnffM8lRQdsl/CWBZ2j3XdYGGynpuKdyR6x/GthnpMa/S4lcPfnpNmuixYfBmTxbp3mugJ7yr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md2l6KrL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md2l6KrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDABFC116C6;
	Fri, 20 Feb 2026 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771614613;
	bh=NgPLERcKi1k4Td+mzo68bEDAt1hzHxhXdDObuuvT3/w=;
	h=From:To:Cc:Subject:Date:From;
	b=md2l6KrLOVCYivUjDiTcaCPTqOEPjxt1UVO7ok3SdXU1tuFjuWTaPU8FI9qZi9cD6
	 EMcCrept6j1TaP5k7t217uyzScom5uvWHk1MpjSouqbqi5SQ5I9nVJWRaGW2haVdGM
	 /edcAOdvccPutPXDlvW16QWd9i+foimlauatlUqVT3UgwIBaea0+XDzp5pgSA4ifEa
	 ciQvA32E1kIwRrXhlJikWwNB5u/vHwtYLKRRKayjU8YE2a3UCSjW72ZH5CeImx2T9A
	 5ErRp+SAohM673d9S7JJXeJjgy1FtXgf6qnLB6HerbY+n57zmt533wOZOcNS+ouZnx
	 Ii/EN4uMxH6OQ==
Message-ID: <c1e196dc59d936e0cbd1f6e1c64c004f@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-merge-window
Date: Fri, 20 Feb 2026 19:10:05 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 5af56f30c4fcbade4a92f94dadfea517d1db9703:

  spi: tools: Add include folder to .gitignore (2026-02-09 12:27:31 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-merge-window

for you to fetch changes up to 40534d19ed2afb880ecf202dab26a8e7a5808d16:

  spi: spidev: fix lock inversion between spi_lock and buf_lock (2026-02-17 15:29:16 +0000)

----------------------------------------------------------------
spi: Fixes for v7.0 merge window

There's a relatively large but ultimately simple fix for spidev here
which addresses some ABBA races by simplifying down to just using a
single lock, it's not clear to me that there was ever any benefit in
having the two separate locks in the first place.

We also have simple missing error check fix in in the wpcm-fiu driver.

----------------------------------------------------------------
Fabian Godehardt (1):
      spi: spidev: fix lock inversion between spi_lock and buf_lock

Felix Gu (1):
      spi: wpcm-fiu: Fix potential NULL pointer dereference in wpcm_fiu_probe()

 drivers/spi/spi-wpcm-fiu.c |  2 +-
 drivers/spi/spidev.c       | 63 ++++++++++++++++------------------------------
 2 files changed, 23 insertions(+), 42 deletions(-)
