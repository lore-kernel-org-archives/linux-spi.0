Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23D918027
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637397; cv=none; b=Dn8mCUCCKVzHSH78LB6swUQhbPcqr2nC25pV0dJcBHVz1oMKJuZkBs64tc/MEgvYl1Vh0bTjwQqKABrggdoDptQO3nQ0G8BGKjj+xftl6FCI7mqv1dctY7EC67KEtUWKDhW0zO3Y/gajD0yVCMceQvREufyoYdYtMgqw9WVzaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637397; c=relaxed/simple;
	bh=nXtsY5FqOFKtBqCFuCnrvTiWVT8kHhO7frxh7iTTAyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tGg/psmUAeBnfvcav7/Mj/X5YuCTH+aBjyqz2nksRlNIKIzBy5eFQDY6SRBlgt+h3edE4uTP8fr4Q8n+JqeE9u8T0BrT7aXIqzvyHOpN7lt7I33eR0AA6AVoxiwj1IrCTvvdjBmzBd02/4wLvQ7TimAKwCYzDf3wzRipCkUg/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ilxhx36S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ilxhx36S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE7EC4CEF1;
	Wed, 28 Jan 2026 21:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769637396;
	bh=nXtsY5FqOFKtBqCFuCnrvTiWVT8kHhO7frxh7iTTAyM=;
	h=Subject:From:Date:To:From;
	b=Ilxhx36Sx8u7ppUseaceVFKpN6s31XdRPuRSN4j2YolYTNjp2cI5rpBVqB75f848z
	 EDDKzxE5EwGFRvAmvCgd9ktvjALb9mNHJtAkfcd2sd0lE5f+nhjxNa7JkmjO/hq5Yt
	 VGNc6MSUUDY/OXKzW9dwdd05+I5Y+49VM8LYjgcBEqUiJ1WYP/XO0x/xlSo0y2mK8U
	 8a3pihWaNG2NluPvjM/t5bMd+rRw7luVosGdH58TRsRV5CIxvIVUJ0epX1r6ndqbdj
	 frauYPvA28JPrPZaMPucKlmt5pGAaxBA0+iLOFGAbI8cQudMhq4YTAMP5pxtyQJWyZ
	 tNhkDBMmY+tQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A9A39EF953;
	Wed, 28 Jan 2026 21:56:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <176963738963.2246921.15871975938617263267.git-patchwork-housekeeping@kernel.org>
Date: Wed, 28 Jan 2026 21:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add DMA support for RZ/T2H RSPI (2026-01-28T21:51:29)
  Superseding: [v2] Add DMA support for RZ/T2H RSPI (2026-01-27T20:17:03):
    [v2,1/3] dt-bindings: spi: renesas,rzv2h-rspi: allow multiple DMAs
    [v2,2/3] arm64: dts: renesas: r9a09g077: wire up DMA support for SPI
    [v2,3/3] arm64: dts: renesas: r9a09g087: wire up DMA support for SPI


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

