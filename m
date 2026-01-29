Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B62F1FEC
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711411; cv=none; b=q/Vs0vGgikCkZMO8CdThkZHCuPU/rOl4SvyGCGgrLOHhCJrVloMoAAv8vv2wNETb9Jmwb94/XVcT0bG2D86ZGpLHeS79DNdX3ChHMx0G1TlHtDSZUDPPcvqLSeC1+rYRYJzQeW90QJ0UeFk8wVTCgHmse+FPNlu0GBjUUykyXvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711411; c=relaxed/simple;
	bh=yTpJ5Z6lzG/Y1pgoBl7yTrF31bdU4NieD+wBpDUEqVA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=P9lpHXjZdaV6MsB3N9eh7rbunCNpVoETcwPcG4kB97ildHo5mPFp4RSGDTazAMaY9FembLZ/3oKuJ9u/ObIBo8vYNacqtqJl5m+rN681UonHJ3KOImjUJwNscewz5rC8pSATIwWsOmbuJABDQdfD3u2V4B666I0y1eCDYRJk/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/odRm6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/odRm6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90590C4CEF7;
	Thu, 29 Jan 2026 18:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769711410;
	bh=yTpJ5Z6lzG/Y1pgoBl7yTrF31bdU4NieD+wBpDUEqVA=;
	h=Subject:From:Date:To:From;
	b=c/odRm6NnKfevCZuPtS5YT/VMj46bGSiGO73+bUByjKeYWZ2v38/fCYe0erWc0lKZ
	 FF6WefYpatoiH2dKHOnUoFltc/35wizAbFyzUZEFPCS2MjnbpZ9n+KBZYDogGDO+n7
	 LWEoV0By8iEBuJEehwcPU/MyD/7cT+Bv+WHP40qU/XTUd9vn5jqGxTunMHAeSQadgp
	 9cjqzhzxM4e126JmXrzMFOWOdIUXPIwylZ9PNhNTuWn2/pa8WbL8jCiyNWU3JgI24i
	 ZuZ1o7ZMG9Fbnnx0i4FArpt20gEusEL1kQ3ohEb8c8GRYSsripdUURYEiNwS7i2m+S
	 qzFLCseRVwa4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8E4B7380CED5;
	Thu, 29 Jan 2026 18:30:04 +0000 (UTC)
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
 <176971140305.2992881.4796742842574274184.git-patchwork-summary@kernel.org>
Date: Thu, 29 Jan 2026 18:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: dw: Remove not-going-to-be-supported code for Baikal SoC
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1047784
  Lore link: https://lore.kernel.org/r/20260127210541.4068379-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


