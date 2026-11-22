Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795386009;
	b=EXU2DEMR2NlceAF5saX8dMx02JGrr+E6dj/hLy3qLRuspy82HdJgY4XiYOT4GfKeg8by
	 uJy+vRBpNd0iSoyziTGVUFOwUzgL8uZvw+qxXbFYPqzpowqbn3XHgGsanASt0tMVvKDlq
	 qOytOo8RkWX+EaFFfipeJymtGjqdP0yAG1R8k2xJSwJpV6JUFlcgnF3zgIqK+12U6vx5V
	 tsQCTe664ZdlcEX/dPYtJ+by45XjfCytY7ifhznoMzB7kAHNq//l4ZtgylBeyfAefdkeo
	 GTp1BiFab5LFtVFYL5hrAKjveHQ91wPKVvq+48ZArNNQzcwEBTj/rwQr9JBGGncy02g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795386009;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=OLA6Ox7gpCsnh40+5fPhqN3sm/nE7PLpoKNIjcbo9+Y=;
	b=xrAazXzqUbUglMCmCiNOY4Gibz6kfe4KNixC75pcNTnqO9R0XlFX2WAyNHDdwZNQ9TRV
	 PsoDeRpKkHoRRvc5ItFE+OFL4bU59RLuU8oACZZ/NuWaLN+0SQ4/M+AY34d6+MdC7QkCb
	 NhWKi+iwsilGmESOT+UZ+wi1IIY1Omj7e+HH6YAIsR4X8dVP274/DHLLgRn8bfS7Cxa5+
	 w/S7hYY1G9vNogi3Mw5gJKF46OVeAlQVqS/deADhjg2KfA4cxKN6AHDC076FEtserPs/f
	 z2dfUSkxaMH7JAVPwXNIB9DihCkM0s8AvXptNBQYkA97WBbaLQ9fj7wvFc2tn3JUfCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoNTdg0C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E6606A320;
	Sun, 22 Nov 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoNTdg0C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF71F1F000D0;
	Sun, 22 Nov 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795386008;
	bh=OLA6Ox7gpCsnh40+5fPhqN3sm/nE7PLpoKNIjcbo9+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XoNTdg0CqNYZAxMQCwQmbJh1amePeY0WAeD8VgJ8jQJF7QqKI5C5zufyzT0m1j4iK
	 1eW9mVBm0ma3OArEssA7kSW4VfkW9nYhtA4ciqrHOoGo5pFBI5zizQYBcagPJCILqQ
	 gQpj8XWYumE4I9ez18q0wUWuR187L7t75vzxnsnLjX3iNc6rbwkGzpnSCAKYOkWVyl
	 LfCV5tmPZ5W/oPXR7R++O9CSW4YRff14ZPYUE/dj4UsLySS4qYAoE84KYCeHNeziBU
	 s55meEQIQlG90b1+MYJYPajqB8iX1/bTkDby4Dd/4TYJDGhIw+S7j4sV4+XByTAx55
	 j+CWqiSZVCzQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43E6392ED41;
	Sun, 22 Nov 2026 22:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261121123038.535713464378@traversing.sirena.org.uk>
References: <20261121123038.535713464378@traversing.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261121123038.535713464378@traversing.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc3
X-PR-Tracked-Commit-Id: 6008a6e34ca0446739abfff189902af2214cfff1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdcd45bc9cfee488b92efc4b7f43d6865ec82770
Message-Id: <179538600738.1569645.2445430804855331458.pr-tracker-bot@kernel.org>
Date: Sun, 22 Nov 2026 22:20:07 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 21 Nov 2026 12:29:44 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdcd45bc9cfee488b92efc4b7f43d6865ec82770

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
