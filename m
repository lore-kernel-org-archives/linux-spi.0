Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BE2E7378
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460252; cv=none; b=JtW0JAVL4aZOg3xwViBxxrScNvunRiDDUUOfB/vqeh6CO7sd+2jbQto1J9F7dwsWn17IGKBe9cFocnKEF3Da2eQACxjXHfiYH+uVaEoMbbzgx0Kja7AtCgigjwIHUE7PN5dPzf6kOBNim2Orb4JjgSilwSaydxC7mir258lbIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460252; c=relaxed/simple;
	bh=yTDB14a7DRpKXDzWrG3HqLxDNQmBd/HdKWUAgBbqeHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WzvJTgchWJjZIxRjv6NbBokjIoGBH5sDiPRX5YAiil4h4UHONYJ8/RHPbCwjsjZdPvNXkRQhyDJfouimSNLJgs8BvPqORTEOBghTHZSqNNdl8x3hvg3+Wwsr2Tc08as5cstEHynl1wRISLYCAstanN/VJZGFNDJBWECUfoFTnuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMqmQftg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMqmQftg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698761F000E9;
	Fri, 31 Jul 2026 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460248;
	bh=HMFTW2N3zDSzgt8MO+wBis4rA5f7B2Q+oOUl2wGQ4nA=;
	h=Subject:From:Date:To;
	b=jMqmQftgzpE2d9Z0G75bSx0jdXa9nSfgI/Ozrrb7jRlEw1/1HFurUvYps7IHR48St
	 y79KbqalnlwPx7bns3U/HHqO7BD6p1CnpkLO72DM81aniiLQSJ7QhB5YuvU8WSMpV/
	 5UcgTq9V35Q6HMmMkCkvfxe9kJf8PdGX57mwUPwHWcyXNFrTzh9VUOIxUEhS+RaaDB
	 bFa0nctmAKcG0ewKmA/4Z162WY01+bUZwtm2bB5CjAAXnTkO403q8RkGRBFw2+pXKn
	 5Rb4r28/cXWoKiboU6ZElS796e4LM7eMHrnrWkiHBRqyWkkA4b6YMxEswagQN1I8+U
	 FQiXATQ3QAZ5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D35983924472;
	Fri, 31 Jul 2026 01:10:12 +0000 (UTC)
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
 <178546021142.69154.15924358185502080693.git-patchwork-summary@kernel.org>
Date: Fri, 31 Jul 2026 01:10:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ppc4xx: use of_property_read_u32 for clock frequency
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1136174
  Lore link: https://lore.kernel.org/r/20260728202932.16207-1-rosenp@gmail.com

Series: Few fix/improvement for spi-nxp-fspi
  Submitter: Bough Chen <haibo.chen@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1135846
  Lore link: https://lore.kernel.org/r/20260728-fspi-clock-v2-0-dbe786a4a6eb@nxp.com
    Patches: [v2,1/3] spi: spi-nxp-fspi: add per-SoC SDR/DTR clock rate limits for all supported SoCs
             [v2,2/3] spi: spi-nxp-fspi: enter stop mode before reconfiguring MCR0 and DLL
             [v2,3/3] spi: spi-nxp-fspi: propagate clock reconfig failures in nxp_fspi_select_mem()

Patch: spi: spi-mpc52xx: use platform_get_irq_optional for IRQ lookup
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1135403
  Lore link: https://lore.kernel.org/r/20260727194714.11354-1-rosenp@gmail.com


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


