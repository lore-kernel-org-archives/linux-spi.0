Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86B27472;
	Sat, 28 Mar 2026 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657852; cv=none; b=tZG3SCgn19+gn70PbpI1CTpLXhQSiBJXgnnYObhvXfimXs3Gd+OxRUR9gkHSEJr4+MxGpTWqOoAq8hT+Lk+VqOO1UYpyzUYNvql145D2bKgVF4fxy55vpX/n3jbPVZQAMkh8salQCpeCYsqza/umM/gGYw3aOHGYnX1ms/9jwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657852; c=relaxed/simple;
	bh=s56YmWGo3yi5WwLHeKgKGeD1D3rf+prmaR9XZuI4aYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jkllUQMvtfrW4cQSqZa0rIzChqdWI8dMvpaSGSC9LLOXjUUrvG1zsA2LWLPNNlhDteVa81rpUf1XO1OTFbUBEjewNal4uve8SXnwMr+sWHGlaEOTQqlUgT7ktKF5a4dETd07KCH67HebcTltLYhPo2b6avMx4HTNBSIBbTFNB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGLJ/J7y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGLJ/J7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A60DC19423;
	Sat, 28 Mar 2026 00:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774657852;
	bh=s56YmWGo3yi5WwLHeKgKGeD1D3rf+prmaR9XZuI4aYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uGLJ/J7y4dEKhA6gefDGkh/qC3wJf80eJUmsznoAzLkzxS7lKaFi3w4GR/TRCJWso
	 abZr8OdRTEYTk4cW9inFUzPbX5lLWeqRPpib9f1qlsR5W9FlnAhNxaaQpBD/2K0g5Z
	 ihHvzMP6xXUOCLayREhmoYpQB+ELchjqJ/eag34iZ0W53CnjKY+QD7m3m+tbwqA45B
	 JmAogj2wIQ3BzR+MW+rgjUibuqIUC81552V1DWcU/PR/7FlBFjP++nptRfo5Zrb3R7
	 a/6898gujgEQzoPXAzytfyyKc4YmexO15DnBCNwRNRpGUWYlWzo8gZhTONdXUhdbbR
	 9KJRIuOA6j1JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030863930181;
	Sat, 28 Mar 2026 00:30:39 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260327185046.198D01AC5847@finisterre.sirena.org.uk>
References: <20260327185046.198D01AC5847@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260327185046.198D01AC5847@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc5
X-PR-Tracked-Commit-Id: b341c1176f2e001b3adf0b47154fc31589f7410e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 335c9017e333894c39853f6fc27db9f0ce44f48b
Message-Id: <177465783751.4134300.6015334099297307149.pr-tracker-bot@kernel.org>
Date: Sat, 28 Mar 2026 00:30:37 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Mar 2026 18:50:37 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/335c9017e333894c39853f6fc27db9f0ce44f48b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
