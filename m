Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2C330656;
	Fri, 31 Jul 2026 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785526286; cv=none; b=PuWhn+3ysl3AznzQsTCB+qML8NX88DAqgTpdfySlIp+XwD9HQtN0Hd59VpXpbOTecK0zBILCKxn6jhC4rT/cB8XDgl5IfXHCslJXz/4FJSiGkpQGHVJYUqzCa0dZ/JiYU0Az46QDBN4reXlZANawbDcvwZneMj1GjzdKsbuzDlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785526286; c=relaxed/simple;
	bh=PSPslov++Zxl+J3G56+4lbvk+zRegOyhbwcfOgFy8pE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ElUN/DuTtGoIWyTJx+nFZqsQvPhs9mSR5FjSjRxI/poMBXpoEv7WrgAyw38HhOTOtRSkxbeDP1dxyh6HtpeRohQ9evHXn2HFO2LiCl57EaX5lQqEH21/6J8ZJ7AvesvLVilctjfq3QrfCMXB4JjWodaoWOWX0vRdDnnvtRQdA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNQJFNXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNQJFNXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA251F00ACF;
	Fri, 31 Jul 2026 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785526285;
	bh=ui+lczv8H2dUeFIUSpx6XJd4vvt/PvFudvfFyz+od+A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=kNQJFNXRrt4+MhBRrTexN8NDVlTN8w6NWtatVPUuTWBZs11OXIYbneAr1T3y8chIP
	 RD+7u/JpsNa5HfgOfuMxN52eLJhQJdL9KlyqI0nJXjit4P/yOYUeyHKasuiqg/+AiQ
	 FVB2KRueiLxHeJ3K9uAI3SXtgmRI5kW2PUeU+CrlLkSaiY/16TmLTyws5DKNs92+FQ
	 mFBhLzWeeWIDLYuD7btdt2QoH6SRXefUfhMxLaccR481cGHIiTrxAbDtPjPd3niZiV
	 XZQKzDWg+ZKBO8nl1qo+4qpddCC6kf5P0yfQVZtPyGdDXlJGmLebPetHM9gCReQRT8
	 W7AN+2IVjZrfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AC73926649;
	Fri, 31 Jul 2026 19:30:49 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <7c414832b0625d7838a18e0bf589b4d4@kernel.org>
References: <7c414832b0625d7838a18e0bf589b4d4@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7c414832b0625d7838a18e0bf589b4d4@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc5
X-PR-Tracked-Commit-Id: 9513b642d233bedb0b703ea75b5f3230eb6293a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6269cc6f52c68f6f5474f86e94256c81d1ff24cb
Message-Id: <178552624772.874622.18279066863120420931.pr-tracker-bot@kernel.org>
Date: Fri, 31 Jul 2026 19:30:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 31 Jul 2026 19:04:54 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6269cc6f52c68f6f5474f86e94256c81d1ff24cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
