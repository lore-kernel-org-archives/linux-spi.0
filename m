Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB28404BC0
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548236; cv=none; b=XeEfENVSPTtd7+Nhhm+fXSbsQZDnLppKLQOVvgc1xu/RuyLMrpXuqq0sQ45LZmTvWd8iTZEKfotj2Cm3wxvQduCSU4FoVoCXTcfYIj3ym899p7f62fqDfyAzOw5IBgVqHKCb835eas4/30T4rO+nTQW7o+NcsuyrEMFFtem+Ugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548236; c=relaxed/simple;
	bh=jR3HyB9S69DSL/7Bqej0O8Xbs1UU0Fa4VzW3Q1PnMH8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=emljFd+4cBQ5CiOXCGWUwKv+YFj5IE6WU9upmnpQwzef2rI8AZASiQzdzMMviKcTejpc/3rc4aK6DQlKeWu04THxwlW5X6zCHz0czgXKgQXECFLly0M7ZdWg77OsEb0NBlHCCCFDBHxgZAbf05W9AnANUoYJBvH0iAkqgXjDyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/5/+umS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/5/+umS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BA41F000E9;
	Mon, 20 Jul 2026 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784548235;
	bh=9wnCfAzBF89Xgl1YRLN6mzY7iw84Hqt3giUAyaTQfxs=;
	h=Subject:From:Date:To;
	b=B/5/+umSX6C5JkZvMghNIHRTVXdTGNjcLZyJXPZTMK9p8rNI+F36LpoNpopdDbtSq
	 sG/Iku0VRSetPM4OkgQldodPSovsslhTWXZUk1OyJ5y8euWMmLSffLwf5e0++5voDK
	 0xHAdk1plBC0uD13YblMXDIiAZNpEqwhEUAYvFxW5gEmqWLdBqqKEIlgt4iJKJfy7N
	 9KatuE8bPrXOMTq2g4ctNqW6yzeVz/MJM99YEBvLaSsbmabpPysr0KXcViOdcCSC3r
	 /WAPhArSJCWDcnU97ExGo1sRfC5zSW5StlHCAwfJGm0AKOsX1NBSDxlMdeQTppMPgH
	 gQk+H3tW6V79w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D36253924447;
	Mon, 20 Jul 2026 11:50:06 +0000 (UTC)
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
 <178454820539.3504031.1277534540477941071.git-patchwork-summary@kernel.org>
Date: Mon, 20 Jul 2026 11:50:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spacemit: Correct TX FIFO slot calculation
  Submitter: Zhengyu He <hezhy472013@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1128146
  Lore link: https://lore.kernel.org/r/20260715-k1-spi-tx-fifo-fix-v1-for-next-v1-1-02024223b08a@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


