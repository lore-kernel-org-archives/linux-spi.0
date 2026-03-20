Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD531F9B0;
	Fri, 20 Mar 2026 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026845; cv=none; b=SKAGYV9In3K+CEKARzD0PIdf/9+lAglC8sTDniQnI3cFjolf0Bwhv45e3cPMvGctnM5Aj4EA53UJlS1Q3bESS25zh+HvLF5JaDx7pxn7FmoLt+gRiYnMaIppPfndN15skdvfMequTZVGKOBE4tS9J9Ihum1VlC8BvVsPgqe3yzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026845; c=relaxed/simple;
	bh=wCtGKGiouo5CV82ZX/9gm3S4rdBbxeQY10ks9ekVGSk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kjFZ1gQ33/EdVzImETKAX9YzftKCFQyXaQhsii1ufYfmoyTFO4hNldCGbLtNCYkyfDw8BtVjSE4rmauMgsuXJdOVBrs8sQEKS4Ak73ucGTxexUN6gbML1f4Jfzb/v6ZCiDJMkV8OXHefh8dheCxbpKRFgw17o4NWvGmp8zsUFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwQvgKgH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwQvgKgH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF91EC4CEF7;
	Fri, 20 Mar 2026 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026845;
	bh=wCtGKGiouo5CV82ZX/9gm3S4rdBbxeQY10ks9ekVGSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iwQvgKgHs42vuqZ86Gyp5GXVKgENH2Z4ztlweKT2N19DWYsNvv+NKhbV/UwA4mCAa
	 slVDLCxDUWFuW2jR2rlZPBs2J7AYhPXkJuqvK2iP6w2PbbsjB/mOtjuC3/p5R7fO0s
	 vbdtpwJ8zuhWH8ap7JcwHZxytL6NhmKRrGeZYI5BusMzTxRrsuniOQWgIiAx3ebLv7
	 1MF/II6n2B2ED6Y5hlaYCDBYx1hWgnRVEQyp7i8MbHzc9RIpL/XBZ5jp2+/Ag8I4n0
	 h4Tp3EZz5dBimEMOsghLJviCNbPPF25GplYPALOXkvOBzVntQWpfPh/CnlTi90Vn+E
	 QHHUwD002EPWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFCD380820D;
	Fri, 20 Mar 2026 17:13:56 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <a4e342d6b3bc37b9a25872843d25f5db@kernel.org>
References: <a4e342d6b3bc37b9a25872843d25f5db@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a4e342d6b3bc37b9a25872843d25f5db@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc4
X-PR-Tracked-Commit-Id: 8c89a077ca796a2fe248c584e9d7e66cff0388c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f582e39712f950f13dfa1ad49748a90937e48be
Message-Id: <177402683510.2580860.2501099941952404452.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 17:13:55 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Mar 2026 15:14:39 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f582e39712f950f13dfa1ad49748a90937e48be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
