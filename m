Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DC3B14AF
	for <linux-spi@vger.kernel.org>; Thu, 23 Jul 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840436; cv=none; b=U2f4Je0snR2j1lGUf+kGTaYxcBbCj9rwo6EqTn8I0lPYxlUO8C7+vj8CchM2JgElJC47wAUl2xOajzCb0IumP2T5oxA3W1l6nQCUBF97BJ+FnuwqHg3IYtnZEiJfyt/n2mSthL+6+JaZAMGjET2u4DjlfDQ4a46tl1M4/5fHmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840436; c=relaxed/simple;
	bh=Rc0d32GnPkqTnd8hpPfIBwtRUSig9agVFGCKE0HET80=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=egtufV2uNZm5+3DqcxnqdaT1MpLjTA/dgPxgVt8DoIRNMr/cSaMCyPUGBmQGn4iDpJstLTMg/Qoot9CLG2hx4jSL1Rmd0XAU6jjDM7D4Q0295nXoVKXpuUYv2qg8FZSbgHbXuzOQbV3rhBNB1spbB4lADCxwbPQv1gz55nycQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR04XsEq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR04XsEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E101F000E9;
	Thu, 23 Jul 2026 21:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784840435;
	bh=b8TD79Ir2FVUnv/o5Lg7J6ZMeg4MVebVwn++dKj6Iwo=;
	h=Subject:From:Date:To;
	b=iR04XsEqaK0tjSXrOwZG64HuSCkT6qw/oppwgLnNwtaEGrI7pEF9kK2sV3uqgo8aq
	 SI+FBRBN2QVfKd/dzyQk0Imh+HSVtM/6OKRiTwSV2TfjuQI1Ngu5XcOal56AOUXyee
	 wq5LtV6307ZQAmPuWO4uzEkFgIE0qxkDYPsEjvyujdrcftf6noA7vSdEktBKTCYtdJ
	 30kIRvjeCswo9H+HUV/bPrmRn8Bg0NHxRMm+Y8PF2r6Glq2+mn6T5CBGLLFPgVF8Lj
	 ydfj+ITrz8DONDUJEAtSKCTXIfxaSXRSy56P9cdTMM0AodtlvWh3J4Q6l7kMmQAknq
	 lMVmRToJwE+aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B753924A1E;
	Thu, 23 Jul 2026 21:00:04 +0000 (UTC)
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
 <178484040354.2870233.16179967637983426059.git-patchwork-summary@kernel.org>
Date: Thu, 23 Jul 2026 21:00:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: qcom-qspi: Correct max DMA length to avoid 64K boundary failure
  Submitter: Vijaya Krishna Nivarthi <vnivarth@qti.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1132313
  Lore link: https://lore.kernel.org/r/20260722092358.459943-1-vnivarth@qti.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


