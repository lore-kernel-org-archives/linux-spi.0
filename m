Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1543D5235;
	Fri,  3 Apr 2026 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245978; cv=none; b=Cm/lSyZUteeAKNTXkyVKBh0KnFuKN2oxST+jiWzEvsTjBnRZy6FUW0sH1XLgMA4y/iK3rmS+qsCuSXRSgnAuqbhYS7mQWsiOnpW9oPZYRlQ2ydU2/gsWQlJ6mQxmCvTkpBHE89tg8CXT7IfR1qGPkN6PEzS4oK2gHEkorQAvnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245978; c=relaxed/simple;
	bh=hu71YVxtcFMDKnRgkbITIEi3wZm7yA3Yl2vpsR6gLPI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qzJFe+IFqWn212qO2AspV1a7joOZMQDmxWWoxyNei/GyTs96qynGeUyIaeigcMD+6GDu3/ALPAuN1v5Sfer1ThU8Eo4RDXsiJs1tdIG4/54HH2Azk9nREfnZFrfU9j23+Ij/Tj6JwASpy8/JjzoUvhmYyOE2qSG32p9yD0rw3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0IWBFEo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0IWBFEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1669BC19424;
	Fri,  3 Apr 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775245978;
	bh=hu71YVxtcFMDKnRgkbITIEi3wZm7yA3Yl2vpsR6gLPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=N0IWBFEo+s7jrI4xLvp4rne9/kbp8cW+tSmpc6U+doS3rXBIYA99LDh9TlipU6tZB
	 xWHQ4ZX+GieJLmrSqwaSJyDbEm9lMc11bkZZNOS+kVt0qUu5sAs4RERNycYPQJYTkB
	 TeseoO8VSGL+wYzZQ4TaB1LfUXCobOf4vbK/Oik9JQuxHkBtNmZtkRmDj2RF9FUtVt
	 j7qar/p/KqtpmjZCh7qWcj2BBBiY0h3YJG3ohAIBWUyMGG4TCtVTgDaVn+F1FvF9O6
	 BEIjeBCkRl1FsghferTujTJj3zbq1H/qZpl6NHORpjM5IH3MOCI1NBOW0h9yZx5Wpr
	 MCagXajyKPVKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F4D3809A14;
	Fri,  3 Apr 2026 19:52:41 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <155f5413c87935ce30a4a00cce806386@kernel.org>
References: <155f5413c87935ce30a4a00cce806386@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155f5413c87935ce30a4a00cce806386@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc6
X-PR-Tracked-Commit-Id: 59e1be1278f064d7172b00473b7e0c453cb1ec52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c514f73377d6e3c2d4bab6db89b5a0e4b8807fa1
Message-Id: <177524595963.1431632.15809011187510542862.pr-tracker-bot@kernel.org>
Date: Fri, 03 Apr 2026 19:52:39 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 03 Apr 2026 15:33:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c514f73377d6e3c2d4bab6db89b5a0e4b8807fa1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
