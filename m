Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73C43128D4
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773096008; cv=none; b=mLGt9xUJGUIy9fqLuo/4vWIaSb6UbW0M8fDw14p3Aj7E80TMIxgZdi1bud/XtiNzP9AihMqonw/zOAdyLXRezGyPTeb+kDdaTQkX+8PJvDezSewJOy2DIwvNdwmO+Y3mpuF09B9FjqrcKoI/KoFbA17M7ljYkTMVvrS8xXK2xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773096008; c=relaxed/simple;
	bh=Wg6xeobWcgRoTqBX+o4Xpdfx1vvUCXUHQOKzJ9ss2Do=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oQ7CS7YLCCOEc5GhlHJPPRC0++pGact8aLbmKIMpicDc86LBn+gW6ZhXLPRrmOOx1Yt5dFBRuNlJ4v5TV4BzlYLVUDS2pe9BAQpCtnuQYLfJWsx5Ngdq4gCDe30vuFLaV5od7b3hNaB67CKL2dJV1ItcizB/6h4Gzzefb2qT33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOUAE/vL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOUAE/vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A09C4CEF7;
	Mon,  9 Mar 2026 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773096008;
	bh=Wg6xeobWcgRoTqBX+o4Xpdfx1vvUCXUHQOKzJ9ss2Do=;
	h=Subject:From:Date:To:From;
	b=rOUAE/vL+snOiru73P4T2wczP5b5uxBqPVL0sMEpXGhtSVOsrDQZIIfjCiPGE2kIy
	 fNWEpOwwg7Ijwv15bKfVmsV0sMMdQgmPg1k4NsKypo2OUgWRU2EdXeSgEeNz+5nq1G
	 p7zpb8jeyZUyRwOLB1lHQFJkrhc4EwUXVeUG9XtrprJewf96149EHfk6s+etxO0LQ6
	 6XURz3vYPWTqlQk4Fdl58z62Gp/NeXBS/3uj41z4lB3RrwATaVhIPh+Rb7pQF+d5I4
	 QMFGIFmtGha0CNDmRdk+da38QVJZ+DJijBvM9fkk1RRnprbsaDFgvE5x6UiOczkoOX
	 ZcdJD183kZYDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCE343808200;
	Mon,  9 Mar 2026 22:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <177309600521.1964591.1335863819219460525.git-patchwork-summary@kernel.org>
Date: Mon, 09 Mar 2026 22:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: rockchip-sfc: Fix double-free in remove() callback
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1063847
  Lore link: https://lore.kernel.org/r/20260310-sfc-v2-1-67fab04b097f@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


