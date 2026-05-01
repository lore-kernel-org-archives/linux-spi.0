Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA336B04E;
	Fri,  1 May 2026 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661014; cv=none; b=ZyXx+kxOlO6+Mqn6gNKDhov6/XIM5PBsVbifjMlXkYDB7lt9JEMn0z4tGj5PkwPG8kXmNHgeydRlSD+861cgF33kJa249FSGafU2u0AFLuwMBRwltJt48v4K8uAUM66nb/fF8tseGSCnGlXHibuxwCGMPUr+2qc9c0F/dGJa9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661014; c=relaxed/simple;
	bh=dg/R5CwDEEAcRHND/ahWRYLsDoObMxoUtzYJ3qSwIgk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=KT7Z2soG5ZIgzVWZV4Kng0wo1AnrmptYe6FZHFtmOhtCyI0CMaT+/Za1z4nCAImi4vGGop+W9eFwPKcqilzSjU/1JBVuqN4t61Csb6I6G8+xa+h/QzhOaLZQiPFPKwrRIn+n+sYm0+dVWvBeb7o6QWwezUFUDpgC9x/VzBHb00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osxAfB6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osxAfB6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC5DC2BCB4;
	Fri,  1 May 2026 18:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777661014;
	bh=dg/R5CwDEEAcRHND/ahWRYLsDoObMxoUtzYJ3qSwIgk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=osxAfB6dIv1wm4C5SMKLQyN6YqBtf/nyxaR+cZgoe8JNHnRUrNUJS63EhNAdIqrlS
	 YX1pXBkcaD6EySjrvxU57/KfPu+XlCWcdlnHPKvrcGB82urBBx+NXufyQ65SWeVRZL
	 r3x4OvjvGMDJNLUWGM0HJHH+qd4s1qKNaFqQNys4+3FVcLdvosPGyGpULHQGrQrbHU
	 Vv+2VccN+XWbjtfnKYmqLRB1chqwC1IlbMEePytZYCUsm731c5VUSBUSkGWcVJoT4k
	 iH0NeCo4zQzS2dnO0V1k33fBfcXZzyYQTMupEPs4eKUCHtbhsh1R8BPRQo2ohataSq
	 Yom3LGc2fJC8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F63380CEE6;
	Fri,  1 May 2026 18:42:49 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260501013924.B14F81AC5863@finisterre.sirena.org.uk>
References: <20260501013924.B14F81AC5863@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260501013924.B14F81AC5863@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc1
X-PR-Tracked-Commit-Id: 8c0f9cd1df41ee029711baca839b99d9592c5dd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33d0c9c5f0945fc93a08d7ab20c4fb6d6976ed3b
Message-Id: <177766096772.3581397.14138634238622520679.pr-tracker-bot@kernel.org>
Date: Fri, 01 May 2026 18:42:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 01 May 2026 10:39:16 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33d0c9c5f0945fc93a08d7ab20c4fb6d6976ed3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
