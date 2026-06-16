Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779BA3C4167;
	Tue, 16 Jun 2026 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577032; cv=none; b=jXTksxf6Hx5xPCKps4C2q/+qSKU9bhV9lEfkBYq0JkH5uh6vSgkCV5FRoHwVSmWThXS66ZcCOdSesLknmDHS+fdTGrefCfaHGdGw+e6qawkzmb9NQcmiBbSNXc6sljShCiaC0fBJZKSDKaQJxDNobHaFf0y2aqPwHCHz5MWfGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577032; c=relaxed/simple;
	bh=jFZPZ41PD8mzGO9HLJWWOlc1xaBMmSuHSbyVkttORic=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OdzmxOFfZ1xWzeWoAo6W7vRdJzsfzU/tWbhib89mp7PRu/c6AJ6lXHoWEitaiupFw6oeRbbYYTpvLuuFpfBFKlwQo/2riNRjDXOL+jG4ke47UFWwvDTdxZgBQO4P2cNtWKNea/o6fPRXikseAoLB1NwoUjuugxtGt70dgu6z0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0WkhJkp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0WkhJkp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE531F0155D;
	Tue, 16 Jun 2026 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577025;
	bh=OzjxJ/KY2q/mrAv/v2ntpny2Vav+COk2vn1Usq/MJRM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=c0WkhJkpoEjT2YZuk9owsnADf0ZdQWty9mXUSkKWSr//FMR0OshMz98Hi/nSPuEUf
	 fJ/ZDlRpO1KpM6uQyOCoy57++w4o+wfeRHhRaL3DfOk/Q0ROqXF+QfUy69cyNFo0ki
	 RkrLqkb1luXEosnrd0errP+Cjn3e4IHKcOgKXx3nGoSrTscVOYj8ofOdInbcq0Qpus
	 ZO+uQJdvgYC1mL7RS3HJgS4Z36frhkMZNA4XQKks5TAKbBmO4Qxj5sVifYuhgyGtKs
	 ar5SME1j6fvXDhKPp5YU8XQOFwbxePc6kXd/xJS24XS/F3nnRcPUddg008MkJ8K1f9
	 WMtorvemIAoGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7DCB2383BF4D;
	Tue, 16 Jun 2026 02:30:21 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <eafbecb22793db47da30c2609eedb2ae@kernel.org>
References: <eafbecb22793db47da30c2609eedb2ae@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <eafbecb22793db47da30c2609eedb2ae@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.2
X-PR-Tracked-Commit-Id: f846d68992142034b1d34a83200a10cdc713eeda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c41cfae42c75a40783a6fc402f66c3c7852961e2
Message-Id: <178157702031.396694.1049279337704344677.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 02:30:20 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 18:04:56 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c41cfae42c75a40783a6fc402f66c3c7852961e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
