Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3773F076F
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277677; cv=none; b=FH1NLkBFFYBYPbYg91KKmnUbNLv0kj0p1Qiy/uSe99JKZ9xdCXMchKQSZDBIlrs9epH5DxB1RtBtoBGtfPPCpO6O+NbySYiFrklq0GtZSsgB02x66DtAS4cQeKgxiNZ2WFAkAstuAu0p8haL5vhqclaIKeoGYCrtNnQF9ss/EC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277677; c=relaxed/simple;
	bh=l0TumwBqOzIo5E6k71Y2pX/5UErfT4EpjEO7jJLANHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ddQhsHj6wyE1aStRk0bkMWUJ+xQCvlnqDzmYPE180WQzsma7cJJ1sfiECJE+sY9GCQXBsVBRzLJMGLy+yKPxxfwnJTqa6KdsbVpAimAFXnOmY/AE62eLY8kJ3VPTvibCIzD1lOUjgrsP+iVcLwi/tHKhORBlZBZoPRZwqh2GANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7prs9QV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7prs9QV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127521F00893;
	Thu, 24 Sep 2026 19:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790277676;
	bh=MQZgbICTF0I3IhwZJVQh6og0MldRXemkpeHna5dGUIc=;
	h=Subject:From:Date:To;
	b=i7prs9QVCSJGYRKRk4qSicDRyBKPZcGc4za5Chm/0CtZAwHNjrnyK++BxMzbguabE
	 x9abSLgN4Y2nh+V/Gwa+WEGbIrXpPLMEwkIqsjPV+ty9GTTECO10ge38D5NFoST/CT
	 ZxesKNs09XAHTbNBCqEyOgyL+MzDqfQXzfZIyeowh4mZrDDt7JzTz1SK5KUdpuNWJ/
	 mDQztiPmOuYeYEQafjGNM30Pc9F9VT/mb9ghkp0u1mlpqfcXuvlLVgOUehGD548WJ0
	 I9Y+LS1Uun0nm5NN8J+hB4bCF2JBSWxgPYfWtQhxvZlVsT8dk5vklXx0422akLEnhg
	 YbtjrLWIELpCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1D2EA3A566E0;
	Thu, 24 Sep 2026 19:20:06 +0000 (UTC)
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
 <179027760470.2163754.12155055326746597212.git-patchwork-summary@kernel.org>
Date: Thu, 24 Sep 2026 19:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: dw: clean ups from "use threaded interrupt"
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1147286/
  Lore link: https://lore.kernel.org/r/20260817151404.28324-1-jszhang@kernel.org
    Patches: [1/2] spi: dw: use DW_SPI_ISR directly

Series: spi: dw: use threaded interrupt
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161423/
  Lore link: https://lore.kernel.org/r/20260909143652.9234-1-jszhang@kernel.org
    Patches: [v3,1/5] spi: dw: use DW_SPI_ISR directly


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


