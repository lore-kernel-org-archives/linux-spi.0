Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C983403E3
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540643; cv=none; b=iUXDDPltvAy8nHQAfaFOA163bo8brTj/kCSRm5PuXF2u97vIsaUPjzl1jbpgdQIVFqEyZ39mTgCS1e6Vhmb4P/GmCGE4hhNltx3Q2zbYiNyBAeTJHXAnIR+iaq0FHtNNzKzUPt9XZhIu2h3oV9tOxOGq9i7MteDgWCs8E3Va3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540643; c=relaxed/simple;
	bh=NGv8zr06jear02iMGDd8zeHQR54t5wJfp7G1PuozoHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oVYTF7uKNqU2/CGFsFKYu818uGJABGUcW9Xw9ru7eQk7ejCIO/xwb7kglMKxhpIwld7GsiThuH/X4g1PMydMCWUfLlwBqvddx0UinKylCfSb/Mg76LzpmWt2sEcFu1ZZxVJtA2vtbgOY7Sls34yRyytRtQnLybJvaP8AhDsFDlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3uBJiZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3uBJiZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31BE1F00ACA;
	Fri, 31 Jul 2026 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785540641;
	bh=LFw+eapa+XjWIzlnUN6r1sDlBrhmUdVQeOugI7lgZ6k=;
	h=Subject:From:Date:To;
	b=K3uBJiZkm1RKK+tGt6LMQKGrG+ILUeKngxKShS8YBBx2//wd5hxsJ1Qs3/9iCylgD
	 ITgFGt+eyyk+dqTwzx+kzKZm5IwoLBGmougeUjrZX4HlJAQXnYD9b9JCPkZzShuGiZ
	 WGVqWXw5Jz2DqLOGhgl+tGlYcr+cp57Sxick54CksINyyFUzMxma1Ernisc4MeWBmj
	 quEeKjnETPvNolPcupLShUH3NiIpOR6OXvm2HDzjKy2vGbjtE11HH+obNuRqRG5/Ou
	 9UHKZFjTueZQkcEOJOBSsXbu0N9qUkdnsuFa+KsZGGkkPgKXDVaVCOulUZ7sRmEukE
	 NJoS0sKHof0cA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 963FB392665D;
	Fri, 31 Jul 2026 23:30:05 +0000 (UTC)
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
 <178554060423.946487.3356184754442253844.git-patchwork-summary@kernel.org>
Date: Fri, 31 Jul 2026 23:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller
  Submitter: Chi-Wen Weng <cwweng.linux@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1137819
  Lore link: https://lore.kernel.org/r/20260731023818.1626075-1-cwweng.linux@gmail.com
    Patches: [v5,1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
             [v5,2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


