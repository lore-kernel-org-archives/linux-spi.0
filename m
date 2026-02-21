Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F9320A0C;
	Sat, 21 Feb 2026 01:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636840; cv=none; b=EdgEwxFci3GixWkXT7clgmMwZj4LsRA9ipl3Y+3HCai9mifDAZ0KVIdxnVACienuCgYdxFmFSP059m1ZdthVbMM8rrnL/ysPS/bufZe2hiRw6f8Jxr+3/rro32rZrPVDiBHo9hQ8KPTBmg6NIAWNeWjku8cvgkLXVMUY8s52UW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636840; c=relaxed/simple;
	bh=ihY0ZRvsVxQjl/m36gmGh8dcY6uMA8D7IgJQZ3EiSBo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gQv7Xy8G5niMV1SpNQ+lJsz+LwZbBly2RDp8jQ/5wcpg6xl2clOSbQaTUu0buyzCVzQdUWXnmMyN2u9m0D2C9kLQjotUppDvF/tMNE30ujZgAZ1f5VhTZgdWblsQDoHuuPi6QXQ0Tv5wJtvr5i5V2iQSo4iDqlu6womzhiA3jqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDi2y4lx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDi2y4lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A943C19423;
	Sat, 21 Feb 2026 01:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636840;
	bh=ihY0ZRvsVxQjl/m36gmGh8dcY6uMA8D7IgJQZ3EiSBo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iDi2y4lxwe0X1zM8NpwZfoNCXfqWQ4GyRBLgOyS02Jeamyo+0dc9uIydcWbyoRfsc
	 rsfKfjNnvRPIsDMigI3ghyrWUelX/AZStCg+jmj3a9Y6+HtS7Bwez0U8sUddjKEF4Y
	 Qcoob2TDR9fDFM7c2iipX690SSET4gV3GikdPVfwTaShqHjEwMZrrxHaCy/wirK8yN
	 rGFvobFXb+0llRn0HMF+iKBd35NawcEtswXAhW/QDK4O9lm6M20H1SvNO5rI3mtgr0
	 rA7dHo8Ls4rGjeKnLbM8jqgwlO9rvPrOLp971MrFL3Okp7Ab4K06Eh8Kv6NSEEfszE
	 LYnZooSlw1NPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E823808200;
	Sat, 21 Feb 2026 01:20:49 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <c1e196dc59d936e0cbd1f6e1c64c004f@kernel.org>
References: <c1e196dc59d936e0cbd1f6e1c64c004f@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c1e196dc59d936e0cbd1f6e1c64c004f@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-merge-window
X-PR-Tracked-Commit-Id: 40534d19ed2afb880ecf202dab26a8e7a5808d16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d79526b89571ae447c1a5cfd3d627efa07098348
Message-Id: <177163684843.970518.17592996587998979572.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 01:20:48 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Feb 2026 19:10:05 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d79526b89571ae447c1a5cfd3d627efa07098348

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
