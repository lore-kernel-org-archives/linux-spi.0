Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C323CD8C9
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927208; cv=none; b=eMdcFCXp1qwKQmqsEFhttLxyQJTDIO6txxIlV7ztYCzC1z8cXyv3iJmU/Ov1Wjrfep531yw6MBid93jNgS01YUP8JVia3denou1KK4GMMbbP9HnAKwiBcb5g/AVwg9kG9d/NyUynA7ewMXXMwKer2tbghv4WXCPEc42hUBkj6yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927208; c=relaxed/simple;
	bh=5RVp3eUIlwhg2z9E91nY7wk6NEjfcw0Vwb6LNAV2cqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fgUUjt+KrL0Enwk84iRwL2hybC0i2MpHpgrCZgkAGorCZHfFXWSX5T/h9LJCu9r1I0VsmkFZ1E3Pi3xIx9f4UzgPkGzh/c762aV87FSFsHX0sW9e6i+ms1WNRLCoGpOnkQ0jRmD4DFg0Fo9EJQYGOG1Iv8utvBOnqQ5Z+xPXNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KglVLhc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KglVLhc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7774B1F00893;
	Mon,  8 Jun 2026 14:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780927207;
	bh=mdnxQEtoKXKxzbuJ05jniZlMdW5tslqfOc3Nuo7tr2w=;
	h=Subject:From:Date:To;
	b=KglVLhc5Y/2tFCmT7bw4Qx4ebYwdzp1cZeuvKfdzVgyVRxAEaPFzkK9TWr3Vi9a8j
	 1G/D+5Xx4jV8uWsgg42qrtUFiug8V4QYCaB525A4mjf1OZJdjksl+NnUU+DHpG8QQB
	 /Y4I8oMvWkpWyBaWYVUZXwh093tDSz5egElEmtk5djphujxIUjICkW8LEEvCGIeyvI
	 GlcZ9mcGa2ijKZBt+VnWFIcZmeBOkoScp3eK0THh3oYCWxf6iIRKk+WRZrjOTkHECu
	 B8jKefmagQ86tEYRHW7LmC1SphJFM0ALJYQaYsvizG3hbexdMRNQSrBT+3u0z4Wpf3
	 OIUU8FUCJgIOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B373930DC4;
	Mon,  8 Jun 2026 14:00:07 +0000 (UTC)
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
 <178092720638.1057913.5943330042570851121.git-patchwork-summary@kernel.org>
Date: Mon, 08 Jun 2026 14:00:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-xspi: Revert COMPILE_TEST support
  Submitter: Nathan Chancellor <nathan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1107162
  Lore link: https://lore.kernel.org/r/20260606-spi-cadence-xspi-revert-compile-testing-v1-1-76219ea378bd@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


