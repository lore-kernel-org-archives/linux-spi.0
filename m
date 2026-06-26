Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC682D8767;
	Fri, 26 Jun 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782504063; cv=none; b=iCvNxkpyVtgq63sPFgqRqDU8XK849EUMhg+ORgMtaOxjLBiz+hYkJQLX89Tq4dSnV/J2SyvW2dAwgqW7rXRfBIj4y8WRJ7ii6rI4H4cRA+ghnEWc0Y9vlfFCXXkuGRSXdXo2ptgeBebdHpVv8eqkLSiUN/k8ScKaEiOaT1ckE1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782504063; c=relaxed/simple;
	bh=CDLd9Uy0RAw0JKYJKRqiT1XUGWVt24pA3P/k39QPyIE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g1DXJymGHtWplmc9ZWjzMmhmr8VKGBqhT5MQKiMBHMJyfsTJvbEwWKNEjN2p9gXzPY9YD6GOU3fkt98k6z9jJCzeh/Je0Fh79JrO733dq3iWG96sMt8qYE3HpSmDQ0kPAbbsqvwoNy5NCq+bjL4qMsgH7RyzokwPCbwoc+mON2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDgYgU2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDgYgU2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2221F000E9;
	Fri, 26 Jun 2026 20:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782504061;
	bh=f+G8P3oCuNL7G15EV2Xd+1YeasS5s6seWdBJmu+v7Ng=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lDgYgU2ArnwXIIB2TTnsFbt+tMcK/t4AMcDTT07qoIknTc1D3qm45DcW0G7WdxoHM
	 yDnEf5J4GPM26ZdjGkBvcFwHvhrIONZm79bUS767/dti4m2RQ/4PCG/BNA6bI33+VS
	 UdazrW4Y9MNz6iWollvHmscVKxVXgwdm79pBEBDTbNYOXmOKs3D+8I05cE+GaddbYI
	 RpOGkk2KsGRsn2y4idspkqsbyiB2gqdWQxSNsiLHTlMc8CNKJx92AWHRyZL0dIDDNS
	 6KMA/6nxQmnTdVKeU/HsuIRTR0cCHZm1DW57NeGaIjsoC8qw/o5WVIoj5SWYl67fWl
	 zG5KucEauZYpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8A3938C5D;
	Fri, 26 Jun 2026 20:00:49 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.2-merge-window
From: pr-tracker-bot@kernel.org
In-Reply-To: <482117f043cd16e559de7afa1674f5d3@kernel.org>
References: <482117f043cd16e559de7afa1674f5d3@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <482117f043cd16e559de7afa1674f5d3@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-merge-window
X-PR-Tracked-Commit-Id: 245404c26563aafb36aafb01298f148db1851be3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0789fd342e015b20b4d2cb43b473268825ae077
Message-Id: <178250404822.1075722.1837584600678912849.pr-tracker-bot@kernel.org>
Date: Fri, 26 Jun 2026 20:00:48 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jun 2026 15:12:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.2-merge-window

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0789fd342e015b20b4d2cb43b473268825ae077

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
