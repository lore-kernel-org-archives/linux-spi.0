Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792830608;
	b=BXNBf9OJSUE1rOPxPGSHrsOOX3RsA70wXwxcpO99EoWKgELFmAPPvy4l6dIuY/YilDho
	 QDv119pmp8rg5JFMPV9e9f1QUZCU4HFupy9eUPUPAvT3fvfNXfBaYLpTt0fYXKMmVlrzC
	 CdzXxigErWRNGad55e/m2G9r+CemzbkVXmin8SFfvr5Nwhb3KKuas84zR3Qk4z0Z4X9TQ
	 g3FvnokLs4CFqa79dP8gcgAoEMn2T1Y5w0YkVIW7XIoUUp0xdFyy/Z0QtTBIGYf12xwil
	 DI+fYc0BPuYsrVFfbfzHTcnrh9CqbvofWaAGWbCthFAJ2XuOhvjzUK5u4JfAsLF5mMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792830608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=3NaG3eWuMWcvnceXM6TVMoFx/AJMq0uTxGOExOLoTaw=;
	b=3UiB9F+lWmz0BC5oZuFlWfJg+WhOjNxAb/eoNNAOLnZ4xiOa6Ko+TWRufFMIHWZX0fFy
	 SHsltpxUEnz3qOXyHIHss4CcESQIXGGDp1YbYn6SAS8qcgA4U3TR+2BJ+5VUW3sIuj/so
	 oLSDNajdN4lTZQiR0XpPcVhRTydfRYTOYDpJh4LHKSuGR6SJzHXVAooraPPSpVc4HPa7D
	 xOMS+W4w9FFHuQmKBiVBGtv8YOG4uJK5L4kRkTYbanCOQbsGInjTEe6Vst/uwmOR5HskA
	 KmS0T6C41FpqLwDFo79/kIIt/nA7Zc5S0qAtomQBxxV/dpNXDFvPK33H+gNyP0qY5iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Md8wtZB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC0606A322
	for <linux-spi@vger.kernel.org>; Sat, 24 Oct 2026 08:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Md8wtZB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED16B1F01825;
	Sat, 24 Oct 2026 08:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792830608;
	bh=3NaG3eWuMWcvnceXM6TVMoFx/AJMq0uTxGOExOLoTaw=;
	h=Subject:From:Date:To;
	b=Md8wtZB0mxmgiC8Gz5w0QimAUrN6Kb9yvqDTiiuWZ3vOo7q+9nlCRbpuz3/D4qnxl
	 4i5dHV31tOmt6QH85QzS515QLmYCf9uWPu9RsC69D72w8QsYVsvSKhx9KhtLQIdnAN
	 vd5hM3+bk8oVWqLB92Go/1WCXxYMNArfYK8OSJIerKYArfPOIfTyaNsc+7pMJQK0GU
	 akRv0gxehqYCUpPEMKU+fS93IU8UG9xpLI0gdv0T33HWwrpCTd0ir9AIUZf/1ceY0N
	 y5ux1ISaRwAm8e9cFREVZ6lk6lc9n04k3b7IjIpkFuQMciWIPCh3vc09luJ4kSpNPS
	 bMi+oE1ENGXig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C176C391B17E;
	Sat, 24 Oct 2026 08:30:07 +0000 (UTC)
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
 <179283060635.1574981.7101871740848350633.git-patchwork-summary@kernel.org>
Date: Sat, 24 Oct 2026 08:30:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: zynq-qspi: fix address buffer corruption and support 4-byte address
  Submitter: Pufan Jin <cyan2254650260@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1187340/
  Lore link: https://lore.kernel.org/r/20261016130812.282624-1-cyan2254650260@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


