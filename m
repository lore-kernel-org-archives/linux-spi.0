Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BA337BB5;
	Sat,  7 Feb 2026 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770486278; cv=none; b=A+TM5l3pShRl+gRnVVU7VOD7m5YWk85Bp9ilD+bpvWmq8ocjDrUxAv6K6VHqYjSWullPuvMPWCtIXaloDs4qu0kypjT0SebDkHTdW3sADZvEh1mByEd4o/ofW8VN1MwLkBwQCfrplfxntKYjOUFQubn9tVX5HKRxW6nE4s6XaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770486278; c=relaxed/simple;
	bh=eioCIu3Qp70XoJPk2btY2GkAADzAxzHsvdHGFsjOS88=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=D7vhUcD8NqyODD8cNKJov1Nelt03Qkjl9d92BzxCdtTzz8mqQQQT/+CplwNyXUxhq2hEpGhl//V6WlD4uHaDHyM+0QYvmoaORTDZxCbhYMCsKJ3/9JAuB3dkHINwVQGUmXYraEcf6Uh/JJOwk+kRvqqyBZfhUgR22i9nYDt1nM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfhEjd46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfhEjd46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83395C116D0;
	Sat,  7 Feb 2026 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770486278;
	bh=eioCIu3Qp70XoJPk2btY2GkAADzAxzHsvdHGFsjOS88=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EfhEjd46a8Hq4ZCJFU68xy41KB3kO5pk4/2cRJ2U262o5IA+8BDuMsrrWMsKn+WcC
	 OEAYJBwxMUn8LsMXI7ndVOkY4yHhDpY7u14UnnvgNDgwr0bQWU9V72sk4/DE0qn7d1
	 HkH3qgtOrHteOWyvNQSIbD6YUR3z8tTaIt7FsSKkGFjALgu6YzvQ01yxqVhcdhUDYV
	 cwHWfL6xUCbndNsbE25tiMKttNX19pclU0IFsy+BfNpI19JXGEvbah3+VIfY1LQsB5
	 FvhgrX5UniwJ+rIBH/kRYfzj06XcigLssUup0rUCJztQuJnTKuJF1xaGiC2HwiYu7J
	 KIbfoy8Qymf3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8542D3809A33;
	Sat,  7 Feb 2026 17:44:36 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.19-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260207124309.7508F1AC57ED@finisterre.sirena.org.uk>
References: <20260207124309.7508F1AC57ED@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260207124309.7508F1AC57ED@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc8
X-PR-Tracked-Commit-Id: a0a75b40c919b9f6d3a0b6c978e6ccf344c1be5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7aa57247700733e52a8e2e4dee6a52c2a76de02
Message-Id: <177048627511.1334874.8603753581772784953.pr-tracker-bot@kernel.org>
Date: Sat, 07 Feb 2026 17:44:35 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 07 Feb 2026 12:43:02 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7aa57247700733e52a8e2e4dee6a52c2a76de02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
