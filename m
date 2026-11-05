Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879408;
	b=HlRScQycBQ9qK1gg2YG8hy2Evm29u5cHxoe6Qv9zjNHlOcm10jF8k5+4kCUEMWLDpJI0
	 f5cocviuMKFTmn2mjpz/pqAWvZVD1XaVtd6ZmZ+b2P7TUImYOCeCFYIa9k/GrC6znaiFE
	 PMjwtwrkFpceNv7spnYAmwKcuKiYePwe6CzZPtSTPKizyuMn00kXtmGu3XD15RORv3AX8
	 uVLfHJCrNTmSU5TeCVAW1wXU38FQzstW92TRRobeFqSqPb5hY/bjQMJu+KyAank4EcnkH
	 MsfCbS7+dPJGefG+hvbyaphg2LyTRwgIykmipnLLF5pceWvPUEed4qZNj19bbUvslVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879408;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=DRRql7BKFadYoz4jZgH+GHwEUbInEN6KC4GCR7tZVho=;
	b=LxBjI6+RC+MHnPXU/1ZuRE+KC/6pDldu3MtcgP/xlXTilupWw/5mvtkYRS7KkjxFjOXh
	 MaAp6YO9CbBCf4fYh/712AbGhr/Bdr3s0ERPKchZkImVZzav1XMhV3f0pf6eUw+Q6lLVd
	 j6Rb+B5juss9OyoBTJboaMbcPi+QZQX8EBK1taFGAmBgAhXC7w2hzIWR1Nri+D8IkUo0m
	 0xeMYfI5N64LALLTw7ohughfGHeezNIN11d3+NTaguaMEgID6u3AbkPS/lEVlqm1iN+jF
	 bVCCqTAEZSEKwgTbngR7lzmH7Zb/ID03BihdAxg4dyndlv4NeIw6eeOKueGIwnHLLWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ad3nU/iD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D8606EE81
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad3nU/iD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443241F000C1;
	Thu,  5 Nov 2026 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879407;
	bh=DRRql7BKFadYoz4jZgH+GHwEUbInEN6KC4GCR7tZVho=;
	h=Subject:From:Date:To;
	b=ad3nU/iD6AfcUU/kPpktafuz6svav9PBMV4Xh8JSlPJBUdu0Gdmmp1OgejG3Mv3oX
	 XbCIArD3Ai1dRyjYYURjZ6o329+m2LMauFHmRV5n/UODwzaq7lIx5MnZgXoKGAl8RC
	 Hi2toGhdYeJLh5HdtqaBGADoYctniVQcb/jXINz3G/NRkVt7jzeDnyV6Y/eioPLXG1
	 tTcU+lr1TDq7EvmQO7KUV84fyOKHK9grN5aVVgQ5II9bE9J+i7SJ4sfRfHFHhZLId0
	 NeT82PtEtJ2OOH1Ct3w1YEcxp3LKNOjjkTtHV+Rg7N8ZUWASJBI8Z8epTNEqR/doXI
	 LL0qGXMlLzFLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 057FF391AFDA;
	Thu,  5 Nov 2026 11:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179387940556.3630286.6907671687986726541.git-patchwork-summary@kernel.org>
Date: Thu, 05 Nov 2026 11:50:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: tegra114: chip-select fixes and PIO-only probe
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1190527/
  Lore link: https://lore.kernel.org/r/179258895296.403962.3492255118456900623@nvidia.com
    Patches: [1/5] spi: tegra114: Allow PIO fallback when DMA is unavailable
             [2/5] spi: tegra114: Run per-transfer delay before ending the transfer
             [4/5] spi: tegra114: Decide the chip-select mode once per message
             [5/5] spi: tegra114: Keep software CS across bus-locked messages
             [3/5] spi: tegra114: Assert CS between transfers when cs_change is set


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


