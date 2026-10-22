Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693901;
	b=aPROD2s0LE00WulO7Ji6eaUCxlVFqFUjubpTTegGHb9vytGhL5GvsO7GYCGUjSNkJSpW
	 RrVYTcrrgYlzlWgn2MryrD8/rCiALCWNb9ycEXfb95SSvfWjELnppQYrhSRg9cFDc6fKR
	 gMz1fcJLwJBYmZVbfhpvORpaogkXn17494PUnWrBGoMmqLXS6xdlc3zHiB7uh4FwPD641
	 5hLbqQ9Tj8qHoy/1I/xEl5BW5C1hCyRZifwzwbI/MRK5CIeVcANpqjbELf5thwE4g7GXn
	 Vb18il4/JncIYas1aTugBj0DTUFYw38XJkCYCFLQoU5CzBjciZJJc8gqonp2GDKR4xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693901;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=j9NnxRl8oXvlNwNoqxERJLGeHYVWa95ZwekGkciySeQ=;
	b=Wqm97w/rCCfK6MBUFCteSJNM7fyd7MD3LYZ1eT8dmD3CgR62n+UTGHarY/9Ub9WTimeb
	 r17ae0cH2Qageb3eI2eyB9gXCwvXOP+Fy6u4P3YQg/uaWziFinIxoYxc4WFToWrC25Pml
	 KhNwAGrpRYp62+W/uPj5xB/gDHaVL3brYtAi+94oaS/5G/iaS4iD2Zx+n3QG5m2s37l9f
	 YUhT1vPzkTSG1NmlyrAlXas5fZ3mDYnfp6eMsjTs+cPdu51hF8AmgPPoDx3+B8BsYoc0F
	 NDdkACY/p/BHG5EwAWjv+VCxDv1cFiICaMikM0ke4sSYNzbhAFF3Nk5C18WFuWvCcjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbWCZqu+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DE4606B7CC;
	Thu, 22 Oct 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbWCZqu+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3BD1F01828;
	Thu, 22 Oct 2026 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693901;
	bh=j9NnxRl8oXvlNwNoqxERJLGeHYVWa95ZwekGkciySeQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=HbWCZqu+AjjXPNVGLLtoCl+/RfODzpnZy475ah9C08MaRIGOtQRhTRSToVz6Spfet
	 jZPpCRkxwYNRFy+zQeB63ljHtvlG7/U432FVPAmx0B32fiVzg1sYQ6c8SaVAEd3vdo
	 0VfiiovgMBe2U1Y0pX9cdIC3KjoTKi4yyb7wfKC7gEu45fuQgMZT+aVAUwu3mGkN2G
	 vS4fLYkNtoGveFDovrh+8+POZFa7W24a80J0xq3C8XgS5zuzp1AVyTd9BLKVY6d/Pz
	 DpRkx8KKSTTmpqFOjboHFZEY8DmPpCvNQBmYnQiC/8QRzw8+fOvYiJH7/XG4kKjBBd
	 lHFXEAd7IZLwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4148A380822E;
	Thu, 22 Oct 2026 18:31:41 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261021110441.5E5C91AC5994@finisterre.sirena.org.uk>
References: <20261021110441.5E5C91AC5994@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261021110441.5E5C91AC5994@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.4
X-PR-Tracked-Commit-Id: d5acef12e819c1627c8bf6a0325845ab39d8c99d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ef8f742f9008132db003313bf7a6ca2edb8bbae
Message-Id: <179269390006.87271.7308923790977324036.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:31:40 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 12:03:53 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ef8f742f9008132db003313bf7a6ca2edb8bbae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
