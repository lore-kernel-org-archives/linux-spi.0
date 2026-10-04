Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E2447F769
	for <linux-spi@vger.kernel.org>; Sun,  4 Oct 2026 22:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791153008; cv=none; b=LG2fChCkZHAMKXVyIz4FqoZuOAp39IaAVVOySdk98lmO9Y4sBP8DcfwGZg21wwTCNcDXVuAg472IIEHug/lnjxbocuRMtOxWPZf+OCsrgM0AGrMM9p0ytxTq5kko+cVT98qbPeJiZJ9FLCYTcwAkgr8RT3soC1R8FfpCkvTCHk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791153008; c=relaxed/simple;
	bh=ILgUdLKH6GwHZmL/4lV213ywY9wB75n0WVeRShSdSrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=j4A2ai6943xuZu72QyJTyVFmDFlwJvEi5jc4nSWRmNAjyQIu5I6fXZwmy3RnbdjEc4GW+caLd/k3Aoc2onS1XeCrPt3Fb/u/hojD2NTwnV5ReajtSce1phj68ZNBEsqmAfNVmK4pUBYgDCEyMwG7d7rhps5Tjg2Vxegby4CXRTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pdp60lif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pdp60lif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85211F000FF;
	Sun,  4 Oct 2026 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791153006;
	bh=LPn7a5+BxFRldbSMhbNTOb5Po4lhBhpIRCTlArK3fng=;
	h=Subject:From:Date:To;
	b=Pdp60lifgOzCgy/YD+S5DEGrOM/J+mR4BrFY2jACeYXcjjg+KMIQm1MzwwW4rdy3l
	 tEXGl3Ev5uIqJSOY2hLnK0IyN9pj7n2kSwWSVWzxiTh5aO8ogwJ9Lc1Ifl2wNRB98o
	 RQ+ytoJgGFB9N21BlMSJIZIJaAvUI5R47akFIGF4xi+OscOtg+iJatMT9hMKcVu2NF
	 F7SUcZkjwzrrA4ajQ1YtkyV51rvLjeraZ+GYWZuHfp6Sj63pFRXvoPmnffOwF2xE/W
	 ZeM0aiVQCR8RnYWRY10ACHbli+Dg6aanegS8JZ3FLeTqDr902c5FFEbBAZ6jXONX6G
	 qrhnf6D53OtRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6EBB39253C0;
	Sun,  4 Oct 2026 22:30:06 +0000 (UTC)
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
 <179115300516.1023890.10941154160280991744.git-patchwork-summary@kernel.org>
Date: Sun, 04 Oct 2026 22:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: bitbang: Drop duplicated word in file header comment
  Submitter: Saad Anjum <saadanjum239@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1178459/
  Lore link: https://lore.kernel.org/r/20261002155527.24845-1-saadanjum239@gmail.com

Patch: Documentation: devres: Remove non-existent SPI register helpers
  Submitter: Jesse Jeronimus <jesse.jeronimus@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1178271/
  Lore link: https://lore.kernel.org/r/20261002110752.89529-1-jesse.jeronimus@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


