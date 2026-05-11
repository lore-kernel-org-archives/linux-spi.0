Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B437A485
	for <linux-spi@vger.kernel.org>; Mon, 11 May 2026 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501101; cv=none; b=almxijGrtMokAbOAe0vYk8RzXbNL5WLjO+5PIkWD6+cJBwE/8NQSlN31C+hdEvs75W4NXaHgZudtNFdcMUD4yPheWnODC2XSDz5BmxrQLGJSTrhPGaGlcMSvFH1fbDRbQrX0yJCnXrMhGnIZIdxvUpAI0d6IPcwoOFXHZvFz+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501101; c=relaxed/simple;
	bh=IG2munX/zeRxVh0/96K6DeeW7yVdMNzI3TgDvQkgjSo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EK5+29SFy03KzhENo6bkRfmQH47qOEbBYNHVo0+rWODwd+zpwaexFY4Ge5MoY+51VEMYYZVVECv9SCymFoWmZu7/5HyRNHvJ3hzDU3EOtFLjuD1CS8FKCd/jrYbPgqh9MoffqBpz6+wLG2ocAkxouMoFLr43+mLWX9PCLoSJ5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZrOvuCj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZrOvuCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F651C2BCB0;
	Mon, 11 May 2026 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778501101;
	bh=IG2munX/zeRxVh0/96K6DeeW7yVdMNzI3TgDvQkgjSo=;
	h=Subject:From:Date:To:From;
	b=nZrOvuCjQSs3C8r/cYqPJnExlUFS68buLMZCKWEYDRuYlA4/7wmTpfClt2DeVA2cd
	 IU7i2OuIfjYS5+53HSbY1tr0tuUXCblmF6mBt8TpT7M7+NdF5cME9DkRo/9Iy57xc2
	 6wEGZ5KAqLha55S444oerWFrECMqCPaRLlu7MTVHmV0CoAwiQdi1RaHIg0XzqBCdQg
	 +fnllObUHjivQYwpiu/XAV9HTk6dMk0nX+KNsmdJxqs9lphnKxoCeTx7gjrg8h6sCI
	 uCFm+fzicpVXI98+tm4+J1qyoOCmwMVP/crY+EIdQdQptKmrWMvmxBT5loN+lt6eQg
	 SaHTwxvKfEerw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 05952393022E;
	Mon, 11 May 2026 12:04:09 +0000 (UTC)
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
 <177850104742.2192705.8379271177905532013.git-patchwork-summary@kernel.org>
Date: Mon, 11 May 2026 12:04:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: switch to managed controller allocation (part 2/3)
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1089683
  Lore link: https://lore.kernel.org/r/20260505072909.618363-1-johan@kernel.org
    Patches: [01/20] spi: pic32: switch to managed controller allocation
             [02/20] spi: pic32-sqi: switch to managed controller allocation
             [03/20] spi: pl022: switch to managed controller allocation
             [04/20] spi: qup: switch to managed controller allocation
             [05/20] spi: rspi: switch to managed controller allocation
             [06/20] spi: sh-hspi: switch to managed controller allocation
             [07/20] spi: sh-msiof: switch to managed controller allocation
             [08/20] spi: sifive: switch to managed controller allocation
             [09/20] spi: slave-mt27xx: switch to managed controller allocation
             [10/20] spi: sprd: switch to managed controller allocation
             [11/20] spi: st-ssc4: switch to managed controller allocation
             [12/20] spi: sun4i: switch to managed controller allocation
             [13/20] spi: sun6i: switch to managed controller allocation
             [14/20] spi: syncuacer: switch to managed controller allocation
             [15/20] spi: tegra114: switch to managed controller allocation
             [16/20] spi: tegra20-sflash: switch to managed controller allocation
             [17/20] spi: ti-qspi: switch to managed controller allocation
             [18/20] spi: ti-qspi: cleanup registration error path
             [19/20] spi: uniphier: switch to managed controller allocation
             [20/20] spi: zync-qspi: switch to managed controller allocation

Patch: [GIT,PULL] SPI fixes for v7.1-rc2
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1091652
  Lore link: https://lore.kernel.org/r/20260508135042.1A2791AC5896@finisterre.sirena.org.uk


Total patches: 21

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


