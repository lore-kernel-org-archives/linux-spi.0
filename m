Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2E93E0C5C;
	Fri, 11 Sep 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166148; cv=none; b=ibqf6l6rdU67bY4c80XqGMehNdfi2oxG6lNwLKBYiknz+o9Rb1P4WqjQskJVAbhqiDGsA1qMC2PlpXqTaTuCP3SQ5DQmTcHw45hoeOeHsaB4jTEA6QbClXPrRT/Zd1ojIL27XNZuy5A2Of7LBZSEScyyc9Ll9h4z/+8ee4XYdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166148; c=relaxed/simple;
	bh=yuYp9J4FnFhxzWS47sYh+Hz/OC34Bpq7M0g5ZfWeIXs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Es0+Vk1Evu9HWZ/Dhf+ZvNPInw/Y0N7AJ8NUroh3t86VF1/EaB/vsZ72Xu+Z/zdi+vZ9b9zVYBu8XhM/Sz+hEoEXWblyBgfkbozKWKhZpIS+iSzhkGd+VCvla/0EZkug4mP8ng1FhMnsjtv/agFcvzi9RRRXthoVvUWOsKLgBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE8JdGZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE8JdGZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F37F1F00893;
	Fri, 11 Sep 2026 22:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166147;
	bh=WlFQ1QWZ8MxIcBhx/wuYP/2kqdYq/ybSiA8C3jc5nm4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=oE8JdGZy4EQiJSVR2NdpCoGU5ED2kJ2AI9bpLTwXocc4HiB8nq1feCOqyaem30p4Q
	 5WI+uO96Hk0sMilKdzM0d2rQdVOaduRKVARiZaMLVuZJ7PADMHD+wAur1OHICMAFy0
	 KDtA5/2wwLAXowKnogGWBsIHYrtp4ftXvUZDqRWeyqE2m7Qaj8Z+mcDhKo0152WqSw
	 KwPAYxfW0i+grkxLGtLufBNZVkE6Oy3h401MZt/YPq4ClLBaiP3Ehx2Tj3733fPQJC
	 FDedZ05+GUdOg3m00YcPJY8cQ8nZk3jgViHPv1QQPe1CrjhDziqD4bzAvV2KsHfpPD
	 HtJ/eFCWkfZug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A9D3924454;
	Fri, 11 Sep 2026 22:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260911213751.1B9B2DE8A41@traversing.sirena.org.uk>
References: <20260911213751.1B9B2DE8A41@traversing.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260911213751.1B9B2DE8A41@traversing.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc2
X-PR-Tracked-Commit-Id: f77de4c33f0edbb33411f92a35d7196965597e6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fb234ce373a331a21c1d33cffef28e53cee4ddb
Message-Id: <178916608370.3141697.7327755887295714334.pr-tracker-bot@kernel.org>
Date: Fri, 11 Sep 2026 22:34:43 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Sep 2026 22:22:47 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fb234ce373a331a21c1d33cffef28e53cee4ddb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
