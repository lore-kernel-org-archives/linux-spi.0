Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89038D40E;
	Sun,  5 Jul 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266439; cv=none; b=c+ElsqkFYNct4yHxIp0qK4u5i468wVowwGdKsBESBFZPrr/mvm+64sZbz9ki8BwtPnEnCCxcVBlCqPMGa7SnP6b/3bWqOYn3Fu+ekBf1PEGKOqSUzZ2aRaipHYwD5GrcGzI19xOs+gTb4VsUT5+0ApoH64yrrf5VdBlcgvSZhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266439; c=relaxed/simple;
	bh=rF2OvHURqp6Kq59HfW9uy2a0CcuQ94PGYEXRIhDEscg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qWOMC9gF6Y5pgVnfQq2jD/2qcbNp5dEK5KChxVA3RY+mKUchyPl6G+JqkVm4QDwFOESVIv0jxDgZxFL8v1idT+rmUV4OOdnfkS3ubUPCZ3Z1ofuwgkmAUgB0XpF22gPkbFNPe51G7GIzhaQrT2zX7BUgcoIc+bkc4P6aBSAq6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXi10193; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXi10193"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432291F000E9;
	Sun,  5 Jul 2026 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266438;
	bh=jtE2TEzEy5vmUhPqvs27fVHtYGTNJz2JNmv89cqq4zA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=eXi10193XhDp7Rg8zhRfNkJYwTQZ7wMOISUEs56sta2RHEs2ajXdHOqumfYTybT8C
	 NbE8r4bb5ireRwpNxOmyGosaKMt6hHPGEmcbaZf28ptl8HRaItrwGbylhBQ4+rJ+nq
	 /rYpq43QLUeHAXBO3KLdG3apXd6jGtzT2mQZGhJglHwT4EFFVuGUEql3GftNSdKHHw
	 3ttatUtRMhcB6K6mVj4+N2oT0OGa8Gst8tQILr4zb4KJeUBbwf/+bA7h3zwfAyrF9e
	 RcPZuuCsaJ0ZocNzGdQWqATKz/JISTs1iLdx/AtplnQn0sRUWzxhU/fdwK8uIT40bm
	 DZT9kla0QysMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A0A3A566C4;
	Sun,  5 Jul 2026 15:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260705115240.BE6C31AC5AC6@finisterre.sirena.org.uk>
References: <20260705115240.BE6C31AC5AC6@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260705115240.BE6C31AC5AC6@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc1
X-PR-Tracked-Commit-Id: 7fc2c3dcae28347a30ccd76c8817e5719005f1c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c9330c764b01519500a656cf3ffab76ff481878
Message-Id: <178326641920.3871366.1405508603897028973.pr-tracker-bot@kernel.org>
Date: Sun, 05 Jul 2026 15:46:59 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 05 Jul 2026 12:52:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c9330c764b01519500a656cf3ffab76ff481878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
