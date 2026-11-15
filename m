Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794781769;
	b=i8Qy88OBxmkaykhJxmL6Hp/hMMChQwMTY70RFOMNyxUvepV4J+qp0ND5/v0GQ+f5c3dY
	 LAovsoyLVuAo4dilOlfYWyAMbt4WSWdvTtsjEHdnBuMVJ2qM+NSmQma/+JHcdgK5Qgg5C
	 RUGctwbXArv/P1o+1jvrmhcwjocTzU8xihODGulOot8ourP53ZjU3VZQDq/h+3mLIRura
	 pbdf8ntarYQ3UFWqSYBCev1Dg4lATQx2jam1+3frxDR7+LTWNLuKlVDhxgH7D7IKRs6uL
	 t2cpq3OJ89MmtSdO55BubYMJt7kKE8CMQ/v91CTgE3gY8hCRSQhdEpXxg9QjNXtYkbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794781769;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=RFxMoSLUp0RLrZJTgAlOmH24J0hcnUfTD2tMDSd0NTU=;
	b=hjUG96iYSc4SoJPv555todHSgeA87GUCJD3sD2jM9oFoplsQURtdessciitB0yAeMlXj
	 Qm3CtESPZhFw5zjj/RJFe1KaCYi5V+YP7bVJJdI0KqEDrCwIJH8oqiTToEGtbIRRTMna8
	 tkQfCuF/oZlAfIWTqkBsfUBzDE4gI1QjNZb8wLge9lDBj97h7OsgGAciGZpy1vLUe1vah
	 YC8FMEZO6ELWTBk6rkkhrfwiBapzeWdU5lykWUURDDDrcDRYQXbQT1BUpBTpXD79d1nKm
	 r61ljv/ngpj3JVdm41LhpVSYRiN4UhqLA+BmLldMN/lorxp2BzA4cPDZ2Gw8xl08mTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO2MM+cq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E12606A32C;
	Sun, 15 Nov 2026 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mO2MM+cq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB321F000C5;
	Sun, 15 Nov 2026 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794781769;
	bh=RFxMoSLUp0RLrZJTgAlOmH24J0hcnUfTD2tMDSd0NTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=mO2MM+cqK0u/SLBFEPYAq75LRtHAPcPbKROelVRpTurJy5Ll+R7AWu+qmUrzJCV/x
	 /snVp0Qs8u7+8lRDnSvmPllz5ZJ/BpbIrdgwyoKlkZ6gWdmox/cM3zXcTRlcjEz5ug
	 1yoTqUn+qCwPHiKazmctErtuC1Iivsk3NiAENeSG5xSjMwiqEMdWfBxE6Q59HrgGqP
	 hwFNhaO9oFuU4SZDf3PjdSHok8/nNw/JME68O2bagtSNhuzp1GY3HQNLUS+AiiAL8x
	 Ny+H/Rh734D41Nj2YkUqrWhSki3cO4ZPFsB0Tp0ch8UesZSEOAgIpjx2pw8XdSgcdT
	 8dwew2p2wTPPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 772DC380823F;
	Sun, 15 Nov 2026 22:29:29 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261115115143.07B293367B9E@traversing.sirena.org.uk>
References: <20261115115143.07B293367B9E@traversing.sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261115115143.07B293367B9E@traversing.sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc2
X-PR-Tracked-Commit-Id: 2a490521d74ac76e5eb3c9a69d928a4c76dd3f78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 481f9afb337b7096aa177cde0c077dee0c649ae5
Message-Id: <179478176800.2784423.12542062709540708850.pr-tracker-bot@kernel.org>
Date: Sun, 15 Nov 2026 22:29:28 +0000
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

The pull request you sent on Sun, 15 Nov 2026 11:50:52 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/481f9afb337b7096aa177cde0c077dee0c649ae5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
