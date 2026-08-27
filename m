Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87028376BE0;
	Thu, 27 Aug 2026 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862341; cv=none; b=n9f41cZpNwaNTXKWPpK3NMVzxzDzSEyCa+DATtSsvA7e6iqZ0gJqR7WcT9e//qusLp0mp82Gmm6htOh9iVMK+GIKtYLgCVttaBVsPKnKpy6Dpr9wW7D1iucUP8X7Y1L7f6JDRlybAvivs9Hz4qkbPvAnuQZ5Ye63gP4IRSnn7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862341; c=relaxed/simple;
	bh=JbY0CfSk/fbVstO/xdPqxdU7bvTM/n5pLvCK5VXX/wg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SCXmm3I1coeLpj3e4uIdwWYWMRLuybrYD4sTueWLxxxJ5e5JmiRd2po6+5V4bFRUFaJ1V8LoRERiI0Ex1/elIPWShX/LnuucJH6JShD3CUCHFqyvUxpeMNe6o55opeiyTFE/3pkqPtJgc56j4qxRW7l7UdFFuaYDU44H1NGiVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8YlFJck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8YlFJck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DD71F000E9;
	Thu, 27 Aug 2026 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787862340;
	bh=sC961/+Sbi3dLhdisR818ptW/53nyvqh4YuAOmh+QQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=X8YlFJck1XIG3fV5Y5+2MeiFRR2md4LOGzI9ssCjnTYeUVTC0iPAdGdvNol/xx+Tj
	 QroEqmIqlYH6NoNwK2Pnx4dMuv7LLLtzhYz+5bfkG5pOTRz4FCEFfnhnv2Jl85y7Dv
	 6uXw7P0H9x+5T/btqLYnMZT8HfHGiQ4RDzNmcfSf+Iu/NXb4PS8LL+SZxMX7+Lr6Oq
	 +G+HYQXxHy4gXPE6/K7tiRy9B89gl3lvcYfdReD/P3w9YBpDu5/nGy5Kn9M248ca+l
	 0DLA6jOmHh9al1FcBZpLui7w7hFhKEM+bWVsWrWQi2AxpcrU6skuZOWnP76E9Jk987
	 Vfw8cvSKKUBqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CF93809A8D;
	Thu, 27 Aug 2026 20:24:46 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.3-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <35d342b33f882cd09e0eaee43805648a@kernel.org>
References: <35d342b33f882cd09e0eaee43805648a@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <35d342b33f882cd09e0eaee43805648a@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-merge-window
X-PR-Tracked-Commit-Id: a9c2f0d401fd1e11ce59e4243946a59bd818e8c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bb34313d94b17a379ea68fae65be0810c88ee64
Message-Id: <178786228514.1831091.7343467797697862535.pr-tracker-bot@kernel.org>
Date: Thu, 27 Aug 2026 20:24:45 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 27 Aug 2026 14:23:33 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bb34313d94b17a379ea68fae65be0810c88ee64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
