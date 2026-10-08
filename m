Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F543636B
	for <linux-spi@vger.kernel.org>; Thu,  8 Oct 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447024; cv=none; b=Yth13OKCdKAGOggL3kncy9avdDmJ+b8LUru2c0iVgwG8MkD35fcrRZEflFYwmJGUpbGhjBEJO8dAWPFbTXnj2iQ5WXb/iRidTR9e4Mp1KPn44+f7TRkJpIZjOwo049ZfNUCMgz7l4niwC5bo8AE1dvHi+1hrq4SegdCxguQjDRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447024; c=relaxed/simple;
	bh=lmHP/4wBagTImBI/aZg6c3v5bm0J79WExjAx0QXABRs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qJEd2GcWigGsNTGKTkGkRWO8Mrd69Eg1lBKxPC9yZZF+UNBjctovZg5U0zsQ2Ubii6rppd1ym6RjgNsd5P6JpNzOCITAfN2E3fsHHZgpjfSHBOTj8R/8uQZO9SB9/NDFRh9Q4lTpL1fO/K7FOLTsvW7QQiYWrwEVKTHLIBRM3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGV5hXj+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGV5hXj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A880A1F000FF;
	Thu,  8 Oct 2026 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447020;
	bh=UWJ5NSqGdtXFLk7+0I3uUUcYoiHv9mraa4UtY3H4kzE=;
	h=Subject:From:Date:To;
	b=iGV5hXj+04Rkg1oQoS7hYLHY8JB+fFJU+QESWrSWWT+IrWEy8roOGE5KL4Wvu1KL1
	 x3HNfYdUrcwC9xoPBcs0yhRAew6bITcFSNHAtjt/VGAME2GrdFRQWsNiIsvzJ8bVXL
	 u2NjuaDmcj6KXldumax+M+/3cqWBBQkrMolFr8iIQE+8CQLo1M/WO4DTBKsHrdGEBD
	 JU2FGso621WCiQxR6zZRhxC8BQkZuMpmgsTAtOJine9PR5mlf+QvwXTpcSRSbb487A
	 RsYatSe3S4mTQ4BuArdW8c9tBMx01LW536ikgcNx8olSzkuZgMEcDKjuK+Peq+elnw
	 vzv61PYv9ZOVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79D8E3809A8A;
	Thu,  8 Oct 2026 08:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179144701900.3885493.15176391108212214827.git-patchwork-summary@kernel.org>
Date: Thu, 08 Oct 2026 08:10:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-sun4i: assorted fixes
  Submitter: Jonas Rebmann <jre@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1164740/
  Lore link: https://lore.kernel.org/r/20260914-spi-sun4i-fixes-v3-0-9fe919d5cecf@pengutronix.de
    Patches: [v3,1/6] spi: spi-sun4i: sun4i_spi_transfer_one(): fix transfers for SUN4I_FIFO_DEPTH
             [v3,2/6] spi: spi-sun4i: sun4i_spi_fill_fifo(): always apply A10 FIFO fill level workaround
             [v3,3/6] spi: spi-sun4i: sun4i_spi_transfer_one(): fix setting of clock rate
             [v3,4/6] spi: spi-sun4i: sun4i_spi_handler(): fix race condition between transfer completion and RX FIFO interrupt
             [v3,5/6] spi: spi-sun4i: sun4i_spi_transfer_one(): add error handling at clock setup
             [v3,6/6] spi: spi-sun4i: sun4i_spi_transfer_one(): report effectively used speed_hz of transfer

Patch: spi: stm32: fix double free of SRAM buffer on MDMA fallback
  Submitter: Pin-Hao Chen <billy920225@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179934/
  Lore link: https://lore.kernel.org/r/20261005220528.7199-1-billy920225@gmail.com


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


