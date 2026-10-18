Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92C401A2E;
	Sun, 18 Oct 2026 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350403; cv=none; b=omf6wrKbYGdEMz/7UGEZNNY8hxFf+yYouw0PO9OBO3qE3T5valJUfWos9Cs/SW3W7Eq2ZfWOu8MbesIX3shQg/NqNdczCBXim2GjR1NbMZt7gbD52/OuLMvMjbSa4JIiigfjYZEDTpgknr0hhB417QB0iWnSFF2v1Vm1uk1hncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350403; c=relaxed/simple;
	bh=qIvdQD3q6uCIGYYpSE/qeRHvEeqMMnarcDDlg1hkGMg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tvLWspYZdcwgSJ7G6XqpbkwUE6C4kw8MrJNfT3qT/JL51mbsIMzuC1fm8Zf/FqGSMtX6o0RnDG7L4bwugXqAHC5HvND6K6Grr5eKTPAyViLJrSwmrNImtv+AUknAhygn7yz2nt4SK3VmX6unYoh5Ae+Dguk9ipL/uNx6Idkuqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TACtlLzo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TACtlLzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ECF1F000C4;
	Sun, 18 Oct 2026 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792350402;
	bh=adYr8KU6JLuyE6vLoAbtmP8076xy5xJGRy0Ay7U3sR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TACtlLzoI8GxuulWwjkPACICagSDszm7EfO6O3spQaBlGrhYs4olsYf8e4Qmc9MPa
	 /EkZfAPqci+BwJjpix0mAHYtJO2MCZuAT0QmCoPRJHCrHL8j3/DSYiENAPqEoAbTGm
	 g4L+GGrAOSwRxuURpEtyyfmR2NRjZwrKR5F44MP4Cpw4dhzNw2glFfrnW2mxz6bwYx
	 hJEcHyXId7rGsIQvSUJPQ1vLZoqoKpKdAEe21WFJIpwym97aLRiJ7XBxci7RQRCNZO
	 j+51Im4if+EarY1b7aw5zx9vD0o0BdyjdwyxxDvYluVsNgdZorriQTh98ibORPKkLK
	 zEa7iF3a+VXBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A286381196D;
	Sun, 18 Oct 2026 19:06:42 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261018125341.75D491AC57D1@finisterre.sirena.org.uk>
References: <20261018125341.75D491AC57D1@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261018125341.75D491AC57D1@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc7
X-PR-Tracked-Commit-Id: b0f0c761ed3fa10754dc9295db85374a173123b7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8486d357129126e27fb5d4e02622566bafc77035
Message-Id: <179235040095.1786430.9593471514944624179.pr-tracker-bot@kernel.org>
Date: Sun, 18 Oct 2026 19:06:40 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 18 Oct 2026 13:52:42 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8486d357129126e27fb5d4e02622566bafc77035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
