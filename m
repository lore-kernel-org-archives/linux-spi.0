Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE25261B71
	for <linux-spi@vger.kernel.org>; Fri, 27 Feb 2026 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155799; cv=none; b=tfvO51NSD+iDIUwksvw3y/mwubIGnz49Sn0ZpSGotIIkk8bwLSayM5cQ0C+E2FJFzL9ULan5Br0Pit5/vsO5oK6xUwZ/Zbguuyxs9GFyHGJ8JKGVeUk73/JwY4VnydMevHY2EjfvDCeqN9KeVBfWiyH554yk+Gq2JBRQJCJ7n7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155799; c=relaxed/simple;
	bh=ilM69sNsvQl2G++FWkwRydSbv3/P4r9b9zp/vHGR9uA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Zstomj34sIqS9QXbDtrOKtY7i3zZMPrfAQXyO+8TCQqCPbySv65TT6YoklDsjkqPYjn85RCwPqupb86fj5gMDa7trvE7efnvl1pbakY5fe9quDIUMzzdR3bz1LcZDP9TU70hb7UOXOX+YgXhqqCCxXdU6E0VA4teNogxS8xJmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjlhJjgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjlhJjgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAF4C116C6;
	Fri, 27 Feb 2026 01:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772155799;
	bh=ilM69sNsvQl2G++FWkwRydSbv3/P4r9b9zp/vHGR9uA=;
	h=Subject:From:Date:To:From;
	b=bjlhJjgYvqHCKBctiL2tDoKXFk3EHgJsm/eZ2Kmv2Qg6PLIiiIF0P7TvbRb86e9Cs
	 ZDeazMeDQj5o+ESytJPYgweDRPbVoWs+ROvzUMx3cuOpklPRCOEjUx/LLSk0T6igbO
	 BUBNut2r2TA+P9u1VYUv1S1S9OpgdE8wnxJzZ/3KPBGpduNk0qAD0m3o8AZOVJKbj+
	 bpXuJvGDi4/ejgwEcxvU8fPdKZu/fhdzTMi5IAfQNTRR/LJcbLEBJ022PBP3ivWZoM
	 CmpvMxeLvozYVRh1+A91X4pB+fltWOPZ4Eogxa4Zw22JZDrA5iqT4ehSNxNvjxMF/Z
	 9fLhePNAXGGcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 429853931098;
	Fri, 27 Feb 2026 01:30:04 +0000 (UTC)
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
 <177215580285.1928940.1695905175571016671.git-patchwork-summary@kernel.org>
Date: Fri, 27 Feb 2026 01:30:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: stm32: fix missing pointer assignment in case of dma chaining
  Submitter: Alain Volmat <alain.volmat@foss.st.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1057281
  Lore link: https://lore.kernel.org/r/20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


