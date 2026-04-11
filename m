Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC738736B;
	Sat, 11 Apr 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937556; cv=none; b=kznjZxbE/wv8axbnCHFJ+Q8Se2nSrimsSojB1z0oRPY6V/JDr5MIHf1+jCAXC+IP9pVYNjadNg7s/b9ux/xowABrmQ69xFa5XSTP9B7ecygqiy3H31uN/oHpKOGItQfhKM2TF0xvNR2iie9xpuWozUOXrDPm+rNMDn4onxlVQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937556; c=relaxed/simple;
	bh=b5MhCUQym/tc5X19ivtmVIuzMv6/nMwD9Tr/vCSr6GY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=cEV/sxroH9lt03USJuRyExyW/yBLvic+ok1pMJiAM2TI3t/vCJJJw7Sb/gGGYuqVkGQ9nQoQjEIU6XoHINwXPInPJMt5GWXY1N6Y660bNEWnieipihK00N04XQqMGhOvoDd9SqV65BnKF2uhVoGIhxfxE+4BapGfPdF5i4A3JX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8Hn3o15; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8Hn3o15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D64BC2BCAF;
	Sat, 11 Apr 2026 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937555;
	bh=b5MhCUQym/tc5X19ivtmVIuzMv6/nMwD9Tr/vCSr6GY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=q8Hn3o1551ooraBvipdNKzYC/0Bd1HGgF1xKDuYdJyOI/GylX/BaChpQc6pCbwVAn
	 yIJiHb9Sw11pH0FQSuaI2jNKj5F7eWCFBUpi9pm6DT6pncp9ceLSPRCP56FDUNsQPJ
	 SoZWuNvfUnEZmtmt7/txRiHSfkIoxATIEE216H5bbNqbT/oqpA33PFvginL5yEdSFB
	 gU03pws9kDzFYsWwRziuqgLVa3yx/hEncrBUiyhekf+oRONpd8Yix5TMhIPK9vR0Rr
	 3Pz+QVCxMQDZq3N0K94bnSfEvJr8A3Pkfem6d3eXzp/ZkLL+CUl2X6eEfxg33FR0/b
	 z1bmq/Q/lyBdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF753809A8B;
	Sat, 11 Apr 2026 19:58:50 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260411192527.7F21E1AC58C1@finisterre.sirena.org.uk>
References: <20260411192527.7F21E1AC58C1@finisterre.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260411192527.7F21E1AC58C1@finisterre.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc7
X-PR-Tracked-Commit-Id: 705355a82b8ea86e0afe44560e970eedc74c05d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e753c16cb3dd1e8feee6977c330d21fbe0e2db0b
Message-Id: <177593752889.3064778.11989510771267197871.pr-tracker-bot@kernel.org>
Date: Sat, 11 Apr 2026 19:58:48 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Apr 2026 20:25:10 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e753c16cb3dd1e8feee6977c330d21fbe0e2db0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
