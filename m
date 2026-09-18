Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B863CF209
	for <linux-spi@vger.kernel.org>; Fri, 18 Sep 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765876; cv=none; b=dGJoyW8Q6Fm7Rcsr1iSt/ZUE3sN2OiQR7dCL5wxupW8jzofPW1WerfPWSxrWHEOht+/UKhJ5Ycw1BtaYYG8tV39uybJecX56xufL80e3YIQBcdxTzetbd7wB3Id/e80Jm82/E3Ts+uA0e364PSSY8dgkzENAeoIRPRb5iYEOhaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765876; c=relaxed/simple;
	bh=Ixo24aAT96KxTsEtvGa7ALtJ0hlRVDR2qXNZkrMYbFg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CNfyZlqfz226Vp+DZ3avNZbFoHcerk8eAACHcK9pqz/KxYTTp3A1ub88FRGxTnjep2qdxdBVkNfbhYzJn9NGtGVr0HKZHFu6H4JyfPNb5GaFwEydgsQgrEXUmUthGpKo2haku7OFCC66IasFurvcDqRrK4r3yG/SEv4pKau+WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRu4Z8P+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRu4Z8P+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D6E1F000FF;
	Fri, 18 Sep 2026 21:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765875;
	bh=lafGOctlppZO/fzmVtRPwVd8uhiR3V8yk2O0sB/s/5Y=;
	h=Subject:From:Date:To;
	b=nRu4Z8P+WnxcvLEn7QDGTPIAz9ifrtrYnzP0EVB2q7XixpmQ33NGxT2P9iZWIhU2W
	 xrV+CtfIGI+NqNUR4C30ZoNeBVO6Lg4MXX38Sgt9cYRXMj1z/zlrFb1a97te9uW4iG
	 iO3WJgxjDsPgChCVPKF1MWuYulF3Z7dk3aWPsNNvCVcR/9Vjkyd966T8QGE5koaj1W
	 WNfqczj5BcNtBuNTuC8o7Y2hCwpsDZV2d1ck6vYYcx9Qc4ty8R6Xhq48Pqx7qNX+ZX
	 YSp5ww8/c7TAVgAsWvHBWipU9Om4DoGTKqH4woAPEt93MqS8XEay5c5ZNfCl3dnd+b
	 WU7/F41MbIG2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5937638111DB;
	Fri, 18 Sep 2026 21:10:09 +0000 (UTC)
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
 <178976580790.1147855.7103390533551597308.git-patchwork-summary@kernel.org>
Date: Fri, 18 Sep 2026 21:10:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mxic: fix ps_clk leak in runtime resume
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1156261/
  Lore link: https://lore.kernel.org/r/20260902-mxic-v1-1-76806325826d@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


