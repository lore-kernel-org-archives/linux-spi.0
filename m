Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE91946DA;
	Fri, 23 Jan 2026 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201225; cv=none; b=AoP5ijygCIOwWhAeVXV9a909/6WPkz9aG+/9tKiI8YyZ6p8dZZEgxRAvmeiMKiA3qyXh+W5VCBe5ZkQv2Sv3Qdg9FpV/I5Nwz6+a+igBGW/XBn1FQXnxAv7KO+nXBcz8E55NvccGapONdoNFRUCGYA+FxkGWs0VbUjZMnj7pMWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201225; c=relaxed/simple;
	bh=7Tl1Y+JNbeTGPMA6XbvO/MvQPLo0mX2X+1Q8ybX0a4Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o5OCYO+I/U/yrAoB5CLttOfZCf257spruyhsOJO/kR6hwyJ9L2yhqctrF8goXQg1a31Hs/vVO1zQ54K+0eyEF8CqaLGqvg3Q0+bzTKiJ/mW9XS5fZ9kmGbW9STFxcLQr4MevTAbRpCdiUgFTeTWEHFDwX0Tu/VUZSJn6tUf61xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMs8Z8wE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMs8Z8wE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B47CC116D0;
	Fri, 23 Jan 2026 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769201223;
	bh=7Tl1Y+JNbeTGPMA6XbvO/MvQPLo0mX2X+1Q8ybX0a4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=vMs8Z8wEHmldbFZBzkLJOHrhg4AyE7ocwyOtQppoi6sbYc3Mdg70vrdfHTU+DnObH
	 Nhh3fJDGNforh7iz/2riVWIUo7A4Koq1sp/D5dCbnaqlzeW4Ua2m0lQLwOVHdGMlzN
	 1eEqHjyZMAFA1OxOCmtwDbWyh4/19tjXsoMb5Lia4HB3d/eHtQz/sqsTzxE7RlzVdC
	 irjWmEivHVQjSDECMSWEF+E5pD+Os0/av8vb22jBMAIUS3OaeWUZH4QrZwxKSpWXxv
	 9GmN/mKWNEVVREdNOGG9upzjf56TJhSrrWtzn5apfnvyUKIEvbYwsBc3sutPXyhOpo
	 PdTuWVt6bmHxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 117F43808200;
	Fri, 23 Jan 2026 20:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <d83f7fb290c025fcc0f6072c521c8de1@kernel.org>
References: <d83f7fb290c025fcc0f6072c521c8de1@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d83f7fb290c025fcc0f6072c521c8de1@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc6
X-PR-Tracked-Commit-Id: caa329649259d0f90c0056c9860ca659d4ba3211
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c133687c2eae4f38d4481430793b04f2e7267e7c
Message-Id: <176920121864.2710575.1326444803962954044.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 20:46:58 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Jan 2026 15:29:14 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c133687c2eae4f38d4481430793b04f2e7267e7c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
