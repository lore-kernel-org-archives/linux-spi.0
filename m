Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA842AA9
	for <linux-spi@vger.kernel.org>; Wed,  2 Sep 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309458; cv=none; b=G6WpjmEUvVoijZ2mvAFY0vaY2Rajoe92AGNlyW1ZieBtPa08OuM9rCwnFNGE7ffC/WoYXKaVfKNgjbANES+fqBuVZvnYYwdm3+R5wjZfmn7ERV9y+Cd7tGvtlu+GgQQG2BV3FTWINWXyBJimxyoeDovu+/1Hvo3BpV2bkdWkJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309458; c=relaxed/simple;
	bh=Y7+eXGb35WSoLp6kxsbkEJDw4qtr/uh2nLnTtCz758U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=swdNVxD7W2iyq58nKRlIwcPQuNNoyImfCSYNWUxpQyg8zf0/rEaHf+ifAsXZhC8LK8IV6v/2XxZOgrqehzw3oszvAfp8A0S2RqmmuIZiUMm1v3f0hFvX4gnfVK25ZFvZ4XqEKV+rAIQFmrfJlGqsZtymmH1QYmFekhGHl5dStw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvN5b6Ty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvN5b6Ty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BFD1F000E9;
	Wed,  2 Sep 2026 00:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309457;
	bh=6sQfrlLDAJyFlmJAN4/R8RRxjU2NBSbO02aaqOdaWg0=;
	h=Subject:From:Date:To;
	b=TvN5b6TyFNH7wO2xQeMrLQnXdJIzSoPwzyisN2aWrWI6kxmclSjt9e7xsjcwtGUVS
	 oIecoh1AVJoCGK5ay2PrdOSKJO/LLzhKKhe9o76uNyDGmlliXJCXv6ADS8w8PxvDV4
	 XFgol7sy5Navx+KtYPr1+uqDGLx1VGXPajaH2W3tv9S41X0cCkm/Tam9ZGva8ZXgvA
	 QddoyBlwjRN30A2q1bPPfpiZzSFyBpYZDuAUY9tANwbkGemg7XipGX+rpYI1HvyJOV
	 js/V6UrM+mhua51gFAtQmB2a5TLqYYeyxb1+rXarfRFkwzysr9mV1+Z9lbSHE9q7jU
	 5v6Df9XMmrBdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A3E3926244;
	Wed,  2 Sep 2026 00:36:40 +0000 (UTC)
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
 <178830939909.1844276.16221432074285151451.git-patchwork-summary@kernel.org>
Date: Wed, 02 Sep 2026 00:36:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Kconfig cleanups
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1149717
  Lore link: https://lore.kernel.org/r/20260821105541.1432348-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/3] spi: Fix tab and space mixture in Kconfig
             [v1,2/3] spi: Drop redundant dependency on SPI_MASTER
             [v1,3/3] spi: Fix the section ordering in accordance with the comment

Patch: spi: qcom-geni: rename setup_fifo_params() to setup_spi_params() and make it void
  Submitter: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1150777
  Lore link: https://lore.kernel.org/r/20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com

Patch: spi: omap2-mcspi: Remove unbalanced pm_runtime_put_sync() calls
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1151651
  Lore link: https://lore.kernel.org/r/20260826-mcspi-v1-1-0a8dd7f6dd56@gmail.com

Patch: spi: sunplus: handle signal interruption in transfer wait
  Submitter: Andrew Gaylard <ag@ffroot.co.za>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1149113
  Lore link: https://lore.kernel.org/r/20260820125835.1584270-1-ag@ffroot.co.za

Patch: spi: sh-msiof: propagate setup runtime-PM errors
  Submitter: Pengpeng Hou <pengpeng@iscas.ac.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1153897
  Lore link: https://lore.kernel.org/r/20260830140133.24156-1-pengpeng@iscas.ac.cn


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


