Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3073C9EF0;
	Sun, 20 Sep 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917097; cv=none; b=ZlDC2v3Wp/sY59zWhb7BAxakwgDfMFc/gCzkumE2gr1IYrmIBiAphfnO3fKf+OVKj+4ueO9EImmms3pnzWXxwX+wN4yS0Hlu3hZOULG77e/cVhXUwgY5lC70NJ12K/k64XNcgdGmCSTFPaeBc9lkFEA6nwceymjl/LtXmCLclyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917097; c=relaxed/simple;
	bh=6PGatwSodTEOwqpBBRB22A541q6Zi3VjYiNLOzE0Erg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oBQtKQX0Aqmw8CZk1Fkkzioxl+SQYghbqZhdYGGfEhydXwbWJYP/eSEn85qh5x8cpNtgjPRznR0CCMDlg9G6jVVSYwJvpJ9GQZi6APHTyaeZs1UcDEZWfuUkjpyHPGuEfPGJxiMw5gW1Pff8ChSP8xwREJHtmSjA5XKkmjicxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj7lvrUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj7lvrUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6E21F000FF;
	Sun, 20 Sep 2026 15:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789917095;
	bh=bhB01Jgxbec9QYHYR+EsOzr+ZXNKFa+NZv4KFVru1Sg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Fj7lvrUT6twQ/gGbsY93HlxdpN7XuNwQAm/7myudBslZIy3xqUnzj5JQ1BdAfcub7
	 WgvrTA+2qIJus0Dz1kbDjBgakYqE33Vu45l2pFhE9OwNtRoDSf6FjOe8VEbgAjMLfW
	 R1di2pOAEitt9A0okCPFLypDrXDBTCt0wL9JowrtXSys7hqL7r3zN3dIqILkTpMEGx
	 JNiGEzrlWlmyg+kcBJOZdv8HDB59l+FUtLZElEGNiK41y85gyQ1ekFwDrDlGnNMgw7
	 Quu65S2uVlPMIR8T0LJuEuBVHOUkV6PuTH6wxBv4syWwvmDhCLE/gN3t1A5N6UGYIN
	 ss36l6qP1Nl0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990A39253CF;
	Sun, 20 Sep 2026 15:10:29 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260920083018.A96F811D3CAE@traversing.sirena.org.uk>
References: <20260920083018.A96F811D3CAE@traversing.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260920083018.A96F811D3CAE@traversing.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc3
X-PR-Tracked-Commit-Id: 3d743adf090cd4c9a2120c1e02b0482e88aa0d2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bf70485f96b927d706a0db66825e4e3b2dd66fc
Message-Id: <178991702780.1703482.9028658616393352736.pr-tracker-bot@kernel.org>
Date: Sun, 20 Sep 2026 15:10:27 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 20 Sep 2026 10:29:59 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bf70485f96b927d706a0db66825e4e3b2dd66fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
