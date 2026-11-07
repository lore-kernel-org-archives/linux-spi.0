Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064806;
	b=v9jxXNP8S+YLXwEO6RMQocUFsQ/zB8ZuhW6VV0gpKpbjlJRnWmj/wVOVRNpsR2nH2r/m
	 /cKo3OJ/N8ZJZagXWNIAbzOQA/Tn7KqENzJk21aL7mVc6s0KVXK+ydAmsIb0EbcY2b6m0
	 I95gNn/6XvEkENarj2Wt/lU+z/oFtuG3IawsWEYG9Lz6X4a06oWdjpyJTre1k0+1sPuFM
	 9FcUIxdb/yro/5CLzp8UYsxhkUwnsSgpeC4UNlzL7OWanXpTW7W8lqBa1SdeHzH4gREJ2
	 p/sX39ShzpNR4K2OTpxMPo841y3Q+Dr+tg3YgEopEuwAut0zzrFW/u0+OqhhHALSBuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=jLPQOvvWVVv/GK/LqcMoBI8D3MhWZ3+fMG3znT250Jk=;
	b=2ODaP5lp6HctvdKnS8Eq2ivhOcX23UDbmFr5eQP9FJXM7zqBR0aFN4/4vZa7FgBhuEBI
	 563b6HDw1x8VnmbHrf1XryXvK/XCRXQOmE42VaziSIpvLMzM4Bq+0DwHmm0QG6g4IRncC
	 +wbQdKY8gADBmSRJAlm6DuKF9YZHixfNHwwybcjKKq30GzJerCya5EOQI0KyZi66ASrIX
	 phvuBVbzv2ZcVsaM42L918t5j5G+jSsD4JWPK87y5N4rHPTmLN5fRDELgVURj+7o63+hk
	 0bBxs1EES+4sRmsfbwR1GdjOJPtODlbWNyoIvXpy6wIXORk5xFo6DaYXN67AQmo8XKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIi+Lh6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCF606C02A
	for <linux-spi@vger.kernel.org>; Sat,  7 Nov 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIi+Lh6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542451F008A3;
	Sat,  7 Nov 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794064806;
	bh=jLPQOvvWVVv/GK/LqcMoBI8D3MhWZ3+fMG3znT250Jk=;
	h=Subject:From:Date:To;
	b=JIi+Lh6OemXmDPacHra4kHl6NkuFVbp6m7vZVpUVi1LldCr8uJTaaalCXFNQEz9HI
	 ZQ/hVSx1969bdbskYNNrICbI73X5yYJQfoV6CkmPhPdbnm6l0EJpJrVtnyVt+EgiFE
	 La3A1pxgFrQGuA7XwDY4UY8avtfLgQqRp+xb60H8HE4/0p9XUnpIdhy6X1mUZcc+0Q
	 /Dt0nVr4nlN5PMbUaxNyxv0M4xnMMPxZeZ/1yO2N3OyKokZOtp2KF9hcYIR0Sdrcgm
	 XWc/KrQqSBkpqR0sqlKTJw82nvaY7Ce7QGjHCM4/K3LjOpdpo0WpU4obwSknWO5d+R
	 JKhi3CMJDQwQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2398C380821F;
	Sat,  7 Nov 2026 15:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179406480471.1216717.203841197637772403.git-patchwork-summary@kernel.org>
Date: Sat, 07 Nov 2026 15:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Convert to subsys_platform_driver()
  Submitter: Peng Fan (OSS) <peng.fan@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1201698/
  Lore link: https://lore.kernel.org/r/20261104113405.1634275-1-peng.fan@oss.nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


