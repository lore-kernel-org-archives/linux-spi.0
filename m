Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791EC490BE0;
	Wed, 19 Aug 2026 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160570; cv=none; b=GZC6nzKoolohIxZynlycplWGJTa9wvnx5mLaLXbJdQWLrun5Yg1k2wVW1rfe3g14/WkX5sW287qGWJkKz6RiNDdF0FN5TYTC91dfh6VAIVYkLwZJN+53GCr7ZVZhWK5rde4KX34I4IaXp8Y9abNpa91VncDGSqB39zT0/ImfF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160570; c=relaxed/simple;
	bh=3p6JazOBPSqVXJVlrxQAQQ6XZFky5qWcPfFj2KGWu/g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n5Gql+ftcfLrVGHoX3G1Z50UOky9tQlR+IfGcOkbU6PDzWBjPXXnbmVRjuIJ5g4jt0x88kL6jFK9BudCCPh4dHiiIv5QG1n2AjmoauBHzhHzEYSwrTksemN8vcYdBI10PwqSAf88abAkzc8taZIzeofOjEGQPhewDx7793CWQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh0/5tNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh0/5tNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9501D1F338E8;
	Wed, 19 Aug 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160102;
	bh=wNnm/yXqxhlpWkQ3mIW9u/vTjmzh9cgbWLKfkM2Ip4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Jh0/5tNb1JeE9NIPezJal3U7m9BQmOiBaLE8ywBHIUo9gSfAZSQ68g8+LJx8tDsqr
	 vnsHfdbQO9la/ydav666C7D66DwrGamPE32omlT3GP+q4lLOWz91XLfCbZZTOSpKfI
	 a8mBm1pEP19u5svmf7A6H1nUqhdfmFi/tk6x4Mh/HfoA5oRGCMn24HecARupXEauV9
	 9RKsBVSCJSJUy+U8OViQttqsxJ5+qwYuRAV3DUmy6Q2WzwUj36+YPwLod3PxFb/DnE
	 lk21yI0P3gXXs6sLyFDeRZ+Eg8551Lg0uZzBEbLBwtSVo9jGogDwU+tYYDJyDd2ozb
	 1Ux2Js//h2rQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2A6738119E7;
	Wed, 19 Aug 2026 17:20:54 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <14728b3c8987929a3f2944ce5ddb7297@kernel.org>
References: <14728b3c8987929a3f2944ce5ddb7297@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <14728b3c8987929a3f2944ce5ddb7297@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.3
X-PR-Tracked-Commit-Id: 23688febe4b44b10f4b454eb1cde0ba379a84119
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 307b9ddbbcf987db77d52da6f9ff5b4096ac9599
Message-Id: <178716005353.3599392.647642152825864246.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:53 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 17:53:25 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/307b9ddbbcf987db77d52da6f9ff5b4096ac9599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
