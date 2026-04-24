Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F937F00F;
	Fri, 24 Apr 2026 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063065; cv=none; b=lLFsr907UrOryGwWHKST8yNJorGejp/IM2U3/4WB6pw08HIu7sYzcX0pHgR7kuiFUgdPy29LBjHGGbOQ0TfcScGK23CtRCDxGWwp4v86CvrIm7/xAIXGUaP2bIzChm27jXMnXVp46QGQPZB9QEX5VsOQUjXmibiskmCLyz/Xe1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063065; c=relaxed/simple;
	bh=S68Z2hwQiQ8aFdgQjQBKYrFg+zpBTvEsB1dC4kIx1a8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ovbfV963fpUR8DCTX5ghWR+10vpxd/H+OFEif4vGSdZ45AKQpUyli2Qrt/3qzQGon4tkHeR37QaMBnUowtZz52JUf/UQa0ov9agTp2B8wijgZsrs/ILoIPiX4KaLY1moNIu4i85/7r7KNz5YnCK6zMyo3Hw9QrkRYc1Se01qOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1AnZ1PA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1AnZ1PA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB7C19425;
	Fri, 24 Apr 2026 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063065;
	bh=S68Z2hwQiQ8aFdgQjQBKYrFg+zpBTvEsB1dC4kIx1a8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=E1AnZ1PAXGlBXYY6n9tVF+7/YHK6ScwXhW0+mOikSlObj5qm6XtPzcCXvHnIInoHG
	 m4vmPQ6EtyCkCXB8AdWxddn8OodnZowKdqwLO19ewKSbg4j+aCkN2sEe0OvR+2jCCu
	 gsUU8UV/exaSEE3dI8w3rKgB+gsTXXWhTaTRMqh91VFIm5OJSN7ytHkn3eM2Umda84
	 QTPXYWFoT1CwiW6RN5ShzBr6eo2QBWOKdWCCKrBxInfO10cJA5d4MmJ2z7mUOE+hTN
	 lNY9hmYuM6ty3ZWfUwoZVwS5RVxRK5KqkvZLBoYbWzCu4Tl/doZw+g4Kkea4T+G7wJ
	 tMpZGICx4Zv+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1EF38119C3;
	Fri, 24 Apr 2026 20:37:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.1-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <b1a629e07ae2ecbbd869f15441a95e06@kernel.org>
References: <b1a629e07ae2ecbbd869f15441a95e06@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <b1a629e07ae2ecbbd869f15441a95e06@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-merge-window
X-PR-Tracked-Commit-Id: 16ab65df5d867961a79cef366cdb33f09ebda603
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2680ba4a2ad259c7bbd856ed830b459e11d88ba
Message-Id: <177706302497.1703875.8416966390124175611.pr-tracker-bot@kernel.org>
Date: Fri, 24 Apr 2026 20:37:04 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Apr 2026 15:59:30 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2680ba4a2ad259c7bbd856ed830b459e11d88ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
