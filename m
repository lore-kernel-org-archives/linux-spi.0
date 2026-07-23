Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B31C381E88
	for <linux-spi@vger.kernel.org>; Thu, 23 Jul 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837439; cv=none; b=VV2ocLZuKf/cuxY3kqTExJYVR8FuUZnEApLKf9W7gSGGp4m2D7pr8j0dBaYMWnMGGuYYSSq7oXRG21snxKG533k1uQNMQoQyS1jXVn+rpDarilCPtC7GY0IMf+rrj063GC8AR8mDG3olQykUrxlSGdwwdzrxsLKLpscyM64gVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837439; c=relaxed/simple;
	bh=SNOyZmWkkU6gKDqYYG7itmFQCoZI/8Zrt7yU6ApBOPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VVCMyVSng88l7m8j2l5SW3LCVmF9z6hqqxKe2ADGo+PPnS4ugDjj4IYik3O0eVtGETtCClGXJTPEWzZQg5CzRkcDurhY+xMWgJf1T/3r76tr6l9MMWgRAeOTwMlweMsTw6wEdBdxCZhQL7CYVL8BUicjrUMXQnHh+jf3PArX2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4e+hsAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4e+hsAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCEF1F00A3A;
	Thu, 23 Jul 2026 20:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784837438;
	bh=R7etBkNiDU1F+ZpRDgjm9v3BYlbu6fvQvs+TGGBe81s=;
	h=Subject:From:Date:To;
	b=h4e+hsAWDi5YkHoiNTg64mARsTCco0rrvelwZ+LuR9zb8VPjgjwBnSm/tZPuR8NvU
	 WFTg6avO1twOwzb52mcWIoCEKlEKF8NrC01v4bcz1t7Q/4XHulQuC7fcAfdLm6vlKb
	 3MaRoxGSBM9DHSQn80CMWeTF74w9+y+vwRhN5HdP2LUGXE1WCchtk9xpGkEjX+KtuG
	 lKcjFJVlwD7bSuM0H9MKZtNLAJ5ig76ghsVAvP60l6CSvNSdsexEGHDUruiA3XN4/+
	 8CWLK70GpKcbiEThrYV3FQFURJIZ0kUbCzGFh3rAeg2SnaCEc+sQwzz0KlUh60IMzn
	 4VckShyFu5Ctg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5958D3924A14;
	Thu, 23 Jul 2026 20:10:07 +0000 (UTC)
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
 <178483740591.2850761.607925005846795810.git-patchwork-summary@kernel.org>
Date: Thu, 23 Jul 2026 20:10:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: None
  Submitter: None <han.xu@oss.nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113142
  Lore link: https://lore.kernel.org/r/20260617215520.3327836-2-han.xu@oss.nxp.com
    Patches: [2/3] spi: nxp-xspi: Improve AHB read performance with DMA
             [3/3] dt-bindings: spi: nxp,imx94-xspi: add DMA properties

Series: Add DMA support for i.MX94 and improve AHB read performance
  Submitter: None <han.xu@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1132738
  Lore link: https://lore.kernel.org/r/20260722-xspi_dma_upstream-v3-0-6b7ff50cae8e@nxp.com
    Patches: [v3,1/3] spi: dt-bindings: nxp,imx94-xspi: add DMA properties
             [v3,2/3] spi: nxp-xspi: Improve AHB read performance with DMA


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


