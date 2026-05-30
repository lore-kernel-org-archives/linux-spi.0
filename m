Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8FB190462;
	Sat, 30 May 2026 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103375; cv=none; b=F+9PBu3Q2d1vyitaAdqExPCv+oNkmc+FDQqYWdsssmdykdFUGnJNKTEfOOiSe4i0Chj2DkfxVONGAqfAr9LB9LavDpWDx7jq9QfRDKPxCBiJxL/0guv5IjicpjIFXgA9t7ex4GHZ+bvl3VDC+X6bJ65MAdPP+c0i1jens307ry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103375; c=relaxed/simple;
	bh=3hSsCWWdLmyf5D+AVXHxp2HjuctmUxhNEaWZkqluTYg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rwkTvfFuLUNwxG33WdAYR5rHMhFs6z/0e2AquE4F9V6rRZc4TZ2DF/bAyMAfQimvbFa8gad2GyKlrmxKSOoGLmBChapR0oKLJUxBNP3EcMQ3mc5ntvTR4lG1Z5VK2+WLSf6oHcFZs8OJvG1k/cXwU+OKfyjIp0EhCriWxp6bbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWZtti+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWZtti+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC551F00893;
	Sat, 30 May 2026 01:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103373;
	bh=FTh4fXZIOpuV983jxOYstJk4u5OjMigtUQWv76l9o+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PWZtti+5Az/g+0Wid82ig567JtR9UoFHOkk4y35p6W2US3Wi28R0d6GskL6gYRo7x
	 4/OxQ2Pv/gVASlD7/7bghjqTg5R3gybY2gDzEFRdoaxWk4AtCbYEzj6c6vcLeaeqR4
	 0HBdMR1/hJPhSGJCMAu0fQDLUte+WNmFZJm8YmKv9Cjl3YbFT3nvGuiZ/ZIhunkwdz
	 YaRBUygxgiCobr2xiYmATRgnGJjxYX+Oy9q83tAOjz4wCKHI+PDBefTHvd8Z+WJKKR
	 HyqaR7IkKyNPmI/bgVSkdD6gFPe7wx9ueYEKglUI1TqP5e9IikUGcJdm41/IJYmiMB
	 neQ73MZ06hXbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C1C39301AB;
	Sat, 30 May 2026 01:09:38 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <882ea35db619e3f9c74cca4619e9eede@kernel.org>
References: <882ea35db619e3f9c74cca4619e9eede@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <882ea35db619e3f9c74cca4619e9eede@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc5
X-PR-Tracked-Commit-Id: 79378db6a86c7014cce40b65252e6c18f5b8bcc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5e5d3509bffb95c6648eb9795f7f236852ae62d
Message-Id: <178010337708.2452153.6382881393362435022.pr-tracker-bot@kernel.org>
Date: Sat, 30 May 2026 01:09:37 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 May 2026 00:00:39 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5e5d3509bffb95c6648eb9795f7f236852ae62d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
