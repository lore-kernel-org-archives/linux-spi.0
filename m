Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292C3AEF24;
	Fri, 14 Aug 2026 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786748350; cv=none; b=f0aPCRTLfgBcc4FIxKRV/ZoIe1Mxbj087eufvhAAGMofVYwn8vMnyVpGvTkt5FGj2WM2/XnMe+I/15ZeeKawhm6iHHsC2QtfzWlOn2muAxJLUR2Hjcr05otMMBJOzcsacnyRsqxChNy7rtj/wIxipvX7DvMqg+CuHU5afZcATmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786748350; c=relaxed/simple;
	bh=yiVYMcL4FYsXIgy4D3uxZt3ULL9bClOPWtapVT2uyZA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CS6HwVjc2zjSQTTGJ1my18WhLM4lI9ElDZ34Iy8vsCNhJvEELhzBjeS4rmY+uVrQ/qg+tO1/zkQqz8nWWbW5RZzFhKnuOvqxfPaa+n8DiTBMKIUrFwJVRpLq+alNMc3mRXrFAzLP4n3ir2WxMgxiGBHxWqqzo4rynqEq+6zHWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvno1yGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvno1yGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2991B1F000E9;
	Fri, 14 Aug 2026 22:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786748349;
	bh=QHhmn9S2m7E8R1GJQf4+kwvlTVIvXTYx8cwMaoy4Yyg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dvno1yGfrcxr7CpnAPt6N7CdHZX6jCzB2w/e6/J0C8dTXy+5hkknOd0OqCPTd/A/h
	 U4rXJ4Mm2Nvo6ZlKUt+pWdRfU9A6Ak0Zp7l+Ko6QrNDTh50eWPnvC5dj2G5oJZEMdz
	 ft+vahycLEm3I9pFnd3CoEd6hb8rGJ6rG45klOdDczhbzJWJ6GGJGBEXO+TpLlkcah
	 GXxQ5buciQg4bKPshIBWHAgAJV58xD5Tq3Z1FBZBKXk/dhUsj+T7aSQ1N2ZBp49REx
	 5MYQWz3Mdb8eAH41Ng0vntfhHiSuryi+Stx0QzHICAj3/aJR3/VdL4kDLnEQwduVIu
	 rnbihr8gStLbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5681C3924460;
	Fri, 14 Aug 2026 22:58:24 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <917f2746ec579064ac9e7603c3e3ee73@kernel.org>
References: <917f2746ec579064ac9e7603c3e3ee73@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <917f2746ec579064ac9e7603c3e3ee73@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc7
X-PR-Tracked-Commit-Id: 11058bd3d47d57eb3473935feae53868d6d168b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06d9a86e0222dcf6858544ba7257994bfe9e63c7
Message-Id: <178674830295.3991221.6402718889890902853.pr-tracker-bot@kernel.org>
Date: Fri, 14 Aug 2026 22:58:22 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 18:55:20 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06d9a86e0222dcf6858544ba7257994bfe9e63c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
