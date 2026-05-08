Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6223E3ED12A;
	Fri,  8 May 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778260875; cv=none; b=JU6mtu3u+IeLzKsgNiBbQdBWtTBy0GZIezXrpxRgUvoUDMxwAdhRwrnoWLSfOfgH54H0e04eqeJgBN3hv1Ktgxndfdss2WZ3iD7uWgqHEtnvuKag1HnY1xjA5uhrcIPVpUuTWBaaZV1GsrayMVIWHwM5xXM1gZxcm9wFe0hZOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778260875; c=relaxed/simple;
	bh=Ia7Cw5uNcu/eP9NM1Cnq0lgUkYeaxhFpsvq02BrxFCI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OFqsjXWLqYfAuacGE+T0JZXywb+1xDQVrgTMBs4yHqfHcgJOpk8IYt0oBAp62Kz32qRokjlbVDLXdV4qfY8Muy1GLyP9qbsg4q+c7L3ZM0C6jTPIwVKkhMHvza2ym7A0XSBLGGYqKm1WInOLmiBOTalGY/aZSASHgUs1QNrGyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0FA+T/0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0FA+T/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B6AC2BCB0;
	Fri,  8 May 2026 17:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778260875;
	bh=Ia7Cw5uNcu/eP9NM1Cnq0lgUkYeaxhFpsvq02BrxFCI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O0FA+T/0d9PVh7NL1fbnzwdL0+IHw1ADKth1FaZ6Oy54QdXR7C7UtIJw7WTMQd4NA
	 BVho+cV21KixzsTi53wYZT443+aWpGiilvhQFeGxgOmxsk+eWZ7/9fu1TWcBrta4E2
	 k6ChzoLcEWhgK94LiUUC7HeVuqjasPEpSFNWUUsgsSa9B+JJWo9cHVyu6HHz+Od3O6
	 +oyvVHFjwuHCq2fkZpOW/MjwBvSGbeIPRAjXAADpngpuL+6VhfOam7n3P3xPxaJ3bA
	 6v3/IGAXGH2BpexQkEXvY/QwnpBJaU1KJWTx5R8iU1zCittOFAdItZHaYXsymZYJYP
	 sKJcnwgtZ43VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1DB3F381197B;
	Fri,  8 May 2026 17:20:25 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260508135042.1A2791AC5896@finisterre.sirena.org.uk>
References: <20260508135042.1A2791AC5896@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260508135042.1A2791AC5896@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc2
X-PR-Tracked-Commit-Id: 4bacec2317527ba04b7172145848f1c206999ea1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bb44576c5ec0e6b29ee048b88235f6f407b6979
Message-Id: <177826082394.771267.7879734633566583915.pr-tracker-bot@kernel.org>
Date: Fri, 08 May 2026 17:20:23 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 08 May 2026 22:50:28 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bb44576c5ec0e6b29ee048b88235f6f407b6979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
