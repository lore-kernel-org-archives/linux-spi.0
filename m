Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018981C5F1B;
	Sun, 19 Jul 2026 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784479543; cv=none; b=OM8OQZTHAGAQVjQXiznk6Jiqus8dwaTL4visSXcEbMMSRljNW+BBf8WSEd395xc/S3QRYkywyZa90+qce2N3GeUcE2POz03GKpMUTZaqitCJyw58BnUxqc0Td14WhA+OCud4y1ZeeHiM/mRogY0jh0N0GEV8SBINRX1+dYX2LWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784479543; c=relaxed/simple;
	bh=L2UK6OIJR/P5t329NbuIGVW8t56r6t88LxzOjX/RjhY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YrfToMuFwuptHPvNpuQ9kfMojpzrXc0m3ujjQbttnx1MtCiURwIUdmCHzgqzQEXlQ+nCnGHiX1kBoHbnSbQthRSKOgHB+bnfU4hroAQ0sK4ho814lPrs0n741BWNrZvelVr+FLntpAyqgQ/HUVeD/6Tih7yU1btoZilgbHc9zOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvuit30W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvuit30W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04661F000E9;
	Sun, 19 Jul 2026 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784479542;
	bh=fneNOmBNEvX7MZ7EPRtWqyUPLyUdWGaAYX7DIT5FsGc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Qvuit30WilJxl7IdaxF7EEwW+W1Qg/PDJIZkvo42DjArF+9WZQo2HLX3dhKVW8ciM
	 Jcc9KpZFsIVbQFcJYOpjmgq9b0h+A4qzIVI9/82zy2xcsrIsi5CatYYYB9bEjUN5j4
	 8r7rCmtfU+cYoq3SvseFmIqeA6x94CLRZvNwkHpTkqXelrooJwm6wYWrLMVaZa0fx2
	 5GaQ2qXNvQuZ+vfWBWqCBho5uX9Yumvj84VzbC+mJ33B19OiJFjfVjpe68TtC50PFt
	 yIV5VYMfDfBV4x8rVefgchsQieLmpuUGJiyVtVcoVI/lHbI5CmI7eRR92lXWBXMsW2
	 jqa3uuxGfohNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AC538119C8;
	Sun, 19 Jul 2026 16:45:15 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <3aee33eeb68bc75cc295997d3b1c182f@kernel.org>
References: <3aee33eeb68bc75cc295997d3b1c182f@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <3aee33eeb68bc75cc295997d3b1c182f@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc3
X-PR-Tracked-Commit-Id: e919ca35a6e84b5adf085da9ffa1544c01d4ce1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b752c85019958558972b75c8703caccd6fd7c47
Message-Id: <178447951361.2771094.3282977210926464718.pr-tracker-bot@kernel.org>
Date: Sun, 19 Jul 2026 16:45:13 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 19 Jul 2026 13:39:35 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b752c85019958558972b75c8703caccd6fd7c47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
