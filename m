Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8032B9A8;
	Sun, 26 Jul 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096037; cv=none; b=LzaHsRzYp+3N+TZfjxsO7q9YntlJmSuib3756On4RU1ufT1lkUi+u5tzlYdnu4e/Rs2L6Ot7BsxCYwh85JLiFTfpTuVsZhwD6Fuqow2LSFXFBXiLoArNxA30Z0mreI1IIniEMYsXWTfcDurl5+pXvsmKNGkiq914tocw7B2WIZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096037; c=relaxed/simple;
	bh=ennHs15Z20mt/0G+UG4medDHX3R42pbwZMvia5684n4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ohR1mLc2Ur/R0AAtUNkWkWtzsRznCRDRK8WQ0tm+Jed30cBd6CrFUI/bgooWmNxYXh3l1MSpgQpOBk1lWq+fb7kIx810kSgPrKQL31F11RbCapcm1f0tq/5Ns92LvhS9rP20t5c8CLr2kyCDrE/Azq/neWsVPNxmNHL3NcDipNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhfPIR6R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhfPIR6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B291F00A3A;
	Sun, 26 Jul 2026 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785096035;
	bh=4qjcSgC7zDdLFJR4OWYhR9xEmKLMGtjTm/mLlXPzA/U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=UhfPIR6RoOMmKJUIn95NUoIMUq49Bm6xKmW71J5jCRXPcdLwByYdrRMzw9qB7b27p
	 Q+CYEukt1bcQ/Ahkf/MrYlIGhZCRS3DE5FViUH0CDn1wLGQry86mCTie934KQwqYxy
	 8fBZ9fp5zdEyoAIz7g/x1xqQORk6Kyl0mDePeyO6WXOPVb/hsD4bDecZl4gw5NMot3
	 6D0WAL/MZVVjL9RpSyMNKxNXZaqPt4L8126xYFhZC6dxnGWvmfPTF8jESUTm1bpHp/
	 Bm5mtegh4ZLbKLJj/57FPxb6F6fRuiaDQf0lchQCfkhJHf/hjq4UPVWhZdJbub7/EH
	 etmRlCLsQ5rpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D169538119F5;
	Sun, 26 Jul 2026 20:00:02 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <fb6ebc01f222a49400ca0aa3d9597648@kernel.org>
References: <fb6ebc01f222a49400ca0aa3d9597648@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <fb6ebc01f222a49400ca0aa3d9597648@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc4
X-PR-Tracked-Commit-Id: 6389eaf11d6cd3a66d10d0a5ea9cd91f242ccba2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72841e8e8345ebf1005095149cc08eb6e2889a54
Message-Id: <178509600173.3839415.14447279194178628888.pr-tracker-bot@kernel.org>
Date: Sun, 26 Jul 2026 20:00:01 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Jul 2026 17:05:41 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72841e8e8345ebf1005095149cc08eb6e2889a54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
